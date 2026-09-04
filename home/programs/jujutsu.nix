{ ... }: {
  programs.jujutsu = {
    enable = true;
    settings = {
      user.email = "brightonlcox@gmail.com";
      user.name = "Brighton Cox";

      ui.default-command = "status";
      ui.diff-formatter = ":git";
    };
  };
}
