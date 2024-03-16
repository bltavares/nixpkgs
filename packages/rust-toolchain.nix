{
  lib,
  flake-parts-lib,
  inputs,
  ...
}: {
  options.perSystem = flake-parts-lib.mkPerSystemOption ({
    inputs',
    config,
    pkgs,
    ...
  }: {
    options.rust.toolchain = lib.mkOption {
      description = lib.mdDoc ''
        Which Rust (Fenix) toolchain to use when compiling the rust..
      '';
      type = lib.types.package;
      default = inputs'.fenix.packages.stable;
    };

    options.rust.craneLib = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.raw;
      default = (inputs.crane.mkLib pkgs).overrideToolchain config.rust.toolchain-packages;
    };

    options.rust.toolchain-packages = lib.mkOption {
      description = lib.mdDoc ''
        DevShell packages based on the rust toolchain selected
      '';
      type = lib.types.package;

      default = config.rust.toolchain.withComponents [
        "cargo"
        "clippy"
        "rust-src"
        "rustc"
        "rustfmt"
      ];
    };
  });
}
