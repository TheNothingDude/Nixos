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
    libsoup_3
    gtk3
    pango
    cairo
    glib
    gdk-pixbuf
  ];
}
