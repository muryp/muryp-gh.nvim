_G.MURYP_CACHE_DIR = os.getenv 'HOME' .. '.muryp/nvim/gh/'
local isTelescope, plug = pcall(require, 'telescope.builtin')
if isTelescope then
  ---add picker telescope
  local api = require 'muryp-gh.api.telescope'
  plug.gh_issue = api.getListIssue
  plug.gh_issue_cache = api.getListIssueCache
end