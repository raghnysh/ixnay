### Nix expression for miscellaneous packages

{
  nixpkgs ? import <nixpkgs> {}
}:

{
  alectryon = nixpkgs.callPackage ./alectryon {
    inherit (builtins) fetchTarball;
    inherit (nixpkgs) glibcLocales makeWrapper lib;
    python = nixpkgs.python39;
  };

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
