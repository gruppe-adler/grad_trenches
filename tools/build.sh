#!/bin/sh

toolsDir=$(realpath "$(pwd)/$(dirname $0)")
baseDir=`dirname "${toolsDir}"`
platform=`uname`
module="$1"

# find hemtt
if [[ ${platform} == "Linux" ]]; then
	hemttPath="${toolsDir}/hemtt"
else
	hemttPath="${toolsDir}/hemtt.exe"
fi

if [[ ! -f ${hemttPath} ]]; then
	echo "warning: hemtt binary not found at ${hemttPath}, will not build pbo files!"
	exit 1
fi

if [[ $module != "" ]]; then
	# build only selected PBOs
    "$hemttPath" build $module --force
else
	# build whole mod
	"$hemttPath" build --release --force --opts all

	# remove all built PBOs
	"$hemttPath" clean
fi