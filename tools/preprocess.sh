#!/bin/bash

DIRECTORY=`dirname $0`/..
PREPARE_ONLY="no"
while getopts 'd:p' OPTION; do
  case "$OPTION" in
    d)
      DIRECTORY=${OPTARG%"/"}
      ;;
    m)
      MACRODIR=${OPTARG%"/"}
      ;;
    p)
      PREPARE_ONLY="yes"
      ;;
    ?)
      echo "script usage: $(basename $0) [-d project_directory] [-m macro_target_dir] [-p]" >&2
      exit 1
      ;;
  esac
done

if [[ ${MACRODIR} == "" ]]; then MACRODIR=${DIRECTORY}; fi

pushd "$DIRECTORY"

acedir="$MACRODIR/z/ace"
cbadir="$MACRODIR/x/cba"
a3dir="$MACRODIR/A3"

function downloadMacroLib {
    local TARGETDIR=$1
    local URL=$2

    if [[ -d ${TARGETDIR} ]]
    then
        echo "INFO it seems we already got $TARGETDIR, skipping…"
    else
        echo "INFO copying $URL => $TARGETDIR…"
        mkdir -p ${TARGETDIR}
        pushd /tmp
        wget "$URL" -O tmp_preprocess.tar.gz && tar -xf tmp_preprocess.tar.gz -C ${TARGETDIR}
        popd
    fi
}

function escapeSlashesForSed {
    echo $1 | sed 's/\//\\\//g'
}

downloadMacroLib ${cbadir} "http://gruppe-adler.de/api/travis/cba.tar.gz"
downloadMacroLib ${acedir} "http://gruppe-adler.de/api/travis/ace.tar.gz"
downloadMacroLib ${a3dir} "http://gruppe-adler.de/api/travis/a3.tar.gz"

FILESWITHINCLUDES=`grep -lire '^\s*#include '`

if [[ PREPARE_ONLY == "no" ]]; then
    echo "INFO editing #include clauses: \\ => / as path joiner"
    for FILEWITHINCLUDE in ${FILESWITHINCLUDES}; do
        sed -i '/#include/s/\\/\//g' "$FILEWITHINCLUDE" #forward-slash all the paths
    done
fi

echo "INFO editing #include clauses: correct include paths…"
for FILEWITHINCLUDE in ${FILESWITHINCLUDES}; do
    sed -i '/#include/s/\/[Aa]3\(.*\)/'$(escapeSlashesForSed ${a3dir})'\L\1/' "$FILEWITHINCLUDE" #lower-case the a3-include
    sed -i '/#include/s/\/x\/cba/'$(escapeSlashesForSed ${cbadir})'/' "$FILEWITHINCLUDE"
    sed -i '/#include/s/\/x\/grad\///' "$FILEWITHINCLUDE" #special case for gruppe_adler_mod
    sed -i '/#include/s/\/x\/grad_trenches\///' "$FILEWITHINCLUDE" #special case for grad_trenches
    sed -i '/#include/s/\/z\/ace/'$(escapeSlashesForSed ${acedir})'/' "$FILEWITHINCLUDE"
done


if [[ PREPARE_ONLY == "no" ]]; then
    echo "INFO removing illegal double-hash from macro files…"
    for MACROFILE in `find . \( -iname '*.cpp' -or -iname '*.hpp' -or -iname '*.h' -or -iname '*.inc' \) -and -not -type l`
    do
        sed -i -e 's/##//g' "$MACROFILE"
    done

    echo "INFO starting preprocessing of SQF files…"
    for SQFFILE in `find . -iname '*.sqf'`
    do
        cpp -iquote ./ "$SQFFILE" "${SQFFILE}.1" && mv "${SQFFILE}.1" "$SQFFILE"
    done

    # remove hash stuff at top of file, it confuses the hell out of sqflint
    for SQFFILE in `find . -iname '*.sqf'`
    do
        sed -i -E 's/^\s*#.*//g' "$SQFFILE"
    done

else
    echo "INFO skipping actual preprocessing…"
fi

popd
