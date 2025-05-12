{
  description = "A Basic Nix Flake Template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    emojis = {
      url = "https://raw.githubusercontent.com/github/gemoji/refs/heads/master/db/emoji.json";
      flake = false;
    };
  };

  outputs = { flake-utils, nixpkgs, emojis, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        program = pkgs.writeShellApplication {
          name = "fzf-emoji";
          text = builtins.readFile ./script.sh;
          runtimeEnv = {
            FZF_EMOJI_DATA_FILE = emojis;
          };
          runtimeInputs = with pkgs; [
            bash
            fzf
            jq
            wl-clipboard
          ];
        };
      in
      {
        packages = rec {
          fzf-emoji = program;
          default = fzf-emoji;
        };
      }
    );
}
