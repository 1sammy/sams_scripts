#!/bin/bash

SRCDIR=/usr/src/linux

eselect kernel list
read KERN_NUM
eselect kernel set $KERN_NUM

cp /KERNELCONFIG $SRCDIR/.config

make -C $SRCDIR nconfig
make -C $SRCDIR -j16
make -C $SRCDIR modules_install

emerge @module-rebuild

mount /boot
make -C $SRCDIR install
grub-mkconfig -o /boot/grub/grub.cfg # grub bootentry
cp $SRCDIR/arch/x86/boot/bzImage /boot/EFI/gentoo_stub/vmlinux # EFI bootstub
umount /boot

