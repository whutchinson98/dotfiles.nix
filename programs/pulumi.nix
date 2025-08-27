{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pulumi
    pulumiPackages.pulumi-nodejs
    pulumiPackages.pulumi-aws-native
  ];
}
