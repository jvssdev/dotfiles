local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "biome" },
    html = { "prettier" },
    javascript = { "biome" },
    typescriptreact = { "biome" },
    javascriptreact = { "biome" },
    json = { "prettier" },
    jsonc = { "prettier" },
    jsx = { "biome" },
    tsx = { "biome" },
    markdown = { "prettier" },
    go = { "goimports", "gofmt" },
    yaml = { "prettier" },
    qml = { "qmlformat" },
  },
  formatters = {
    stylua = {
      command = vim.fn.stdpath "data" .. "/mason/bin/stylua",
      prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
    },
    prettier = {
      prepend_args = {
        "--tab-width=2",
        "--use-tabs=false",
      },
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
