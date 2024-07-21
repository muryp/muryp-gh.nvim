return function()
  local CONTENT = vim.api.nvim_buf_get_lines(0, 0, -1, false) ---@type string[]
  local isContent = false
  local BODY = {}
  for _, v in ipairs(CONTENT) do
    if isContent then
      table.insert(BODY, v)
    end
    if v == '-->' then
      isContent = true
    end
  end
  local RESULT = table.concat(BODY, '\n')
  return RESULT
end
