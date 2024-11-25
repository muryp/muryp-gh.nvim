local picker = require 'muryp-gh.utils.picker'

---@param callback function -- have param string user select remote
---@return nil
return function(callback)
  local ListRemote = require 'muryp-gh.utils.getRemote'()
  if #ListRemote > 1 then
    ---@param UserSelect string|string[]
    ---@return nil
    local function pickerCallBack(UserSelect)
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

    return picker {
      ListOption = ListRemote,
      callBack = pickerCallBack,
      title = 'choose your remote',
    }
  end
  callback(ListRemote[1])
end
