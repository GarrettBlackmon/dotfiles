{
  pkgs,
  lib,
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
                "expr" = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.GLaDOS.options";
              };
              "home-manager" = {
                "expr" = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.GLaDOS.options.home-manager.users.type.getSubOptions []";
              };
            };
          };
        };
      };
    };
  };

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      background-opacity =  "0.7";
      
    };
  };

  # programs.kitty = {
  #   enable = true;

  #   font = {
  #     name = lib.mkForce "Hack Nerd Font";
  #     size = 12;
  #   };

  #   shellIntegration.enableZshIntegration = true;

  #   settings = {
  #     background_opacity = lib.mkForce "0.90";
  #     enable_audio_bell = "no";
  #     confirm_os_window_close = 0;

  #     # Padding
  #     margin_width = 10;
  #     margin_height = 10;
  #   };

  #   # Optional keybindings or extra settings
  #   keybindings = {
  #     "ctrl+shift+v" = "paste_from_clipboard";
  #     "ctrl+shift+c" = "copy_to_clipboard";
  #   };
  # };

  # programs.wezterm = {
  #   enable = true;
  #   extraConfig = ''
  #     return {
  #       window_background_opacity = 0.9,
  #       window_frame = {
  #         font_size = 12.0,
  #       },
  #       window_padding = {
  #         left = 12,
  #         right = 12,
  #         top = 10,
  #         bottom = 10,
  #       },
  #       enable_wayland = true, -- optional: Wayland native
  #       colors = {
  #         background = "#1E1E2E",
  #       },
  #     }
  #   '';
  # };

  # programs.alacritty = {
  #   enable = true;
  #   settings = {
  #     terminal.shell = "/run/current-system/sw/bin/zsh";
  #     font.normal.family = lib.mkForce "MesloLGS Nerd Font";
  #     font.size = lib.mkForce 12;
  #     window.opacity = lib.mkForce 0.9;
  #     window.decorations = "none";
  #     window.padding = {
  #       x = 24;
  #       y = 24;
  #     };
  #   };
  # };

  # programs.gnome-terminal = {
  #   enable = true;
  #   showMenubar = false;

  #   profile."b1dcc9dd-5262-4d8d-a863-c897e6d979b9" = {
  #     default = true;
  #     visibleName = "Garrett";
  #     showScrollbar = false;
  #     transparencyPercent = 90;
  #     font = "Hack Nerd Font 12";
  #     customCommand = "zsh";
  #   };
  # };

  programs.bash = {
    enable = true;
    shellAliases = shellAliases;
  };

  programs.zsh = {
    enable = true;
    shellAliases = shellAliases;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = ["git" "z" "sudo" "command-not-found"]; # optional plugins
    };
  };

  #gnome hotkeys
  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Launch Alacritty";
      command = "ghostty";
      binding = "<Super>T";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "Launch Firefox";
      command = "firefox";
      binding = "<Super>B";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      name = "Launch File Browser";
      command = "nautilus";
      binding = "<Super>F";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
      name = "Launch VSCode";
      command = "code";
      binding = "<Super>C";
    };
  };

  home.stateVersion = "25.05";
}
