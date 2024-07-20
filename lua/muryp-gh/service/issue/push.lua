---@param REMOTE_URL string
---@return string
return function(REMOTE_URL)
  local ISSUE_NUMBER = require 'muryp-gh.utils.issue.get.number'()
  local CONTENT = require 'muryp-gh.utils.issue.get.content'()
  vim.env.ISSUE_CONTENT = CONTENT
  local CMD = require('muryp-gh.query.issue').push(REMOTE_URL .. '/issues/' .. ISSUE_NUMBER)
  return vim.fn.system(CMD)
end