#! /bin/sh

echo "/* Generated by $0 */"
echo "#include \"cmds.h\""
echo "help_t help[] = {"
needcomma=0
IFS="
"
sed -e 's,["],\\&,g' | while read -r line; do
	if [ -z "${line%%:*}" ]; then
		if [ ${needcomma} -eq 1 ]; then
			printf "\""
			[ ${garble} -eq 1 ] && printf ")"
			printf "},\n"
		fi
		line="${line#:}"
		garble=0
		if [ "${line%:}" != "${line}" ]; then
			garble=1
			line="${line%:}"
		fi
		type="${line%:*}"
		cmd="${line#*:}"
		[ "${cmd}" = "end" ] && break
		case ${type} in
			hub)  type_int=1 ;;
			leaf) type_int=2 ;;
			*)    type_int=0 ;;
		esac

		if [ ${garble} -eq 0 ]; then
			printf "  {%d, \"%s\", %d, \"" ${type_int} "${cmd}" ${garble}
		else
			printf "  {%d, \"%s\", %d, STR(\"" ${type_int} "${cmd}" ${garble}
	fi
		needcomma=0
	else
		printf "%s\\\n" "${line}"
		needcomma=1
	fi
done
echo "};"