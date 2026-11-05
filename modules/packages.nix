{
  inputs,
  config,
  pkgs,
  ...
}:

{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    eza
    xwayland
    fuzzel
    qt6Packages.qt6ct
    nwg-look
    nautilus
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
