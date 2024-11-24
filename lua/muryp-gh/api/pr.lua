local CLI_CMD = require 'muryp-gh.query.pr'
local getRemote = require 'muryp-gh.telescope.remote'
local getPrNum = require 'muryp-gh.utils.pr.number'
local M = {}

---@param isUseCommitMsg boolean
M.create = function(isUseCommitMsg)
  local MSG = ''
  if isUseCommitMsg then
    local getCommitMsg = vim.fn.system 'git log -1 --pretty=%B'
    MSG = getCommitMsg:gsub('[\r\n].*', '')
  end
  require 'muryp-gh.telescope.remote'(function(REMOTE)
    local SSH_CMD = 'eval "$(ssh-agent -s)" && ssh-add ' .. _G.MURYP_GH.ssh_dir .. ' && '
    vim.cmd('term ' .. SSH_CMD .. CLI_CMD.create(REMOTE, MSG))
  end)
end

---@param isOnline boolean
M.list = function(isOnline)
  if isOnline then
    local callback = function(REMOTE)
      require('muryp-gh.telescope.pr').getListPR(REMOTE)
    end
    require 'muryp-gh.telescope.remote'(callback)
    return
  end
  local callback = function(REMOTE)
    require('muryp-gh.telescope.pr').getListPRCache(REMOTE)
  end
  require 'muryp-gh.telescope.remote'(callback)
end
---@param isOnline boolean
M.getByNum = function(isOnline)
  local createPR = require 'muryp-gh.utils.pr.write.content'
  local callback
  if isOnline then
    callback = function(REMOTE)
      local USER_NUMBER = vim.fn.input 'Enter your number PR: '
      local ListNumber = vim.split(USER_NUMBER, ',')
      if ListNumber[2] == nil then
        createPR {
          remote_url = REMOTE,
          pr_num = ListNumber[1],
        }
      else
        for _, USER_SELECT in pairs(ListNumber) do
          createPR {
            remote_url = REMOTE,
            pr_num = USER_SELECT,
          }
        end
      end
    end
  else
    callback = function(REMOTE)
      local USER_NUMBER = vim.fn.input 'Enter your number PR: '
      local ListNumber = vim.split(USER_NUMBER, ',')
      local getCacheDir = _G.MURYP_GH.cache_dir .. '/' .. REMOTE .. '/pr/'
      if ListNumber[2] == nil then
        vim.cmd('e ' .. getCacheDir .. ListNumber[1] .. '.md')
      else
        for _, USER_SELECT in pairs(ListNumber) do
          vim.cmd('e ' .. getCacheDir .. USER_SELECT .. '.md')
        end
      end
    end
  end
  require 'muryp-gh.telescope.remote'(callback)
end
M.rg = function()
  local telescope = require 'muryp-gh.telescope.pr'
  local callback = function(REMOTE)
    telescope.RgPR(REMOTE)
  end
  require 'muryp-gh.telescope.remote'(callback)
end
-- M.close = function(ISSUE_NUMBER)
--   vim.cmd('term ' .. CLI_CMD.close(ISSUE_NUMBER))
-- end
-- M.reopen = function(ISSUE_NUMBER)
--   vim.cmd('term ' .. CLI_CMD.reopen(ISSUE_NUMBER))
-- end
-- M.edit = function(ISSUE_NUMBER)
--   vim.cmd('term ' .. CLI_CMD.edit(ISSUE_NUMBER))
-- end
-- M.delete = function(ISSUE_NUMBER)
--   vim.cmd('term ' .. CLI_CMD.delete(ISSUE_NUMBER))
-- end
M.merge = function()
  local PR_NUM = getPrNum()
  local callback = function(REMOTE)
    require('muryp-gh.telescope.pr').getMergeStrategy(function(MERGE_STRATEGY)
      local MERGE_CMD = CLI_CMD.merge(PR_NUM, REMOTE, MERGE_STRATEGY)
      vim.cmd('term ' .. MERGE_CMD)
    end)
  end
  getRemote(callback)
end
return M
