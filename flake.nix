{
  inputs = {
    systems.url = "github:nix-systems/default";

    nixpkgs.url = "github:NixOS/nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.systems.follows = "systems";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system: rec {
      legacyPackages = import nixpkgs {
        inherit system;
        overlays = [
          (import ./pkgs/default.nix)
        ];
      };

      devShells.default = legacyPackages.mkShell {
        name = "comfyui";
        packages = with legacyPackages; [
          arion

          git
          nodejs
        ];

        shellHook = ''
          if [[ -e /run/user/$(id -u)/podman/podman.sock ]]; then
            alias podman="DOCKER_HOST=unix:///run/user/$(id -u)/podman/podman.sock podman"
            alias arion="DOCKER_HOST=unix:///run/user/$(id -u)/podman/podman.sock arion"
          fi
        '';
      };
    });
}
