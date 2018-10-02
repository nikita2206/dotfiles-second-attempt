#!/bin/bash
# This script installs dependencies required by dotfiles, and then the configuration files with git repo.

set -e
set -x
# curl -sL https://github.com/naggie/dotfiles/raw/master/provision.sh | bash && bash

cat <<EOF
This script is intended to be run once. It will install packages then sync
dotfiles.

Hit CTRL+C to abort in the next 3 seconds....

EOF

sleep 3

# tmpreaper tries to do a post-install "configuration" screen to warn the user.
export DEBIAN_FRONTEND=noninteractive

# packages are installed via the stock system package manager unless a more
# recent version is available elsewhere.

if [ $(uname) == 'Darwin' ]; then
    # macos
    if [ ! -f /usr/local/bin/brew ]; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        brew update
    fi

    # recommended, uses /Applications now.
    brew tap caskroom/homebrew-cask
    brew cask install google-chrome spectacle

    # flux is no longer required -- night shift!

    # Upgrade or install (logic necessary)
    packages=(tmux vim git tig httpie ncdu tree bash openssh jq wget task htop gnupg2 bash-completion keychain iproute2mac tmpreaper coreutils sox ffmpeg httrack python)
    for package in "${packages[@]}"; do
        brew upgrade $package || brew install $package
    done

    pip install ansible ipython

    # correct so alias works cross platform
    ln -sf /usr/local/bin/gpg /usr/local/bin/gpg2

elif grep -q Ubuntu /etc/issue || grep -q Raspbian /etc/issue; then
    if grep -q Ubuntu /etc/issue; then
        sudo -E apt-add-repository multiverse
        sudo -E apt-get -y install language-pack-en
    fi

    sudo -E apt-get -y update
    sudo -E apt-get -y install tmux vim git tig ssh figlet httpie ncdu tree wget htop gnupg2 curl keychain tmpreaper bash-completion jq sox ffmpeg httrack python-pip
    pip install --user ansible ipython
    sudo -E ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
else
    echo "Unsupported OS."
    exit 2
fi


# all platforms

# clone main repository to home
cd ~
test ! -d ~/dotfiles && git clone https://github.com/naggie/dotfiles.git
cd dotfiles

# Adobe source code pro (powershell patched)
./etc/powerline-patched/install.sh

# install dotfile configuration
./install.sh
