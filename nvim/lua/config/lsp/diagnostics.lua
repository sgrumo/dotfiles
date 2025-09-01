local M = {}

-- Setup diagnostic configuration
function M.setup()
  -- Diagnostic Config
  -- See :help vim.diagnostic.Opts
  vim.diagnostic.config {
    severity_sort = true,
    float = {
      border = 'rounded',
      source = 'if_many',
    },
    underline = {
      severity = vim.diagnostic.severity.ERROR,
    },
    signs = vim.g.have_nerd_font and {
      text = {
        [vim.diagnostic.severity.ERROR] = '󰅚 ',
        [vim.diagnostic.severity.WARN] = '󰀪 ',
        [vim.diagnostic.severity.INFO] = '󰋽 ',
        [vim.diagnostic.severity.HINT] = '󰌶 ',
      },
    } or {},
    virtual_text = {
      source = 'if_many',
      spacing = 2,
      format = function(diagnostic)
        local diagnostic_message = {
          [vim.diagnostic.severity.ERROR] = diagnostic.message,
          [vim.diagnostic.severity.WARN] = diagnostic.message,
          [vim.diagnostic.severity.INFO] = diagnostic.message,
          [vim.diagnostic.severity.HINT] = diagnostic.message,
        }
        return diagnostic_message[diagnostic.severity]
      end,
    },
  }
end

-- Setup diagnostic keymaps (if you want diagnostic-specific keymaps)
function M.setup_keymaps()
  -- Example diagnostic keymaps (uncomment if desired)
  -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
  -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
  -- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic error messages' })
  -- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })
end

return M
