{
  services.xserver = {
    enable = false;
    videoDrivers = [ "amdgpu" ];
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.displayManager = {
  };
}
