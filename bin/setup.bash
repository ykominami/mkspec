#!/bin/bash

bin_abspath=$(cd $(dirname $0) && pwd)
top_abspath=$(dirname ${bin_abspath})
parent_abspath=$(dirname ${top_abspath})

GLOBAL_YAML_FNAME=${parent_abspath}/mkspec_data/global.yml
if [ -e ${GLOBAL_YAML_FNAME} ]; then
	echo "export GLOBAL_YAML_FNAME=${GLOBAL_YAML_FNAME}"
else
	echo ""
fi

