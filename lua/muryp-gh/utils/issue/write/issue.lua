---@param Args {remote_url:string,issue:number}
---@return nil --- open issue
return function(Args)
  local getIssue = require 'muryp-gh.service.issue.preview'(Args)
  local DATA = vim.split(Args.remote_url, '/')
  local USER_NAME, REPO_NAME = unpack(DATA)
  local DIR = _G.MURYP_GH.cache_dir .. '/' .. USER_NAME .. '/' .. REPO_NAME .. '/issue'
  local FILE = DIR .. '/' .. Args.issue .. '.md'
  vim.fn.mkdir(vim.fn.fnamemodify(DIR, ':p:h'), 'p')
  local splitIssue = vim.split(getIssue, '[\n\r]')
  vim.fn.writefile(splitIssue, FILE)
  vim.cmd('e ' .. FILE)
end
