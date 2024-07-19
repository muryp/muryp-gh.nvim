local createIssue = require 'muryp-gh.utils.issue.write.issue'
local CLI_CMD = require 'muryp-gh.gh.cli.issue'

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
  local ISSUE_URL = require 'muryp-gh.utils.issue.get.issueUrl'()
  local ISSUE_CONTENT = require 'muryp-gh.utils.issue.get.content'()
  local CMD = CLI_CMD.push(ISSUE_URL)
  vim.env.ISSUE_CONTENT = ISSUE_CONTENT
  local status = vim.fn.system(CMD)
  if string.find(status, 'https://github.com') then
    print 'success push'
  else
    error(status)
  end
end

M.update = function()
  local ISSUE_URL = require 'muryp-gh.utils.issue.get.issueUrl'()
  local REMOTE_URL = string.gsub(ISSUE_URL, '(https://github.com/[^/]+/[^/]+)/issues/)[0-9]+', '%1')
  local ISSUE_NUM = vim.split(ISSUE_URL, '/')[7]

  createIssue {
    remote_url = REMOTE_URL,
    issue = ISSUE_NUM,
  }
end

M.pin = function()
  local ISSUE_URL = require 'muryp-gh.utils.issue.get.issueUrl'()
  local CMD = CLI_CMD.pin(ISSUE_URL)
  local status = vim.fn.system(CMD)
  if string.find(status, 'https://github.com') then
    print 'success pin'
  else
    error(status)
  end
end
M.unpin = function()
  local ISSUE_URL = require 'muryp-gh.utils.issue.get.issueUrl'()
  local CMD = CLI_CMD.issue_unpin(ISSUE_URL)
  local status = vim.fn.system(CMD)
  if string.find(status, 'https://github.com') then
    print 'success unpin'
  else
    error(status)
  end
end

M.close = function()
  local ISSUE_URL = require 'muryp-gh.utils.issue.get.issueUrl'()
  local CMD = CLI_CMD.close(ISSUE_URL)
  local status = vim.fn.system(CMD)
  if string.find(status, 'https://github.com') then
    print 'success close'
  else
    error(status)
  end
end

M.reopen = function()
  local ISSUE_URL = require 'muryp-gh.utils.issue.get.issueUrl'()
  local CMD = CLI_CMD.reopen(ISSUE_URL)
  local status = vim.fn.system(CMD)
  if string.find(status, 'https://github.com') then
    print 'success reopen'
  else
    error(status)
  end
end

M.lock = function()
  local ISSUE_URL = require 'muryp-gh.utils.issue.get.issueUrl'()
  local CMD = CLI_CMD.lock(ISSUE_URL)
  local status = vim.fn.system(CMD)
  if string.find(status, 'https://github.com') then
    print 'success lock'
  else
    error(status)
  end
end

M.unlock = function()
  local ISSUE_URL = require 'muryp-gh.utils.issue.get.issueUrl'()
  local CMD = CLI_CMD.unlock(ISSUE_URL)
  local status = vim.fn.system(CMD)
  if string.find(status, 'https://github.com') then
    print 'success unlock'
  else
    error(status)
  end
end

M.rm = function(isOnline)
  local ISSUE_URL = require 'muryp-gh.utils.issue.get.issueUrl'()
  if isOnline then
    local CMD = CLI_CMD.rm(ISSUE_URL)
    local status = vim.fn.system(CMD)
    if string.find(status, 'https://github.com') then
      print 'success rm'
    else
      error(status)
    end
  else
    local FILE = _G.MURYP_GH.cache_dir .. string.gsub(ISSUE_URL, '(https://github.com', '')
    vim.fn.delete(FILE, 'rf')
  end
end

M.edit = function()
  local ISSUE_URL = require 'muryp-gh.utils.issue.get.issueUrl'()
  local CMD = CLI_CMD.edit(ISSUE_URL)
  vim.cmd(CMD)
end
return M
