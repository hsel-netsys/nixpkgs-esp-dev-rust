{ pkgs ? import ../default.nix  }:
pkgs.mkShell {
  name = "esp-idf";

  buildInputs = with pkgs; [
    esp-idf-esp32s3

    # Tools required to use ESP-IDF.
    git
    wget
    gnumake

    flex
    bison
    gperf
    pkg-config
    cargo-generate

    cmake
    ninja

    ncurses5

    llvm-xtensa
    llvm-xtensa-lib
    rust-xtensa

    ldproxy
    espflash

    python3
    python3Packages.pip
    python3Packages.virtualenv
  ];
  shellHook = ''
    # fixes libstdc++ issues and libgl.so issues
    export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [ pkgs.libxml2 pkgs.zlib pkgs.stdenv.cc.cc.lib ]}
    export ESP_IDF_VERSION=v5.3
    export LIBCLANG_PATH=${pkgs.llvm-xtensa-lib}/lib
    export RUSTFLAGS="--cfg espidf_time64"
  '';
}
