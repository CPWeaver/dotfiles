#!/bin/bash

cd ~/dev/tools/ || exit 1

function install_tool() {
  toolname=$1
  toolrepo=$2

  if [ ! -d "$HOME/dev/tools/$toolname" ]; then
    cd ~/dev/tools && git clone "$toolrepo"
  fi
}

function run_build_cmds() {
  toolname=$1
  shift
  echo "***"
  echo "*** Working on $toolname"
  echo "***"

  cd "$HOME/dev/tools/$toolname" || exit 1 
  git pull
  git clean -fdx
  commands=( "$@" )
  for command in "${commands[@]}"; do
    $command || exit 1
  done
}

function run_install_cmds() {
  toolname=$1
  shift
  echo "***"
  echo "*** Installing $toolname"
  echo "***"

  cd "$HOME/dev/tools/$toolname" || exit 1
  commands=( "$@" )
  for command in "${commands[@]}"; do
    $command || exit 1
  done
}

# install_tool "keepassxc" "git@github.com:keepassxreboot/keepassxc.git" 
install_tool "tmux"      "git@github.com:tmux/tmux.git" 
install_tool "neovim"    "git@github.com:neovim/neovim.git" 
install_tool "fzf"       "git@github.com:junegunn/fzf.git" 


platform=$(uname)

declare -a neovimbuild=(
  "neovim"
)
#declare -a neovimbuild=(
  #"neovim"
  #"make -j4"
#)

declare -a tmuxbuild=(
  "tmux"
  # "git checkout 875139f5"
  "./autogen.sh"
  "./configure"
  "make -j4"
)

declare -a keepassbuild=(
  "keepassxc"
  "mkdir build"
  "cd build"
)

declare -a fzfbuild=(
  "fzf"
)

if [[ $platform == "Darwin"* ]]; then
  keepassbuild+=("cmake -DCMAKE_OSX_ARCHITECTURES=x86_64 -DCMAKE_BUILD_TYPE=Release -DWITH_XC_ALL=ON ..")
  keepassbuild+=("make -j4 package")
fi

if [[ $platform == "Linux"* ]]; then
  keepassbuild+=("cmake -DWITH_XC_AUTOTYPE=ON -DWITH_XC_HTTP=ON -DWITH_XC_YUBIKEY=OFF \
                    -DCMAKE_BUILD_TYPE=Release ..")
  keepassbuild+=("make -j8")
fi

# run_build_cmds "${keepassbuild[@]}"
run_build_cmds "${tmuxbuild[@]}"
run_build_cmds "${neovimbuild[@]}"
run_build_cmds "${fzfbuild[@]}"

## No auto install on mac
if [[ $platform == "Linux"* ]]; then
  run_install_cmds "fzf"      "./install --all"
  #run_install_cmds "keepassxc" "sudo make install"
fi

run_install_cmds "tmux"     "sudo make install"
# run_install_cmds "keepassxc" "cd build" "pwd" "sudo make install"
run_install_cmds "neovim"   "sudo MACOSX_DEPLOYMENT_TARGET=10.14 make -j4 CMAKE_INSTALL_PREFIX=/usr/local CMAKE_BUILD_TYPE=Release" "sudo make -j4 install" "sudo git clean -fdx"
