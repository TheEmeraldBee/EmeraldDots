$env.EDITOR = "hx"
# Bitwarden desktop's SSH agent (its own socket, not the system ssh-agent)
$env.SSH_AUTH_SOCK = $"($env.HOME)/.bitwarden-ssh-agent.sock"
$env.QT_QPA_PLATFORM = "wayland"

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

$env.PATH = ($env.PATH | prepend $"($env.HOME)/.scripts")
