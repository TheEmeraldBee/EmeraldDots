{ ... }: {
  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
    # replaces cd itself with zoxide's fuzzy jump
    options = [
      "--cmd"
      "cd"
    ];
  };
}
