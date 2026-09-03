{ pkgs, ... }:
let
  gitCredentialBitwarden = pkgs.writeShellApplication {
    name = "git-credential-bitwarden";
    runtimeInputs = [
      pkgs.bitwarden-cli
      pkgs.jq
    ];
    text = ''
      [ "''${1:-}" = "get" ] || exit 0
      [ -n "''${BW_SESSION:-}" ] || exit 0

      host=""
      while IFS='=' read -r key value; do
        [ "$key" = "host" ] && host="$value"
      done

      [ -n "$host" ] || exit 0

      item=$(bw get item "$host" --session "$BW_SESSION" 2>/dev/null) || exit 0
      [ -n "$item" ] || exit 0

      username=$(jq -r '.login.username // empty' <<< "$item")
      password=$(jq -r '.login.password // empty' <<< "$item")

      [ -n "$username" ] && printf 'username=%s\n' "$username"
      [ -n "$password" ] && printf 'password=%s\n' "$password"
    '';
  };
in
{
  programs.git = {
    enable = true;
    settings = {
      user.email = "brightonlcox@gmail.com";
      user.name = "Brighton Cox";
      credential.helper = "${gitCredentialBitwarden}/bin/git-credential-bitwarden";
    };
  };
}
