#!/bin/bash

# Bash script to generate a flag_list.txt file with everything in it per folder.
#
# Created for flaghunters by WhatIsThisImNotGoodWithComputers (ohgod AT whatisthisimnotgoodwithcomputers DOT com)

#vars
FILE="flag_list.txt"
FLAG_TOP_DIR="../flags"
FLAG_TOP_DIR_FILE="${FLAG_TOP_DIR}/${FILE}"

#countries
ls "${FLAG_TOP_DIR}" > "${FLAG_TOP_DIR_FILE}"
sed -i '/'${FILE}'/d' "${FLAG_TOP_DIR_FILE}"

#generate regions recursive
#feed this method full (relative) path
gen_list()
{
	#echo "${1}"
	
	#gen list for folder I'm in
	ls -p "${1}" | grep -v / > "${1}${FILE}"
	sed -i '/'${FILE}'/d' "${1}${FILE}"
	sed -i 's/.png//g' "${1}${FILE}"
	
	#run recursive for folders
	FOLDER_LIST=''
	
	shopt -s nullglob
	FOLDER_LIST=("${1}"*/)
	shopt -u nullglob
	
	if [ ! -z "${FOLDER_LIST}" ]; then
		#echo 11111111111111111111111111111111111 ${FOLDER_LIST}
		for region in "${FOLDER_LIST[@]}"
		do
			#echo "${region}"
			gen_list "${region}"
		done
	fi
}

#kick off recursive generation
while IFS='' read -r country || [[ -n "${country}" ]]; do
    gen_list "${FLAG_TOP_DIR}/${country}/"
done < "${FLAG_TOP_DIR_FILE}"

exit 0
