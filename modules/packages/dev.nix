{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    alejandra
    claude-code
    godot_4
    home-manager
    just
    nixfmt
    ripgrep
  ];
}
