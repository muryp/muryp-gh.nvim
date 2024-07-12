---@param repoUrl string
---@return string|nil
local function getCheckRemotePath(repoUrl)
  local RG_GH = '.*github.com[/:]'
  local RM_DOMAIN = string.gsub(repoUrl, RG_GH, '')
  local RM_DOT = string.gsub(RM_DOMAIN, '%.git', '')
  local RM_NEW_LINE = string.gsub(RM_DOT, '[ \n\r]', ' ')
  local REPO_OWNER, REPO_NAME = string.match(RM_NEW_LINE, '([^/]+)/([^/]+)')
  return REPO_OWNER .. '/' .. REPO_NAME
end
---@return string|string[]|nil DIR_ISSUE location of dir cache
return function()
  local getRepoUrl = vim.fn.system 'git config --get remote.origin.url' ---@type string|nil
  local LIST_REMOTE = vim.split(getRepoUrl, '[\n\r]')
  local userSelect
  vim.ui.select(LIST_REMOTE, { prompt = 'choose your remote' }, function(choise)
    userSelect = choise
  end)
  if userSelect == nil then
    return
  end
  if userSelect then
    local REMOTE_PATH = getCheckRemotePath(userSelect)
    if REMOTE_PATH then
      return REMOTE_PATH
    end
  end
end
