#!/bin/bash

bin_abspath=$(cd $(dirname $0) && pwd)
top_abspath=$(dirname ${bin_abspath})
parent_abspath=$(dirname ${top_abspath})

MKSPEC_GLOBAL_YAML_FNAME=${parent_abspath}/mkspec_data/global.yml
MKSPEC_SPECIFIC_YAML_FNAME=${parent_abspath}/mkspec_data/specific.yml

if [ -e ${MKSPEC_GLOBAL_YAML_FNAME} ]; then
	echo "export MKSPEC_GLOBAL_YAML_FNAME=${MKSPEC_GLOBAL_YAML_FNAME}"
else
	echo ""
fi

if [ -e ${MKSPEC_SPECIFIC_YAML_FNAME} ]; then
	echo "export MKSPEC_SPECIFIC_YAML_FNAME=${MKSPEC_SPECIFIC_YAML_FNAME}"
else
	echo ""
fi

echo "export MKSPEC_LOG_DIR=${PWD}/logs"
