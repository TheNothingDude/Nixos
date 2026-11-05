{
  inputs,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    inputs.mangowm.nixosModules.mango
  ];
  # --- Bootloader (GRUB) ---
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true; # Set to false if using Legacy BIOS
    useOSProber = true;
    configurationLimit = 10;
  };
  services.fstrim.enable = true;
  zramSwap = {
    enable = true;
    memoryPercent = 50; # Maximum percentage of physical RAM to use for ZRAM
    priority = 100; # Swap priority (higher number means it is used first)
    algorithm = "zstd"; # Compression algorithm (e.g., zstd, lz4, lzo)
  };
  # --- Networking ---
  networking.hostName = "nix-uwu";
  networking.networkmanager.enable = true;

  # --- Time & Locale ---
  time.timeZone = "Europe/Budapest";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "hu_HU.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  # ---------- Services -----------
  systemd.user.services.mate-polkit-authentication-agent-1 = {
    description = "MATE Polkit Authentication Agent";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.mate-polkit}/libexec/polkit-mate-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
  # --- Display, Audio & Hardware ---
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.displayManager = {
    gdm.enable = false;
  };
  services.printing.enable = false;

  # Audio via PipeWire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      mesa
    ];
  };
  hardware.amdgpu.initrd.enable = true;

  # --- Kernel & Overlays ---
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # --- Users ---
  users.users."helium" = {
    isNormalUser = true;
    description = "Helium";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # --- Home Manager ---
  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
    users = {
      "helium" = import ./home.nix;
    };
  };

  # --- Fonts ---
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.annotationmono
    nerd-fonts.jetbrains-mono
  ];

  # --- Programs & Features ---
  nixpkgs.config.allowUnfree = true;
  security.polkit.enable = true;
  #dynamically linked support
  programs.nix-ld.enable = true;
  programs.gamemode.enable = true;
  programs.niri.enable = true;
  programs.mango.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    wlr.settings.screencast = {
      chooser_type = "dmenu";
      chooser_cmd = "${pkgs.fuzzel}/bin/fuzzel --dmenu";
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
    config = {
      common.default = [ "gtk" ];
      niri = {
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ]; # or "kde"
      };
      sway = {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
        "org.freedesktop.impl.portal.Screencast" = [ "wlr" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
      };
    };
  };
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
  # --- Environment Variables ---
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    NIXOS_OZONE_WL = "1";
    DOTNET_ROOT = "${pkgs.dotnet-sdk_10}/share/dotnet";
  };

  environment.systemPackages = with pkgs; [
    fzf
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

  # --- Nix Settings & Garbage Collection ---
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };
  programs.nh = {
    enable = true;
    flake = "/etc/nixos";
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 5";
    };
  };

  # --- State Version ---
  system.stateVersion = "26.05";
}
