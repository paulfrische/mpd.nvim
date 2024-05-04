local M = {}

function M.check()
  vim.health.start('Cheking...')
  if vim.fn.executable('mpc') then
    vim.health.ok('mpc installed')
  else
    vim.health.error('mpc not found')
  end

  local s, _ = pcall(require, 'telescope')
  if s then
    vim.health.ok('telescope installed')
  else
    vim.health.error('needs telescope')
  end
end

return M
