return {
  'folke/trouble.nvim',
  opts = {
    preview = {
      type = 'float',
      relative = 'editor',
      row = 0.1,
      col = 0.2,
      width = 0.6,
      height = 0.6,
      zindex = 200,
      border = 'rounded',
    },
    modes = {
      telescope = {
        auto_preview = true,
        preview = {
          type = 'float',
          relative = 'editor',
          row = 0.1,
          col = 0.2,
          width = 0.6,
          height = 0.6,
          zindex = 200,
          border = 'rounded',
        },
      },
    },
  },
  cmd = 'Trouble',
  keys = {
    {
      '<leader>xx',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>xX',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics (Trouble)',
    },
    {
      '<leader>cs',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Symbols (Trouble)',
    },
    {
      '<leader>cl',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'LSP Definitions / references / ... (Trouble)',
    },
    {
      '<leader>xL',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Location List (Trouble)',
    },
    {
      '<leader>xQ',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix List (Trouble)',
    },
    {
      '<leader>xr',
      '<cmd>Trouble telescope toggle<cr>',
      desc = 'Telescope Results (Trouble)',
    },
    {
      '<leader>xt',
      '<cmd>Trouble todo toggle<cr>',
      desc = 'Todo (Trouble)',
    },
    {
      '<leader>xT',
      '<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>',
      desc = 'Todo/Fix/Fixme (Trouble)',
    },
  },
}
