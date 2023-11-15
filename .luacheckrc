---@diagnostic disable: lowercase-global
-- Rerun tests only if their modification time changed.
cache = true

std = luajit
codes = true

self = false

-- Global objects defined by the C code
read_globals = {
  "vim",
}

exclude_files = {
  "plenary.nvim/*",
}