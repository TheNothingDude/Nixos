{
  inputs,
  config,
  pkgs,
  ...
}:

{
  users.users."helium" = {
    isNormalUser = true;
    description = "Helium";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
