{ config, pkgs, ... }:
{
  imports = [
    ./bat.nix
    ./direnv.nix
    ./eza.nix
    ./tmux.nix
    ./zoxide.nix
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
  ];
}
