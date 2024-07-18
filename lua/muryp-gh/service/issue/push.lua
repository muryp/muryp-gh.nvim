---@param REMOTE_URL string
---@return string
return function(REMOTE_URL)
  local ISSUE_NUMBER = require 'muryp-gh.utils.issue.get.number'()
  local CONTENT = require 'muryp-gh.utils.issue.get.content'()
  local CMD = require('muryp-gh.gh.cli').issue_push {
    remote_url = REMOTE_URL,
    issue = ISSUE_NUMBER,
    content = CONTENT,
  }
  return vim.fn.system(CMD)
end
