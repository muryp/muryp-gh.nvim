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
  end
}
```
## how to mapping
> add this code into configs or `after/plugins`
```lua
local MAPS = require('muryp-gh.maps')
local OPTS = { prefix = "<leader>", noremap = true, mode = 'n', silent = true }
local isWk, wk = pcall(require, 'which-key')

if isWk then
  wk.register(MAPS, OPTS)
end
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
- edit info in terminal
```lua
require('muryp-gh.api.cmd').edit()
```
- update local file
```lua
require('muryp-gh.api.cmd').push()
```
- delete issue
> warning: this really delete issue on github
```lua
require('muryp-gh.api.cmd').delete()
```
- add cache issue file with number issue
```lua
require('muryp-gh.api.cmd').addIssue()
```
- pin this current file/issue
```lua
--- pin this current file/issue
require('muryp-gh.api.cmd').pin()
```
- unpin this current file/issue
```lua
--- unpin this current file/issue
require('muryp-gh.api.cmd').unpin()
```
- lock this current file/issue
```lua
--- lock this current file/issue
require('muryp-gh.api.cmd').lock()
```
- unlock this current file/issue
```lua
--- unlock this current file/issue
require('muryp-gh.api.cmd').unlock()
```
- reopen this current file/issue
```lua
--- reopen this current file/issue
require('muryp-gh.api.cmd').reopen()
```
- close this current file/issue
```lua
--- close this current file/issue
require('muryp-gh.api.cmd').close()
```

## Telescope Register
- `Telescope gh_issue` : get list issue online and create chachce then open.
- `Telescope gh_issue_cache` : get list issue on cache.

## Lisensi
The `nvim-muryp-git` plugin is distributed under the **Apache License 2.0**. Please refer to the `LICENSE` file for more information about this license.

## Contributing
We greatly appreciate contributions from anyone can produce **issue** or **maintaine code** to help this repo. Please read `CONTRIBUTE.md` for more info.