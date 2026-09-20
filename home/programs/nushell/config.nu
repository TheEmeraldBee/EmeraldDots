$env.config.show_banner = false

alias d = yazi
alias dots = cd ~/dotfiles
alias zi = __zoxide_zi

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

def jm --wrapped [--help(-h), bookmark:string, rev:string = "@", ...rest] {
  jj bookmark move --to $rev $bookmark ...$rest
}

# Wraps bw, logging in and unlocking as needed and caching the session for this shell
def --env --wrapped bw [...args] {
  if ($env.BW_SESSION? | is-empty) {
    let status = (^bw status | from json | get status)

    let session = match $status {
      "unauthenticated" => (^bw login --raw)
      "locked" => (^bw unlock --raw)
      _ => ""
    }

    if not ($session | is-empty) {
      $env.BW_SESSION = $session
    }
  }

  ^bw ...$args
}

if not ("~/.opencode_token" | path exists) {
  bw get notes "OpenCode Zen" | save -f "~/.opencode_token"
}

$env.OPENCODE_API_KEY = open $"($env.HOME)/.opencode_token"

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

$env.config.hooks.display_output = { table --icons }
