{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  pkgs-stable = import inputs.nixpkgs-stable {system = pkgs.stdenv.system;};
in {
  # https://devenv.sh/packages/
  packages = with pkgs; [
    git
    # linter and formatter for JavaScript, TypeScript, JSX, CSS and GraphQL
    biome
    # Nix code formatter
    alejandra
  ];

  # https://devenv.sh/languages/
  languages.elixir.enable = true;
  languages.elixir.package = pkgs-stable.elixir_1_18;
  languages.javascript.enable = true;
  languages.javascript.npm.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}
