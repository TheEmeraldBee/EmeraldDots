{ ... }: {
  # enables greetd and points its session command at noctalia-greeter itself
  programs.noctalia-greeter = {
    enable = true;
    settings = {
      keyboard.layout = "us";

      # "Synced" reads the palette/wallpaper noctalia's shell.greeter_sync
      # pushes over from the live session, see home/programs/noctalia.nix
      appearance = {
        scheme = "Synced";
        theme_mode = "dark";
      };
    };
  };

  # this laptop's two amdgpu devices can still be loading firmware when
  # greetd starts, so /dev/dri/cardN doesn't exist yet and the compositor
  # fails immediately; wait for udev to finish creating device nodes, and
  # give it more room to retry in case the timing varies boot-to-boot
  systemd.services.greetd = {
    after = [ "systemd-udev-settle.service" ];
    wants = [ "systemd-udev-settle.service" ];
    startLimitIntervalSec = 60;
    startLimitBurst = 10;
    serviceConfig.RestartSec = "2s";
  };
}
