---@param REMOTE string
---@return string[] LIST_ISSUE
return function(REMOTE)
  local LIMIT = vim.fn.input 'limit: '
  if LIMIT == '' then
    LIMIT = 5
  end
  local SEARCH = vim.fn.input 'search: '
  local STATUS = vim.fn.input 'status (*open|closed|all): '

  local getList = require('muryp-gh.query.issue').list {
    remote_url = REMOTE,
    limit = LIMIT,
    search = SEARCH,
    state = STATUS,
  }
  local listIssue = vim.fn.system(getList)
  local LIST_ISSUE = {}
  for _, v in ipairs(vim.split(listIssue, '[\n\r]')) do
    table.insert(LIST_ISSUE, v)
  end
  return LIST_ISSUE
end
