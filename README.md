# NixOS Flake Configuration

This NixOS system now uses flakes for configuration management. This provides better reproducibility and dependency management.

## System Rebuild Commands

### Using Flakes (Recommended)
```bash
# Rebuild and switch to new configuration
sudo nixos-rebuild switch --flake .#nixos

# Build without switching (useful for testing)
sudo nixos-rebuild build --flake .#nixos

# Test the configuration (switch but don't set as default)
sudo nixos-rebuild test --flake .#nixos

# Boot into new configuration on next reboot
sudo nixos-rebuild boot --flake .#nixos
```

### Legacy Commands (Still Available)
```bash
# Traditional rebuild command (still works)
sudo nixos-rebuild switch
```

## Flake Structure

- `flake.nix` - Main flake configuration file
- `flake.lock` - Lock file that pins exact versions of dependencies
- `configuration.nix` - System configuration (now flake-compatible)
- `hardware-configuration.nix` - Hardware-specific configuration

## Available Inputs

- `nixpkgs` - Stable NixOS 25.05 channel
- `nixpkgs-unstable` - Unstable nixpkgs for latest packages
- `unstable` - Available as a parameter in configuration.nix for accessing unstable packages

## Example Usage of Unstable Packages

In your `configuration.nix`, you can now use unstable packages:

```nix
environment.systemPackages = with pkgs; [
  # Stable packages
  git
  vim
  
  # Unstable packages (when needed)
  # unstable.some-bleeding-edge-package
];
```

## Updating the System

```bash
# Update flake inputs (equivalent to channel updates)
nix flake update

# Rebuild with updated inputs
sudo nixos-rebuild switch --flake .#nixos
```

## Benefits of Flakes

1. **Reproducibility** - Exact versions are pinned in flake.lock
2. **Multiple Sources** - Can easily use stable and unstable packages together
3. **Better Caching** - Nix can better cache and share builds
4. **Modern Nix** - Uses the new, more powerful Nix CLI
5. **Version Control** - All dependencies are tracked and versioned
