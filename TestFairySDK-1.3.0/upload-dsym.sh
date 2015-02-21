#!/bin/sh

TESTFAIRY_ENDPOINT="http://app.testfairy.com/upload/dsym/";

ZIP=zip
CURL=curl

log() {
	NOW=$(date +"%Y-%m-%d %H:%M:%S")
	echo "${NOW} ${1}"
}

DAEMON=0
if [ "${1}" == "-d" ]; then
	log "Enabling background dSYM upload"

	DAEMON=1
	shift
fi

API_KEY="${1}"
if [ ! "${API_KEY}" ]; then
	echo "Usage: ${0} [-d] TESTFAIRY_API_KEY"
	exit 1
fi

NOW=$(date +%s)
TMP_FILENAME="/tmp/${NOW}-${DWARF_DSYM_FILE_NAME}.zip"

# Compress the .dSYM folder into a zip file
log "Compressing .dSYM folder"
$ZIP -qrp9 ${TMP_FILENAME} ${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}
FILE_SIZE=$(stat -f "%z" "${TMP_FILENAME}")

foreground_upload() {
	# Upload zipped .dSYM file to TestFairy's servers
	STARTED=$(date +"%s")
	$CURL -s -F api_key="${API_KEY}" -F dsym=@"${1}" -o /dev/null "${TESTFAIRY_ENDPOINT}"
	ENDED=$(date +"%s")
	DIFF=$(expr ${ENDED} - ${STARTED})
	log "Symbols uploaded in ${DIFF} seconds"

	# Clean up behind
	rm -f ${TMP_FILENAME}
}

background_upload() {
	sh -c "$CURL -F api_key=\"${API_KEY}\" -F dsym=@\"${1}\" -s -o /dev/null \"${TESTFAIRY_ENDPOINT}\"; rm -f ${TMP_FILENAME};" /dev/null 2>&1 &
}

if [ "$DAEMON" == "0" ]; then
	log "Uploading ${FILE_SIZE} bytes to dsym server"
	foreground_upload "${TMP_FILENAME}"
else
	log "Uploading ${FILE_SIZE} bytes to dsym server in background"
	background_upload "${TMP_FILENAME}"
fi

log "TestFairy .dSYM upload script ends"
