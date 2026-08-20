{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/vm.nix
    ../../modules/files.nix
  ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
    };
  };
 

  programs.noctalia-greeter = {
    enable = true;

    # Optional configuration
    greeter-args = "";
    settings = {
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 24;
        path = "${pkgs.bibata-cursors}/share/icons";
      };
      keyboard = {
        layout = "us";
      };
    };
  };

  
  programs.niri = {
    enable = true;
  };


  

  networking.hostName = "nixos-btw"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Bluetooth support
  hardware.bluetooth.enable = true;

  # Power profile switching (Performance, Balanced, Power Saver)
  services.power-profiles-daemon.enable = true;

  # Battery and power management information
  services.upower.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };


  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Critical for OpenGL / glXChooseVisual
  };

# Enable Steam properly through the NixOS module (handles dependencies & firewall)
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports for Source Dedicated Server
  };


  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  programs.fish.enable = true;

  users.users.mordred = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "kvm" ];
    packages = with pkgs; [
      tree
    ];
  };

  # Disable Power-button for keybinds
  services.logind.settings.Login.HandlePowerKey = "ignore";

  # Enable Nix-Commands and Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  hardware.enableRedistributableFirmware = true; 

  programs.direnv = {
    enable = true;
    loadInNixShell = true;
    nix-direnv.enable = true;
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    alsa-ucm-conf
    alsa-utils
    pavucontrol
    neovim
    wget
    kitty
    lazygit
    git
    adw-gtk3
    adwaita-icon-theme
    nwg-look
    bibata-cursors
    chromium
    libreoffice
    krita
    wineWow64Packages.staging
    winetricks
    umu-launcher
    lutris
    bottles
    material-design-icons
    vesktop
    xwayland-satellite
    glib
    gsettings-desktop-schemas
    nodejs
    devenv
  ];


  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.departure-mono
    noto-fonts-color-emoji
  ];


  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "26.05";

}

