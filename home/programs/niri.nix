{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  niriSettings = with config.lib.niri.actions; {
    outputs = {
      "DP-4" = {
        mode = {
          width = 3840;
          height = 2160;
          refresh = 60.000;
        };
        position = {
          x = 0;
          y = 0;
        };
        scale = 1.5;
      };
      "eDP-2" = {
        mode = {
          width = 2560;
          height = 1600;
          refresh = 165.000;
        };
        position = {
          x = 2560;
          y = 500;
        };
        scale = 1.5;
      };
    };

    cursor = {
      theme = "Bibata-Modern-Classic";
      size = 18;
    };

    input = {
      keyboard.xkb.layout = "us";

      touchpad = {
        tap = true;
        natural-scroll = true;
      };

      mouse.natural-scroll = true;

      warp-mouse-to-focus = {
        enable = true;
        mode = "center-xy";
      };

      focus-follows-mouse = {
        enable = true;
        max-scroll-amount = "0%";
      };
    };

    layout = {
      gaps = 16;
      empty-workspace-above-first = true;
      center-focused-column = "never";

      background-color = "transparent";

      preset-column-widths = [
        { proportion = 0.25; }
        { proportion = 0.33333; }
        { proportion = 0.5; }
        { proportion = 0.66667; }
        { proportion = 0.75; }
        { proportion = 1.0; }
      ];
      default-column-width.proportion = 0.5;

      border = {
        enable = true;
        width = 4;
        active.gradient = {
          from = "#8fd694";
          to = "#2e6b32";
          angle = 45;
          relative-to = "window";
        };
        inactive.gradient = {
          from = "#6b6b6b";
          to = "#2a2a2a";
          angle = 45;
          relative-to = "window";
        };
      };

      shadow.enable = true;
      focus-ring.enable = false;
    };

    spawn-at-startup = [
      { argv = [ "noctalia" ]; }
    ];

    debug.honor-xdg-activation-with-invalid-serial = [ ];

    window-rules = [
      {
        geometry-corner-radius = {
          top-left = 12.0;
          top-right = 12.0;
          bottom-right = 12.0;
          bottom-left = 12.0;
        };
        clip-to-geometry = true;
        draw-border-with-background = false;
      }
      {
        matches = [ { app-id = "dev.noctalia.Noctalia"; } ];
        open-floating = true;
        default-column-width.fixed = 1080;
        default-window-height.fixed = 920;
      }
    ];

    layer-rules = [
      {
        place-within-backdrop = true;
      }
    ];

    prefer-no-csd = true;

    binds = {
      "Mod+Return".action = spawn "ghostty" "--background-opacity=0.85";
      "Mod+E".action = spawn "zen";
      "Mod+Space".action = spawn "noctalia" "msg" "panel-toggle" "launcher";
      "Mod+Q".action = close-window;

      "Mod+H".action = focus-column-left;
      "Mod+L".action = focus-column-right;
      "Mod+J".action = focus-window-down;
      "Mod+K".action = focus-window-up;

      "Mod+Alt+H".action = move-column-left;
      "Mod+Alt+L".action = move-column-right;
      "Mod+Alt+J".action = move-window-down;
      "Mod+Alt+K".action = move-window-up;

      "Mod+Comma".action = consume-window-into-column;
      "Mod+Period".action = expel-window-from-column;
      "Mod+W".action = toggle-column-tabbed-display;

      "Mod+Shift+J".action = focus-workspace-down;
      "Mod+Shift+K".action = focus-workspace-up;
      "Mod+Alt+Shift+J".action = move-window-to-workspace-down;
      "Mod+Alt+Shift+K".action = move-window-to-workspace-up;

      "Mod+N".action = focus-monitor-right;
      "Mod+Shift+N".action = focus-monitor-left;
      "Mod+Alt+N".action = move-window-to-monitor-right;
      "Mod+Alt+Shift+N".action = move-window-to-monitor-left;

      "Mod+V".action = toggle-window-floating;
      "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;

      "Mod+Minus".action = set-column-width "-10%";
      "Mod+Equal".action = set-column-width "+10%";
      "Mod+Shift+Minus".action = set-window-height "-10%";
      "Mod+Shift+Equal".action = set-window-height "+10%";

      "Mod+Shift+R".action = expand-column-to-available-width;
      "Mod+R".action = switch-preset-column-width;
      "Mod+M".action = switch-preset-window-height;
      "Mod+Shift+M".action = reset-window-height;

      "Mod+F".action = maximize-column;
      "Mod+Shift+F".action = fullscreen-window;

      # "Mod+Shift+S".action = screenshot;
      # "Mod+Ctrl+Shift+S".action = screenshot-window;

      "Mod+Shift+Slash".action = show-hotkey-overlay;

      "Mod+O".action = toggle-overview;
      "Mod+Ctrl+Shift+Q".action = quit;
    };
  };

  # window blur has no typed option in niri-flake's settings schema, grafted on below via lib.internal
  renderedSettings =
    (lib.evalModules {
      modules = [
        inputs.niri.lib.internal.settings-module
        { programs.niri.settings = niriSettings; }
      ];
    }).config.programs.niri.config;

  blurWindowRule =
    inputs.niri.lib.kdl.node "window-rule"
      [ ]
      [
        (inputs.niri.lib.kdl.node "background-effect"
          [ ]
          [
            (inputs.niri.lib.kdl.node "blur" [ true ] [ ])
          ]
        )
      ];
in
{
  imports = [ inputs.niri.homeModules.niri ];

  programs.niri.enable = true;
  # nixpkgs' package, not niri-flake's vendored build, see modules/desktop/niri.nix
  programs.niri.package = pkgs.niri;

  programs.niri.config = renderedSettings ++ [ blurWindowRule ];
}
