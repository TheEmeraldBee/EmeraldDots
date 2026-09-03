{ pkgs, ... }: {
  users.users.brightonlcox = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.nushell;
    packages = with pkgs; [
      tree
    ];
  };
}
