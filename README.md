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

### PR
#### USAGE
```
GhPR <core-cmd> <sub-cmd>
```
#### CORE COMMAND
- list <true|false> => get list pr online/offline and open it.
- create => create pr
- edit => edit current pr
- delete <true|false> => delete current pr online/offline
- getByNum <true|false> => open by pr number online/offline
- pin => pin current pr
- unpin => unpin current pr
- reopen => reopen current pr
- close => close current pr
- lock => lock current pr
- unlock => unlock current pr


## Telescope Register

- `Telescope gh_issue` : get list issue online and open it.
- `Telescope gh_issue_cache` : get list issue on cache and open it.
- `Telescope gh_issue_cache_rg` : get list issue with rg on cache and open it.
- `Telescope gh_pr` : get list pr online and open it.
- `Telescope gh_pr_cache` : get list pr on cache and open it.
- `Telescope gh_pr_cache_rg` : get list pr with rg on cache and open it.

## Lisensi

The `nvim-muryp-git` plugin is distributed under the **Apache License 2.0**. Please refer to the `LICENSE` file for more information about this license.

## Contributing

We greatly appreciate contributions from anyone can produce **issue** or **maintaine code** to help this repo. Please read `CONTRIBUTE.md` for more info.