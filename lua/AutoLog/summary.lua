local M = {}

local projects = {}

M.get_project_name = function()
  local project_name = ""

  -- Run the git command to fetch the repository URL
  local handle = io.popen("git remote get-url origin 2>/dev/null")
  local result = handle:read("*a")
  handle:close()

  -- Check if we got a result (i.e., a valid URL)
  if result and result ~= "" then
    -- Clean up the URL (remove any extra spaces or newlines)
    result = result:gsub("\n", ""):gsub("\r", "")

    local repo_name = result:match("([^/]+)%.git$") -- This regex extracts the repo name from the URL
    return repo_name
  else
    -- If not a Git repo, just use the last part of the directory as project name
    project_name = vim.fn.fnamemodify(cwd, ":t")
  end
  return project_name
end

-- Create a log entry template
M.create_summary = function(projects)
  table.insert(projects, summary.get_project_name())

  local summary = "# Github Activity Monitor\n\n"
  summary = summary .. "## Projects worked on in the last 30 minutes:\n\n"

  for _, info in ipairs(projects) do
    summary = summary .. "- " .. info .. "\n"
  end

  return summary
end

return M
