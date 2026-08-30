{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nh
    wget
    yazi
  ];
}
