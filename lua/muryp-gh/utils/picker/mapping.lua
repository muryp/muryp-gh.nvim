return function(callBack)
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'

  return function(prompt_bufnr, _)
    actions.select_default:replace(function()
      local MultiSelect = action_state.get_current_picker(prompt_bufnr)._multi._entries
      actions.close(prompt_bufnr)
      local UserSelect = {}
      local TABLE_LENG = 0
      for key, _ in pairs(MultiSelect) do
        table.insert(UserSelect, key[1])
        TABLE_LENG = TABLE_LENG + 1
      end
      ---@return string|string[]
      local singleSelect = function()
        if TABLE_LENG == 0 then
          return action_state.get_selected_entry()[1]
        end
        return UserSelect
      end
      callBack(singleSelect())
    end)
    -- keep default keybindings
    return true
  end
end
