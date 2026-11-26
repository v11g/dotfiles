local Lsp = require("utils.lsp")

-- run only the first available formatter of the list
local function first(list)
  list.stop_after_first = true
  return list
end

return {
  {
    "stevearc/conform.nvim",
    optional = true,
    keys = {
      { "<leader>cn", "<cmd>ConformInfo<cr>", desc = "Conform Info" },
    },
    opts = {
      formatters_by_ft = {
        fish = {},
        go = { "goimports", "gofmt" },
        python = { "ruff_fix", "ruff_format" },
        php = { "pint" },
        rust = { "rustfmt" },
        -- ❌ Remove nested brackets
        yaml = first({ "prettierd", "prettier", "dprint" }),
        ["markdown"] = first({ "prettierd", "prettier", "dprint" }),
        ["markdown.mdx"] = first({ "prettierd", "prettier", "dprint" }),
        ["javascript"] = first({ "deno_fmt", "prettierd", "prettier", "biome", "dprint" }),
        -- rustywind (tailwind class sort) must run before the formatter, so no stop_after_first here
        ["javascriptreact"] = { "rustywind", "deno_fmt", "prettierd", "biome", "dprint" },
        ["typescript"] = first({ "deno_fmt", "prettierd", "prettier", "biome", "dprint" }),
        ["typescriptreact"] = { "rustywind", "deno_fmt", "prettierd", "biome", "dprint" },
        ["svelte"] = { "rustywind", "deno_fmt", "prettierd", "biome", "dprint" },
      },
      formatters = {
        biome = {
          condition = function()
            local path = Lsp.biome_config_path()
            local is_nvim = path and string.match(path, "nvim")
            return path and not is_nvim
          end,
        },
        deno_fmt = {
          condition = function()
            return Lsp.deno_config_exist()
          end,
        },
        dprint = {
          condition = function()
            return Lsp.dprint_config_exist()
          end,
        },
        prettier = {
          condition = function()
            local path = Lsp.biome_config_path()
            local is_nvim = path and string.match(path, "nvim")
            return not (path and not is_nvim)
          end,
        },
        prettierd = {
          condition = function()
            local path = Lsp.biome_config_path()
            local is_nvim = path and string.match(path, "nvim")
            return not (path and not is_nvim)
          end,
        },
      },
    },
  },
}
