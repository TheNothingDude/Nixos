{
  inputs,
  pkgs,
  ...
}:

{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    stdenv.cc
    eza
    xwayland
    fuzzel
    qt6Packages.qt6ct
    p7zip
    wget
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    mangohud
    protonplus
    fastfetch
    vim
    git
    gh
    unzip
    unrar
  ];
}
