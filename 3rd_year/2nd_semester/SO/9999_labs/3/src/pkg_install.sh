echo "Attempting to build $PACKAGE_NAME..."

# 0. GNU AutoGen
[ -x "./autogen.sh" ] && { 
    echo "Found autogen.sh, running it..."
    ./autogen.sh || echo "autogen.sh failed"
}

# 1. GNU Autotools
if [ -x "./configure" ]; then
    echo "Found configure script, using autotools..."
    ./configure || echo "Configure failed"
    if make; then
        echo "Autotools build succeeded."
        make install || echo "Installation failed or interrupted."
        exit 0
    fi
fi

# 2. CMake with default generator (Makefiles)
if [ -f "CMakeLists.txt" ]; then
    echo "Found CMakeLists.txt, using CMake with Makefiles..."
    mkdir -p build
    cd build || exit 1
    cmake .. || echo "CMake configuration failed"
    if make; then
        echo "CMake build succeeded."
        make install || echo "Installation failed or interrupted."
        exit 0
    fi
    cd ..
fi

# 3. Plain Ninja
if [ -f "build.ninja" ]; then
    echo "Found build.ninja, using Ninja..."
    ninja || echo "Ninja build failed"
    ninja install || echo "Installation failed or interrupted"
    exit 0
fi

# 4. Plain Makefile
if [ -f "Makefile" ] || [ -f "makefile" ]; then
    echo "Found Makefile, using make..."
    if make; then
        echo "Make build succeeded."
        make install || echo "Installation failed or interrupted."
        exit 0
    fi
fi

# 5. Cargo (Rust)
if [ -f "Cargo.toml" ]; then
    echo "Found Cargo.toml, using Cargo..."
    cargo build --release || echo "Cargo build failed"
    cargo install --path . || echo "Cargo install failed or interrupted"
    exit 0
fi

echo "Error: No recognized build method succeeded."
exit 1
