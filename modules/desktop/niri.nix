{ ... }: {
  # config lives in home/programs/niri.nix, kept decoupled from niri-flake's nixos module
  programs.niri.enable = true;
}
