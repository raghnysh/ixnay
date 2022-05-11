### Nix expression for the coqdoc-overlay package

{ stdenv, fetchTarball, lib }:

stdenv.mkDerivation {
  ## <https://nixos.org/manual/nixpkgs/stable/#sec-using-stdenv>
  ## <https://nixos.org/manual/nixpkgs/stable/#sec-package-naming>
  pname = "coqdoc-overlay-unstable";
  version = "2015-08-15";

  src = fetchTarball {
    url = "https://github.com/gverdier/coqdoc-overlay/archive/821227442305a44eb52f122572a18a6c6311100b.tar.gz";
    sha256 = "0r6ww3ncaz8sf4z80v228dmid12ygfxcnhr1xfpf01y6bcfqarhp";
  };

  installPhase = ''
    runHook preInstall
    package_directory="$out/share/javascript/coqdoc-overlay"
    mkdir -p "$package_directory"
    cp -R LICENSE README alignment.pl examples proofs-toggle.js \
        proofs-toggle.sed "$package_directory"
    runHook postInstall
  '';

  meta = {
    description = "Scripts to improve the output of coqdoc";
    longDescription = ''
      coqdoc-overlay is a collection of scripts to improve the output
      of coqdoc, the documentation generation tool for the Coq proof
      assistant.
    '';
    homepage = "https://github.com/gverdier/coqdoc-overlay";
    license = lib.licenses.bsd2;
    maintainers = [
      {
        name = "Raghavendra Nyshadham";
        email = "rn@raghnysh.com";
        github = "nyraghu";
        githubId = 11349287;
      }
    ];
  };
}

### End of file
