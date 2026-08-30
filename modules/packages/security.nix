{pkgs, ...}: {
  # primary secrets manager, credentials never live in nix store files
  environment.systemPackages = with pkgs; [
    bitwarden-desktop
    bitwarden-cli
  ];
}
