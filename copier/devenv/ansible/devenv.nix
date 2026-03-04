{pkgs, ...}:
{
  packages = with pkgs; [
    ansible
    just
  ];
}
