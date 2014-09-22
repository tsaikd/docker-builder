#!/bin/bash

if [ ! -f "/etc/fonts/conf.d/55-noto-mono.conf" ] ; then
	echo "Install /etc/fonts/conf.d/55-noto-mono.conf"
	cat > "/etc/fonts/conf.d/55-noto-mono.conf" <<EOF
<fontconfig>
	<match target="pattern">
		<test qual="any" name="family">
			<string>monospace</string>
		</test>
		<edit name="family" mode="prepend" binding="same">
			<string>DejaVu Sans Mono</string>
		</edit>
	</match>
</fontconfig>
EOF
fi

mkdir -p "/usr/share/fonts/opentype/noto"
mkdir -p "/tmp/font-$$"

pushd "/tmp/font-$$" &>/dev/null

unzip "${DOCKER_SRC}/NotoSansCJKTC-hinted.zip"
chmod 644 *.otf
mv *.otf "/usr/share/fonts/opentype/noto"

popd &>/dev/null

rm -rf "/tmp/font-$$"

