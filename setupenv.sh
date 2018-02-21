export MY_DISTRO_PREFIX=/usr

export MY_DISTRO_LIBDIR=/usr/lib64

#DEPENDENCIES
sudo yum install gcc make automake bison ncurses-devel -y
sudo yum install gcc make automake bison ncurses-devel xorg-server-devel -y
sudo yum install rpm-build redhat-rpm-config asciidoc hmaccalc perl-ExtUtils-Embed pesign xmlto -y
sudo yum install audit-libs-devel binutils-devel elfutils-devel elfutils-libelf-devel -y
sudo yum install ncurses-devel newt-devel numactl-devel pciutils-devel python-devel zlib-devel -y

sudo yum install kmod-devel -y
sudo yum install -y procps-ng-devel
sudo yum install -y libunwind-devel

#xorg macros
git clone https://anongit.freedesktop.org/git/xorg/util/macros.git

cd macros
./autogen.sh --prefix=$MY_DISTRO_PREFIX --libdir=$MY_DISTRO_LIBDIR
make
sudo make install

cd ..

#DRM-TIP
git clone https://anongit.freedesktop.org/git/drm-tip.git
cd drm-tip
make defconfig

make

sudo make modules_install

sudo make install
cd ..

#libdrm
git clone https://anongit.freedesktop.org/git/mesa/drm.git
cd drm

./autogen.sh --prefix=$MY_DISTRO_PREFIX --libdir=$MY_DISTRO_LIBDIR

make

sudo make install
cd ..

#XF86-video-intel

git clone https://anongit.freedesktop.org/git/xorg/driver/xf86-video-intel.git

cd xf86-video-intel

./autogen.sh --prefix=$MY_DISTRO_PREFIX --libdir=$MY_DISTRO_LIBDIR

make

sudo make install

cd ..

#MESA

git clone https://anongit.freedesktop.org/git/mesa/mesa.git/

cd mesa

./autogen.sh --prefix=$MY_DISTRO_PREFIX --libdir=$MY_DISTRO_LIBDIR --with-dri-drivers="i915 i965" --with-dri-driverdir=$MY_DISTRO_PREFIX/lib/dri --enable-gles1--enable-gles2  --enable-shared-glapi  --with-gallium-drivers= --with-egl-platforms=x11,drm --enable-texture-float --enable-gbm --enable-glx-tls --enble-dri3

make

sudo make install

cd ..

#XSERVER
git clone https://anongit.freedesktop.org/git/xorg/xserver.git
cd xserver
./autogen.sh --prefix=$MY_DISTRO_PREFIX

make

sudo make install

cd ..

#LIBVA

git clone https://github.com/intel/libva.git
cd libva
./autogen.sh --prefix=$MY_DISTRO_PREFIX

make

sudo make install
cd ..

#VAAPI-INTEL-DRIVER
git clone https://github.com/intel/intel-vaapi-driver.git
cd intel-vaapi-driver
./autogen.sh --prefix=$MY_DISTRO_PREFIX

make

sudo make install
cd ..

#CAIRO

git clone https://anongit.freedesktop.org/git/cairo/
cd cairo
./autogen.sh --prefix=$MY_DISTRO_PREFIX

make

sudo make install

cd ..

#

#XORG INTEL-GPU-TOOLS
git clone https://anongit.freedesktop.org/git/xorg/app/intel-gpu-tools.git/

cd intel-gpu-tools

./autogen.sh --prefix=$MY_DISTRO_PREFIX --libdir=$MY_DISTRO_LIBDIR --disable-amdgpu

make

sudo make install

#File Tweaks
sudo rm -f /etc/X11/xorg.conf.d/20-modesetting.conf
sudo cp 20-modesetting.conf /etc/X11/xorg.conf.d/20-modesetting.conf
sudo cp i915.conf /etc/modprobe.d/

echo "Lets Go to init 2 now if all is good!! and run sudo ./setupX.sh"
