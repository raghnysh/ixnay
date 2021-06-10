### Nix expression for miscellaneous packages

{
  nixpkgs ? import <nixpkgs> {}
}:

{
  coq-serapi = nixpkgs.callPackage ./coq-serapi {
    inherit (builtins) fetchTarball;
    inherit (nixpkgs) lib coq;
  };

  coqdoc-overlay = nixpkgs.callPackage ./coqdoc-overlay {
    inherit (builtins) fetchTarball;
    inherit (nixpkgs) stdenv lib;
  };
}

### End of file
