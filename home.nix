{
  config,
  pkgs,
  inputs,
  ...
}:

{

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "helium";
  home.homeDirectory = "/home/helium";
  home.stateVersion = "26.05"; # Please read the comment before changing.
  gtk = {
    enable = true;
    theme = {
      package = pkgs.adw-gtk3; # Required by Noctalia for proper Libadwaita back-porting
      name = "adw-gtk3";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme; # Or your choice of icon pack
      name = "Papirus-Dark";
    };
  };

  #Qt configuration for Noctalia compatibility
  qt = {
    enable = true;
    platformTheme.name = "qt6ct"; # Explicitly binds Qt back to the GTK layers
    style.name = "adwaita-dark";
  };

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };

  #cursor
  home.pointerCursor = {
    enable = true;
    x11.enable = true;
    package = pkgs.oreo-cursors-plus;
    name = "oreo_spark_pink_cursors";
    size = 24; # Adjust size (e.g., 24, 32, 48) if needed
  };
  programs.fzf.enable = true;
  home.packages = with pkgs; [
    nodejs
    nixd
    protonplus
    nil
    hydralauncher
    python3
    floorp-bin
    zed-editor
    kitty
    vesktop
    qbittorrent
    prismlauncher
    dotnet-sdk_10
    xdg-user-dirs
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/helium/etc/profile.d/hm-session-vars.sh
  #

  # Let Home Manager install and manage itself.
  #programs.home-manager.enable = true;
}
