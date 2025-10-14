local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "biome" },
    html = { "biome" },
    javascript = { "biome" },
    typescriptreact = { "biome" },
    javascriptreact = { "biome" },
    json = { "biome" },
    jsx = { "biome" },
    tsx = { "biome" },
    markdown = { "biome" },
    go = { "goimports", "gofmt" },
  },
  formatters = {
    stylua = {
      command = vim.fn.stdpath "data" .. "/mason/bin/stylua",
      prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
    },
    prettier = {
      prepend_args = { "--tab-width", "2" },
    },
    prettierd = {
      env = {
        PRETTIERD_DEFAULT_CONFIG = vim.fn.expand "~/.prettierrc",
      },
    },
    isort = {
      prepend_args = { "--line-length", "88", "--profile", "black" },
    },
    black = {
      prepend_args = { "--line-length", "88" },
    },
    htmlbeautifier = {
      prepend_args = { "--indent-size", "2" },
    },
    biome = {
      prepend_args = {
        "format",
        "--indent-style",
        "space",
        "--indent-width",
        "2",
      },
    },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
