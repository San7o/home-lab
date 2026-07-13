#!/bin/sh

#
# Update lei mailbox, create one if it does not exist
#

set -ex

STAGING_MAILBOX=~/Mail/drivers-staging
STAGING_INBOX=https://lore.kernel.org/linux-staging/
# "dfn:" stands for diff filename
STAGING_QUERY='(l:linux-staging.vger.kernel.org OR l:linux-staging@lists.linux.dev OR dfn:drivers/staging/) AND rt:30.days.ago..'

JANITORS_MAILBOX=~/Mail/kernel-janitors
JANITORS_INBOX=https://lore.kernel.org/kernel-janitors/
JANITORS_QUERY='l:kernel-janitors AND rt:30.days.ago..'

IIO_MAILBOX=~/Mail/iio
IIO_INBOX=https://lore.kernel.org/linux-iio/
IIO_QUERY='l:linux-iio AND rt:30.days.ago..'

NETDEV_MAILBOX=~/Mail/netdev
NETDEV_INBOX=https://lore.kernel.org/netdev/
NETDEV_QUERY='l:netdev AND rt:30.days.ago..'

EBPF_MAILBOX=~/Mail/bpf
EBPF_INBOX=https://lore.kernel.org/bpf/
EBPF_QUERY='(l:bpf@vger.kernel.org OR dfn:kernel/bpf/ OR dfn:tools/lib/bpf/ OR dfn:tools/testing/selftests/bpf/) AND rt:30.days.ago..'

UBOOT_MAILBOX=~/Mail/u-boot
UBOOT_INBOX=https://lore.kernel.org/u-boot/ UBOOT_QUERY='l:u-boot.lists.denx.de: AND rt:30.days.ago..'

WATCHLIST_MAILBOX=~/Mail/watchlist/
# [PATCH] media: cedrus: fix memory leak in cedrus_init_ctrls()
WATCHLIST_MIDS='20260624085920.578446-1-dawei.feng@seu.edu.cn'

# Staging
if [ ! -d $STAGING_MAILBOX ]; then
    echo "Setting up staging"
    lei q -o $STAGING_MAILBOX \
        -I $STAGING_INBOX \
        --threads "$STAGING_QUERY"
fi

# Janitors
if [ ! -d $JANITORS_MAILBOX ]; then
    echo "Setting up janitors"
    lei q -o $JANITORS_MAILBOX \
        -I $JANITORS_INBOX \
        --threads "$JANITORS_QUERY"
fi

# iio
if [ ! -d $IIO_MAILBOX ]; then
    echo "Setting up iio"
    lei q -o $IIO_MAILBOX \
        -I $IIO_INBOX \
        --threads "$IIO_QUERY"
fi

# netdev
if [ ! -d $NETDEV_MAILBOX ]; then
    echo "Setting up netdev"
    lei q -o $NETDEV_MAILBOX \
        -I $NETDEV_INBOX \
        --threads "$NETDEV_QUERY"
fi

# eBPF
if [ ! -d $EBPF_MAILBOX ]; then
    echo "Setting up ebpf"
    lei q -o $EBPF_MAILBOX \
        -I $EBPF_INBOX \
        --threads "$EBPF_QUERY"
fi

# U-boot
if [ ! -d $UBOOT_MAILBOX ]; then
    echo "Setting up uboot"
    lei q -o $UBOOT_MAILBOX \
        -I $UBOOT_INBOX \
        --threads "$UBOOT_QUERY"
fi

# Watchlist
if [ ! -d $WATCHLIST_MAILBOX ]; then
    mkdir $WATCHLIST_MAILBOX
fi

echo "Updating watchlist"
b4 mbox -M -o $WATCHLIST_MAILBOX \
    $WATCHLIST_MIDS

lei up --all

echo "Done"
