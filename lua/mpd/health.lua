local M = {}

function M.check()
  vim.health.start('Cheking...')
  if vim.fn.executable('mpc') then
    vim.health.ok('mpc installed')
  else
    vim.health.error('mpc not found')
  end
end

return M
