#!/bin/bash

PROGRAM_FILE="main.go"
TEST_FILE="service-now-plugin_test.go"
ERROR_FOUND=0
for function in $(grep "func" ${PROGRAM_FILE} | grep -v main\( | awk '{print $4}'| awk -F'(' '{print $1}')
do
	grep -i test$function ${TEST_FILE} > /dev/null
	if test $? == 1
	then
		echo "Function $function doesn't have tests"
		ERROR_FOUND=1
	fi
done

echo ""
if test ${ERROR_FOUND} -eq 0
then
	echo "All functions in ${PROGRAM_FILE} have tests in ${TEST_FILE}"
else
	echo "Errors found, please fix them"
	exit 1
fi
