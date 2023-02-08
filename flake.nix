{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";

  outputs = { self, nixpkgs }: let
    forAllSystems = f: nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ] (system: f system);
  in rec {
    packages = forAllSystems (system: let pkgs = nixpkgs.legacyPackages.${system}; in {
      python-jetson = pkgs.python310.pkgs.buildPythonPackage {
        pname = "python-jetson";
        version = "0.0.0";
        src = ./.;

        propagatedBuildInputs = [
          pkgs.python3.pkgs.pyftdi
        ];

        doCheck = false;
      };
    });

    defaultPackage = forAllSystems (system: packages.${system}.python-jetson);
  };
}
