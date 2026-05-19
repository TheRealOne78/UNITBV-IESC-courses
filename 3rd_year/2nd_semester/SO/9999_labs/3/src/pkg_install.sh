#!/usr/bin/env sh

usage() {
    echo "Usage: $0 <url>" >&2
    echo "Download, extract/clone, build and install a package" >&2
}

[ "$#" -ne 1 ] && { usage; exit 1; }

PACKAGE_URL="$1"
PACKAGE_NAME=$(basename "$PACKAGE_URL")

download_source() {
    url="$1"

    # Try git first
    if command -v git >/dev/null 2>&1; then
        echo "Attempting to clone as git repo..."
        dir="src_$$"  # unique temporary folder for this clone
        if git clone "$url" "$dir" 2>/dev/null; then
            cd "$dir" || return 1
            return 0
        fi
        echo "Not a git repo (or clone failed), falling back..."
    fi

    # Download
    file=$(basename "$url")
    echo "Downloading $file..."

    if command -v curl >/dev/null 2>&1; then
        curl -L -o "$file" "$url" || return 1
    elif command -v wget >/dev/null 2>&1; then
        wget -O "$file" "$url" || return 1
    else
        echo "Error: need curl or wget"
        return 1
    fi

    extract_archive "$file" || return 1
    enter_source_dir
}

extract_archive() {
    file="$1"
    echo "Extracting $file with bsdtar..."
    bsdtar -xf "$file" || return 1
}

enter_source_dir() {
    dir=$(find . -maxdepth 1 -type d ! -name . | head -n 1)
    if [ -n "$dir" ]; then
        cd "$dir" || {
            echo "Failed to cd into $dir"
            return 1
        }
    else
        echo "Could not determine source directory"
        return 1
    fi
}




# prep src
download_source "$PACKAGE_URL" || {
    echo "Failed to prepare source"
    exit 1
}

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
