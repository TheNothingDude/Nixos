{
  inputs,
  config,
  pkgs,
  ...
}:

{
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
  programs.partition-manager.enable = true;
}
