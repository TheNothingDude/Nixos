{
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
}
