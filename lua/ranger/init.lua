local api = vim.api
local win = require('ranger.window')
local infos = {}
local config = {}

local function open_file(open, opt)
  if opt == 'left' then
    vim.cmd('set nosplitright')
  elseif opt == 'down' then
    vim.cmd('set splitbelow')
  elseif opt == 'up' then
    vim.cmd('set nosplitbelow')
  elseif opt == 'right' then
    vim.cmd('set splitright')
  end

  if vim.fn.filereadable(vim.fn.expand(infos.tempname)) == 1 then
    local filenames = vim.fn.readfile(infos.tempname)
    for _, filename in ipairs(filenames) do
      vim.cmd(open .. ' ' .. filename)
    end
  end
end

local function end_options()
  vim.fn.delete(infos.tempname)
  vim.cmd('silent! lcd ' .. infos.workpath)
end

local function ranger(open, opt)
  infos.workpath = vim.fn.getcwd()
  infos.tempname = vim.fn.tempname()

  vim.cmd('silent! lcd %:p:h')

  local float_opt = config

  if infos.bufnr then
    float_opt.bufnr = infos.bufnr
    api.nvim_set_option_value('modified', false, { scope = 'local', buf = infos.bufnr })
  end

  infos.bufnr, infos.winid = win:new_float(float_opt, true, true):wininfo()

  vim.cmd('startinsert')

  vim.fn.termopen(string.format('ranger --choosefiles="%s"', infos.tempname), {
    on_exit = function()
      if api.nvim_win_is_valid(infos.winid) then
        api.nvim_win_close(infos.winid, true)
        infos.winid = nil
        open_file(open, opt)
      end
      end_options()
    end,
  })
end

local function defualt()
  return {
    width = 0.8,
    height = 0.8,
    title = ' Ranger ',
    relative = 'editor',
    row = 'c',
    col = 'c',
  }
end

local function setup(opts)
  config = vim.tbl_extend('force', defualt(), opts or {})

  if config.pos then
    config.row = config.win.pos:sub(1, 1)
    config.col = config.win.pos:sub(2, 2)
    config.pos = nil
  end

  api.nvim_create_user_command('Ranger', function(args)
    if #args.args == 0 then
      ranger('edit')
    elseif args.args == 'left' then
      ranger('vsplit', 'lefs')
    elseif args.args == 'down' then
      ranger('split', 'down')
    elseif args.args == 'up' then
      ranger('split', 'up')
    elseif args.args == 'right' then
      ranger('vsplit', 'right')
    elseif args.args == 'tabe' then
      ranger('tabe')
    else
      error('Wrong parameters')
    end
  end, { nargs = '?' })
end

return { setup = setup }
