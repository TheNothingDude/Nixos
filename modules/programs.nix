{
  inputs,
  pkgs,
  ...
}:

{
  programs.thunar.enable = true;
  programs.gamemode.enable = true;
  security.polkit.enable = true;
  programs.nix-ld.enable = true;
  programs.nautilus-open-any-terminal.enable = true;
  programs.nautilus-open-any-terminal.terminal = "kitty";
  services.gvfs.enable = true;
  services.gnome.gnome-keyring.enable = true;
  programs.xwayland.enable = true;
  programs.git.enable = true;
  programs.steam.enable = true;
  services.flatpak.enable = true;
  programs.zsh.enable = true;
  programs.zsh.enableGlobalCompInit = false;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    dust
    vlc
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
    nitch
    vim
    git
    unzip
    unrar
  ];
}
