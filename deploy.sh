#!/bin/bash
set -e

if [ "$1" = "--install" ]; then
  # identify package manager, upgrade and install OS specific packages
  if hash pacman 2>/dev/null; then
      # Arch linux
      pacman -Syu --noconfirm --needed sudo || true
      sudo pacman -Syu --noconfirm
      sudo pacman -S --noconfirm --needed base-devel zsh-completions
      # dual-booting
      #sudo pacman -S os-prober
      pacman_bin="pacman -S --noconfirm --needed"
  elif hash dnf 2>/dev/null; then
      # Fedora
      dnf -y install sudo || true
      sudo dnf -y upgrade
      sudo dnf -y group install 'Development Tools'
      sudo dnf -y install util-linux-user
      pacman_bin="dnf -y install"
  elif hash apt-get 2>/dev/null; then
      # Debian/Ubuntu
      apt-get -y update || true
      apt-get -y install sudo || true
      sudo apt-get -y update
      sudo apt-get -y upgrade
      sudo apt-get -y install build-essential libpam-systemd
      pacman_bin="apt-get -y install"
  else
      pacman_bin=/bin/false
  fi

  # install basic packages
  sudo $pacman_bin git tmux htop zip unzip curl
fi

# get submodules
git submodule init
git submodule update --recursive --remote

# copy vim config
ln -srfv _vimrc ~/.vimrc

# copy tmux config
ln -srfv _tmux.conf ~/.tmux.conf

# copy binaries
mkdir -vp ~/bin
ln -srfv bin/* ~/bin/

# copy ssh config
mkdir -p ~/.ssh
ln -srfv _ssh_config ~/.ssh/config