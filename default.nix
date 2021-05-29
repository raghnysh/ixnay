### Nix expression for miscellaneous packages

{
  nixpkgs ? import <nixpkgs> {}
}:

{
  coqdoc-overlay = nixpkgs.callPackage ./coqdoc-overlay {
    inherit (builtins) fetchTarball;
    inherit (nixpkgs) stdenv lib;
  };
}

### End of file
