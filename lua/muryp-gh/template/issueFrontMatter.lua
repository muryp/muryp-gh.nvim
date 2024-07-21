---@param DATA_ISSUE table
---@return string
return function(DATA_ISSUE)
  local SKIP_KEY = { 'body', 'title', 'url' }
  local NotSkipList = {}

  for key, value in pairs(DATA_ISSUE) do
    local isNotSkip = not vim.tbl_contains(SKIP_KEY, key)
    if isNotSkip then
      NotSkipList[key] = value
    end
  end
  local TOP_FRONTMATTER = 'title: "' .. DATA_ISSUE.title .. '"\nurl: ' .. DATA_ISSUE.url .. '\n'
  local JSON_NOT_SKIP_LIST = vim.fn.json_encode(NotSkipList) ---@type string
  _G.PRINT = JSON_NOT_SKIP_LIST
  vim.env.JSON_NOT_SKIP_LIST = JSON_NOT_SKIP_LIST
  local NOT_SKIP_LIST = vim.fn.system 'echo $JSON_NOT_SKIP_LIST | yq -p json -o yaml' ---@type string
  local RESULT = TOP_FRONTMATTER .. NOT_SKIP_LIST
  return RESULT
end
