let
  sources = import ./sources.nix;
  pkgs = import sources.nixpkgs {
    config.allowUnfree = true;
    overlays = [
      # the tool we use for versioning (The thing that generates sources.json)
      (_: _: { niv = (import sources.niv {}).niv; })
      # All society-server specific packages
      (import ./overlays/society-server.nix)

    ];
  };
in
  pkgs
