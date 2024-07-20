local M = {}

local isUseTelescope = true
--- @param Args {cache_dir:string,isUseTelescope:boolean,isUseMaps:boolean}|nil
M.setup = function(Args)
  _G.MURYP_GH = {
    cache_dir = os.getenv 'HOME' .. '/.muryp/nvim/gh',
  }
  if not Args then
    Args = {}
  end
  if Args.cache_dir then
    _G.MURYP_GH.cache_dir = Args.cache_dir
  end
  if Args.isUseTelescope then
    isUseTelescope = Args.isUseTelescope
  end
  if Args.isUseMaps ~= false then
    require 'muryp-gh.mappings'
  end
end
if isUseTelescope then
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
end
return M
