#! /bin/sh
#
# replace-string.sh
# =================
#
# Replace all occurrences of a string in all files recursively.
#
# Author: Giovanni Santini
# Mail: giovanni.santini@proton.me
# License: MIT
#

set -e

OLD_NAME="my_old_name"
NEW_NAME="my_new_name"

echo "Replacing string $OLD_NAME with $NEW_NAME"
grep -r $OLD_NAME -l --exclude-dir=".git/" | tr '\n' ' ' | xargs sed -i "s|${OLD_NAME}|${NEW_NAME}|g"

echo "Done"