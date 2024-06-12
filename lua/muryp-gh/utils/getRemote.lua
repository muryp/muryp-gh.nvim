---@param repoUrl string
---@return string|nil
local function checkPathExist(repoUrl)
  local RgName = 'github.com[/:]([^/]+)/([^/]+).git'
  -- print(repoUrl)
  local REPO_OWNER, REPO_NAME = string.match(repoUrl, RgName) ---@type string,string
  return REPO_OWNER .. '/' .. REPO_NAME
end
---@return string|string[]|nil DIR_ISSUE location of dir cache
---@param isOpts boolean|nil
return function(isOpts)
  local getRepoUrl = vim.fn.system 'git config --get remote.origin.url' ---@type string|nil
  if getRepoUrl and not isOpts then
    local checkPath = checkPathExist(getRepoUrl)
    if checkPath then
      return checkPath
    end
  end
  local getNameRemote = vim.fn.system 'git remote'
  if string.find(getNameRemote, 'error') then
    vim.api.nvim_err_writeln(getNameRemote)
    return
  end
  local ListPath = {} ---@type string[]
  for line in getNameRemote:gmatch '[^\r\n]+' do
    local cmdRemoteUrl = 'git config --get remote.' .. line .. '.url'
    getRepoUrl = vim.fn.system(cmdRemoteUrl) ---@type string
    local checkPath = checkPathExist(getRepoUrl)
    table.insert(ListPath, checkPath)
  end
  return ListPath
end
