{ config, pkgs, ... }:

{
  home.username = "garrett";
  home.homeDirectory = "/home/garrett";

  programs.git = {
    enable = true;
    userName = "Garrett Blackmon";
    userEmail = "garrett@blackmon.dev";
  };

  home.stateVersion = "25.05";
}
