{ config, pkgs, ... }:

{
  users.users.garrett = {
    isNormalUser = true;
    description = "Garrett Blackmon";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  age.secrets.github_ssh = {
    file = ../hosts/GLaDOS/secrets/github_ssh.age;
    mode = "0400";
    owner = "garrett";
    path = "/home/garrett/.ssh/id_github";
  };
}
