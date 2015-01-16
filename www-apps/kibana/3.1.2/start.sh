#!/bin/bash

pushd /usr/local/kibana >/dev/null

echo "Listen http at 80 port"
python3 -m http.server 80 &

popd >/dev/null

