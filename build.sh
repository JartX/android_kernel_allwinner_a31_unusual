#!/bin/bash
set -e

PLATFORM=""
MODULE=""
BOOT_VERSION=""

show_help()
{
	printf "\nbuild.sh - Top level build scritps\n"
	echo "Valid Options:"
	echo "  -h  Show help message"
	echo "  -p <platform> platform, e.g. sun6i, sun6i_fiber or sun6i_dragonboard"
	echo "  -v <boot_version> boot_version, e.g. boot_v1.0 or boot_v2.0"
	printf "  -m <module> module\n\n"
}

while getopts hp:m:v: OPTION
do
	case $OPTION in
	h) show_help
	;;
	p) PLATFORM=$OPTARG
	;;
	m) MODULE=$OPTARG
	;;
	v) BOOT_VERSION=$OPTARG
	;;
	*) show_help
	;;
esac
done

if [ -z "$PLATFORM" ]; then
	show_help
	exit 1
fi

if [ -z "$MODULE" ]; then
	MODULE="all"
fi

if [ "${BOOT_VERSION}" = "boot_v2.0" ]; then
	BOOT_VERSION="boot_v2.0"
elif [ "${BOOT_VERSION}" = "boot_v1.0" ]; then
	BOOT_VERSION="boot_v1.0"
else
		echo -e "\033[0;31;1m################################################\033[0m"
		echo -e "\033[0;31;1m#        make sure boot version is correct     #\033[0m"
		echo -e "\033[0;31;1m#  your data is incorrect,build project again  #\033[0m"
		echo -e "\033[0;31;1m################################################\033[0m"
		exit 1
fi

if [ -x ./scripts/build_${PLATFORM}.sh ]; then
	./scripts/build_${PLATFORM}.sh $MODULE $BOOT_VERSION
else
	printf "\nERROR: Invalid Platform\nonly sun6i sun6i_fiber or sun6i_dragonboard sopport\n"
	show_help
	exit 1
fi



