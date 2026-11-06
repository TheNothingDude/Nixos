{
  inputs,
  config,
  pkgs,
  ...
}:
{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    webkitgtk_4_1
  ];
}
