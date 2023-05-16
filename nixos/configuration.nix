# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "orion";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    keyMap = "uk";
  };

  # Configure keymap in X11
  services.xserver.layout = "gb";

  # Enable sound.
  sound.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    wireplumber.enable = true;
    pulse.enable = true;
  };

  virtualisation.docker.enable = true;

  programs.hyprland.enable = true;
  
  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  users.users.iain = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "docker" "wheel" ];
    packages = with pkgs; [

      # Applications
      vivaldi
      slack
      spotify
      pavucontrol

      # Wayland/Hyprland tools
      wofi
      waybar
      mako
      wl-clipboard
      xdg-desktop-portal-hyprland
      hyprland-share-picker

      # CLI Tools
      stow
      kitty
      fish
      starship
      lsd
      bat
      fd
      ripgrep
      fzf
      gh
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    neovim
    gcc
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "gnome3";
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
