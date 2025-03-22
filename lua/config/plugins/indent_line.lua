return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function()
      vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#555555', nocombine = true })

      require('ibl').setup {
        indent = {
          highlight = { 'IndentBlanklineChar' },
          char = '▏',
        },
      }
    end,
  },
}
