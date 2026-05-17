#!/bin/sh

#
# Update lei mailbox, create one if it does not exist
#

set -e

STAGING_MAILBOX=~/Mail/drivers-staging
STAGING_INBOX=https://lore.kernel.org/linux-staging/
STAGING_QUERY='dfn:drivers/staging/ AND rt:30.days.ago..'

EBPF_MAILBOX=~/Mail/bpf
EBPF_INBOX=https://lore.kernel.org/bpf/
EBPF_QUERY='(dfn:kernel/bpf/ OR dfn:tools/lib/bpf/ OR dfn:tools/testing/selftests/bpf/) AND rt:30.days.ago..'

if [ ! -d $STAGING_MAILBOX ]; then
    echo "Setting up staging"
    lei q -o $STAGING_MAILBOX \
        -I $STAGING_INBOX \
        --threads $STAGING_QUERY
else
    echo "Fetching staging"
    lei up $STAGING_MAILBOX
fi

if [ ! -d $EBPF_MAILBOX ]; then
    echo "Setting up ebpf"
    lei q -o $EBPF_MAILBOX \
        -I $EBPF_INBOX \
        --threads $EBPF_QUERY
else
    echo "Fetching ebpf"
    lei up $EBPF_MAILBOX
fi

echo "Done"
