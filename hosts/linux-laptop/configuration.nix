{
  ...
}: {
  imports =
    [
      ./hardware-configuration.nix
    ]
    ++ (import ../../modules);

  networking.hostName = "BrightonLaptop";

  # do not change without reading options#opt-system.stateVersion first
  system.stateVersion = "26.05";
}
