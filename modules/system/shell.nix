{pkgs, ...}: {
  programs.nushell.enable = true;
  environment.shells = [pkgs.nushell];
}
