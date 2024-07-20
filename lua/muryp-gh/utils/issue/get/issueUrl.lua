---@return integer
return function()
  local CONTENT = vim.api.nvim_buf_get_lines(0, 0, -1, false) ---@type string[]
  local CONTENT_STR = table.concat(CONTENT, '\n')
  local ISSUE_NUMBER = string.match(CONTENT_STR, '(https://github.com/[^/]+/[^/]+/issues/[0-9]+)')
  return ISSUE_NUMBER
end
