{
  config,
  lib,
  pkgs,
  ...
}: {
  # Enable GNOME display manager and desktop
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Keyboard layout
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Stylix theming support
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/ashes.yaml";
    image = ./cherryb.png;
  };

  # Install extensions and tweaks
  environment.systemPackages = with pkgs;
    [
      gnome-tweaks
    ]
    ++ (with pkgs.gnomeExtensions; [
      user-themes
      blur-my-shell
      appindicator
      dash-to-dock
      clipboard-indicator
      hide-activities-button
      vitals
      tiling-shell
    ]);
  # Enable and configure GNOME extensions and UI behavior
  programs.dconf.profiles = {
    user.databases = [
      {
        settings = {
          #Dock apps
          #gsettings get org.gnome.shell favorite-apps
          "org/gnome/shell".favorite-apps = [
            "firefox.desktop"
            "chromium-browser.desktop"
            "org.gnome.Nautilus.desktop"
            "org.gnome.Console.desktop"
            "code.desktop"
            "discord.desktop"
            "steam.desktop"
          ];

          #Enable Extensions
          #gnome-extensions list
          "org/gnome/shell" = {
            enabled-extensions = [
              "user-theme@gnome-shell-extensions.gcampax.github.com"
              "appindicatorsupport@rgcjonas.gmail.com"
              "blur-my-shell@aunetx"
              "clipboard-indicator@tudmotu.com"
              "dash-to-dock@micxgx.gmail.com"
              "Hide_Activities@shay.shayel.org"
              "Vitals@CoreCoding.com"
              "tilingshell@ferrarodomenico.com"
            ];
          };

          # dash-to-dock settings
          # To find these, install the extension, make your changes then do
          # dconf dump /org/gnome/shell/extensions/dash-to-dock/
          "org/gnome/shell/extensions/dash-to-dock" = {
            dock-position = "LEFT";
            extend-height = true;
            intellihide = false;
            click-action = "minimize";
            show-mounts = false;
          };

          #vitals settings
          "org/gnome/shell/extensions/vitals" = {
            alphabetize = false;
            hide-icons = false;
            hot-sensors = [
              "_processor_usage_"
              "_gpu#1_utilization_"
              "_memory_usage_"
              "__network-rx_max__"
            ];
            icon-style = lib.gvariant.mkInt32 0;
            include-static-gpu-info = false;
            menu-centered = false;
            position-in-panel = lib.gvariant.mkInt32 0;
            show-gpu = true;
          };

          #Tiling Shell
          "org/gnome/shell/extensions/tilingshell" = {
            enable-autotiling = true;
            enable-blur-selected-tilepreview = true;
            enable-blur-snap-assistant = true;
            enable-screen-edges-windows-suggestions = true;
            enable-snap-assistant-windows-suggestions = true;
            enable-tiling-system-windows-suggestions = true;
            inner-gaps = lib.gvariant.mkUint32 10;
            outer-gaps = lib.gvariant.mkUint32 10;
            last-version-name-installed = "16.4";
            top-edge-maximize = true;

            layouts-json = ''              [
                          {"id":"Layout 1","tiles":[
                            {"x":0,"y":0,"width":0.22,"height":0.5,"groups":[1,2]},
                            {"x":0,"y":0.5,"width":0.22,"height":0.5,"groups":[1,2]},
                            {"x":0.22,"y":0,"width":0.56,"height":1,"groups":[2,3]},
                            {"x":0.78,"y":0,"width":0.22,"height":0.5,"groups":[3,4]},
                            {"x":0.78,"y":0.5,"width":0.22,"height":0.5,"groups":[3,4]}
                          ]},
                          {"id":"Layout 2","tiles":[
                            {"x":0,"y":0,"width":0.22,"height":1,"groups":[1]},
                            {"x":0.22,"y":0,"width":0.56,"height":1,"groups":[1,2]},
                            {"x":0.78,"y":0,"width":0.22,"height":1,"groups":[2]}
                          ]},
                          {"id":"Layout 3","tiles":[
                            {"x":0,"y":0,"width":0.33,"height":1,"groups":[1]},
                            {"x":0.33,"y":0,"width":0.67,"height":1,"groups":[1]}
                          ]},
                          {"id":"Layout 4","tiles":[
                            {"x":0,"y":0,"width":0.67,"height":1,"groups":[1]},
                            {"x":0.67,"y":0,"width":0.33,"height":1,"groups":[1]}
                          ]}
                        ]'';

            overridden-settings = ''              {
                          "org.gnome.mutter.keybindings": {
                            "toggle-tiled-right": ["<Super>Right"],
                            "toggle-tiled-left": ["<Super>Left"]
                          },
                          "org.gnome.desktop.wm.keybindings": {
                            "maximize": ["<Super>Up"],
                            "unmaximize": ["<Super>Down", "<Alt>F5"]
                          },
                          "org.gnome.mutter": {
                            "edge-tiling": true
                          }
                        }'';

            selected-layouts = ''[["Layout 1"], ["Layout 1"]]''; # Double-escaped JSON
          };

          # reduce animation time for responsiveness
          "org/gnome/desktop/interface".enable-animations = true;

          # show date in top bar
          "org/gnome/desktop/interface".clock-show-date = true;

          # reduce accidental hot corner triggers
          "org/gnome/desktop/interface".enable-hot-corners = false;

          # configure clipboard indicator behavior (if applicable)
          "org/gnome/shell/extensions/clipboard-indicator".move-item-first = true;
        };
      }
    ];
  };
}
