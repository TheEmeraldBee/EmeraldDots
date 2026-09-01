{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Home Manager
    home-manager

    # AI
    claude-code

    # Formatter
    alejandra
    nixfmt

    # Language Servers
    nixd
    tombi
    markdown-oxide
    just-lsp
    texlab
    ruff
    ty

    # Game Dev
    godot_4

    # CLI
    ripgrep

    # Build
    just
  ];
}
