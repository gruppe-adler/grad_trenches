#!/bin/bash


if [[ `command -v sqflint` == "" ]]; then
    echo "cannot find sqflint :( aborting…"
    exit 255
fi

THISDIR=`dirname $0`
PROJECTDIR=${THISDIR}/..

while getopts 'd:C:' OPTION; do
  case "$OPTION" in
    d)
      PROJECTDIR=${OPTARG%"/"}
      ;;
    C)
      WD=${OPTARG%"/"}
      ;;
    ?)
      echo "script usage: $(basename $0) -d project_directory [-C temp_dir]" >&2
      exit 1
      ;;
  esac
done

if [[ ${WD} != "" ]]
then
    BUILDDIR=${WD}/`date +%s`
    mkdir -p ${BUILDDIR}
    cp -r ${PROJECTDIR} ${BUILDDIR}
    pushd ${BUILDDIR}
else
    pushd ${PROJECTDIR}
fi

bash ${THISDIR}/preprocess.sh -d ${BUILDDIR} -p
EXITCODE=$?
if [[ ${EXITCODE} != 0 ]]; then popd; exit ${EXITCODE}; fi

sqflint -d . -ee
EXITCODE=$?
if [[ ${EXITCODE} != 0 ]]; then popd; exit ${EXITCODE}; fi

popd
