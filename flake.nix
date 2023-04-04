{
  description = "Asciidoctor flake template";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          document-name = "Readme";
        in
        rec {
          packages = {

            pdf = pkgs.stdenvNoCC.mkDerivation rec
            {

              name = "asciidoctor flake template pdf";
              src = self;

              buildInputs = with pkgs; [ asciidoctor ];

              buildPhase = ''
                asciidoctor-pdf ${document-name}.adoc
              '';

              installPhase = ''
                mkdir -p $out
                cp ${document-name}.pdf $out
              '';
            };

            html = pkgs.stdenvNoCC.mkDerivation rec
            {

              name = "asciidoctor flake template html";
              src = self;

              buildInputs = with pkgs; [ asciidoctor ];

              buildPhase = ''
                asciidoctor ${document-name}.adoc
              '';

              installPhase = ''
                mkdir -p $out
                cp ${document-name}.html $out
              '';
            };
          };

          defaultPackage = packages.pdf;
        }
      );
}

