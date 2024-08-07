local M = {}

---@param REMOTE_URL string
---@param MSG string|nil
---@return string
M.create = function(REMOTE_URL, MSG)
  if MSG then
    vim.env.MSG_PR = MSG
    return 'gh pr create -R ' .. REMOTE_URL .. ' -m $MSG_PR'
  end
  return 'gh pr create -R ' .. REMOTE_URL
end

---@param Opts {remote_url:string,pr_num:number,list_info?:string[]}
---@return string
M.view = function(Opts)
  local PR_NUM = Opts.pr_num
  local REMOTE_URL = Opts.remote_url
  local LIST_INFO = Opts.list_info
    or {
      -- 'additions',
      'assignees',
      'author',
      -- 'autoMergeRequest',
      -- 'baseRefName',
      'body',
      -- 'changedFiles',
      -- 'closed',
      'closedAt',
      -- 'comments',
      'commits',
      'createdAt',
      -- 'deletions',
      'files',
      -- 'headRefName',
      -- 'headRefOid',
      -- 'headRepository',
      -- 'headRepositoryOwner',
      -- 'id',
      -- 'isCrossRepository',
      -- 'isDraft',
      'labels',
      'latestReviews',
      -- 'maintainerCanModify',
      -- 'mergeCommit',
      -- 'mergeStateStatus',
      'mergeable',
      'mergedAt',
      'mergedBy',
      -- 'milestone',
      -- 'number',
      -- 'potentialMergeCommit',
      -- 'projectCards',
      -- 'projectItems',
      -- 'reactionGroups',
      -- 'reviewDecision',
      -- 'reviewRequests',
      -- 'reviews',
      'state',
      -- 'stateReason',
      -- 'statusCheckRollup',
      'title',
      'updatedAt',
      'url',
    }
  local CMD = 'gh pr view ' .. PR_NUM .. ' -R ' .. REMOTE_URL .. ' --json '
  local LIST_INFO_JSON = {}
  for _, v in pairs(LIST_INFO) do
    table.insert(LIST_INFO_JSON, v)
  end
  return CMD .. table.concat(LIST_INFO_JSON, ',')
end

---@param ISSUE_NUMBER integer
---@param REMOTE_URL string
---@return string
M.close = function(ISSUE_NUMBER, REMOTE_URL)
  return 'gh pr close ' .. ISSUE_NUMBER .. ' -R ' .. REMOTE_URL
end

---@param ISSUE_NUMBER integer
---@param REMOTE_URL string
---@return string
M.reopen = function(ISSUE_NUMBER, REMOTE_URL)
  return 'gh pr reopen ' .. ISSUE_NUMBER .. ' -R ' .. REMOTE_URL
end

---@param ISSUE_NUMBER integer
---@param REMOTE_URL string
---@param TYPE string
---@return string
M.merge = function(ISSUE_NUMBER, REMOTE_URL, TYPE)
  return 'gh pr merge ' .. ISSUE_NUMBER .. ' -R ' .. REMOTE_URL .. TYPE
end

---TODO: by author,label, etc
---@param Args {remote_url:string}
---@return string
M.list = function(Args)
  local REMOTE_URL = Args.remote_url
  return 'gh pr list -R ' .. REMOTE_URL
end

---@param ISSUE_NUMBER integer
---@param REMOTE_URL string
---@return string
M.edit = function(ISSUE_NUMBER, REMOTE_URL)
  return 'gh pr edit ' .. ISSUE_NUMBER .. ' -R ' .. REMOTE_URL
end

---@param ISSUE_NUMBER integer
---@param REMOTE_URL string
---@return string
M.delete = function(ISSUE_NUMBER, REMOTE_URL)
  return 'gh pr delete ' .. ISSUE_NUMBER .. ' -R ' .. REMOTE_URL
end

M.lock = function(ISSUE_NUMBER, REMOTE_URL)
  return 'gh pr lock ' .. ISSUE_NUMBER .. ' -R ' .. REMOTE_URL
end

M.unlock = function(ISSUE_NUMBER, REMOTE_URL)
  return 'gh pr unlock ' .. ISSUE_NUMBER .. ' -R ' .. REMOTE_URL
end
return M
