local picker = require 'muryp-gh.utils.picker'
local M = {}
M.getListPR = function(REMOTE_URL)
  local ListPR = require 'muryp-gh.service.pr.list' { remote_url = REMOTE_URL }
  ---@param UserSelect string|string[]
  ---@return nil
  local function callBack(UserSelect)
    local writePR = require 'muryp-gh.utils.pr.write.content'

    if type(UserSelect) == 'string' then
      local PR_NUM_STR = string.gsub(UserSelect, '\t.*', '')
      local PR_NUM = tonumber(PR_NUM_STR) or 1
      writePR {
        remote_url = REMOTE_URL,
        pr_num = PR_NUM,
      }
    else
      for _, USER_SELECT in pairs(UserSelect) do
        local PR_NUM_STR = string.gsub(USER_SELECT, '\t.*', '')
        local PR_NUM = tonumber(PR_NUM_STR) or 1
        writePR {
          remote_url = REMOTE_URL,
          pr_num = PR_NUM,
        }
      end
    end
  end

  picker {
    ListOption = ListPR,
    callBack = callBack,
    PREVIEW_OPTS = 'pr',
    title = 'choose your issue',
    remote_url = REMOTE_URL,
  }
end
M.getListPRCache = function(REMOTE_URL)
  local getCacheDir = _G.MURYP_GH.cache_dir .. '/' .. REMOTE_URL .. '/pr'
  local isHaveDir = vim.fn.isdirectory(getCacheDir)
  if isHaveDir == 0 then
    print 'no cache dir'
    return
  end
  require('telescope.builtin').find_files {
    cwd = getCacheDir,
    prompt_title = 'choose your issue on PR',
  }
end
M.RgPR = function(REMOTE_URL)
  local getCacheDir = _G.MURYP_GH.cache_dir .. '/' .. REMOTE_URL .. '/pr'
  local isHaveDir = vim.fn.isdirectory(getCacheDir)
  if isHaveDir == 0 then
    print 'no cache dir'
    return
  end
  require('telescope.builtin').find_files {
    cwd = getCacheDir,
    prompt_title = 'choose your PR on cache',
  }
end
M.getMergeStrategy = function(callback)
  ---@param UserSelect string|string[]
  ---@return nil
  local function pickerCallBack(UserSelect)
    local REMOTE = ''
    if type(UserSelect) == 'string' then
      REMOTE = UserSelect
    else
      for _, USER_SELECT in pairs(UserSelect) do
        REMOTE = USER_SELECT
      end
    end
    callback(REMOTE)
  end
  picker {
    ListOption = { 'merge', 'rebase', 'squash' },
    callBack = pickerCallBack,
    title = 'choose your strategy merge',
  }
end
return M
