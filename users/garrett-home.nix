{ config, pkgs, ... }:

let
  shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#GLaDOS";
    rebuild-boot = "sudo nixos-rebuild boot --flake ~/dotfiles#GLaDOS";
    rebuild-test = "sudo nixos-rebuild test --flake ~/dotfiles#GLaDOS";
  };
in {
  home.username = "garrett";
  home.homeDirectory = "/home/garrett";

  home.packages = with pkgs; [
    discord
    chromium
    steam
    gnome-terminal
    vscode
    obs-studio
  ];

  programs.git = {
    enable = true;
    userName = "Garrett Blackmon";
    userEmail = "garrett@blackmon.dev";
  };

  # programs.gnome-terminal = {
  #   enable = true;
  #   profile = {
  #     "b1dcc9dd-5262-4d8d-a863-c897e6d979b9" = {
  #       visibleName = "Garrett";
  #       font = "Monospace 12";
  #     };
  #   };
  # };

  programs.bash = {
    enable = true;
    shellAliases = shellAliases;
  };

  home.stateVersion = "25.05";
}
