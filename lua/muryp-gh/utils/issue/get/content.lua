return function()
  local CONTENT = vim.api.nvim_buf_get_lines(0, 0, -1, false) ---@type string[]
  local isContent = false
  local BODY = ''
  for _, v in ipairs(CONTENT) do
    if isContent then
      BODY = BODY .. '\n' .. v
    end
    if v == '-->' then
      isContent = true
    end
  end
  return BODY
end
