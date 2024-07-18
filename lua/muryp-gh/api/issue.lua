local M = {}

---@param isOnline boolean
---@return nil
M.list_issue = function(isOnline)
  local listRemote = require 'muryp-gh.utils.getRemote'()
  local listIssue = require 'muryp-gh.telescope.issue'
  local callback
  if isOnline then
    callback = function(REMOTE)
      listIssue.getListIssue(REMOTE)
    end
  else
    callback = function(REMOTE)
      listIssue.getListIssueCache(REMOTE)
    end
  end
  local count = 0
  for _, _ in pairs(listRemote) do
    count = count + 1
  end
  if count > 1 then
    require 'muryp-gh.telescope.remote'(listRemote, callback)
  end
  callback(listRemote[1])
end

---@param isOnline boolean
---@return nil
M.getByNum = function(isOnline)
  local createIssue = require 'muryp-gh.utils.issue.write.issue'

  local listRemote = require 'muryp-gh.utils.getRemote'()
  local callback
  if isOnline then
    callback = function(REMOTE)
      local USER_NUMBER = vim.fn.input 'Enter your number issue: '
      local ListNumber = vim.split(USER_NUMBER, ',')
      if ListNumber[2] == nil then
        createIssue {
          remote_url = REMOTE,
          issue = ListNumber[1],
        }
      else
        for _, USER_SELECT in pairs(ListNumber) do
          createIssue {
            remote_url = REMOTE,
            issue = USER_SELECT,
          }
        end
      end
    end
  else
    callback = function(REMOTE)
      local USER_NUMBER = vim.fn.input 'Enter your number issue: '
      local ListNumber = vim.split(USER_NUMBER, ',')
      local getCacheDir = _G.MURYP_GH.cache_dir .. '/' .. REMOTE .. '/issue/'
      if ListNumber[2] == nil then
        vim.cmd('e ' .. getCacheDir .. ListNumber[1] .. '.md')
      else
        for _, USER_SELECT in pairs(ListNumber) do
          vim.cmd('e ' .. getCacheDir .. USER_SELECT .. '.md')
        end
      end
    end
  end
  local count = 0
  for _, _ in pairs(listRemote) do
    count = count + 1
  end
  if count > 1 then
    require 'muryp-gh.telescope.remote'(listRemote, callback)
  end
  callback(listRemote[1])
end

M.push = function()
  local ISSUE_URL = require 'muryp-gh.utils.issue.get.number'()
  local ISSUE_CONTENT = require 'muryp-gh.utils.issue.get.content'()
  local CMD = require('muryp-gh.gh.cli').issue_push(ISSUE_URL)
  vim.env.ISSUE_CONTENT = ISSUE_CONTENT
  local status = vim.fn.system(CMD)
  if string.find(status, 'https://github.com') then
    print 'success push'
  else
    error(status)
  end
end

return M
