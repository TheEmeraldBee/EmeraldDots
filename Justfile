default:
    @just --list

# Rebuild and switch the NixOS system
rebuild: fmt
    nh os switch . -H linux-laptop

# Rebuild and switch the standalone home-manager profile
home: fmt
    nh home switch . -c brightonlcox

# Update all flake inputs
update:
    nix flake update

# Check that the flake evaluates and builds cleanly
check: fmt
    nix flake check

# Format all Nix files in the repository
fmt:
    alejandra .

# Remove old generations and garbage-collect the Nix store
gc:
    sudo nix-collect-garbage -d
    nix-collect-garbage -d
