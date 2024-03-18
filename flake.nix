{
  description = "Python shell flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, mach-nix, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        mach = mach-nix.lib.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            python311
            python311Packages.pip
            python311Packages.virtualenv
            # Packages for jupiter
            python311Packages.ipykernel
            python311Packages.ipython
            python311Packages.notebook
            # Packages for project
            python311Packages.numpy
            python311Packages.pandas
            python311Packages.openpyxl
            python311Packages.odfpy
          ];

          shellHook = ''
            python -m venv ./.venv
            . ./.venv/bin/activate
          '';
        };
      }
    );
}
