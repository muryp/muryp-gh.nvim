local getIssue = require 'muryp-gh.api.getIssue'
local headerInfo = require 'muryp-gh.api.headerInfo'
local M = {}

---@param ISSUE_NUMBER number: the index in line_manager
---@return string[]: {body, name file, dirloc}
M.getContent = function(ISSUE_NUMBER)
  local DIR_LOC_CACHE = _G.MURYP_CACHE_DIR()
  local GetIssueData = getIssue { ISSUE_NUMBER = ISSUE_NUMBER }
  local HEADER_ISSUE_STR = headerInfo { GetIssueData = GetIssueData }
  -- TODO: use name file just isse number
  local FILE_NAME = '/' .. ISSUE_NUMBER .. '.md'
  local FILE_RESULT = DIR_LOC_CACHE .. FILE_NAME:gsub(' ', '_') ---@type string
  local ISSUE_HEADER = '+++' .. HEADER_ISSUE_STR .. '+++\n' ---@type string
  local HELP_HEADER = require 'muryp-gh.helper'
  local content = ISSUE_HEADER .. HELP_HEADER .. string.gsub(GetIssueData.body, '\r', '') ---@type string
  return { content, FILE_RESULT, DIR_LOC_CACHE }
end
---@param ISSUE_NUMBER number: the index in line_manager
---create file and add maps
M.ghIssue = function(ISSUE_NUMBER)
  local content = M.getContent(ISSUE_NUMBER)
  os.execute('mkdir -p ' .. content[3])
  local f = io.open(content[2], 'w')
  ---@diagnostic disable-next-line: need-check-nil
  f:write(content[1])
  ---@diagnostic disable-next-line: need-check-nil
  f:close()
  vim.cmd('e ' .. content[2])
end
return M
