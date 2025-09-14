return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        -- General toggleterm settings
        size = function(term)
          if term.direction == 'horizontal' then
            return 15
          elseif term.direction == 'vertical' then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<c-z>]], -- Default toggle mapping
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = true,
        direction = 'horizontal', -- 'vertical' | 'horizontal' | 'tab' | 'float'
        close_on_exit = true,
        shell = vim.o.shell,
        auto_scroll = true,

        -- Float terminal specific settings
        float_opts = {
          border = 'curved', -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
          width = math.floor(vim.o.columns * 0.9),
          height = math.floor(vim.o.lines * 0.9),
          winblend = 0,
          highlights = {
            border = 'Normal',
            background = 'Normal',
          },
        },

        -- Custom highlights
        highlights = {
          Normal = {
            guibg = '#1e1e2e',
          },
          NormalFloat = {
            link = 'Normal',
          },
        },

        -- Window options
        winbar = {
          enabled = false,
        },
      }

      -- Create a custom terminal class for lazygit
      local Terminal = require('toggleterm.terminal').Terminal

      -- Lazygit terminal with custom layout
      local lazygit = Terminal:new {
        cmd = 'lazygit',
        dir = 'git_dir',
        direction = 'float',
        float_opts = {
          border = 'curved',
          width = math.floor(vim.o.columns * 0.95),
          height = math.floor(vim.o.lines * 0.95),
          winblend = 0,
        },
        -- Function to call when opening the terminal
        on_open = function(term)
          vim.cmd 'startinsert!'
          vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
          vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<C-h>', '<C-\\><C-N><C-w>h', { noremap = true, silent = true })
          vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<C-j>', '<C-\\><C-N><C-w>j', { noremap = true, silent = true })
          vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<C-k>', '<C-\\><C-N><C-w>k', { noremap = true, silent = true })
          vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<C-l>', '<C-\\><C-N><C-w>l', { noremap = true, silent = true })
        end,
        -- Function to call when closing the terminal
        on_close = function(term)
          vim.cmd 'startinsert!'
        end,
      }

      -- Additional custom terminals
      local horizontal_term = Terminal:new {
        direction = 'horizontal',
        size = 15,
      }

      local vertical_term = Terminal:new {
        direction = 'vertical',
        size = vim.o.columns * 0.4,
      }

      local float_term = Terminal:new {
        direction = 'float',
        float_opts = {
          border = 'curved',
          width = math.floor(vim.o.columns * 0.8),
          height = math.floor(vim.o.lines * 0.8),
        },
      }

      -- Function to toggle lazygit
      function _lazygit_toggle()
        lazygit:toggle()
      end

      -- Function to toggle horizontal terminal
      function _horizontal_term_toggle()
        horizontal_term:toggle()
      end

      -- Function to toggle vertical terminal
      function _vertical_term_toggle()
        vertical_term:toggle()
      end

      -- Function to toggle float terminal
      function _float_term_toggle()
        float_term:toggle()
      end

      -- Key mappings
      vim.api.nvim_set_keymap('n', '<leader>gg', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true, desc = 'Toggle Lazygit' })
      vim.api.nvim_set_keymap(
        'n',
        '<leader>tt',
        '<cmd>lua _horizontal_term_toggle()<CR>',
        { noremap = true, silent = true, desc = 'Toggle Horizontal Terminal' }
      )
      vim.api.nvim_set_keymap('n', '<leader>tv', '<cmd>lua _vertical_term_toggle()<CR>', { noremap = true, silent = true, desc = 'Toggle Vertical Terminal' })
      vim.api.nvim_set_keymap('n', '<leader>to', '<cmd>lua _float_term_toggle()<CR>', { noremap = true, silent = true, desc = 'Toggle Float Terminal' })

      -- Additional keymaps for terminal mode navigation
      vim.api.nvim_set_keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('t', '<C-\\>', '<C-\\><C-n>', { noremap = true, silent = true })

      -- Auto commands for better terminal experience
      vim.cmd [[
        autocmd TermOpen * setlocal nonumber norelativenumber
        autocmd TermOpen * startinsert
      ]]
    end,
  },
}
