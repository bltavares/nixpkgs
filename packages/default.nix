{...}: {
  imports = [
    ./rust-toolchain.nix
  ];

  perSystem = {
    pkgs,
    config,
    lib,
    ...
  }: {
    legacyPackages = {
      aws-env = import ./aws-env {
        inherit (config.rust) craneLib;
        inherit pkgs lib;
      };
    };
  };
}
