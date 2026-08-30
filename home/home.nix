{hostname, ...}: {
  imports = [
    ./programs/shell.nix
    ./programs/nushell.nix
    ./programs/starship.nix
    ./programs/fzf.nix
    ./programs/zoxide.nix
    ./programs/carapace.nix
    ./programs/direnv.nix
    ./programs/git.nix
    ./programs/jujutsu.nix
    ./programs/zellij.nix
    ./programs/ghostty.nix
    ./programs/helix.nix
    ./programs/niri.nix
    ./programs/spotify.nix
    ./programs/noctalia.nix
    ./programs/yazi.nix
    ./programs/devenv.nix
    ./hosts/${hostname}.nix
  ];

  home.username = "brightonlcox";
  home.homeDirectory = "/home/brightonlcox";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
