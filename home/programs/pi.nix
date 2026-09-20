{ pkgs, ... }: {
  programs.pi-coding-agent = {
    enable = true;
    extraPackages = with pkgs; [
      nodejs
      bun
      gcc
      gnumake
      python3
    ];
  };
}
