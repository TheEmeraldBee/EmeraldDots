{ ... }: {
  programs.yazi = {
    enable = true;

    keymap.mgr.prepend_keymap = [
      {
        on = "B";
        run = "shell 'set -- %s; first=1; for f in \"$@\"; do if [ \"$first\" = 1 ]; then zen --new-window \"file://$f\"; first=0; else zen --new-tab \"file://$f\"; fi; done' --confirm";
        desc = "Open selected files in zen (one window)";
      }
    ];
  };
}
