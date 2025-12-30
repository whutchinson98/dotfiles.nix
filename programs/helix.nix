{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox";
      editor = {
        bufferline = "multiple";
        file-picker = {
          hidden = false;
          git-ignore = true;
        };
        cursor-shape = {
          insert = "block";
          normal = "block";
          select = "underline";
        };
        line-number = "relative";
        cursorline = true;
        auto-format = true;
        end-of-line-diagnostics = "hint";
        soft-wrap = {
          enable = true;
        };
        lsp = {
          display-inlay-hints = true;
          display-messages = true;
          display-progress-messages = true;
        };
        inline-diagnostics = {
          cursor-line = "hint";
        };
      };
      keys = {
        normal = {
          esc = [
            "keep_primary_selection"
            "collapse_selection"
          ];
          space = {
            s = {
              l = "vsplit";
            };
          };
          C-c = [
            "keep_primary_selection"
            "collapse_selection"
          ];
          minus = "file_picker_in_current_buffer_directory";
        };
      };
    };
    languages = {
      language-server.rust-analyzer = {
        config = {
          check = {
            command = "clippy";
          };
          checkOnSave = true;
          cargo = {
            allFeatures = true;
          };
        };
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
          };
        }
        {
          name = "rust";
          auto-format = true;
          formatter = {
            command = "rustfmt";
            args = [
              "--edition"
              "2024"
            ];
          };
          indent = {
            tab-width = 4;
            unit = "t";
          };
        }
        {
          name = "json";
          auto-format = true;
        }
        {
          name = "just";
          auto-format = true;
          formatter = {
            command = "just";
            args = [
              "--justfile"
              "/dev/stdin"
              "--dump"
            ];
          };
        }
        {
          name = "toml";
          auto-format = true;
          formatter = {
            command = "taplo";
            args = [
              "format"
              "-"
            ];
          };
        }
        {
          name = "typescript";
          roots = [
            "package.json"
          ];
          file-types = [
            "ts"
            "tsx"
          ];
          auto-format = true;
          language-servers = [ "typescript-language-server" ];
        }
      ];
    };
  };
}
