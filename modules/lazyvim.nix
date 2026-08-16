{ config, pkgs, inputs, ... }:

{
  imports = [ lazyvim.homeManagerModules.default ];
  programs.lazyvim.enable = true;
}
