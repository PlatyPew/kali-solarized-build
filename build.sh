# Pull modules
git submodule init
git submodule update --remote --recursive

# Copy relevant files
cp rice.list.chroot live-build-config/kali-config/variant-i3wm/package-lists/kali.list.chroot

# Live build
cd live-build-config
./build.sh --variant i3wm --verbose
