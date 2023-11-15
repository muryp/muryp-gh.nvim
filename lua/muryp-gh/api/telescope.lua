-- gh issue list
local picker        = require "muryp-gh.utils.picker"
local ghIssue       = require('muryp-gh.api').ghIssue
local cacheDir      = _G.MURYP_CACHE_DIR
local M             = {}

--- get issue list get from online
M.getListIssue      = function()
  local ListIssue = {}
  local ISSUE_LIST = vim.api.nvim_command_output("echo system('gh issue list')")
  for WORD in string.gmatch(ISSUE_LIST, "[^\r\n]+") do
    table.insert(ListIssue, WORD)
  end
  ---@param UserSelect string|string[]
  ---@return nil
  local function callBack(UserSelect)
    if type(UserSelect) == 'string' then
      local ISSUE_NUMBER = UserSelect:gsub("\t.*", "") ---@type number : single issue number
      ghIssue(ISSUE_NUMBER)
    else
      for _, USER_SELECT in pairs(UserSelect) do
        local ISSUE_NUMBER = USER_SELECT:gsub("\t.*", "") ---@type number : single issue number
        ghIssue(ISSUE_NUMBER)
      end
    end
  end

  picker({
    opts = ListIssue,
    callBack = callBack,
    PREVIEW_OPTS = 'GH_ISSUE',
    title = 'choose your issue'
  })
end

---issue list offline
M.getListIssueCache = function()
  local GET_DIR     = vim.fn.system("ls " .. cacheDir())
  local isHaveIssue = string.find(GET_DIR, 'No such file or directory')
  if isHaveIssue then
    vim.api.nvim_err_writeln("you haven't issue on cache")
    return
  end
  local ListIssue = {}
  for FILE_NAME in string.gmatch(GET_DIR, "[^\r\n]+") do
    table.insert(ListIssue, FILE_NAME)
  end
  ---@param UserSelect string|string[]
  ---@return nil
  local callback = function(UserSelect)
    if type(UserSelect) == 'string' then
      vim.cmd('e ' .. cacheDir() .. UserSelect)
      return
    end
    for _, value in pairs(UserSelect) do
      vim.cmd('e ' .. cacheDir() .. value)
    end
  end

  picker({
    opts = ListIssue,
    callBack = callback,
    PREVIEW_OPTS = 'FILE',
    title = 'choose your issue cache',
  })
end

return M
