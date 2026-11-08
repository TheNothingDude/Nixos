{
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ./modules
  ];

  # --- State Version ---
  system.stateVersion = "26.05";
}
