{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  nix.optimise.automatic = true;
  programs.nh = {
    enable = true;
    flake = "/etc/nixos";
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 5";
    };
  };
}
