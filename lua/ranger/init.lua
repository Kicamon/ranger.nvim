local prev_win = -1
local winnr = -1
local bufnr = -1
local tempname = ''
local workpath = ''
local opt = {
  win = {
    width = 0.8,
    height = 0.8,
    position = 'cc',
  },
  open = {
    ['edit'] = '<leader>re',
    ['tabedit'] = nil,
    ['split'] = nil,
    ['vsplit'] = nil,
  }
}

local function OpenFile(open)
  if vim.fn.filereadable(vim.fn.expand(tempname)) == 1 then
    if vim.api.nvim_buf_get_name(0) == '' then
      open = 'edit'
    end
    local filenames = vim.fn.readfile(tempname)
    for _, filename in ipairs(filenames) do
      vim.cmd(string.format(':%s %s', open, filename))
    end
  end
end

local function EndOpt()
  vim.fn.delete(tempname)
  vim.cmd('silent! lcd ' .. workpath)
end

local function RangerOpen(name)
  vim.api.nvim_create_autocmd('TermOpen', {
    buffer = bufnr,
    callback = function()
      vim.api.nvim_command('file ' .. name)
      vim.cmd([[startinsert]])
    end
  })
end

local function CloseFloatWin()
  vim.api.nvim_win_close(winnr, true)
  vim.api.nvim_buf_delete(bufnr, { force = true })
  vim.api.nvim_set_current_win(prev_win)
end

local function Ranger(open)
  prev_win = vim.api.nvim_get_current_win()
  workpath = vim.fn.getcwd()
  vim.cmd('silent! lcd %:p:h')
  local Win = require("ranger.FloatWin")
  Win:Create({
    width = opt.win.width,
    height = opt.win.height,
    title = ' Ranger ',
  }, {
    pos = opt.win.position,
  })
  WinInfo = Win:GetInfo()
  winnr, bufnr = WinInfo.winnr, WinInfo.bufnr
  RangerOpen('Ranger')
  tempname = vim.fn.tempname()
  vim.fn.termopen('ranger --choosefiles="' .. tempname .. '"', {
    on_exit = function()
      if vim.api.nvim_win_is_valid(winnr) then
        CloseFloatWin()
        OpenFile(open or 'edit')
      end
      EndOpt()
    end
  })
end

local function kmap(open)
  if opt.open[open] ~= nil then
    vim.keymap.set('n', opt.open[open], function() Ranger(open) end, {})
  end
end

local function setup(opts)
  opt = vim.tbl_extend('force', opt, opts or {})
  kmap('edit')
  kmap('tabedit')
  kmap('split')
  kmap('vsplit')
  vim.api.nvim_create_user_command('Ranger', Ranger, {})
end

return {
  setup = setup
}
