function update-nvim
    set -l previous_dir (pwd)
    cd ~/src/neovim
    git pull
    git clean -fx
    make clean
    rm -Rf .deps
    make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.local" CMAKE_BUILD_TYPE=RelWithDebInfo
    make install
    cd $previous_dir
end
