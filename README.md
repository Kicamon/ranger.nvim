# ranger.nvim
Ranger plugin for neovim

### Screenshot
![Screenshot](./Screenshot.gif)

### Dependencies
[ranger](https://github.com/ranger/ranger)

### Install
**lazy.nvim**

```lua
{
  "Kicamon/ranger.nvim",
  config = function()
    require('ranger').setup()
  end
}
```

**vim-plug**

```vim
Plug "Kicamon/ranger.nvim"
lua require('ranger').setup()
```

### Usage
use command `Ranger` or shortcut keys

### Configuration
defualt config 
```lua
require('ranger').setup({
  win = {
    width = 0.8,
    height = 0.8,
    position = 'cc',
  },
  open = {
    ['edit'] = '<leader>re',
    ['tabedit'] = '<leader>rt',
    ['split'] = '<leader>rs',
    ['vsplit'] = '<leader>rv',
  }
})
```

#### position
```
+--------------+-------------------+---------------+
|              |                   |               |
|      tl      |                   |       tr      |
|              |                   |               |
+--------------+                   +---------------+
|                                                  |
|                 +-------------+                  |
|                 |             |                  |
|                 |     cc      |                  |
|                 |             |                  |
|                 +-------------+                  |
|                                                  |
+--------------+                   +---------------+
|              |                   |               |
|     bl       |                   |       br      |
|              |                   |               |
+--------------+-------------------+---------------+
```

#### open
| open      | description                    |
|-----------|--------------------------------|
| `edit`    | open files in buffers          |
| `tabedit` | open files in tabs             |
| `split`   | open files in horizontal split |
| `vsplit`  | open files in vertical split   |

### License MIT
