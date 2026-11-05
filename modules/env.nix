{
  pkgs,
  ...
}:
{
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    NIXOS_OZONE_WL = "1";
    DOTNET_ROOT = "${pkgs.dotnet-sdk_10}/share/dotnet";
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  };
}
