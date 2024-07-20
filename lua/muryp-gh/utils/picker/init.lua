---@param Arg {callBack:function,ListOption:string[],PREVIEW_OPTS?:'GH_ISSUE'|'FILE',title:string,CACHE_DIR?:string,remote_url:string}
---@return nil : Telescope custom list
return function(Arg)
  ---req
  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values
  local attachMappings = require 'muryp-gh.utils.picker.mapping'

  --- opts
  local callBack = Arg.callBack ---if user select/enter
  local Opts = Arg.ListOption ---list opts for choose
  local PREVIEW_ARG = Arg.PREVIEW_OPTS ---what preview use it
  local TITLE = Arg.title ---title for telescope

  local showPreview
  if PREVIEW_ARG == 'GH_ISSUE' then
    showPreview = require 'muryp-gh.utils.picker.preview'(Arg)
  end

  pickers
    .new({}, {
      prompt_title = TITLE,
      finder = finders.new_table {
        results = Opts,
      },
      attach_mappings = attachMappings(callBack),
      previewer = showPreview,
      sorter = conf.generic_sorter {},
    })
    :find()
end
