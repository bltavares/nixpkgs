{
  imports = [
    ./nix.nix
    ./treefmt.nix
  ];

  perSystem = {
    pkgs,
    config,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      name = "bltavares-nixpkgs";
      inputsFrom = [config.devShells.nix config.devShells.treefmt];
    };
  };
}
