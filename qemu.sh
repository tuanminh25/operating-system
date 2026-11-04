### INSTALLATION ###
# QEMU
sudo dnf install qemu-system-x86-core

# UI for qemu
sudo dnf install  qemu-ui-gtk.x86_64 


### RUN ###
# via bootable medium
qemu-system-i386 -cdrom myos.iso

# direct without needing one
qemu-system-i386 -kernel myos

# burn to an usb stick and boot on device
sudo dd if=myos.iso of=/dev/sdx && sync
