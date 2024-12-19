local M = {}

local projects = {}

M.setup = function()
  local timer = vim.uv.new_timer()

  -- Get general information about the working environment
  local function get_project_name()
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

  local function create_summary()
    -- Write to the summary
    local summary = "# Github Activity Monitor\n\n"
    summary = summary .. "## Projects worked on in the last 30 minutes:\n\n"

    -- Add the working directory and repository information
    for _, info in ipairs(projects) do
      summary = summary .. "- " .. info .. "\n"
    end

    return summary
  end

  local function git_commit(filename)
    local repo_path = vim.fn.expand("~/.config/GithubActivityMon")
    os.execute("cd " .. repo_path .. " && git add " .. filename)
    os.execute("cd " .. repo_path .. " && git commit -m 'Auto commit: " .. filename .. "' > /dev/null 2>&1")
    os.execute("cd " .. repo_path .. " && git push origin main > /dev/null 2>&1")
  end

  -- Timer setup to run every 30 minutes
  timer:start(
    1800000,
    1800000,
    vim.schedule_wrap(function()
      local current_project = get_project_name()
      table.insert(projects, current_project)
      local summary = create_summary()

      local timestamp = os.date("%Y-%m-%d_%H-%M-%S")
      local filename = string.format("activity_%s.md", timestamp)
      local filepath = vim.fn.expand("~/.config/GithubActivityMon/" .. filename)

      local file = io.open(filepath, "w")
      file:write(summary)
      file:close()

      git_commit(filename)
      vim.notify("Your activity log has been updated!", vim.log.levels.INFO)
    end)
  )
end

return M
