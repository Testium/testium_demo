#!/bin/bash

export curdir=`pwd`
export srcDir=${curdir}/../src/main/resources
export targetSrcDir=${curdir}/../target/testium/src
export globalConfig=${srcDir}/config/global.xml

export cmd=$1
export testFile=$2
export baseUrl=$3

if [ "${cmd}" = "" ]; then
	cmd="execute"
fi
if [ "${testFile}" = "" ]; then
	testFile="${srcDir}/test/all.xml"
fi
if [ "${baseUrl}" = "" ]; then
	baseUrl="localhost"
fi

java -DBrowser.BaseUrl="${baseUrl}" -jar "${targetSrcDir}/testium.jar" --command "${cmd}" --globalconfigfile "${globalConfig}" --file "${testFile}"

echo "Check results in ${curdir}/../target/<date>"

