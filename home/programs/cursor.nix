{pkgs, ...}: {
  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors; # Replace with your cursor package
    name = "Bibata-Modern-Classic"; # Replace with your exact cursor theme name
    size = 18;
    gtk.enable = true;
    x11.enable = true;
  };
}
