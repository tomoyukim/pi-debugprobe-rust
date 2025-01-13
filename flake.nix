{
  description = "A rust project.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { nixpkgs, flake-utils, rust-overlay, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlay = [ (import rust-overlay) ];
        pkgs = import nixpkgs { inherit system overlay; };
      in {
        devShells.default = with pkgs; mkShell {
          buildInputs = [
            openssl # cargo-generate
            pkg-config
            probe-rs-tools
            picoprobe-udev-rules
            libusb1
            libudev-zero
            rust-bin.stable.latest.default
            rustfmt
            rust-analyzer
          ];
        };
      }
    );
}
