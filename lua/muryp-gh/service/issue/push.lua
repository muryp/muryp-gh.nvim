---@param Args {issue_url:string,remote_url:string,issue_number:number}
---@return string
return function(Args)
  local ISSUE_URL = Args.issue_url
  local REMOTE_URL = Args.remote_url
  local ISSUE_NUMBER = Args.issue_number
  local CONTENT = require 'muryp-gh.utils.issue.get.content'()
  local CURR_CONTENT = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local updateAt = ''
  for _, v in pairs(CURR_CONTENT) do
    local RG = 'updatedAt: '
    if v:match(RG) then
      updateAt = v:gsub(RG, '')
      break
    end
  end
  print(vim.inspect(updateAt))
  local JSON_UPDATE_ONLINE = vim.fn.system('gh issue view ' .. ISSUE_NUMBER .. ' --json updatedAt -R ' .. REMOTE_URL)
  local updateAtOnline = vim.fn.json_decode(JSON_UPDATE_ONLINE).updatedAt
  if updateAt ~= updateAtOnline then
    local isWantMerge = vim.fn.input 'Want to merge? [y/N] '
    if isWantMerge ~= 'y' then
      return 'Abort'
    end
  end
  vim.env.ISSUE_CONTENT = CONTENT
  local CMD = require('muryp-gh.query.issue').push(ISSUE_URL)
  return vim.fn.system(CMD)
end
