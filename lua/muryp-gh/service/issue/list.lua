---@param REMOTE string
---@return string[] LIST_ISSUE
return function(REMOTE)
  local getList = require('muryp-gh.gh.cli.issue').list {
    remote_url = REMOTE,
  }
  local listIssue = vim.fn.system(getList)
  local LIST_ISSUE = {}
  for _, v in ipairs(vim.split(listIssue, '[\n\r]')) do
    table.insert(LIST_ISSUE, v)
  end
  return LIST_ISSUE
end