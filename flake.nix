{
  description = "StarBuffer";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    fstar-src = {
      url = "github:FStarLang/FStar/dd464b1c4cdebbbfd21808e1d71736e873743f46";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    steel-src = {
      url = "github:FStarLang/steel";
      inputs = {
        fstar.follows = "fstar-src";
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "fstar-src/flake-utils";
      };
      };
      krml-src = {
        url = "github:FStarLang/karamel";
        inputs = {
          nixpkgs.follows = "nixpkgs";
          flake-utils.follows = "fstar-src/flake-utils";
          fstar.follows = "fstar-src";
        };
      };
      flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{self, nixpkgs, fstar-src, krml-src, steel-src, flake-utils}:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {inherit system; };
        fstar = fstar-src.packages.${system}.fstar;
        in with pkgs;
          {
            devShells.default = mkShell {
              buildInputs = [fstar];
            };
          });
}
