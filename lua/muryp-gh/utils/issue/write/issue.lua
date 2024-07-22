---@param Args {remote_url:string,issue_number:number}
---@return nil --- open issue
return function(Args)
  local ContentIssue = require 'muryp-gh.service.issue.preview'(Args)
  local DATA = vim.split(Args.remote_url, '/')
  local USER_NAME, REPO_NAME = unpack(DATA)
  local DIR = _G.MURYP_GH.cache_dir .. '/' .. USER_NAME .. '/' .. REPO_NAME .. '/issue/'
  local FILE = DIR .. Args.issue_number .. '.md'
  vim.fn.mkdir(vim.fn.fnamemodify(DIR, ':p:h'), 'p')
  vim.fn.writefile(ContentIssue, FILE)
  vim.cmd('e ' .. FILE)
end
