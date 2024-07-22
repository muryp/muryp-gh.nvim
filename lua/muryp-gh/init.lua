local M = {}

--- @param Args {cache_dir:string,isUseMaps:boolean}|nil
M.setup = function(Args)
  _G.MURYP_GH = {
    cache_dir = os.getenv 'HOME' .. '/.muryp/nvim/gh',
    ssh_dir = os.getenv 'HOME' .. '/.ssh/github',
  }
  if not Args then
    Args = {}
  end
  if Args.cache_dir then
    _G.MURYP_GH.cache_dir = Args.cache_dir
  end
  if Args.isUseMaps ~= false then
    require 'muryp-gh.mappings'
  end
end
local isTelescope, plug = pcall(require, 'telescope.builtin')
if isTelescope then
  ---add picker telescope
  local IssueApi = require 'muryp-gh.api.issue'
  plug.gh_issue = function()
    IssueApi.list(true)
  end
  plug.gh_issue_cache = function()
    IssueApi.list(false)
  end
  plug.gh_issue_cache_rg = IssueApi.rg

  local PrApi = require 'muryp-gh.api.pr'
  plug.gh_pr = function()
    PrApi.list(true)
  end
  plug.gh_pr_cache = function()
    PrApi.list(false)
  end
  plug.gh_pr_cache_rg = PrApi.rg
end
return M
