local M = {}

-- Function to dynamically load all server configurations
function M.load_servers()
  local servers = {}

  -- Get the path to the servers directory
  local servers_path = vim.fn.stdpath 'config' .. '/lua/config/lsp/servers'

  -- Check if the servers directory exists
  local uv = vim.loop or vim.uv
  local stat = uv.fs_stat(servers_path)
  if not stat or stat.type ~= 'directory' then
    vim.notify('LSP servers directory not found: ' .. servers_path, vim.log.levels.WARN)
    return servers
  end

  -- Read all files in the servers directory
  local handle = uv.fs_scandir(servers_path)
  if not handle then
    vim.notify('Failed to scan LSP servers directory: ' .. servers_path, vim.log.levels.ERROR)
    return servers
  end

  local name, type = uv.fs_scandir_next(handle)
  while name do
    -- Only process .lua files that aren't init.lua
    if type == 'file' and name:match '%.lua$' and name ~= 'init.lua' then
      local server_name = name:gsub('%.lua$', '')

      -- Try to load the server configuration
      local ok, server_config = pcall(require, 'config.lsp.servers.' .. server_name)
      if ok then
        servers[server_name] = server_config
        vim.notify('Loaded LSP server config: ' .. server_name, vim.log.levels.INFO)
      else
        vim.notify('Failed to load LSP server config: ' .. server_name .. ' - ' .. server_config, vim.log.levels.ERROR)
      end
    end

    name, type = uv.fs_scandir_next(handle)
  end

  return servers
end

return M
