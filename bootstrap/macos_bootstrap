#!/bin/bash
# 
# Bootstrap script for setting up a new OSX machine
# 
# This should be idempotent so it can be run multiple times.
#
# Notes:
#
# - If installing full Xcode, it's better to install that first from the app
#   store before running the bootstrap script. Otherwise, Homebrew can't access
#   the Xcode libraries as the agreement hasn't been accepted yet.
#
# Reading:
#
# - http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac
# - https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716
# - https://news.ycombinator.com/item?id=8402079
# - http://notes.jerzygangi.com/the-best-pgp-tutorial-for-mac-os-x-ever/
set -e
echo "Starting bootstrapping"

pushd .
cd

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
PATH=$PATH:/opt/homebrew/bin/brew

# Update homebrew recipes
brew update
brew upgrade

PACKAGES=(
   zsh
   git
   coreutils
   ack
   imagemagick
   python3
   rename
   tree
   p7zip
   openssl
   gnu-sed
   node
   jq
   scrcpy
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Cleaning up..."
brew cleanup

NPM_PACKAGES=(
    @aws-amplify/cli
    git-branch-delete
    avocado
    firebase-tools
)

echo "Installing NPM packages"
npm i -g ${NPM_PACKAGES[@]}

echo "Installing Zulu JDK 11 for ARM"
brew tap mdogan/zulu
brew install --cask zulu-jdk11

echo "Installing Fluter version manager"
brew tap leoafarias/fvm
brew install fvm

CASKS=(
    slack
    vlc
    postman
    spotify
    visual-studio-code
    1password
    iterm2
    tunnelblick
)

echo "Installing cask apps..."
brew install --cask ${CASKS[@]}

echo "Creating folder structure..."
[[ ! -d Workspace ]] && mkdir Workspace

echo "Installing Oh My Zsh"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Configuring Zsh"
curl https://gist.githubusercontent.com/Nimrodda/a4d411b969d7b31b739e0f087737d85b/raw/665c34e74dc254ef933234615a32eff14b935f54/zshrc -o ~/.zshrc

echo "Bootstrapping complete"
popd
