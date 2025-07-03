{
  description = "Adam's Nix user profile";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      supportedSystems = [
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ ];
            config = {
              allowUnfree = true;
            };
          };

          my-emacs = (import ./emacs.nix { inherit pkgs; });

        in
        {
          default = pkgs.buildEnv {
            name = "my-profile";
            paths = [
              pkgs.claude-code
              pkgs.direnv
              pkgs.nix-direnv
              pkgs.entr
              pkgs.fd
              pkgs.fish
              pkgs.tree
              pkgs.just
              pkgs.jq
              pkgs.nixfmt-rfc-style
              pkgs.ripgrep
              pkgs.sqlite
              pkgs.unzip
              (pkgs.aspellWithDicts (dicts: with dicts; [ en ]))
              my-emacs
              pkgs.texlive.combined.scheme-basic
            ];
          };
        }
      );

      # Make the default package available at the root level
      defaultPackage = forAllSystems (system: self.packages.${system}.default);
    };
}
