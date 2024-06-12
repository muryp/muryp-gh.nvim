local getIssue = require 'muryp-gh.api.getIssue'
local getListRemote = require 'muryp-gh.utils.getRemote'
local headerInfo = require 'muryp-gh.api.headerInfo'
local M = {}

---@param TYPE 'issue'|'pr'|'comment_issue'|'comment_pr'
M.getPathCacheGh = function(TYPE)
  local DIR_LOC_CACHE = _G.MURYP_CACHE_DIR
  local chooseRemote = require('muryp-gh.api.telescope').listRemote
  local listRemote = getListRemote(true)
  if listRemote == nil then
    return
  end
  if type(listRemote) ~= 'string' then
    local totalRemote = 0
    for _ in pairs(listRemote) do
      totalRemote = totalRemote + 1
    end
    if totalRemote > 1 then
      local PATH = chooseRemote(listRemote)
      if PATH == nil then
        return
      end
      DIR_LOC_CACHE = DIR_LOC_CACHE .. PATH
    else
      DIR_LOC_CACHE = DIR_LOC_CACHE .. listRemote[1]
    end
  else
    DIR_LOC_CACHE = DIR_LOC_CACHE .. listRemote
  end
  return DIR_LOC_CACHE .. '/' .. TYPE
end
---@param ISSUE_NUMBER number: the index in line_manager
---@return string[]|nil: {body, name file, dirloc}
M.getContent = function(ISSUE_NUMBER, isUseRemote)
  local DIR_LOC_CACHE = ''
  if isUseRemote then
    DIR_LOC_CACHE = M.getPathCacheGh 'issue' or ''
  end
  local GetIssueData = getIssue { ISSUE_NUMBER = ISSUE_NUMBER }
  local HEADER_ISSUE_STR = headerInfo { GetIssueData = GetIssueData }
  local FILE_NAME = '/' .. ISSUE_NUMBER .. '.md'
  local FILE_RESULT = DIR_LOC_CACHE .. FILE_NAME:gsub(' ', '_') ---@type string
  local ISSUE_HEADER = '+++' .. HEADER_ISSUE_STR .. '+++\n' ---@type string
  local HELP_HEADER = require 'muryp-gh.helper'
  local content = ISSUE_HEADER .. HELP_HEADER .. string.gsub(GetIssueData.body, '\r', '') ---@type string
  return { content, FILE_RESULT, DIR_LOC_CACHE }
end
local function write_to_file(filename, content)
  local file = io.open(filename, 'w')
  if file then
    file:write(content)
    file:close()
  else
    print 'Error opening file for writing.'
  end
end
---@param ISSUE_NUMBER number: the index in line_manager
---create file and add maps
M.ghIssue = function(ISSUE_NUMBER)
  local content = M.getContent(ISSUE_NUMBER, true)
  if content == nil then
    return
  end
  os.execute('mkdir -p ' .. content[3])
  write_to_file(content[2], content[1])
  vim.cmd('e ' .. content[2])
end
return M
