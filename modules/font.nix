{
  pkgs,
  ...
}:

{
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.annotationmono
    nerd-fonts.jetbrains-mono
  ];
}
