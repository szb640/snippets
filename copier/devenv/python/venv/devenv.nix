{ pkgs, lib, config, inputs, ... }:
{
  packages = with pkgs; [
    (python311.withPackages (pyPkgs: with pyPkgs; [
      pip
    ]))
  ];

  env.LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
    pkgs.zlib
    pkgs.openssl
    pkgs.stdenv.cc.cc
  ];

  enterShell = ''
    if [ ! -d ".venv" ]; then
      echo "Setting up virtual environment..."
      python3 -m venv .venv
      . .venv/bin/activate
      pip install pytest
    else
      echo "Activating virtual environment..."
      . .venv/bin/activate
    fi
  '';
}
