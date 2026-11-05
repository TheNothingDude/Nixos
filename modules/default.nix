{ lib, ... }:

{
  imports =
    let
      dirContents = builtins.readDir ./.;
      validFiles = lib.filterAttrs (
        name: type: type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix"
      ) dirContents;
    in
    lib.mapAttrsToList (name: _: ./. + "/${name}") validFiles;
}
