{...}: {
  programs.helix = {
    enable = true;
    themes = {
      kanagawa-invis = {
        inherits = "kanagawa";
        "ui.background" = { };
        "ui.statusline.normal" = {fg = "#181616"; bg = "#8ba4b0"; modifiers = ["bold"];};
        "ui.statusline.insert" = {fg = "#181616"; bg = "#87a987"; modifiers = ["bold"];};
        "ui.statusline.select" = {fg = "#181616"; bg = "#a292a3"; modifiers = ["bold"];};
        "ui.bufferline" = {fg = "#a6a69c"; bg = "#282727"; };
        "ui.bufferline.active" = {fg = "#181616"; bg = "#c8c093"; modifiers = ["bold"]; };
      };
    };
    settings = {
      theme = "kanagawa-invis";

      editor = {
        shell = ["nu" "-c"];
        text-width = 80;
        bufferline = "multiple";
        color-modes = true;

        soft-wrap.enable = false;
        soft-wrap.wrap-at-text-width = true;

        statusline = {
          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "VISUAL";
        };
        
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };

      keys.normal = {
        ";" = {
          f = ":format";
          w = ":write";
          q = ":bc";
          Q = ":q";
          s.w = ":toggle-option soft-wrap.enable";
          r = ":reload";
        };

        space.f = {
          f = "file_picker";
          t = [
            ":sh rm -f /tmp/unique-file"
            ":insert-output yazi \"%{buffer_name}\" --chooser-file=/tmp/unique-file"
            ":sh printf \"\\u{1b}[?1049h\\u{1b}[?2004h\" o+e> /dev/tty"
            ":open %sh{cat /tmp/unique-file | lines | str join \" \"}"
            ":redraw"
          ];
        };
      };
    };
  };
}
