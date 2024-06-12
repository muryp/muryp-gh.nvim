---@param Arg {GetIssueData:getIssueData}
return function(Arg)
  local GetIssueData = Arg.GetIssueData
  local HeaderIssue = {}
  for KEY, VAL in pairs(GetIssueData) do
    -- extrack name
    if KEY == 'author' then
      HeaderIssue[KEY] = '"' .. GetIssueData[KEY].name .. '"'
    elseif KEY == 'labels' or KEY == 'assignees' then
      local LIST = '' --- get name label
      local issueAssignLabels = GetIssueData[KEY] ---@type issueDataAssign|issueDataLabels
      for _, Val in pairs(issueAssignLabels) do
        LIST = LIST .. '[' .. Val.name .. ']' .. ','
      end
      HeaderIssue[KEY] = '"' .. LIST .. '"'
    elseif KEY == 'title' then
      HeaderIssue[KEY] = '"' .. GetIssueData[KEY] .. '"'
    else
      HeaderIssue[KEY] = VAL
    end
  end
  HeaderIssue.body = nil
  --TODO: change name
  local HEADER_ISSUE = require('muryp-gh.utils.tableToString').serializeTable(HeaderIssue)
  local HEADER_ISSUE_DEL_SPC = string.gsub(string.gsub(HEADER_ISSUE, '\n ', '\n'), '^ ', '')
  return HEADER_ISSUE_DEL_SPC
end