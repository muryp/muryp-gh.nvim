---@param DataIssue table
---@return string
return function(DataIssue)
  local SKIP_KEY = { 'body', 'title', 'url', 'updatedAt', 'closed', 'state' }
  local NotSkipList = {}

  for key, value in pairs(DataIssue) do
    local isNotSkip = not vim.tbl_contains(SKIP_KEY, key)
    if isNotSkip then
      NotSkipList[key] = value
    end
  end
  local TOP_FRONTMATTER = 'title: "' .. DataIssue.title .. '"\n'
  TOP_FRONTMATTER = TOP_FRONTMATTER .. 'url: ' .. DataIssue.url .. '\n'
  TOP_FRONTMATTER = TOP_FRONTMATTER .. 'updatedAt: ' .. DataIssue.updatedAt .. '\n'
  TOP_FRONTMATTER = TOP_FRONTMATTER .. 'status: ' .. DataIssue.state .. '\n'
  local JSON_NOT_SKIP_LIST = vim.fn.json_encode(NotSkipList) ---@type string
  _G.PRINT = JSON_NOT_SKIP_LIST
  vim.env.JSON_NOT_SKIP_LIST = JSON_NOT_SKIP_LIST
  local NOT_SKIP_LIST = vim.fn.system 'echo $JSON_NOT_SKIP_LIST | yq -p json -o yaml' ---@type string
  local RESULT = TOP_FRONTMATTER .. NOT_SKIP_LIST
  return RESULT
end
