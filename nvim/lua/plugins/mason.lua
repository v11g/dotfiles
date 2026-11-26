return {
  -- cmdline tools and lsp servers
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        -- formatters
        "prettier",
        "prettierd",
        "stylelint",
        -- code spell
        "codespell",
        "misspell",
        "cspell",
        -- markdown
        "markdownlint",
        -- rustywind for tailwindcss
        "rustywind",
        -- js
        "js-debug-adapter",
        "oxlint",
        "standardjs",
        -- typescript
        "ts-standard",
        -- prisma ls
        "prisma-language-server",
        -- sql ls
        "sqlls",
        -- helm ls
        "helm-ls",
        -- nginx
        "nginx-language-server",
        -- docker
        "docker-compose-language-service",
        "dockerfile-language-server",
        -- sonarlint
        "sonarlint-language-server",
        -- yaml
        "yamllint",
        "yamlfmt",
      },
    },
  },
}
