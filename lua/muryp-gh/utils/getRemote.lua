---@param repoUrl string
---@return string|nil
local function getOwnerRepoName(repoUrl)
  local RG_GH = '.*github.com[/:]'
  local RM_DOMAIN = repoUrl:gsub(RG_GH, '')
  local RM_DOT = RM_DOMAIN:gsub(' .*', ''):gsub('(.*)%.git', '%1')
  return RM_DOT
end
---@return string[] REMOTE_LIST location of dir cache
return function()
  local listRemote = vim.fn.system 'git remote -v'
  local splitRemote = vim.split(listRemote, '[\r\n]') ---@type string[]
  local LIST_REMOTE = {}
  for _, remote in ipairs(splitRemote) do
    local isGithub = string.find(remote, 'github.com')
    if isGithub then
      local ownerRepoName = getOwnerRepoName(remote)
      local isEmpty = ownerRepoName == nil or ownerRepoName == ''
      if not vim.tbl_contains(LIST_REMOTE, ownerRepoName) and not isEmpty then
        table.insert(LIST_REMOTE, ownerRepoName)
      end
    end
  end
  return LIST_REMOTE
end
