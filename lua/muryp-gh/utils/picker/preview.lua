--- @param Opts {remote_url:string}
return function(Opts)
  local previewers = require 'telescope.previewers'
  local REMOTE_URL = Opts.remote_url

  -- Fungsi untuk mengaktifkan highlight sintaksis Markdown
  local function enable_markdown_highlight(bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'filetype', 'markdown')
    vim.api.nvim_command 'runtime! syntax/markdown.vim'
  end

  --- for content result by issue number
  local CONTENT_RESULT = {}
  local loadingCmd = function(ISSUE_NUMBER, bufnr)
    local timer = vim.loop.new_timer()
    timer:start(
      1000,
      0,
      vim.schedule_wrap(function()
        local getIssue = require 'muryp-gh.service.issue.preview'
        if CONTENT_RESULT[ISSUE_NUMBER] == nil then
          local CONTENT = getIssue {
            remote_url = REMOTE_URL,
            issue = ISSUE_NUMBER,
          }
          CONTENT_RESULT[ISSUE_NUMBER] = vim.split(CONTENT, '[\n\r]')
        end
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, CONTENT_RESULT[ISSUE_NUMBER])
      end)
    )
  end
  return previewers.new_buffer_previewer {
    get_buffer_by_name = function(_, entry)
      return entry.filename
    end,
    define_preview = function(self, entry)
      local bufnr = self.state.bufnr
      local ISSUE_NUMBER = vim.split(entry.value, '\t')[1]
      enable_markdown_highlight(bufnr)
      -- add loading text if content will not generate now
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { 'loading...' })

      if CONTENT_RESULT[ISSUE_NUMBER] == nil then
        loadingCmd(ISSUE_NUMBER, bufnr)
        return
      end
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, CONTENT_RESULT[ISSUE_NUMBER])
    end,
  }
end
