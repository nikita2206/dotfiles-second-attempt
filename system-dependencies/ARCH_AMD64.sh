# dstask
EXE="$(
    obtain \
        https://github.com/naggie/dstask/releases/download/v0.14/dstask-linux-amd64 \
        03ecaf42a662e14a564d2e5fed94b64852ea45da0b0235049ba4d35596e3272b
)"
sudo cp "${EXE}" /usr/local/bin/dstask.new
sudo chmod +x /usr/local/bin/dstask.new
sudo mv -f /usr/local/bin/{dstask.new,dstask}

sudo pacman --noconfirm -Syu \
    bash-completion \
    curl \
    etckeeper \
    ffmpeg \
    fzf \
    git \
    gnupg \
    go \
    htop \
    httpie \
    httrack \
    jq \
    ncdu \
    neovim \
    openssh \
    pass \
    python \
    ripgrep \
    sox \
    tig \
    tmux \
    tree \
    unzip \
    upx \
    vim \
    wget \
    zsh \

# TODO yubikey stuff
# TODO tmpreaper
# TODO Nvidia, AMD, Intel display drivers

# browserpass host
TARGZ="$(
    obtain \
        https://github.com/browserpass/browserpass-native/releases/download/3.0.6/browserpass-linux64-3.0.6.tar.gz \
        f63047cbde5611c629b9b8e2acf6e8732dd4d9d64eba102c2cf2a3bb612b3360
)"
[ -f /usr/local/bin/browserpass ] && sudo rm -f /usr/local/bin/browserpass
sudo tar -C /usr/local/bin/ --strip=1 -xzf "$TARGZ" browserpass-linux64-3.0.6/browserpass-linux64
sudo mv /usr/local/bin/browserpass-linux64 /usr/local/bin/browserpass
