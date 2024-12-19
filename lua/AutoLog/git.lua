local M = {}

-- Commit and push the file to the repo
M.git_commit = function(filename)
  local repo_path = vim.fn.expand("~/.config/GithubActivityMon")
  os.execute("cd " .. repo_path .. " && git add " .. filename)
  os.execute("cd " .. repo_path .. " && git commit -m 'Auto commit: " .. filename .. "' > /dev/null 2>&1")
  os.execute("cd " .. repo_path .. " && git push origin main > /dev/null 2>&1")
end

return M
