{ config, ... }:
let
  # Kept as a plain string, not a Nix path, so it points at the live repo on
  # disk rather than a copy in the Nix store
  nuDir = "${config.home.homeDirectory}/dotfiles/home/programs/nushell";
in
{
  home.file.".scripts".source = config.lib.file.mkOutOfStoreSymlink ../programs/scripts;

  programs.nushell = {
    enable = true;

    extraConfig = "source ${nuDir}/config.nu\n";
    extraEnv = "source ${nuDir}/env.nu\n";
  };
}
