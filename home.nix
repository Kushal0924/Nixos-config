{ config, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "mordred";
  home.homeDirectory = "/home/mordred";

  imports = [
    inputs.noctalia.homeModules.default
    inputs.niri.homeModules.niri
  ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    btop
    grc
    ani-cli
  ];


  programs.fastfetch = {
    enable = true;
  };
  
 
  programs.noctalia = {
    enable = true;

    settings = { # This may also be a string or path to a .toml file.
      theme = {
        mode = "dark";
        source = "community";
        builtin = "Everforest";
      };

     wallpaper = {
       enabled = true;
       #default.path = "path/to/wallpapers/wallpaper.png";
      };
     };
  };


  # Niri  
  xdg.configFile."niri/config.kdl".source = ./niri/config.kdl;
  xdg.configFile."niri/binds.kdl".source = ./niri/binds.kdl;
  xdg.configFile."niri/input.kdl".source = ./niri/input.kdl;
  xdg.configFile."niri/misc.kdl".source = ./niri/misc.kdl;
  xdg.configFile."niri/rules.kdl".source = ./niri/rules.kdl;
  xdg.configFile."niri/monitor.kdl".source = ./niri/monitor.kdl;
  xdg.configFile."niri/layout.kdl".source = ./niri/layout.kdl;


  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      yzhang.markdown-all-in-one
    ];
  };


  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    plugins = [
      { 
        name = "grc"; 
        src = pkgs.fishPlugins.grc.src; 
      }
    ];
  };


  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":";
    };
  };


  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [ "kitty.desktop" ];
    };
  };


  home.stateVersion = "26.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}

