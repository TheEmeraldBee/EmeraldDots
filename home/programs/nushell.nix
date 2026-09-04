{ config, ... }: {
  programs.nushell = {
    enable = true;

    settings.show_banner = false;

    shellAliases.d = "yazi";
    shellAliases.dots = "cd ~/dotfiles";

    shellAliases.zi = "__zoxide_zi";

    environmentVariables.EDITOR = "hx";
    # Bitwarden desktop's SSH agent (its own socket, not the system ssh-agent)
    environmentVariables.SSH_AUTH_SOCK = "${config.home.homeDirectory}/.bitwarden-ssh-agent.sock";

    environmentVariables.QT_QPA_PLATFORM = "wayland";

    envFile.text = ''
      def --env source-posix-env [file: string] {
        if ($file | path exists) {
          let vars = (
            ^bash -c $"source '($file)' 2>/dev/null; env -0"
            | split row (char nul)
            | where {|x| ($x | str length) > 0 }
          )
          for pair in $vars {
            let parts = ($pair | split column "=" -n 2 key value)
            if ($parts | length) == 1 {
              let key = ($parts | get 0.key)
              let value = ($parts | get 0.value)
              if $key == "PATH" {
                $env.PATH = ($value | split row (char esep))
              } else {
                # skips vars nushell manages itself, like PWD
                try { load-env {($key): $value} }
              }
            }
          }
        }
      }

      source-posix-env $"($env.HOME)/.nix-profile/etc/profile.d/hm-session-vars.sh"
    '';

    extraConfig = ''
      def b [file: path] {
        ^zen --blank-window $"file://($file | path expand)"
      }

      # A diff-helper for jujutsu
      def jd [--help(-h), --unified(-u), branch?:string] {
        mut branch = $branch

        if ($branch | is-empty) {
          $branch = "@-"
        }
        
        let text = jj diff --to @ --from $branch
        if $unified {
          $text | diffnav -u
        } else {
          $text | diffnav -s
        }
      }

      # hand-applied since noctalia has no nushell theming template
      $env.config.color_config = {
        separator: "#54546d"
        leading_trailing_space_bg: { attr: "n" }
        header: "#7e9cd8"
        empty: "#7fb4ca"
        bool: "#957fb8"
        int: "#d27e99"
        filesize: "#98bb6c"
        duration: "#98bb6c"
        date: "#98bb6c"
        range: "#d27e99"
        float: "#d27e99"
        string: "#dcd7ba"
        nothing: "#727169"
        binary: "#957fb8"
        cell-path: "#dcd7ba"
        row_index: "#7e9cd8"
        record: "#dcd7ba"
        list: "#dcd7ba"
        block: "#dcd7ba"
        hints: "#727169"
        search_result: { fg: "#1f1f28" bg: "#e6c384" }
      }
    '';
  };
}
