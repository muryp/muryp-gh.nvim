local picker = require 'muryp-gh.utils.picker'
local M = {}

--- get issue list get from online
M.getListIssue = function(REMOTE_URL)
  local LIST_ISSUE = require 'muryp-gh.service.issue.list'(REMOTE_URL)
  ---@param UserSelect string|string[]
  ---@return nil
  local function callBack(UserSelect)
    local openIssue = require 'muryp-gh.utils.issue.write.issue'

    if type(UserSelect) == 'string' then
      local ISSUE_NUMBER_STR = string.gsub(UserSelect, '\t.*', '')
      local ISSUE_NUMBER = tonumber(ISSUE_NUMBER_STR) or 1
      openIssue {
        remote_url = REMOTE_URL,
        issue_number = ISSUE_NUMBER,
      }
    else
      for _, USER_SELECT in pairs(UserSelect) do
        local ISSUE_NUMBER_STR = string.gsub(USER_SELECT, '\t.*', '')
        local ISSUE_NUMBER = tonumber(ISSUE_NUMBER_STR) or 1
        openIssue {
          remote_url = REMOTE_URL,
          issue_number = ISSUE_NUMBER,
        }
      end
    end
  end

  picker {
    ListOption = LIST_ISSUE,
    callBack = callBack,
    PREVIEW_OPTS = 'GH_ISSUE',
    title = 'choose your issue',
    remote_url = REMOTE_URL,
  }
end

M.getListIssueCache = function(REMOTE)
  local getCacheDir = _G.MURYP_GH.cache_dir .. '/' .. REMOTE .. '/'
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
      return
    end,
  }
end

return M
