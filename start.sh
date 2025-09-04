#!/bin/bash

# Nếu biến BOOT_MODE = INSTALL thì boot từ ISO
if [ "$BOOT_MODE" = "INSTALL" ]; then
    echo "Booting in INSTALL mode (with ISO)..."
    qemu-system-x86_64 -m 8G -smp 4 \
        -hda /root/win10.qcow2 \
        -cdrom /root/win10.iso \
        -boot d -vnc :0
else
    echo "Booting in RUN mode (HDD only)..."
    qemu-system-x86_64 -m 8G -smp 4 \
        -hda /root/win10.qcow2 \
        -boot c -vnc :0
fi
