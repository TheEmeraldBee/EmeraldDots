{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Home Manager
    home-manager

    # AI
    claude-code

    # Formatter
    nixfmt
    stylua

    # Language Servers
    nixd
    tombi
    markdown-oxide
    just-lsp
    texlab
    ruff
    ty
    lua-language-server

    # Game Dev
    godot_4

    # CLI
    ripgrep

    # Build
    just
  ];
}
