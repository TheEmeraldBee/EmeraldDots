{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  # a version-controlled snapshot of noctalia's live settings.toml
  # keep the bar named "default", not "main", or two bars render at once
  programs.noctalia = {
    enable = true;
    settings = {
      backdrop.enabled = true;

      dock.reserve_space = false;

      # keeps noctalia-greeter's wallpaper and colors matching the live session
      # forced to pkexec: run0 would otherwise be preferred and hits systemd's
      # broad manage-units polkit action instead of the scoped rule in
      # modules/desktop/noctalia.nix
      shell.greeter_sync = {
        auto_sync = true;
        privilege_command = "pkexec";
      };

      location = {
        auto_locate = true;
        sunrise = "07:00";
        sunset = "21:00";
      };

      nightlight = {
        enabled = true;
        temperature_night = 4600;
      };

      shell = {
        niri_overview_type_to_launch_enabled = true;
        settings_window_translucent = true;
        panel.transparency_mode = "glass";
      };

      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Kanagawa";
        community_palette = "Oxocarbon";
        wallpaper_scheme = "m3-rainbow";

        templates = {
          enable_builtin_templates = true;
          builtin_ids = [
            "gtk3"
            "gtk4"
            "niri"
          ];
        };
      };

      wallpaper = {
        enabled = true;
        directory = "~/Wallpapers";
        default.path = "/home/brightonlcox/Wallpapers/celeste.png";
        automation = {
          enabled = true;
          interval_seconds = 100;
        };
        # wallpaper.last / wallpaper.monitors.* omitted, automation rewrites them constantly
      };

      weather.unit = "imperial";

      widget = {
        brightness.show_label = false;
        clock.format = "{:%I:%M %P - %h %d}";
        control-center.glyph = "progress";
        network.show_label = false;
        volume.show_label = false;
      };

      bar.default = {
        background_opacity = 0.17999999597668648;
        border = "primary";
        border_width = 1.0;
        capsule = true;
        capsule_opacity = 0.669999985024333;
        capsule_padding = 8.0;
        icon_color = "primary";
        margin_edge = 8;
        padding = 12;
        widget_spacing = 10;

        start = [
          "launcher"
          "wallpaper"
          "battery"
          "power_profile"
        ];
        center = [
          "media"
          "control-center"
        ];
        end = [
          "bluetooth"
          "network"
          "volume"
          "brightness"
          "clock"
          "session"
          "notifications"
        ];
      };

      lockscreen_widgets = {
        enabled = false;
        schema_version = 2;
        widget_order = [
          "lockscreen-login-box@DP-4"
          "lockscreen-login-box@eDP-2"
        ];

        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = true;
        };

        widget."lockscreen-login-box@DP-4" = {
          type = "login_box";
          output = "DP-4";
          cx = 1280.0;
          cy = 1258.0;
          box_width = 810.0;
          box_height = 196.0;
          placement_width = 2560.0;
          placement_height = 1440.0;
          rotation = 0.0;

          settings = {
            layout = "regular";
            background_color = "surface_variant";
            background_opacity = 0.88;
            background_radius = 12.0;
            input_opacity = 1.0;
            input_radius = 6.0;
            center_password_text = false;
            show_caps_lock = true;
            show_keyboard_layout = true;
            show_login_button = true;
            show_media = true;
            show_session_buttons = true;
            show_unlock_hint = true;
            show_weather = true;
          };
        };

        widget."lockscreen-login-box@eDP-2" = {
          type = "login_box";
          output = "eDP-2";
          cx = 854.0;
          cy = 885.0;
          box_width = 810.0;
          box_height = 196.0;
          placement_width = 1707.0;
          placement_height = 1067.0;
          rotation = 0.0;

          settings = {
            layout = "regular";
            background_color = "surface_variant";
            background_opacity = 0.88;
            background_radius = 12.0;
            input_opacity = 1.0;
            input_radius = 6.0;
            center_password_text = false;
            show_caps_lock = true;
            show_keyboard_layout = true;
            show_login_button = true;
            show_media = true;
            show_session_buttons = true;
            show_unlock_hint = true;
            show_weather = true;
          };
        };
      };
    };
  };
}
