local config = require('mpd.config')

local M = {}

function M.setup(opts)
  config.values = vim.tbl_deep_extend('keep', opts or {}, config.values)
end

M.actions = require('mpd._telescope').actions

return M
