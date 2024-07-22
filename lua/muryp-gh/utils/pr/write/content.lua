--- @param Args {remote_url:string,pr_num:number}
return function(Args)
  local REMOTE_URL = Args.remote_url
  local USER_NAME, REPO_NAME = unpack(vim.split(REMOTE_URL, '/')) ---@type string,string
  local PR_NUM = Args.pr_num
  local DIR = _G.MURYP_GH.cache_dir .. '/' .. USER_NAME .. '/' .. REPO_NAME .. '/pr/'
  local FILE = DIR .. Args.pr_num .. '.md'

  local ContentPR = require 'muryp-gh.service.pr.view' {
    remote_url = REMOTE_URL,
    pr_num = PR_NUM,
  }

  vim.fn.mkdir(vim.fn.fnamemodify(DIR, ':p:h'), 'p')
  vim.fn.writefile(ContentPR, FILE)
  vim.cmd('e ' .. FILE)
end
