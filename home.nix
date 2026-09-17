{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "helium";
  home.homeDirectory = "/home/helium";

  nixpkgs.config.allowUnfree = true;
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
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
    platformTheme.name = "gtk3"; # Explicitly binds Qt back to the GTK layers
    style.name = "adwaita-dark"; 
  };

  #Required session variables to prevent broken textures/missing assets

  xdg = {
    enable = true;
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gnome ]; # Essential for Noctalia's Libadwaita color scheming
      config.common.default = "*";
    };
    mimeApps = {
      enable = true;
      
      defaultApplications = {
        # Vivaldi Browser defaults
        "text/html" = [ "vivaldi-stable.desktop" ];
        "x-scheme-handler/http" = [ "vivaldi-stable.desktop" ];
        "x-scheme-handler/https" = [ "vivaldi-stable.desktop" ];
        "x-scheme-handler/about" = [ "vivaldi-stable.desktop" ];
        "x-scheme-handler/unknown" = [ "vivaldi-stable.desktop" ];

        # File Manager defaults (Replace thunar with your choice if different)
        "inode/directory" = [ "thunar.desktop" ];
      };
    };
  };

  # Explicitly tell CLI tools and wrappers to launch Vivaldi
  home.sessionVariables = {
    BROWSER = "vivaldi-stable";
    QT_QPA_PLATFORMTHEME = "gtk3";
  };

  #cursor
  home.pointerCursor = {
  enable = true;
  x11.enable = true;
  package = pkgs.oreo-cursors-plus;
  name = "oreo_spark_pink_cursors";
  size = 24; # Adjust size (e.g., 24, 32, 48) if needed
};

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
      vivaldi
      vscode
      ghostty
      vesktop
      qbittorrent
      thunar
      prismlauncher
      faugus-launcher
      jetbrains.rider
      dotnet-sdk_8 # Cleaner alias than dotnetCorePackages.sdk_8_0
      mono
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
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
  programs.home-manager.enable = true;
}
