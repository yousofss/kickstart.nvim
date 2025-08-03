return {
  'nvim-neotest/neotest',
  dependencies = {
    'V13Axel/neotest-pest',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-pest',
      },
    }
    vim.keymap.set('n', '<leader>tn', function()
      require('neotest').run.run()
    end, { desc = '[T]est [N]earest, Test single method' })

    vim.keymap.set('n', '<leader>tf', function()
      require('neotest').run.run(vim.fn.expand '%')
    end, { desc = '[T]est [F]ile, Test single file' })
  end,
}
