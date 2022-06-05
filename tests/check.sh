#!/bin/sh

#
# Test transferwee by uploading and then downloading a test file.
#
# To run this test, just invoke:
#  % ./check.sh
#

TRANSFERWEE=$(readlink -f ../transferwee.py)

set -e

testtmpdir=$(mktemp -d '/tmp/transferwee_test_XXXXXX')
testtmpfile=hello

cd "${testtmpdir}"

echo "Creating a test file..."
echo "Hello world!" > "${testtmpfile}"

echo "Uploading the test file..."
url=$(${TRANSFERWEE} upload -v -n 'Nice transfer title' -m 'Just a text file with the mandatory message...' "${testtmpfile}")
echo "test file uploaded as ${url}"

echo "Renaming original test file..."
mv "${testtmpfile}" "${testtmpfile}.orig"

echo "Waiting 10 seconds before downloading the file..."
sleep 10

echo "Downloading the test file via ${url}..."
${TRANSFERWEE} download -v "${url}"

echo "Checking if the uploaded file and downloaded file are the same..."
cmp "${testtmpfile}.orig" "${testtmpfile}"

cd "${OLDPWD}"
rm -rf "${testtmpdir}"
