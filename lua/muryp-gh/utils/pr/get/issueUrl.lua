---@return {num:number,url:string}
return function()
  local CONTENT = vim.api.nvim_buf_get_lines(0, 0, -1, false) ---@type string[]
  local CONTENT_STR = table.concat(CONTENT, '\n')
  local URL = string.match(CONTENT_STR, '(https://github.com/[^/]+/[^/]+/issues/[0-9]+)')
  local PR_NUMBER = string.gsub(CONTENT_STR, '.*/', '')
  return { num = tonumber(PR_NUMBER) or 1, url = URL }
end
