### Nix expression for the alectryon package

## The package `glibcLocales' is declared a dependency in order to
## avoid "unsupported locale setting" errors when running the commands
## `coqrst2html.py' and `rstcoq2html.py'.

{
  python, fetchTarball, glibcLocales, makeWrapper, lib
}:

let
  pythonPackages = python.pkgs;
in
pythonPackages.buildPythonPackage {
  ## <https://nixos.org/manual/nixpkgs/stable/#sec-using-stdenv>
  ## <https://nixos.org/manual/nixpkgs/stable/#sec-package-naming>
  pname = "alectryon-unstable";
  version = "2021-05-24";

  src = fetchTarball {
    url = "https://github.com/cpitclaudel/alectryon/archive/df5664e71c1026af4aaf69e6b227d427a728e7c6.tar.gz";
    sha256 = "1czy3sbwm6lfrgdbj0y12q4n70w6zg8g3y27iz1zr4y20hhcp2zk";
  };

  propagatedBuildInputs =
    with pythonPackages; [
      beautifulsoup4
      docutils
      dominate
      pygments
    ]
    ++
    [ glibcLocales ];

  nativeBuildInputs = [ makeWrapper ];

  dontBuild = true;

  dontUseSetuptoolsCheck = true;

  installPhase = ''
    runHook preInstall
    site_packages_directory="$out/${python.sitePackages}"
    package_directory="$site_packages_directory/alectryon"
    mkdir -p "$package_directory"
    cp -r "$src"/* "$package_directory"
    runHook postInstall
  '';

  ## The setup hook of the `glibcLocales' package exports the setting
  ## of the environment variable `LOCALE_ARCHIVE' in the install
  ## phase.  Use that setting in the wrappers for the commands
  ## `alectryon', `rstcoq2html', and `coqrst2html'.

  postInstall = ''
    PYTHONPATH="$site_packages_directory:$PYTHONPATH"
    bin_directory="$out/bin"
    for command in alectryon coqrst2html rstcoq2html ; do \
      makeWrapper \
        "$package_directory/$command.py" \
        "$bin_directory/$command" \
        --prefix PYTHONPATH : "$PYTHONPATH" \
        --set LOCALE_ARCHIVE "$LOCALE_ARCHIVE"; \
    done
  '';

  ## Provide the `python' dependency as an attribute of this package.
  ## This can be used to build a consistent Python environment like
  ## this:
  ##
  ## python = alectryon.python; pythonEnvironment =
  ## python.withPackages [ package1 package2 ...];

  inherit python;

  meta = {
    description = "Tools for documents that mix Coq code and prose";
    longDescription = ''
      Alectryon is a library to process Coq snippets embedded in
      documents, showing goals and messages for each Coq sentence.
      It is also a literate programming toolkit for Coq.  The goal
      of Alectryon is to make it easy to write textbooks, blog
      posts, and other documents that mix Coq code and prose.
    '';
    homepage = "https://github.com/cpitclaudel/alectryon";
    license = lib.licenses.mit;
    maintainers = [
      {
        name = "Raghavendra Nyshadham";
        email = "rn@raghnysh.com";
        github = "raghnysh";
        githubId = 11349287;
      }
    ];
  };
}

### End of file
