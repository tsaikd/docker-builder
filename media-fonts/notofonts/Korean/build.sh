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
sed -i 's|\(\s*\)</edit>|\1  '"<string>Noto Sans Korean</string>"'\n\0|i' "${HOME}/.fonts.conf" || exit $?

mkdir -p "${HOME}/.fonts/noto" || exit $?
mkdir -p "/tmp/font-$$" || exit $?

pushd "/tmp/font-$$" &>/dev/null || exit $?

unzip "${DOCKER_SRC}/NotoSansKorean-hinted.zip" || exit $?
mv *.otf "${HOME}/.fonts/noto" || exit $?

popd &>/dev/null || exit $?

rm -rf "/tmp/font-$$" || exit $?

