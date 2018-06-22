#!/bin/bash

./tools/gridinit-genconf.sh 5

export PATH=/tmp/oio/bin:$PATH
export LD_LIBRARY_PATH=/tmp/oio/lib:$LD_LIBRARY_PATH

set -e
set -x

GR="gridinit_cmd -S /tmp/gridinit.sock"

gridinit -d /tmp/gridinit.conf

# console
for cmd in status status2 status3 start stop reload repair; do
    $GR $cmd
done

# yaml
for cmd in status status2 status3; do
    ($GR -f yaml $cmd || true) > /tmp/yaml.txt
    yamllint /tmp/yaml.txt
done

# json
for cmd in status status2 status3; do
    ($GR -f json $cmd || true)| python -m json.tool
done
