mkdir -p isodir/boot/grub
cp myos isodir/boot/myos
cp grub.cfg isodir/boot/grub/grub.cfg

# For my Fedora machine it is grub2
# Windows users will likely want to use a Cygwin
# Warning with grub2-mkrescue: https://wiki.osdev.org/Bare_Bones
# read this first before redistribute the img (not source code)

# Warning: GNU GRUB, the bootloader used by grub-mkrescue, is licensed under the GNU General Public License. Your iso file contains copyrighted material under that license and redistributing it in violation of the GPL constitutes copyright infringement. The GPL requires you publish the source code corresponding to the bootloader. You need to get the exact source package corresponding to the GRUB package you have installed from your distribution, at the time grub-mkrescue is invoked (as distro packages are occasionally updated). You then need to publish that source code along with your ISO to satisfy the GPL. Alternative, you can build GRUB from source code yourself. Extract it somewhere, then build GRUB from it, and install it in a isolated prefix in your PATH to ensure its grub-mkrescue program is used to produce your iso. You can then publish the official GRUB tarball along with your OS release. You're not required to publish the source code of your OS at all, only the code for the bootloader that's inside the iso.

grub2-mkrescue -o myos.iso isodir