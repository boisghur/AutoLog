local M = {}

M.repo_path = vim.fn.expand("~/.config/GithubActivityMon") -- Default repo path
M.timer_interval = 18000 -- Default 30 minutes (in milliseconds)

return M
