local picker = require 'muryp-gh.utils.picker'

---@param ListRemote string[]
---@param callback function -- have param string user select remote
---@return nil
return function(ListRemote, callback)
  ---@param UserSelect string|string[]
  ---@return nil
  local function callBack(UserSelect)
    local REMOTE = ''
    if type(UserSelect) == 'string' then
      REMOTE = UserSelect
    else
      for _, USER_SELECT in pairs(UserSelect) do
        REMOTE = USER_SELECT
      end
    end
    callback(REMOTE)
  end

  picker {
    opts = ListRemote,
    callBack = callBack,
    PREVIEW_OPTS = 'GH_ISSUE',
    title = 'choose your remote',
  }
end
