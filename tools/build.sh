#!/usr/bin/env bash
### CONFIG ###
zip_path="zip.exe"
modname="@grad_trenches"
pboprefix="grad_trenches_"
RAW_VERSION="1.5.5"

### AS AS USER, DONT EDIT BELOW THIS LINE ###

toolsDir=$(realpath "$(pwd)/$(dirname $0)")
baseDir=`dirname "${toolsDir}"`
platform=`uname`
module="$1"


if [[ ${platform} == "Linux" ]]; then
	armakePath="${toolsDir}/armake"
else
	armakePath="${toolsDir}/armake_w64.exe"
fi

if [[ ! -f ${armakePath} ]]; then
	echo "warning: armake binary not found at ${armakePath}, will not build pbo files!"
	exit 1
fi

#copy to release directory
releaseDir="$baseDir/release/$modname"
mkdir -p "$releaseDir"
cp -r "${baseDir}/addons/" "${releaseDir}/"
cp -r "${baseDir}/optionals/" "${releaseDir}/"
cp "${baseDir}"/*.paa "${baseDir}"/*.cpp "${baseDir}/README.md" "${releaseDir}/"

#get release version
version=$RAW_VERSION
pushd "$baseDir" # get into git directory - elsewise we will not be able to get version info
	if [[ ${version} == "" ]]; then
		version=$(git describe --tag --always)
	fi
popd

echo "current version: $version"
if [[ ${version} == "" ]]; then
	echo "cant find version. are you sure we're having a .git directory here?"
	exit 2
fi

#make a key
mkdir -p "$baseDir/build_keys"
keyFileName="${pboprefix}${version}"
keyFilePath="$baseDir/build_keys/$keyFileName"
"${armakePath}" keygen -f "$keyFilePath"

#copy public key into key directory
rm -r "${releaseDir}/keys/" # remove all existing keys in directory
mkdir -p "${releaseDir}/keys"
cp "${keyFilePath}.bikey" "${releaseDir}/keys/$keyFileName.bikey" # copy bikey to release directory

build_pbo() {
	componentname=`basename "${1}"`
	componentpath=`dirname "${1}"`
	echo "packing $componentname"

	pbofilename="${pboprefix}${componentname}.pbo"
	pbofilepath="${componentpath}/$pbofilename"

	"${armakePath}" build -f -p -s "$pbofilepath.$keyFileName.bisign" -k "$keyFilePath.biprivatekey" "${1}" "$pbofilepath" || exit 2

	if [[ ! -f "$pbofilepath" ]]; then
		echo "failed"
		exit 2
	fi
}

pack_directory() {
	find "$1" -maxdepth 1 ! -path "$1" -type d | while read component; do
		build_pbo "${component}"
		rm -r "${component}"
	done
}

if [[ $module != "" ]]; then
    echo "building only $module"
    build_pbo $module
else
    pack_directory "$releaseDir/addons"
    pack_directory "$releaseDir/optionals"
fi

zipname="${modname}-$version"
if [[ ${platform} == "Linux" ]]; then
	tar -czf "$baseDir/release/${zipname}.tar.gz" -C "${baseDir}/release" ${modname}
	(cd ${baseDir}/release; zip -r ${zipname}.zip ${modname})
else
	pushd "${baseDir}/release"
		# check zipper
		if [ ! -e "${zip_path}" ]; then
			zip_path="${toolsDir}/zip.exe"
		fi

		if [ ! -e "${zip_path}" ]; then
			echo "warning: zip.exe not found, will not zip mod release!"
			exit 1
		fi

		"${zip_path}" -r "$baseDir/release/${zipname}.zip" "${modname}"
	popd
fi