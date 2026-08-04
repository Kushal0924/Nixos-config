{ config, lib, pkgs, ... }:

{

  # Enable Phone connection
  services.gvfs.enable = true;

  environment.systemPackages = with pkgs; [
    yazi
    file
    imagemagick
    ffmpegthumbnailer
    poppler
    nautilus
    sushi
    loupe
    celluloid
  ];

}
