---@alias issueDataLabels {id:string,name:string,description:string,color:string}[]
---@alias issueDataAssign {id:string,login:string,name:string}[]
---@alias issueDataAuthor {id:string,is_bot:boolean,login:string,name:string}
---@alias getIssueData { title:string, assignees:issueDataAssign, author:issueDataAuthor, body:string, closed:string, closedAt:string, createdAt:string, labels:issueDataLabels, milestone:string, number:string, state:string, title:string, updatedAt:string, url:string} : object all info about issue
---@param Arg {ISSUE_NUMBER:number} : get issue number
---@return getIssueData
return function(Arg)
  local LIST_INFO = {
    'title',
    'assignees',
    'author',
    'body',
    'closed',
    'closedAt',
    -- "comments",
    'createdAt',
    -- "id",
    'labels',
    'milestone',
    'number',
    -- "projectCards",
    -- "reactionGroups",
    'state',
    'title',
    'updatedAt',
    'url',
  }
  local LIST_INFO_JSON = {}
  for _, v in pairs(LIST_INFO) do
    table.insert(LIST_INFO_JSON, '--json ' .. v)
  end
  local LIST_INFO_CDM = 'gh issue view ' .. table.concat(LIST_INFO_JSON, ' ') .. ' ' .. Arg.ISSUE_NUMBER
  local GET_ISSUE_DATA_JSON = vim.fn.system(LIST_INFO_CDM) ---@string
  local IssueData = vim.fn.json_decode(GET_ISSUE_DATA_JSON) ---@type getIssueData
  return IssueData
end
