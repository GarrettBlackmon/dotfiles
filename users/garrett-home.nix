{
  config,
  pkgs,
  ...
}: let
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
    obs-studio
  ];

  programs.git = {
    enable = true;
    userName = "Garrett Blackmon";
    userEmail = "garrett@blackmon.dev";
  };

  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        ms-python.python
        ms-vscode.cpptools
        esbenp.prettier-vscode
        jnoortheen.nix-ide
      ];
      userSettings = {
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.serverSettings" = {

          "nixd" = {
            "formatting" = {
              "command" = ["alejandra"];
            };
            "options" = {
              "nixos" = {
                "expr" = "(builtins.getFlake \"/home/garrett/dotfiles\).nixosConfigurations.GLaDOS.options";
              };
              "home-manager" = {
                "expr" = "(builtins.getFlake \"/home/garrett/dotfiles\).nixosConfigurations.GLaDOS.options.home-manager.users.type.getSubOptions []";
              };
            };
          };
        };
      };
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = shellAliases;
  };

  home.stateVersion = "25.05";
}
