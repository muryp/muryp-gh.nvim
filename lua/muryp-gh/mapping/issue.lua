local api = require 'muryp-gh.api.issue'
---TODO: get list issue
---TODO: get list issue cache
---TODO: get list issue cache rg
---TODO: open issue from number online
vim.api.nvim_create_user_command('GhIssue', function()
  api.getByNum(true)
end)
---TODO: open issue from number cache
vim.api.nvim_create_user_command('GhIssueCache', function()
  api.getByNum(false)
end)
