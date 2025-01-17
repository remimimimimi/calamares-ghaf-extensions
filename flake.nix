{
  description = "Flake utils demo";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      rec {
        packages.default = pkgs.callPackage ./. {};

        devShells.default = with pkgs; mkShell {
          packages = [
            # libsForQt5.kpmcore
            # calamares-nixos
            packages.default.override { debug = true; }

            glibcLocales
          ];
        };
      }
    );
}
