{
  craneLib,
  lib,
  pkgs,
}: let
  upstream = builtins.fetchGit {
    url = "https://github.com/naftulikay/aws-env";
    ref = "main";
  };
  src = craneLib.cleanCargoSource (craneLib.path upstream.outPath);
  commonArgs = {
    inherit src;
    strictDeps = true;
    buildInputs = lib.optionals pkgs.stdenv.isDarwin [
      pkgs.libiconv
    ];
  };
  cargoArtifacts = craneLib.buildDepsOnly commonArgs;
in
  craneLib.buildPackage (commonArgs
    // {
      inherit cargoArtifacts;
    })
