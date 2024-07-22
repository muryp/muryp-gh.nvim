---@param Args {remote_url:string,pr_num:number}
---@return string[] -- content
return function(Args)
  local REMOTE_URL = Args.remote_url
  local PR_NUM = Args.pr_num
  local CMD = require('muryp-gh.query.pr').view {
    remote_url = REMOTE_URL,
    pr_num = PR_NUM,
  }
  local getPR = vim.fn.system(CMD) ---@type string JSON
  local DataPR = vim.fn.json_decode(getPR)
  local FRONT_MATTER = require 'muryp-gh.template.prFrontMatter'(DataPR)
  local HELPER = require 'muryp-gh.template.helper' 'GhPR'
  local CONTENT = '---\n' .. FRONT_MATTER .. '\n---\n' .. HELPER .. DataPR.body
  return vim.split(CONTENT, '\n')
end
