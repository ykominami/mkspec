#!/bin/bash
function do_test()
{
   TECSGEN=$1
   shift
   pushd $1
   shift
   echo "##### $TECSGEN $*  #####"
   $TECSGEN $*
   exit_code=$?
   popd

   return $exit_code
}

echo $*
test_data_dir=$1
shift
result_file=$1
shift
# TECSGEN=$1
# shift
# pushd $1
# shift
# echo "##### $TECSGEN $*  #####"
# $TECSGEN $* | tee $result_file
# popd
do_test $* | tee $result_file
exit $?
