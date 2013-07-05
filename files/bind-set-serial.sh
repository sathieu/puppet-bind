#!/bin/sh

set -e

usage() {
  echo "Usage:"
  echo "  $0 zone-name /path/to/input-zone-noserial /path/to/output-zone"
}

if [ "$#" != 3 ]; then
  usage
  exit 1
fi
zonename="$1"
infile="$2"
outfile="$3"

if [ ! -f "$infile" -o ! -r "$infile" ]; then
  echo "ERROR: File '$infile' does not exists, is not a file, or is not readable"
  exit 1
fi
if [ ! -w "$(dirname $outfile)" ]; then
  echo "ERROR: Parent directory of file '$outfile' is not writable"
  exit 1
fi

todayserial=$(date +'%Y%m%d01')
if [ -f $outfile ]; then
  oldserial=$(grep 'serial number' "${outfile}"  | awk '{print $1}')
else
  oldserial='1'
fi
if [ "${todayserial}" -gt "${oldserial}" ]; then
  newserial="${todayserial}"
else
  newserial=$((oldserial+1))
fi
if [ "${newserial}" -gt $((todayserial+98)) ]; then
  echo "ERROR: Serial is in the future: '$newserial'"
  exit 1
fi

tmpfile=$(mktemp)
sed "s/@@serial@@/${newserial}/" "${infile}" > "${tmpfile}"
named-checkzone "${zonename}" "${tmpfile}"
cat "${tmpfile}" > ${outfile}
