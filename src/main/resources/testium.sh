#!/bin/sh
# ====================================================================== #
#                                                                        #
#  Testium run Script                                                    #
#                                                                        #
# ====================================================================== #

# OS specific support (must be 'true' or 'false').
cygwin=false;
case "`uname`" in
    CYGWIN*)
        cygwin=true
        ;;
esac

# Setup TESTIUM_HOME
dir_name=`dirname $0`
if [ "x$TESTIUM_HOME" = "x" ]
then
    # get the full path (without any relative bits)
    TESTIUM_HOME=`cd $dir_name/..; pwd`
    cd $dir_name
fi

# Testium jar-file
TESTIUM_JAR=$TESTIUM_HOME/src/Testium.jar
#export TESTIUM_JAR

# Input file
if [[ $# < 1 ]]
then
	echo "ERROR: No Test Group file specified"
	exit 1
fi

# For Cygwin, switch paths to Windows format before running java
if $cygwin
then
    TESTIUM_JAR=`cygpath --path --dos "$TESTIUM_JAR"`
fi

# Run Testium
TRACE=0
java -jar $TESTIUM_JAR "$@"
