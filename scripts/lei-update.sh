#!/bin/sh

#
# Update lei mailbox, create one if it does not exist
#

set -e

STAGING_MAILBOX=~/Mail/drivers-staging
STAGING_INBOX=https://lore.kernel.org/linux-staging/
#STAGING_QUERY='dfn:drivers/staging/ AND rt:30.days.ago..'
STAGING_QUERY='(l:linux-staging.vger.kernel.org OR l:linux-staging@lists.linux.dev OR dfn:drivers/staging/) AND rt:30.days.ago..'

JANITORS_MAILBOX=~/Mail/kernel-janitors
JANITORS_INBOX=https://lore.kernel.org/kernel-janitors/
JANITORS_QUERY='rt:30.days.ago..'

EBPF_MAILBOX=~/Mail/bpf
EBPF_INBOX=https://lore.kernel.org/bpf/
#EBPF_QUERY='(dfn:kernel/bpf/ OR dfn:tools/lib/bpf/ OR dfn:tools/testing/selftests/bpf/) AND rt:30.days.ago..'
EBPF_QUERY='(l:bpf@vger.kernel.org OR dfn:kernel/bpf/ OR dfn:tools/lib/bpf/ OR dfn:tools/testing/selftests/bpf/) AND rt:30.days.ago..'

UBOOT_MAILBOX=~/Mail/u-boot
UBOOT_INBOX=https://lore.kernel.org/u-boot/
UBOOT_QUERY='l:u-boot.lists.denx.de: AND rt:30.days.ago..'

# Staging
if [ ! -d $STAGING_MAILBOX ]; then
    echo "Setting up staging"
    lei q -o $STAGING_MAILBOX \
        -I $STAGING_INBOX \
        --threads $STAGING_QUERY
else
    echo "Fetching staging"
    lei up $STAGING_MAILBOX
fi

# Janitors
if [ ! -d $JANITORS_MAILBOX ]; then
    echo "Setting up staging"
    lei q -o $JANITORS_MAILBOX \
        -I $JANITORS_INBOX \
        --threads $JANITORS_QUERY
else
    echo "Fetching staging"
    lei up $JANITORS_MAILBOX
fi

# eBPF
if [ ! -d $EBPF_MAILBOX ]; then
    echo "Setting up ebpf"
    lei q -o $EBPF_MAILBOX \
        -I $EBPF_INBOX \
        --threads $EBPF_QUERY
else
    echo "Fetching ebpf"
    lei up $EBPF_MAILBOX
fi

# U-boot
if [ ! -d $UBOOT_MAILBOX ]; then
    echo "Setting up uboot"
    lei q -o $UBOOT_MAILBOX \
        -I $UBOOT_INBOX \
        --threads $UBOOT_QUERY
else
    echo "Fetching uboot"
    lei up $UBOOT_MAILBOX
fi

echo "Done"
