### Nix expression for the coq-serapi package

## NOT WORKING: <https://github.com/ejgallego/coq-serapi/issues/241>

{ lib, coq, fetchTarball }:

## Ensure that the Coq version is in the stated interval.  This will
## ensure all the other dependency constraints specified in the OPAM
## file at
## <https://github.com/ejgallego/coq-serapi/blob/v8.13/coq-serapi.opam>

assert
  lib.versionAtLeast coq.version "8.13.0"
  &&
  lib.versionOlder coq.version "8.14";

let
  ocamlPackages = coq.ocamlPackages;
in
ocamlPackages.buildDunePackage {
  pname = "coq-serapi";
  version = "8.13.0+0.13.0";

  src = fetchTarball {
    url = "https://github.com/ejgallego/coq-serapi/releases/download/8.13.0%2B0.13.0/coq-serapi-8.13.0.0.13.0.tbz";
    sha256 = "0k69907xn4k61w4mkhwf8kh8drw9pijk9ynijsppihw98j8w38fy";
  };

  useDune2 = true;

  propagatedBuildInputs = [ coq ] ++ (with ocamlPackages; [
    cmdliner
    dune_2
    findlib
    ocaml
    ppx_deriving
    ppx_deriving_yojson
    ppx_import
    ppx_sexp_conv
    sexplib
    yojson
    zarith
  ]);

  meta = {
    description = "Serialization API for machine interaction with Coq";
    longDescription = ''
      SerAPI is a library for machine-to-machine interaction with the
      Coq proof assistant, with particular emphasis on applications in
      IDEs, code analysis tools, and machine learning.  SerAPI provides
      automatic serialization of Coq's internal OCaml datatypes from/to
      JSON or S-expressions (sexps).
    '';
    homepage = "https://github.com/ejgallego/coq-serapi";
    license = lib.licenses.lgpl21Plus;
    maintainers = [
      {
        name = "Raghavendra Nyshadham";
        email = "raghu@hri.res.in";
        github = "nyraghu";
        githubId = 11349287;
      }
    ];
  };
}

### End of file
