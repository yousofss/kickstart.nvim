vim.g.format_on_save_enabled = true

local function toggle_format_on_save()
  vim.g.format_on_save_enabled = not vim.g.format_on_save_enabled
  if vim.g.format_on_save_enabled then
    vim.notify('Format on save: enabled', vim.log.levels.INFO)
  else
    vim.notify('Format on save: disabled', vim.log.levels.INFO)
  end
end

vim.api.nvim_create_user_command('ToggleFormatOnSave', toggle_format_on_save, {})

vim.keymap.set('n', '<leader>fs', toggle_format_on_save, { desc = '[T]oggle [F]ormat on save' })

return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        if vim.g.format_on_save_enabled == false then
          return false
        end

        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- python = { 'isort', 'black' },
        html = { 'prettier' },
        htmldjango = { 'djlint' },
      },
    },
  },
}
