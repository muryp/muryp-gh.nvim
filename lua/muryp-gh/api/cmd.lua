local ghIssue = require('muryp-gh.api').ghIssue
local M = {}
---@return {getFile:string,getIssue:number,gitRoot:string,updatedAt:string}
local getVar = function()
  local getFile = vim.api.nvim_command_output 'echo expand("%:p")' ---@type string
  local GET_CONTENT_FILE = vim.fn.system('cat ' .. getFile) ---@type string
  local _, _, getIssue = string.find(GET_CONTENT_FILE, 'https://github.com/.*/.*/issues/(%d*)') ---@type nil,nil,string
  local gitRoot = vim.fn.system('git rev-parse --show-toplevel'):gsub('\n', '') ---@type string
  local _, _, updatedAt = string.find(GET_CONTENT_FILE, 'updatedAt = "(%d%d%d%d.%d%d.%d%dT%d%d:%d%d:%d%dZ)"')

  if getIssue == '' then
    return vim.api.nvim_err_writeln "ERR: isssue number not found. Be sure you're in correct file. This cmd only work in issue file patern."
  end
  return { getFile = getFile, getIssue = getIssue, gitRoot = gitRoot, updatedAt = updatedAt }
end
M.edit = function()
  local arg = getVar()
  if arg == nil then
    return
  end
  vim.cmd('term cd ' .. arg.gitRoot .. ' && gh issue edit ' .. arg.getIssue)
end
M.open = function()
  if getVar() == nil then
    return
  end
  vim.cmd('!gh issue view -w ' .. getVar().getIssue)
end
M.push = function()
  if getVar() == nil then
    return
  end
  local VAR = getVar()
  local CURRENT_FILE = VAR.getFile
  local REGEX = [[ | sed -z 's/<!--.*-->//g' | sed -e '/^+++/,/^+++/d']]
  local BODY_ISSUE = [[cat ]] .. CURRENT_FILE .. REGEX
  local ISSUE_NUMBER = VAR.getIssue
  local localLastUpdate = VAR.updatedAt
  local getGhLastUpdate = vim.fn.system('gh issue view --json updatedAt ' .. ISSUE_NUMBER)
  local ghLastUpdate = vim.fn.json_decode(getGhLastUpdate).updatedAt
  local push = function()
    ---@type string
    local PUSH_INTO_GH = vim.fn.system('gh issue edit ' .. ISSUE_NUMBER .. ' --body ' .. '"$(' .. BODY_ISSUE .. ')"')
    if string.find(PUSH_INTO_GH, 'error') then
      vim.api.nvim_err_writeln(PUSH_INTO_GH)
      return
    end
    M.update()
    print('succes push : ' .. PUSH_INTO_GH)
  end
  if localLastUpdate == ghLastUpdate then
    push()
    return
  end
  local isPush = vim.fn.input 'local and remote not sync, are you still update from local (N/y) ? ' ---@type string
  if isPush == 'y' or isPush == 'Y' then
    push()
    return
  end
  vim.api.nvim_err_writeln 'youre not update into gh. update local issue or update gh from local'
end
M.update = function()
  if getVar() == nil then
    return
  end
  local ISSUE_NUMBER = getVar().getIssue ---@type number
  ghIssue(ISSUE_NUMBER)
end
M.delete = function()
  if getVar() == nil then
    return
  end
  local ISSUE_NUMBER = getVar().getIssue ---@type number
  vim.cmd('term gh issue delete ' .. ISSUE_NUMBER .. ' && rm %')
  vim.cmd 'bd'
end
M.addIssue = function()
  local NUMBER_ISSUE = vim.fn.input 'number issue ? ' ---@type number
  if NUMBER_ISSUE == '' or NUMBER_ISSUE == nil then
    return print 'type number please...'
  end
  ghIssue(NUMBER_ISSUE)
end
---@param CMD string : cmd issue args
local optsIssue = function(CMD)
  local ISSUE_NUMBER = getVar().getIssue
  local PUSH_INTO_GH = vim.fn.system('gh issue ' .. CMD .. ' ' .. ISSUE_NUMBER) ---@type string
  if string.find(PUSH_INTO_GH, 'error') then
    vim.api.nvim_err_writeln(PUSH_INTO_GH)
    return
  end
  M.update()
  print('succes ' .. CMD .. ' : ' .. PUSH_INTO_GH)
end
--- pin this current file/issue
M.pin = function()
  optsIssue 'pin'
end
--- unpin this current file/issue
M.unpin = function()
  optsIssue 'unpin'
end
--- lock this current file/issue
M.lock = function()
  optsIssue 'lock'
end
--- unlock this current file/issue
M.unlock = function()
  optsIssue 'unlock'
end
--- reopen this current file/issue
M.reopen = function()
  optsIssue 'reopen'
end
--- close this current file/issue
M.closed = function()
  optsIssue 'close'
end
return M