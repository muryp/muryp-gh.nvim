return function(Args)
  local REMOTE_URL = Args.remote_url
  local CMD = 'gh pr list -R ' .. REMOTE_URL
  local getListPR = vim.fn.system(CMD)
  local ListPR = vim.fn.split(getListPR, '\n')
  return ListPR
end
