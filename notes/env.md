# Installing steps for binutils

Setting current shell session:

```text
export PREFIX="$HOME/opt/cross"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"

# Check
echo $PREFIX
echo $TARGET
echo $PATH


# Binutils
cd $HOME/src
mkdir build-binutils
cd build-binutils

# Check version before going ! 
../binutils-x.y.z/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror --enable-default-execstack=no
make
make install


# GCC
cd $HOME/src

# The $PREFIX/bin dir _must_ be in the PATH. We did that above.
which -- $TARGET-as || echo $TARGET-as is not in the PATH

mkdir build-gcc
cd build-gcc

# Check GCC version !
../gcc-x.y.z/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers --enable-initfini-array --disable-hosted-libstdcxx
make all-gcc
make all-target-libgcc
make all-target-libstdc++-v3
make install-gcc
make install-target-libgcc
make install-target-libstdc++-v3


```

# Convinience

```
export PATH="$HOME/opt/cross/bin:$PATH"
```