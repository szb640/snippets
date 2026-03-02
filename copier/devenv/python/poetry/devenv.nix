{ pkgs, lib, config, inputs, ... }:
{
  overlays = [
    (final: prev: {
      poetry = prev.poetry.override { python3 = prev.python311; };
    })
  ];

  env.LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
    pkgs.zlib
    pkgs.openssl
    pkgs.stdenv.cc.cc
  ];

  packages = with pkgs; [
    python311
    poetry
  ];
}
