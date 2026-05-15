#!/bin/sh

#
# Update lei index, create one if it does not exist
#

set -e

MAIL_DIR=~/Mail/drivers-staging

if [ ! -d $MAIL_DIR ]; then
    lei q -o $MAIL_DIR \
        -I https://lore.kernel.org/all/ \
        --threads 'dfn:drivers/staging/ AND rt:30.days.ago..'
    exit 0
fi

lei up $MAIL_DIR
