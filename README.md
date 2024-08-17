# ranger.nvim
Ranger plugin for neovim

### Screenshot
![Screenshot](./Screenshot.gif)

### Dependencies:[ranger](https://github.com/ranger/ranger)

### Install
**lazy.nvim**

```lua
{
  "Kicamon/ranger.nvim",
  lazy = true,
  cmd = "Ranger",
  config = function()
    require('ranger').setup()
  end
}
```

**vim-plug**

```vim
Plug "Kicamon/ranger.nvim", {['on'] = 'Ranger' }}
lua require('ranger').setup()
```

### command
| open           | description                       |
|----------------|-----------------------------------|
| `Ranger`       | Open files in buffers             |
| `Ranger edit`  | Open files in tabs                |
| `Ranger left`  | Open the file in the left window  |
| `Ranger down`  | Open the file in the lower window |
| `Ranger up`    | Open the file in the top window   |
| `Ranger right` | Open the file in the right window |

### Configuration
defualt config
```lua
require('ranger').setup({
  width = 0.8,
  height = 0.8,
  position = 'cc',
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

### License MIT
