{
  inputs,
  config,
  pkgs,
  ...
}:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
    users = {
      "helium" = import ./home.nix;
    };
  };
}
