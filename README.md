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
    --- option
    -- _G.muryp_gh = {
    --   cache_dir = '/path/custom/root/dir/for/cache'
    -- }
  end,
  dependencies = 'nvim-telescope/telescope.nvim',
}
```

## API

### ISSUE
```lua
local api = require('muryp-gh.api.issue')

--- choose issue from online
api.list(true)

--- choose issue from cache
api.list(false)

--- create issue
api.create()

--- edit current issue
api.edit()

--- delete current issue online
api.rm(true)

--- delete current issue on cache
api.delete(false)

--- open by issue number online
api.getByNum(true)

--- open by issue number on cache
api.getByNum(false)

--- pin current issue
api.pin()

--- unpin current issue
api.unpin()

--- reopen current issue
api.reopen()

--- close current issue
api.close()

--- lock current issue
api.lock()

--- unlock current issue
api.unlock()

```

### EXAMPLE MAPS

see my dot configs in [here](https://github.com/alifprihantoro/conf.nvim)

## COMMANDS
### ISSUE
#### USAGE
```
GhIssue <core-cmd> <sub-cmd>
```
#### CORE COMMAND
- list <true|false> => get list issue online/offline and open it.
- create => create issue
- edit => edit current issue
- delete <true|false> => delete current issue online/offline
- getByNum <true|false> => open by issue number online/offline
- pin => pin current issue
- unpin => unpin current issue
- reopen => reopen current issue
- close => close current issue
- lock => lock current issue
- unlock => unlock current issue

## Telescope Register

- `Telescope gh_issue` : get list issue online and open it.
- `Telescope gh_issue_cache` : get list issue on cache and open it.

## Lisensi

The `nvim-muryp-git` plugin is distributed under the **Apache License 2.0**. Please refer to the `LICENSE` file for more information about this license.

## Contributing

We greatly appreciate contributions from anyone can produce **issue** or **maintaine code** to help this repo. Please read `CONTRIBUTE.md` for more info.