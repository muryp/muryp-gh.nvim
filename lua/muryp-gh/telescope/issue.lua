local picker = require 'muryp-gh.utils.picker'
local M = {}

---TODO: get list previews issue

--- get issue list get from online
M.getListIssue = function(REMOTE_URL)
  local LIST_ISSUE = require 'muryp-gh.service.issue.list'(REMOTE_URL)
  ---@param UserSelect string|string[]
  ---@return nil
  local function callBack(UserSelect)
    local writeIssue = require 'muryp-gh.utils.issue.write.issue'

    if type(UserSelect) == 'string' then
      local ISSUE_NUMBER_STR = string.gsub(UserSelect, '\t.*', '')
      local ISSUE_NUMBER = tonumber(ISSUE_NUMBER_STR) or 1
      writeIssue {
        remote_url = REMOTE_URL,
        issue_number = ISSUE_NUMBER,
      }
    else
      for _, USER_SELECT in pairs(UserSelect) do
        local ISSUE_NUMBER_STR = string.gsub(USER_SELECT, '\t.*', '')
        local ISSUE_NUMBER = tonumber(ISSUE_NUMBER_STR) or 1
        writeIssue {
          remote_url = REMOTE_URL,
          issue_number = ISSUE_NUMBER,
        }
      end
    end
  end

  picker {
    ListOption = LIST_ISSUE,
    callBack = callBack,
    PREVIEW_OPTS = 'issue',
    title = 'choose your issue',
    remote_url = REMOTE_URL,
  }
end

M.getListIssueCache = function(REMOTE_URL)
  local getCacheDir = _G.MURYP_GH.cache_dir .. '/' .. REMOTE_URL .. '/issue'
  print(getCacheDir)
  local isHaveDir = vim.fn.isdirectory(getCacheDir)
  if isHaveDir == 0 then
    print 'no cache dir'
    return
  end
  require('telescope.builtin').find_files {
    cwd = getCacheDir,
    prompt_title = 'choose your issue on cache',
  }
end

M.RgIssueCache = function(REMOTE)
  local getCacheDir = _G.MURYP_GH.cache_dir .. '/' .. REMOTE .. '/issue'
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
    end,
  }
end

return M
