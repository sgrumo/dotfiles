local M = {}

-- Helper function to create LSP keymaps
local function map(keys, func, desc, mode, buffer)
  mode = mode or 'n'
  vim.keymap.set(mode, keys, func, { buffer = buffer, desc = 'LSP: ' .. desc })
end

-- Setup LSP keymaps for a specific buffer
function M.setup(event)
  local buffer = event.buf

  -- Rename the variable under your cursor.
  --  Most Language Servers support renaming across files, etc.
  map('grn', vim.lsp.buf.rename, '[R]e[n]ame', 'n', buffer)

  -- Execute a code action, usually your cursor needs to be on top of an error
  -- or a suggestion from your LSP for this to activate.
  map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' }, buffer)

  -- Find references for the word under your cursor.
  map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences', 'n', buffer)

  -- Jump to the implementation of the word under your cursor.
  --  Useful when your language has ways of declaring types without an actual implementation.
  map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation', 'n', buffer)

  -- Jump to the definition of the word under your cursor.
  --  This is where a variable was first declared, or where a function is defined, etc.
  --  To jump back, press <C-t>.
  map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition', 'n', buffer)

  -- WARN: This is not Goto Definition, this is Goto Declaration.
  --  For example, in C this would take you to the header.
  map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration', 'n', buffer)

  -- Fuzzy find all the symbols in your current document.
  --  Symbols are things like variables, functions, types, etc.
  map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols', 'n', buffer)

  -- Fuzzy find all the symbols in your current workspace.
  --  Similar to document symbols, except searches over your entire project.
  map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols', 'n', buffer)

  -- Jump to the type of the word under your cursor.
  --  Useful when you're not sure what type a variable is and you want to see
  --  the definition of its *type*, not where it was *defined*.
  map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition', 'n', buffer)

  -- Get the LSP client for additional feature checks
  local client = vim.lsp.get_client_by_id(event.data.client_id)

  -- The following code creates a keymap to toggle inlay hints in your
  -- code, if the language server you are using supports them
  --
  -- This may be unwanted, since they displace some of your code
  if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, buffer) then
    map('<leader>th', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = buffer })
    end, '[T]oggle Inlay [H]ints', 'n', buffer)
  end

  -- Organize imports keybinding
  map('<leader>oi', function()
    vim.lsp.buf.code_action {
      context = { only = { 'source.organizeImports' }, diagnostics = {} },
      apply = true,
    }
  end, '[O]rganize [I]mports', 'n', buffer)
end

return M
