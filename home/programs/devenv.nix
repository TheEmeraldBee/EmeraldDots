{pkgs, ...}: {
  home.packages = with pkgs; [
    devenv
  ];

  # per project: devenv init --include-envrc && direnv allow
}
