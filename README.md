[![License: Apache](https://img.shields.io/badge/License-Apache-blue.svg)](https://opensource.org/licenses/Apache-2.0)
![Neovim version](https://img.shields.io/badge/Neovim-0.8.x-green.svg)
![Lua version](https://img.shields.io/badge/Lua-5.4-yellow.svg)
[![Repo Size](https://img.shields.io/github/repo-size/muryp/muryp-gh.nvim)](https://github.com/muryp/muryp-gh.nvim)
[![Latest Release](https://img.shields.io/github/release/muryp/muryp-gh.nvim)](https://github.com/muryp/muryp-gh.nvim/releases/latest)
[![Last Commit](https://img.shields.io/github/last-commit/muryp/muryp-gh.nvim)](https://github.com/muryp/muryp-gh.nvim/commits/master)
[![Open Issues](https://img.shields.io/github/issues/muryp/muryp-gh.nvim)](https://github.com/muryp/muryp-gh.nvim/issues)
# Plugin Nvim MuryP Git
easy use github issue in nvim, with telescope.
## feature
- manage github issue
## requirement
- gh cli
- git
- nvim 0.8+ (recommendation)
- telescope
## install
- lazy.nvim
```lua
{
  'muryp/muryp-gh.nvim',
  config = function()
    require('muryp-gh')
  end,
  dependencies = 'nvim-telescope/telescope.nvim',
}
```
## how to mapping
> add this code into configs after require or create file on folder `.config/nvim/after/plugins`
```lua
local MAPS = require('muryp-gh.maps')
local OPTS = { prefix = "<leader>", noremap = true, mode = 'n', silent = true }
local isWk, wk = pcall(require, 'which-key')

if isWk then
  wk.register(MAPS, OPTS)
end

## example full configs
```lua
{
  'muryp/muryp-gh.nvim',
  config = function()
    require('muryp-gh')
    --- if this method make error, move to after/plugins/maps.lua
    local MAPS = require('muryp-gh.maps')
    local OPTS = { prefix = "<leader>", noremap = true, mode = 'n', silent = true }
    local isWk, wk = pcall(require, 'which-key')

    if isWk then
      wk.register(MAPS, OPTS)
    end
  end,
  dependencies = 'nvim-telescope/telescope.nvim',
}
```
```

## Maps
- use `<leader>gii` to get list issue (online)
or
- use `<leader>gic` to get list issue (offline)
- use `<leader>giC` : closed this issue
- use `<leader>gis` : sync local to gh
- use `<leader>giS` : sync from gh to current file
- use `<leader>gie` : edit (title,body,assign,label,project,milestone)
- use `<leader>gia` : add new issue
- use `<leader>gid` : delete this issue both loacal and gh
- use `<leader>gil` : lock this issue
- use `<leader>giL` : unlock this issue
- use `<leader>gio` : get issue by number
- use `<leader>giu` : pin this issue
- use `<leader>giU` : unpin this issue
- use `<leader>gir` : reopen this issue

## Api
```lua
local gh = require('muryp-gh.api.cmd')
--- edit info in terminal
gh.edit()
--- update local file
gh.push()
--- delete issue
--- warning: this really delete issue on github
gh.delete()
-- add cache issue file with number issue
gh.addIssue()
--- pin this current file/issue
gh.pin()
--- unpin this current file/issue
gh.unpin()
--- lock this current file/issue
gh.lock()
--- unlock this current file/issue
gh.unlock()
--- reopen this current file/issue
gh.reopen()
--- close this current file/issue
gh.close()
```

## Telescope Register
- `Telescope gh_issue` : get list issue online and create chachce then open.
- `Telescope gh_issue_cache` : get list issue on cache.

## Lisensi
The `nvim-muryp-git` plugin is distributed under the **Apache License 2.0**. Please refer to the `LICENSE` file for more information about this license.

## Contributing
We greatly appreciate contributions from anyone can produce **issue** or **maintaine code** to help this repo. Please read `CONTRIBUTE.md` for more info.