{...}: {
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;

    # hardcoded Kanagawa colors, not noctalia's starship template, see home/programs/noctalia.nix
    settings = {
      add_newline = true;
      command_timeout = 1000;

      format = ''
        $directory$git_branch$git_status$nix_shell$fill$shell
        $character'';
      right_format = "$cmd_duration";

      fill.symbol = " ";

      shell = {
        disabled = false;
        format = "[$indicator]($style)";
        style = "dimmed #ffa066";
      };

      character = {
        success_symbol = "[❯](dimmed #98bb6c)";
        error_symbol = "[❯](dimmed #c34043)";
      };

      directory = {
        style = "bold #7e9cd8";
        truncation_length = 3;
        truncate_to_repo = true;
      };

      git_branch = {
        style = "#957fb8";
        symbol = " ";
        format = "[$symbol$branch]($style) ";
      };

      git_status = {
        style = "#e6c384";
        format = "([$all_status$ahead_behind]($style)) ";
      };

      nix_shell = {
        symbol = " ";
        style = "bold #7aa89f";
        format = "[$symbol$name]($style) ";
      };

      cmd_duration = {
        style = "#dcd7ba";
        format = "[$duration]($style)";
      };
    };
  };
}
