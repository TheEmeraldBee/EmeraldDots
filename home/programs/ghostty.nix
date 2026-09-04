{ ... }: {
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "Kanagawa Dragon";
      background-opacity = 0.8;
      working-directory = "inherit";
      window-inherit-working-directory = true;
    };
  };
}
