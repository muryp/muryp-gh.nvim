require 'muryp-gh.opts'

local isTelescope, plug = pcall(require, 'telescope.builtin')
if isTelescope then
  ---add picker telescope
  local api = require 'muryp-gh.api.issue'
  plug.gh_issue = function()
    api.list_issue(true)
  end
  plug.gh_issue_cache = function()
    api.list_issue(false)
  end
  -- plug.gh_issue_cache_rg = api.RgIssueCache
end