{
  inputs,
  config,
  pkgs,
  ...
}:

{
  networking.hostName = "nix-uwu";
  networking.networkmanager.enable = true;
}
