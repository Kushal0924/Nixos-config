{ config, pkgs, inputs, ... }:

{

  imports = [ inputs.lazyvim.homeManagerModules.default ];
  programs.lazyvim = {
    enable = true;

    extras = {
      lang = {
        nix.enable = true;
        python = {
          enable = true;
          installDependencies = true;        # Install ruff
          installRuntimeDependencies = true; # Install python3
        };
        go = {
          enable = true;
          installDependencies = true;        # Install gopls, gofumpt, etc.
          installRuntimeDependencies = true; # Install go compiler
        };
      };
    };

    # Additional packages (optional)
    extraPackages = with pkgs; [
      nixd       # Nix LSP
      alejandra  # Nix formatter
      statix     # Nix linter
    ];

    config = {
      options = ''
        vim.cmd.colorscheme = nil
        vim.opt.termguicolors = true
        vim.cmd("set t_Co=256")
      '';
    };

    plugins = {
      colors = ''
        return {
          {
            "LazyVim/LazyVim",
              opts = {
                colorscheme = function() end, -- Disable LazyVim's colorscheme
              },
            },
          }
      '';
    };

  };

}
