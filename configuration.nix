{ inputs, config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  # --- Bootloader (GRUB) ---
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true; # Set to false if using Legacy BIOS
    useOSProber = true;
    configurationLimit = 2; 
  };

  # --- Networking ---
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # --- Time & Locale ---
  time.timeZone = "Europe/Budapest";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "hu_HU.UTF-8";
    LC_IDENTIFICATION = "hu_HU.UTF-8";
    LC_MEASUREMENT = "hu_HU.UTF-8";
    LC_MONETARY = "hu_HU.UTF-8";
    LC_NAME = "hu_HU.UTF-8";
    LC_NUMERIC = "hu_HU.UTF-8";
    LC_PAPER = "hu_HU.UTF-8";
    LC_TELEPHONE = "hu_HU.UTF-8";
    LC_TIME = "hu_HU.UTF-8";
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
    gdm.enable = true;
    defaultSession = "niri";
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
  };
  hardware.amdgpu.initrd.enable = true;

  # --- Kernel & Overlays ---
  nixpkgs.overlays = [
    (final: prev: {
      steam = prev.steam.override {
        extraArgs = "-cef-disable-gpu-compositing";
      };
    })
    inputs.nix-cachyos-kernel.overlays.pinned
  ];
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

  # --- Users ---
  users.users."helium" = {
    isNormalUser = true;
    description = "Helium";
    extraGroups = [ "networkmanager" "wheel" ];
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

  programs.firefox.enable = true;
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;
  programs.niri.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  programs.xwayland.enable = true;
  programs.git.enable = true;
  services.flatpak.enable = true;

  # --- Environment Variables ---
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    SDL_VIDEODRIVER = "wayland";
  };

  # --- System Packages (CLI tools only) ---
  # GUI apps have been moved to home.nix
  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    xwayland-satellite
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
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # --- State Version ---
  system.stateVersion = "26.05";
}