#!/bin/bash

if [ ! -f "${HOME}/.fonts.conf" ] ; then
	echo "Install ${HOME}/.fonts.conf"
	cat > "${HOME}/.fonts.conf" <<EOF
<fontconfig>
  <match target="pattern">
    <test qual="any" name="family">
      <string>serif</string>
    </test>
    <edit name="family" mode="prepend" binding="strong">
    </edit>
  </match> 
  <match target="pattern">
    <test qual="any" name="family">
      <string>sans-serif</string>
    </test>
    <edit name="family" mode="prepend" binding="strong">
    </edit>
  </match>
  <match target="pattern">
    <test qual="any" name="family">
      <string>monospace</string>
    </test>
    <edit name="family" mode="prepend" binding="strong">
    </edit>
  </match>
</fontconfig>
EOF
fi

echo "Patch ${HOME}/.fonts.conf"
sed -i 's|\(\s*\)</edit>|\1  '"<string>Noto Sans Korean</string>"'\n\0|i' "${HOME}/.fonts.conf"

mkdir -p "${HOME}/.fonts/noto"
mkdir -p "/tmp/font-$$"

pushd "/tmp/font-$$" &>/dev/null

unzip "${DOCKER_SRC}/NotoSansKorean-hinted.zip"
mv *.otf "${HOME}/.fonts/noto"

popd &>/dev/null

rm -rf "/tmp/font-$$"

