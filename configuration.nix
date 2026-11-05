{
  inputs,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    inputs.mangowm.nixosModules.mango
    ./modules
  ];

  # --- State Version ---
  system.stateVersion = "26.05";
}
