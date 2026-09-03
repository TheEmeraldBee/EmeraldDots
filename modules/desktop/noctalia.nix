{
  pkgs,
  inputs,
  ...
}:
{
  # pkexec ships non-setuid unless opted into explicitly; shell.greeter_sync
  # invokes it directly (see home/programs/noctalia.nix), so it needs to work
  security.polkit.enablePkexecWrapper = true;

  # lets shell.greeter_sync.auto_sync push wallpaper/palette updates to the
  # greeter without a password prompt on every wallpaper rotation
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id == "org.noctalia.greeter.apply-appearance" &&
          subject.user == "brightonlcox") {
        return polkit.Result.YES;
      }
    });
  '';
}
