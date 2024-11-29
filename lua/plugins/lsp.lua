return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "selene",
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "kotlin-language-server",
        "css-lsp",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      --- other options
      servers = {
        tsserver = {
          on_attach = function(client)
            -- this is important, otherwise tsserver will format ts/js
            -- files which we *really* don't want.
            client.server_capabilities.documentFormattingProvider = false
          end,
        },
        biome = {},
        -- other language servers
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls").builtins
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.formatting.biome,

        -- or if you like to live dangerously like me:
        nls.formatting.biome.with({
          args = {
            "check",
            "--write",
            "--unsafe",
            "--formatter-enabled=true",
            "--organize-imports-enabled=true",
            "--skip-errors",
            "--stdin-file-path=$FILENAME",
          },
        }),
      })
    end,
  },
}
