#!/bin/bash

export curdir=`pwd`

export srcDir="${curdir}/../target/testium/src"
export globalConfig="${curdir}/../src/main/resources/config/global.xml"

java -jar ${srcDir}/testium.jar --command keyword_details --globalconfigfile $globalConfig


