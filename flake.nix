{
  description = "A rust project.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, flake-utils, rust-overlay, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ rust-overlay.overlays.default ];
        pkgs = import nixpkgs { inherit system overlays; };
        rustToolchain = pkgs.rust-bin.fromRustupToolchain {
          channel = "stable";
          components = [
            "clippy"
            "rustfmt"
            "rust-analyzer"
            "rust-src"
          ];
          targets = [
            "thumbv6m-none-eabi"
          ];
        };
      in {
          devShells.default = with pkgs; mkShell {
            buildInputs = [
              probe-rs-tools
              rustToolchain
              flip-link
            ];
          };
        }
    );
}
