---@param Args {remote_url:string,issue_number:number}
---@return string[]
return function(Args)
  local REMOTE_URL = Args.remote_url
  local ISSUE_NUMBER = Args.issue_number

  local CMD = require('muryp-gh.query.issue').view {
    remote_url = REMOTE_URL,
    issue_number = ISSUE_NUMBER,
  }
  local getIssue = vim.fn.system(CMD) ---@type string -- json
  local DataIssue = vim.fn.json_decode(getIssue) ---@type table
  local FRONT_MATTER = require 'muryp-gh.template.issueFrontMatter'(DataIssue)
  local HELPER = require 'muryp-gh.template.helper' 'Ghissue'
  local CONTENT = '---\n' .. FRONT_MATTER .. '\n---\n' .. HELPER .. DataIssue.body
  return vim.split(CONTENT, '\n')
end
