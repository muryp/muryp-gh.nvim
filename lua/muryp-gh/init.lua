---@return string DIR_ISSUE location of dir cache
_G.MURYP_CACHE_DIR     = function()
  local GET_GIT_DIR = string.gsub(vim.fn.system("git rev-parse --show-toplevel"), '\n', '')
  local DIR_ISSUE   = GET_GIT_DIR .. '/.git/muryp/gh_issue/'
  return DIR_ISSUE
end

local isWk, plug = pcall(require, 'telescope.builtin')
if isWk then
  ---add picker telescope
  local ghIssue        = require('nvim-muryp-git.gh.telescope').getListIssue
  local ghCache        = require('nvim-muryp-git.gh.telescope').getListIssueCache

  plug.git_issue       = ghIssue
  plug.git_issue_cache = ghCache
end
