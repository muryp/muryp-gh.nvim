local M = {}

---@param Args {remote_url:string,limit?:integer,search?:string,open_browser?:boolean,label?:string,milestone?:string,state?:string,author?:string,issue_number:integer}
---@return string
M.issue_list = function(Args)
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
    CMD = CMD .. ' -S ' .. SEARCH
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

---@param Opts {issue:number,remote_url:string,open_browser?:boolean,list_info?:string[]}
M.issue_view = function(Opts)
  local ISSUE_NUMBER = Opts.issue
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
  else
    return CMD .. table.concat(LIST_INFO_JSON, ' ')
  end
end

---@param ISSUE_URL integer
---@return string
M.issue_push = function(ISSUE_URL)
  local CMD = 'gh issue edit ' .. ISSUE_URL .. ' --body $ISSUE_CONTENT'
  return CMD
end
return M
