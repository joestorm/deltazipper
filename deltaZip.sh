#!/bin/bash
SYSTEM=$1
if [ "$SYSTEM" == "" ]; then
  echo "No SYSTEM name. Setting SYSTEM to deltaZips."
	SYSTEM=deltaZips
fi
TIME_STAMP=$(date +%Y-%m-%d-%H%M)
MY_DIR=/var/opt/MyDir
EXPORT_OUTPUT_DOCKER=$MY_DIR/watchInDir
BASE_DIR=/var/opt/MyDir/deltaZips/$SYSTEM
VERSION_NUMBER_FILE=$BASE_DIR/latestversion
ISRUNNING_FILE=$MY_DIR/ISRUNNING
ALL_EXPORT_DIR=$MY_DIR/deltaCompareDir



mkdir -p $BASE_DIR
if [[ -f $ISRUNNING_FILE ]]; then
	echo 'Is already running!'
	exit 1
fi
`touch $ISRUNNING_FILE`


VERSION=0
if [[ -f $VERSION_NUMBER_FILE ]]; then
	VERSION=`cat $VERSION_NUMBER_FILE`
fi

VERSION=$((VERSION+1))



PARTIAL_EXPORT_DIR=$BASE_DIR/${SYSTEM}-$TIME_STAMP-$VERSION

mkdir -p $ALL_EXPORT_DIR
mkdir -p $PARTIAL_EXPORT_DIR


echo rsyncing
rsync -rclq --progress  --compare-dest=$ALL_EXPORT_DIR/ $EXPORT_OUTPUT_DOCKER/ $PARTIAL_EXPORT_DIR/;
rsync -rtlq $PARTIAL_EXPORT_DIR/ $ALL_EXPORT_DIR/


cd $PARTIAL_EXPORT_DIR

cd ..
echo zipping
zip -qr0 -s 3g --symlinks $BASE_DIR/$SYSTEM-$TIME_STAMP-$VERSION.zip `basename $PARTIAL_EXPORT_DIR`

#clean up
rm -rf $PARTIAL_EXPORT_DIR

#inc version number
echo $VERSION > $VERSION_NUMBER_FILE
`rm -f $ISRUNNING_FILE`
