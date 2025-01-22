local M = {}

M.create = function()
  return 'gh issue create'
end
---@param Args {remote_url:string,limit?:integer,search?:string,open_browser?:boolean,label?:string,milestone?:string,state?:string,author?:string,issue_number:integer}
---@return string
M.list = function(Args)
  local REMOTE_URL = Args.remote_url
  local LIMIT = Args.limit or 5
  local SEARCH = Args.search or ''
  local isOpenBrowser = Args.open_browser or false
  local LABEL = Args.label or ''
  local MILESTONE = Args.milestone or ''
  local STATE = Args.state or 'open'
  local AUTHOR = Args.author or ''

  local CMD = 'gh issue list'
  CMD = CMD .. ' -R ' .. REMOTE_URL
  CMD = CMD .. ' -L ' .. LIMIT
  if SEARCH ~= '' then
    CMD = CMD .. ' -S "' .. SEARCH .. '"'
  end
  if LABEL ~= '' then
    CMD = CMD .. ' -l ' .. LABEL
  end
  if MILESTONE ~= '' then
    CMD = CMD .. ' -m ' .. MILESTONE
  end
  if STATE ~= '' then
    CMD = CMD .. ' -s ' .. STATE
  end
  if AUTHOR ~= '' then
    CMD = CMD .. ' -A ' .. AUTHOR
  end
  if isOpenBrowser then
    CMD = CMD .. ' --web'
  end
  return CMD
end

---@param Opts {issue_number:number,remote_url:string,open_browser?:boolean,list_info?:string[]}
M.view = function(Opts)
  local ISSUE_NUMBER = Opts.issue_number
  local REMOTE_URL = Opts.remote_url
  local isOpenBrowser = Opts.open_browser or false
  local LIST_INFO = Opts.list_info
    or {
      'title',
      'assignees',
      'author',
      'body',
      'closed',
      'closedAt',
      'createdAt',
      'labels',
      'milestone',
      'reactionGroups',
      'state',
      'title',
      'updatedAt',
      'url',
    }
  local CMD = 'gh issue view ' .. ISSUE_NUMBER .. ' -R ' .. REMOTE_URL .. ' '

  local LIST_INFO_JSON = {}
  for _, v in pairs(LIST_INFO) do
    table.insert(LIST_INFO_JSON, '--json ' .. v)
  end

  if isOpenBrowser then
    return CMD '--web '
  else
    return CMD .. table.concat(LIST_INFO_JSON, ' ')
  end
end

---@param ISSUE_URL string
---@return string
M.push = function(ISSUE_URL)
  local CMD = 'gh issue edit ' .. ISSUE_URL .. ' --body $ISSUE_CONTENT'
  return CMD
end

M.pin = function(ISSUE_URL)
  local CMD = 'gh issue pin ' .. ISSUE_URL
  return CMD
end

M.unpin = function(ISSUE_URL)
  local CMD = 'gh issue unpin ' .. ISSUE_URL
  return CMD
end

M.close = function(ISSUE_URL)
  local CMD = 'gh issue close ' .. ISSUE_URL
  return CMD
end

M.reopen = function(ISSUE_URL)
  local CMD = 'gh issue reopen ' .. ISSUE_URL
  return CMD
end

M.rm = function(ISSUE_URL)
  local CMD = 'gh issue delete ' .. ISSUE_URL
  return CMD
end

M.edit = function(ISSUE_URL)
  local CMD = 'gh issue edit ' .. ISSUE_URL
  vim.cmd('term ' .. CMD)
end

return M