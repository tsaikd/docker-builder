#!/bin/bash
# apt-get install jq
#set -eu
shopt -s nullglob

readonly base_dir=$1
if [ -z "$base_dir" ] ; then
 echo 'please location docker registry store location!';
 exit;
fi

echo "ready go...[ press any key to continue]"
read ok;

readonly output_dir=$(mktemp -d -t trace-images-XXXX)
readonly jq=$(which jq)

readonly repository_dir=$base_dir/repositories
readonly image_dir=$base_dir/images

readonly all_images=$output_dir/all
readonly used_images=$output_dir/used
readonly unused_images=$output_dir/unused

function info() {
    echo -e "\nArtifacts available in $output_dir"
}
trap info EXIT ERR INT

function image_history() {
    local readonly image_hash=$1
    $jq '.[]' $image_dir/$image_hash/ancestry | tr -d  '"'
}

echo "Collecting orphan images at $repository_dir"
for library in $repository_dir/*; do
    echo "Library $(basename $library)" >&2

    for repo in $library/*; do
        echo " Repo $(basename $repo)" >&2

        for tag in $repo/tag_*; do
            echo "  Tag $(basename $tag)" >&2

            tagged_image=$(cat $tag)
            image_history $tagged_image
        done
    done
done | sort | uniq > $used_images

echo "used_images:$used_images"
ls $image_dir > $all_images
echo "all_images:$all_images"

# 
grep -v -F -f $used_images $all_images > $unused_images || true

readonly all_image_count=$(wc -l $all_images | awk '{print $1}')
readonly used_image_count=$(wc -l $used_images | awk '{print $1}')
readonly unused_image_count=$(wc -l $unused_images | awk '{print $1}')

readonly unused_image_size=$( if [ $unused_image_count -gt 0 ] ; then \
       cd $image_dir; du -hc $(cat $unused_images) | tail -n1 | cut -f1; \
       else echo 0;     fi
   )

if [  $unused_image_count -le 0 ] ; then
  echo "no unused images.";
  exit;
fi

echo -e "\nTrimming _index_images..."
readonly unused_images_flatten=$output_dir/unused.flatten
cat $unused_images | sed -e 's/\(.*\)/\"\1\" /' | tr -d "\n" > $unused_images_flatten

for library in $repository_dir/*; do
    echo "Library $(basename $library)" >&2

    for repo in $library/*; do
        echo " Repo $(basename $repo)" >&2
        mkdir -p "$output_dir/$(basename $repo)"
        jq '.' "$repo/_index_images" > "$output_dir/$(basename $repo)/_index_images.old"
        jq -s '.[0] - [ .[1:][] | {id: .} ]' "$repo/_index_images" $unused_images_flatten > "$output_dir/$(basename $repo)/_index_images"
        cp "$output_dir/$(basename $repo)/_index_images" "$repo/_index_images"
    done
done

echo "these are unused images:"
cat $unused_images 

echo "${all_image_count} images, ${used_image_count} used, ${unused_image_count} unused"
echo "Unused images consume ${unused_image_size}"

ok="N";
echo -e "\nRemove images,are you sure?[Y=yes]"
read ok;

if [ "$ok" = "Y" ] ; then 
  echo "before cleanup:" && du -sm $base_dir
  cat $unused_images | xargs -I{} rm -rf $image_dir/{} 
  echo "after cleanup:" &&  du -sm $base_dir
else
  echo "do nothing"
fi

