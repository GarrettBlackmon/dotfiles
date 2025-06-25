{...}: {
  imports = [
    ../../modules/base.nix
    ../../modules/desktop/gnome.nix
    ../../modules/hardware/nvidia.nix
    ../../modules/services/audio-pipewire.nix
    ../../users/garrett.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "GLaDOS";
  system.stateVersion = "25.05";

  age.identityPaths = ["/home/garrett/.ssh/id_agenix"];

}
