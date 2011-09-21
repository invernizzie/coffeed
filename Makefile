COFFEE_DIR = coffee
JS_DIR = js
BUILD_DIR = build
OUT_DIR = ${BUILD_DIR}/dist/

COFFEE_FILES = ${COFFEE_DIR}/coffeed.coffee\
 ${COFFEE_DIR}/coffeeditem.coffee\
 ${COFFEE_DIR}/coffeedatom.coffee\
 ${COFFEE_DIR}/coffeedrss.coffee\

JS_FILE = ${JS_DIR}/jquery.coffeed.js

COFFEED = ${BUILD_DIR}/dist/jquery.coffeed.coffee
WE = ${BUILD_DIR}/dist/jquery.coffeed.js
WE_PACK = ${BUILD_DIR}/dist/jquery.coffeed.pack.js
WE_ARCH = ../jquery.coffeed.tar.gz

MERGE = sed -s -e '1 s/^\xEF\xBB\xBF//' ${COFFEE_FILES} > ${COFFEED}
COMPILE = coffee -o ${OUT_DIR} -c ${COFFEED}
PACKER = perl -I${BUILD_DIR}/packer ${BUILD_DIR}/packer/jsPacker.pl -i ${WE} -o ${WE_PACK} -e62

all: archive

coffeed:
	@@echo "Building" ${COFFEED}

	@@echo " - Merging files"
	@@${MERGE}

	@@echo ${COFFEED} "Built"
	@@echo

compile: coffeed
	@@echo "Building" ${WE}

	@@echo " - Compiling"
	@@${COMPILE}
	@@echo ${WE} "Built"
	@@echo

pack: compile
	@@echo "Building" ${WE_PACK}

	@@echo " - Compressing using Packer"
	@@${PACKER}

	@@echo ${WE_PACK} "Built"
	@@echo

archive: pack
	@@echo "Building" ${WE_ARCH}

	@@echo " - Creating archive"
	@@tar -C .. -czf ${WE_ARCH} --exclude '.git' coffeed
