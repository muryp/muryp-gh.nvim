return function(DataPR)
  local SKIP_KEY = { 'body', 'title', 'url', 'updatedAt', 'closed', 'state' }
  local NotSkipList = {}

  for key, value in pairs(DataPR) do
    local isNotSkip = not vim.tbl_contains(SKIP_KEY, key)
    if isNotSkip then
      NotSkipList[key] = value
    end
  end
  local TOP_FRONTMATTER = 'title: "' .. DataPR.title .. '"\n'
  TOP_FRONTMATTER = TOP_FRONTMATTER .. 'url: ' .. DataPR.url .. '\n'
  TOP_FRONTMATTER = TOP_FRONTMATTER .. 'updatedAt: ' .. DataPR.updatedAt .. '\n'
  TOP_FRONTMATTER = TOP_FRONTMATTER .. 'status: ' .. DataPR.state .. '\n'
  local JSON_NOT_SKIP_LIST = vim.fn.json_encode(NotSkipList) ---@type string
  _G.PRINT = JSON_NOT_SKIP_LIST
  vim.env.JSON_NOT_SKIP_LIST = JSON_NOT_SKIP_LIST
  local NOT_SKIP_LIST = vim.fn.system 'echo $JSON_NOT_SKIP_LIST | yq -p json -o yaml' ---@type string
  local RESULT = TOP_FRONTMATTER .. NOT_SKIP_LIST
  return RESULT
end
