-- clippy lints on save instead of plain cargo check
return {
  {
    "mrcjkb/rustaceanvim",
    opts = {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            check = { command = "clippy" },
          },
        },
      },
    },
  },
}
