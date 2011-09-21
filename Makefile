COFFEE_DIR = coffee
JS_DIR = js
BUILD_DIR = build

COFFEE_FILES = ${COFFEE_DIR}/coffeed.coffee\
 ${COFFEE_DIR}/cofeeditem.coffee\
 ${COFFEE_DIR}/coffeedatom.coffee\
 ${COFFEE_DIR}/coffeedrss.coffee\

JS_FILES = ${JS_DIR}/coffeed.js\
 ${JS_DIR}/cofeeditem.js\
 ${JS_DIR}/coffeedatom.js\
 ${JS_DIR}/coffeedrss.js

WE = ${BUILD_DIR}/dist/jquery.coffeed.js
WE_PACK = ${BUILD_DIR}/dist/jquery.coffeed.pack.js
WE_ARCH = ../jquery.coffeed.tar.gz

MERGE = sed -s -e '1 s/^\xEF\xBB\xBF//' ${JS_FILES} > ${WE}
PACKER = perl -I${BUILD_DIR}/packer ${BUILD_DIR}/packer/jsPacker.pl -i ${WE} -o ${WE_PACK} -e62

all: archive

coffeed:
	@@echo "Building" ${WE}

	@@echo " - Merging files"
	@@${MERGE}

	@@echo ${WE} "Built"
	@@echo

pack: coffeed
	@@echo "Building" ${WE_PACK}

	@@echo " - Compressing using Packer"
	@@${PACKER}

	@@echo ${WE_PACK} "Built"
	@@echo

archive: pack
	@@echo "Building" ${WE_ARCH}

	@@echo " - Creating archive"
	@@tar -C .. -czf ${WE_ARCH} --exclude '.git' coffeed
