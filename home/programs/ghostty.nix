{ ... }: {
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "Kanagawa Dragon";
      font-family = "Hack Nerd Font Mono";
      background-opacity = 0.8;
      working-directory = "inherit";
      window-inherit-working-directory = true;
    };
  };
}
