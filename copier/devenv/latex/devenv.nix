{ pkgs, lib, config, inputs, ... }:
{
  packages = with pkgs;[
    texliveFull
  ];

  env.TEXINPUTS = "${config.env.DEVENV_ROOT}/cls:";
  env.FONTCONFIG_FILE = pkgs.makeFontsConf {
    fontDirectories = [
      pkgs.atkinson-hyperlegible
      pkgs.charis-sil
    ];
  };

  enterShell = ''
    luaotfload-tool --update >/dev/null 2>&1 || true
  '';
}
