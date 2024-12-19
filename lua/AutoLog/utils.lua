local M = {}
local config = AutoLog.config

-- Ensure the necessary directory exists
M.ensure_directory = function()
  if vim.fn.isdirectory(config.repo_path) == 0 then
    vim.fn.mkdir(config.repo_path, "p")
  end
end

return M
