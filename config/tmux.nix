{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";
    sensibleOnTop = true;
    shell = "${pkgs.zsh}/bin/zsh";
    # tmux-256color (not the default "screen") so tmux advertises the extended
    # key + truecolor capabilities that modern TUIs and kitty rely on.
    terminal = "tmux-256color";
    # Let modified keys survive the trip through tmux. Without this, tmux
    # collapses Shift+Enter to plain Enter, so Claude Code submits the prompt
    # instead of inserting a newline. extkeys/RGB tell tmux the outer terminal
    # (kitty) supports the kitty keyboard protocol and truecolor.
    extraConfig = ''
      set -s extended-keys always
      set -as terminal-features '*:extkeys'
      set -as terminal-features '*:RGB'
    '';
  };
}
