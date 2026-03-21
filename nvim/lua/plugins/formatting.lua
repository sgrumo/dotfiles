local function web_formatter(bufnr)
  if vim.fs.root(bufnr, { '.oxfmtrc', '.oxfmtrc.json', 'oxfmt.config.js' }) then
    return { 'oxfmt' }
  end
  return { 'prettier' }
end

return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 2500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = web_formatter,
        javascriptreact = web_formatter,
        typescript = web_formatter,
        typescriptreact = web_formatter,
        json = web_formatter,
        yaml = web_formatter,
        css = web_formatter,
        html = web_formatter,
        markdown = { 'prettier' },
      },
    },
  },
}
