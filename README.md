### Overview

Modular, Lazy.nvim-based Neovim configuration designed for multi-language development, with extra polish for LSP, DAP, testing, and formatting.

<br>

<div align="center">
 <img src="./content/demo.gif" alt="demo">
</div>

<br>

### Contents

 - init.lua — Entrypoint to load lua/ tree and setup nvim.

- lua/ — Modular Lua configuration (plugins, utils, language-specific configs).

- scripts/ — Helper scripts used for setup/maintenance.

-  hooks/ — Git Hooks.

- setup.sh — Convenience installer to make files executable and replace current Neovim configuration.

- lazy-lock.json — Lockfile for Lazy.nvim plugin versions.

### Quick Summary

The idea is to provide a clean and generic Neovim configuration that’s easy to maintain and adapt. While it already includes optimized setups for Java, it’s intentionally structured to make it simple to add or adjust support for any language.

Languages, as well as Linters and Formatters will be automatically installed by Mason and Mason-LSP. To add new languages, it's just needed to add the LSP's name to the [lua/utils/mason-ensure-installed.lua](https://github.com/rafaeltxc/Neovim/blob/master/lua/utils/mason-ensure-installed.lua) 
file, and its Tree-sitter parser inside [lua/utils/treesitter-ensure-installed.lua](https://github.com/rafaeltxc/Neovim/blob/master/lua/utils/treesitter-ensure-installed.lua).

Formatters and Linters can also be installed from the [lua/plugins/nonels.lua](https://github.com/rafaeltxc/Neovim/blob/master/lua/plugins/nonels.lua), but keep in mind these are outside the LSP scope, meaning features like visual mode formatting won’t work with them.

For testing, the project already supports Java and JS/TS, but new adapters may also be configured inside [lua/plugins/neotest.lua](https://github.com/rafaeltxc/Neovim/blob/master/lua/plugins/neotest.lua) for any additional languages you want to support.

Debugging is also possible (currently only for Java), and for new languages support, the [lua/plugins/dap.lua](https://github.com/rafaeltxc/Neovim/blob/master/lua/plugins/dap.lua) plugin will need some additional configuration.

### Keymaps

Keymaps have two main places that they can be configured:
- [lua/core/keymaps.lua](https://github.com/rafaeltxc/Neovim/blob/master/lua/core/keymaps.lua): For general vim keymaps
- [lua/utils/plugins-keymaps.lua](https://github.com/rafaeltxc/Neovim/blob/master/lua/utils/plugins-keymaps.lua): For plugins keymaps

_plugins-keymaps.lua_ serves the purpose of storing keymaps that are meant to be shown by the [whichkey](https://github.com/rafaeltxc/Neovim/blob/master/lua/plugins/whichkey.lua) plugin. Keymaps used with CTRL/SHIFT may be found inside their own plugin configuration file, as for example, the [multicursor](https://github.com/rafaeltxc/Neovim/blob/master/lua/plugins/multicursor.lua) plugin.

<details>
<summary>Plugins Keymaps</summary>

<table>
<tr>
<td align="center" style="vertical-align: top;">

| Navigation | |
| :--- | :--- |
| `<leader>lD` | Declaration |
| `<leader>ld` | Definition |
| `<leader>li` | Implementation |
| `<leader>lk` | Documentation |
| `<leader>ld` | Diagnostics |
| `<leader>lr` | References |

</td>
<td align="center" style="vertical-align: top;">

| Finder | |
| :--- | :--- |
| `<leader>fb` | Active Buffers |
| `<leader>fc` | Current Buffer |
| `<leader>ff` | Find Files |
| `<leader>fl` | Live Grep |
| `<leader>fu` | Mod. History |
| `<leader>fo` | Recent Projects |

</td>
<td align="center" style="vertical-align: top;">

| Git | |
| :--- | :--- |
| `<leader>ga` | Diff |
| `<leader>gb` | Blame |
| `<leader>gd` | Deleted |

</td>
</tr>
<tr>
<td align="center" style="vertical-align: top;">

| Debugging | |
| :--- | :--- |
| `<leader>Ds` | Start Debug |
| `<leader>Dd` | Toggle Breakpoint|
| `<leader>Db` | Cond. Breakpoint|
| `<leader>Dc` | Commands |
| `<leader>Dl` | List Breakpoints|
| `<leader>Dv` | Variables |
| `<leader>Df` | Frames |
| `<leader>Du` | Toggle UI |

</td>
<td align="center" style="vertical-align: top;">

| Testing | |
| :--- | :--- |
| `<leader>qd` | Debug Nearest |
| `<leader>qn` | Test Nearest |
| `<leader>qf` | Test File |
| `<leader>qs` | Stop Test |
| `<leader>qo` | Show Output |
| `<leader>qp` | Show Output |
| `<leader>qt` | Show Summary |

</td>
<td align="center" style="vertical-align: top;">

| Refactoring | |
| :--- | :--- |
| `<leader>rr` | Rename Variable |
| `<leader>rr` | Quickfix |
| `<leader>ra` | Code Actions |
| `<leader>ro` | File Refactor |
| `<leader>rs` | Toggle Spectre |

</td>
</tr>
<tr>
<td align="center" style="vertical-align: top;">

| Utilities | |
| :--- | :--- |
| `<leader>ui` | LSP Info |
| `<leader>ul` | NullLs Info |
| `<leader>us` | Snip Info |
| `<leader>un` | Messages |
| `<leader>up` | Markdown Preview|
| `<leader>um` | MiniMap |

</td>
<td align="center" style="vertical-align: top;">

| Managers | |
| :--- | :--- |
| `<leader>ml` | Lazy Manager |
| `<leader>mt` | TS Update |
| `<leader>mml`| Mason Logs |
| `<leader>mmm`| Mason Manager |

</td>
<td align="center" style="vertical-align: top;">

| Diagnostics | |
| :--- | :--- |
| `<leader>dj` | Next Diagnostic |
| `<leader>dk` | Prev Diagnostic |
| `<leader>dp` | Problems |
| `<leader>dq` | Quickfix |

</td>
</tr>
<tr>
<td align="center" style="vertical-align: top;">

| Workspace | |
| :--- | :--- |
| `<leader>wh` | Horizontal Win |
| `<leader>wv` | Vertical Win |
| `<leader>wl` | Toggle Line Wrap |

</td>
<td align="center" style="vertical-align: top;">
</td>
<td align="center" style="vertical-align: top;">
</td>
</tr>
</table>

</details>

---

### Requirements
- **Neovim**: recommended >= 0.9 (some plugins/features assume modern Neovim; if you run into nil handlers or runtime API differences, try upgrading).

- **A POSIX shell & standard utilities:** (sh and curl) for setting up the environment.

- **(Optional) Java JDK:** JDK 17+ recommended.

### Installation

Clone the repo:
```
git clone https://github.com/rafaeltxc/nvim-config.git
cd nvim-config
```

Setup the environment:
```bash
# First, you may need to make the setup.sh file executable with:
chmod +x ./setup.sh

# And then:
./setup.sh
```

Open Neovim:
```
nvim
```

Lazy.nvim will install plugins. Mason will ensure required tools are present. This may take a few minutes.

### Support

This configuration was written for linux (tested on Arch specifically), and should work fine on most distributions. Although it includes default handling for other operating systems, some adjustments may be required since MacOS and Windows have their own nuances. Setting it up is generally pretty straightforward, adding/fixing system paths to match your current OS.

### Contributing and Repository Activity

This is only my personal take on Neovim that i've been working on a while from time to time, and as it's just a hobby, i wont be going to work on it all the times, but i do intend to keep improving it. The ideia that will follow the subsequent improvements is to make the configuration feel even more like an actual IDE.

- Languages Improvements
    - The _master_ branch will aim to include support for as many languages as possible, a complete "battle station" to work with any project in any language.
    - Having a _nvim\_{language}_ branch to each language inside of the _master_ branch, where each one of them will carry a unique language implementation (like Java, Rust, etc.), but will also include utility languages and tools such as XML, YAML, Dockerfiles, and basic front-end support (JS/TS, HTML, CSS...).
 
- Plugins improvements
    - The addition of new plugins is not guaranteed to happen, at least not plugins that change the current looks and/or mechanics, such as _bufferline.nvim_ or _lualine.nvim_. On the other hand, plugins such as _harpoon.nvim_ might be added since their use is more “optional” and up to each individual user.
 
I won’t be writing a _CONTRIBUTING.md_, since the project is pretty simple, but any contribution is welcome as long as it follows the notes above.

As far as code formatting goes, just stick to the current file style while using stylua with its default settings and it should be enough.
