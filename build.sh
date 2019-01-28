# Ensure script is executed in correct directory
DIR="$(cd "$(dirname "$0")" && pwd)"
cd ${DIR}

# Pull modules
git submodule init
git submodule update --remote --recursive

# Include packages
cp rice-kali.list.chroot ./live-build-config/kali-config/variant-i3wm/package-lists/kali.list.chroot

# Include install scripts
cp install-scripts/* live-build-config/kali-config/common/hooks/live

# Copy wallpapers
mkdir -p live-build-config/kali-config/common/includes.chroot/root/Pictures
cp -r solarized_wallpaper ./live-build-config/kali-config/common/includes.chroot/root/Pictures

# Copy fonts
mkdir -p live-build-config/kali-config/common/includes.chroot/root/.local/share/fonts
cp 'fonts/Inconsolata Nerd Font Complete.otf' ./live-build-config/kali-config/common/includes.chroot/root/.local/share/fonts

# Install vim plug
mkdir -p ./live-build-config/kali-config/common/root/includes.chroot/.local/share/nvim/site/autoload
wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -O ./live-build-config/kali-config/common/root/includes.chroot/.local/share/nvim/site/autoload/plug.vim

# Install oh my zsh
mkdir -p ./live-build-config/kali-config/common/includes.chroot/root/.oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ./live-build-config/kali-config/common/includes.chroot/root/.oh-my-zsh
sed -i '1iexec zsh' ./live-build-config/kali-config/common/includes.chroot/root/.bashrc

# Begin live build
cd live-build-config
./build.sh --variant i3wm --verbose
