# Ensure script is executed in correct directory
DIR="$(cd "$(dirname "$0")" && pwd)"
cd ${DIR}

# Pull modules
git submodule update --init --remote --recursive

# Include packages
cp rice-kali.list.chroot ./live-build-config/kali-config/variant-i3wm/package-lists/kali.list.chroot

# Include install scripts
cp install-scripts/* live-build-config/kali-config/common/hooks/live

# Copy wallpapers
mkdir -p live-build-config/kali-config/common/includes.chroot/root/Pictures
cp -r solarized_wallpaper ./live-build-config/kali-config/common/includes.chroot/root/Pictures
mkdir -p live-build-config/kali-config/common/includes.chroot/root/.config/i3
cp -r lockscreen live-build-config/kali-config/common/includes.chroot/root/.config/i3

# Copy fonts
mkdir -p live-build-config/kali-config/common/includes.chroot/root/.local/share/fonts
cp 'fonts/Inconsolata Nerd Font Complete.otf' ./live-build-config/kali-config/common/includes.chroot/root/.local/share/fonts

# Install vim plug
curl -fLo live-build-config/kali-config/common/includes.chroot/root/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Include dotfiles
git clone --recursive https://github.com/PlatyPew/dotfiles-kali.git ./live-build-config/kali-config/common/includes.chroot/root/.dotfiles

# Install oh my zsh
mkdir -p ./live-build-config/kali-config/common/includes.chroot/root/.oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ./live-build-config/kali-config/common/includes.chroot/root/.oh-my-zsh
sed -i '1iexec zsh' ./live-build-config/kali-config/common/includes.chroot/root/.bashrc
git clone https://github.com/zsh-users/zsh-completions.git ./live-build-config/kali-config/common/includes.chroot/root/.oh-my-zsh/custom/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ./live-build-config/kali-config/common/includes.chroot/root/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Begin live build
cd live-build-config
./build.sh --variant i3wm --verbose
