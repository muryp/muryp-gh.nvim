local cmd = vim.api.nvim_create_user_command
local IssueApi = require 'muryp-gh.api.issue'

cmd('GhIssue', function(Opts)
  local Args = Opts.fargs
  if #Args == 0 then
    print 'no args'
    return
  end
  if #Args >= 1 then
    if #Args == 2 then
      local stringToBool = function(str)
        if str == 'true' then
          return true
        end
        if str == 'false' then
          return false
        end
      end
      return IssueApi[Args[1]](stringToBool(Args[2]))
    end
    if #Args == 1 then
      return IssueApi[Args[1]]()
    end
  end
end, {
  nargs = '*',
  complete = function(_, cmdLine)
    local parts = vim.split(vim.trim(cmdLine), ' ')
    if #parts == 1 then
      local command_keys = vim.tbl_keys(IssueApi)
      return command_keys
    end
    if #parts == 2 then
      local haveArgsBool = {
        'list',
        'getByNum',
        'rm',
      }
      if vim.tbl_contains(haveArgsBool, parts[2]) then
        return { 'true', 'false' }
      end
    end
  end,
  desc = 'My custom command with arguments',
})
