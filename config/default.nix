{
  config,
  lib,
  pkgs,
  ...
}:
let
  suffixAliases = {
    md = "glow -p";
    json = "jq .";
    log = "less +G";
  };
  renderAlias = ext: cmd: "alias -s ${ext}=${lib.escapeShellArg cmd}";
in
{
  imports = [
    ./bat.nix
    ./direnv.nix
    ./eza.nix
    ./tmux.nix
    #./zoxide.nix
  ];
  programs.zsh = {
    dotDir = "${config.xdg.configHome}/zsh";
    enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "af-magic";
      plugins = [
        "git"
        "ssh"
        "sudo"
        "web-search"
        "extract"
        "colored-man-pages"
        "compleat"
        "fzf"
        "vi-mode"
        "direnv"
      ];
    };
    initContent = lib.mkAfter (
      lib.concatStringsSep "\n" (lib.mapAttrsToList renderAlias suffixAliases)
    );
    shellAliases = {
      ls = "eza";
      cat = "bat";
    };
    shellGlobalAliases = {
      "--help" = "--help 2>&1 | bat --language=help --style=plain";
    };
  };
  home.packages = with pkgs; [
    zsh-syntax-highlighting
    fd
    fzf
    glow
    jq
    w3m
  ];
}
