local M = {}

local config = require("AutoLog.config")
local summary = require("AutoLog.summary")
local git = require("AutoLog.git")
local utils = require("AutoLog.utils")

M.setup = function()
  -- Ensure the directory exists
  utils.ensure_directory()

  local timer = vim.uv.new_timer()
  local projects = {}
  -- Timer setup to run every 30 minutes
  timer:start(
    config.timer_interval,
    config.timer_interval,
    vim.schedule_wrap(function()
      table.insert(projects, summary.get_project_name())

      -- Create the summary
      local activity_summary = summary.create_summary(projects)

      -- Generate a timestamped filename
      local timestamp = os.date("%Y-%m-%d_%H-%M-%S")
      local filename = string.format("activity_%s.md", timestamp)
      local filepath = vim.fn.expand(config.repo_path .. "/" .. filename)

      -- Write the summary to a file
      local file = io.open(filepath, "w")
      file:write(activity_summary)
      file:close()

      -- Commit and push the changes
      git.git_commit(filename)

      -- Notify the user
      vim.notify("Your activity log has been updated!", vim.log.levels.INFO)
    end)
  )
end

return M
