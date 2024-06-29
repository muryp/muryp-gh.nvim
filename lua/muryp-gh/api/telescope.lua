local picker = require 'muryp-gh.utils.picker'
local ghIssue = require('muryp-gh.api').ghIssue
local M = {}

--- get issue list get from online
M.getListIssue = function()
  local ListIssue = {}
  local ISSUE_LIST = vim.api.nvim_command_output "echo system('gh issue list')"
  for WORD in string.gmatch(ISSUE_LIST, '[^\r\n]+') do
    table.insert(ListIssue, WORD)
  end
  ---@param UserSelect string|string[]
  ---@return nil
  local function callBack(UserSelect)
    if type(UserSelect) == 'string' then
      local ISSUE_NUMBER_STR = string.gsub(UserSelect, '\t.*', '')
      local ISSUE_NUMBER = tonumber(ISSUE_NUMBER_STR) or 1
      ghIssue(ISSUE_NUMBER)
    else
      for _, USER_SELECT in pairs(UserSelect) do
        local ISSUE_NUMBER_STR = string.gsub(USER_SELECT, '\t.*', '')
        local ISSUE_NUMBER = tonumber(ISSUE_NUMBER_STR) or 1
        ghIssue(ISSUE_NUMBER)
      end
    end
  end

  picker {
    opts = ListIssue,
    callBack = callBack,
    PREVIEW_OPTS = 'GH_ISSUE',
    title = 'choose your issue',
  }
end

---@param listDir string[]
M.listRemote = function(listDir)
  local DIR = nil ---@type string|nil
  local callback = function(UserSelect)
    DIR = UserSelect
  end
  picker {
    opts = listDir,
    callBack = callback,
    title = 'choose your remote',
  }
  return DIR
end

M.getListIssueCache = function()
  local getCacheDir = require('muryp-gh.api').getPathCacheGh 'issue'
  if getCacheDir == nil or getCacheDir == '' then
    print 'youre remote invalid'
    return
  end
  local isHaveDir = vim.fn.isdirectory(getCacheDir)
  if isHaveDir == 0 then
    print 'no cache dir'
    return
  end
  require('telescope.builtin').find_files {
    cwd = getCacheDir,
    prompt_title = 'choose your issue',
  }
end
M.RgIssueCache = function()
  local getCacheDir = require('muryp-gh.api').getPathCacheGh 'issue'
  if getCacheDir == nil or getCacheDir == '' then
    print 'youre remote invalid'
    return
  end
  local isHaveDir = vim.fn.isdirectory(getCacheDir)
  if isHaveDir == 0 then
    print 'no cache dir'
    return
  end
  require('telescope.builtin').live_grep {
    cwd = getCacheDir,
    prompt_title = 'choose your issue',
    callBack = function(ctx)
      print(vim.inspect(ctx))
      error 'hello'
      return
    end,
  }
end

return M
