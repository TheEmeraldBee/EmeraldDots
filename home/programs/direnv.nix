{ ... }: {
  programs.direnv = {
    enable = true;
    enableNushellIntegration = true;
    # caches plain use_nix/use_flake shells, devenv caches itself separately
    nix-direnv.enable = true;
  };
}
