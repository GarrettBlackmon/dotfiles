{pkgs, config, ...}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  # hardware.opengl has beed changed to hardware.graphics

  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    powerManagement.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  #maybe fix insomnia?
  # hardware.nvidia.powerManagement.enable = true;
  #   boot.extraModprobeConfig = ''
  #     options nvidia NVreg_PreserveVideoMemoryAllocations=0
  #   '';
}
