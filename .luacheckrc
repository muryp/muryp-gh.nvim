---@diagnostic disable: lowercase-global
-- Rerun tests only if their modification time changed.
cache = true

std = luajit
codes = true
allow_defined = true
max_code_line_length = false
max_comment_line_length = false

self = false

-- Global objects defined by the C code
globals = {
  'vim',
}

exclude_files = {
  'plenary.nvim/*',
}
