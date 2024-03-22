{
  description = "Minimal Scala development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        pkgs-unstable = import nixpkgs-unstable { inherit system; };

        jdk = pkgs.openjdk17_headless;

        metals = pkgs.metals.override { jre = jdk; };

        sbt = pkgs.sbt.override { jre = jdk; };

        scala-cli = pkgs-unstable.scala-cli.override { jre = jdk; };

        scalafmt = pkgs.scalafmt.override { jre = jdk; };

      in {
        devShells = {

          # Default environment for Scala development
          default = pkgs.mkShell {
            packages = [ jdk metals sbt scala-cli scalafmt ];

            env.JAVA_HOME = jdk;
          };

          # Nix environment for development of this flake
          # Additionally pandoc is used for markdown support
          # See .envrc at the root of this project
          nix = pkgs.mkShell { packages = with pkgs; [ nil nixfmt pandoc ]; };
        };
      });
}
