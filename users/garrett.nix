{pkgs, ...}: {
  users.users.garrett = {
    isNormalUser = true;
    description = "Garrett Blackmon";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };

  age.secrets.github_ssh = {
    file = ../hosts/GLaDOS/secrets/github_ssh.age;
    mode = "0400";
    owner = "garrett";
    path = "/home/garrett/.ssh/id_github";
  };

  #Gamer stuff
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  environment.systemPackages = with pkgs; [
    mangohud
    protonup
  ];
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };
  programs.gamemode.enable = true;

  programs.obs-studio.enable = true;
  programs.chromium.enable = true;
  programs.zsh.enable = true;
}
