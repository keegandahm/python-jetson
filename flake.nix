{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";

  outputs = { self, nixpkgs }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    packages.x86_64-linux.python-jetson = pkgs.python310.pkgs.buildPythonPackage {
      pname = "python-jetson";
      version = "0.0.0";
      src = ./.;

      propagatedBuildInputs = [
        pkgs.python3.pkgs.pyftdi
      ];

      doCheck = false;
    };
  };
}
