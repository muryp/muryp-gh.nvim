local IMPORT_GH_MAPS = ":lua require('muryp-gh.api.cmd')"

return {
  name = "GIT",
  i = {
    name = "GH_ISSUE",
    c = { ':Telescope gh_issue_cache<CR>', "LIST_ISSUE_ON_CACHE" },
    i = { ':Telescope gh_issue<CR>', "EDIT_ISSUE" },
    o = { IMPORT_GH_MAPS .. ".addIssue()<CR>", "GET_ISSUE_BY_NUM" },
    a = { ':term gh issue create<CR>', "ADD_ISSUE" },
    s = { IMPORT_GH_MAPS .. ".push()<CR>", "SYNC_LOCAL_TO_GH" },
    S = { IMPORT_GH_MAPS .. ".update()<CR>", "SYNC_GH_TO_LOCAL" },
    e = { IMPORT_GH_MAPS .. ".edit()<CR>", "EDIT" },
    d = { IMPORT_GH_MAPS .. ".delete()<CR>", "DELETE" },
    p = { IMPORT_GH_MAPS .. ".pin()<CR>", "pin" },
    P = { IMPORT_GH_MAPS .. ".unpin()<CR>", "unpin" },
    l = { IMPORT_GH_MAPS .. ".lock()<CR>", "lock" },
    L = { IMPORT_GH_MAPS .. ".unlock()<CR>", "unlock" },
    r = { IMPORT_GH_MAPS .. ".reopen()<CR>", "reopen" },
    C = { IMPORT_GH_MAPS .. ".unlock()<CR>", "closed" },
  },
}