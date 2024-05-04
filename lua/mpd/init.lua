local config = require('mpd.config')

local M = {}

function M.setup(opts)
  config.values = vim.tbl_deep_extend('keep', opts or {}, config.values)
end

M.actions = require('mpd._telescope').actions
M.find_song = require('mpd._telescope').song
M.find_album = require('mpd._telescope').album

M.pause = require('mpd._mpd').pause
M.play = require('mpd._mpd').play
M.toggle = require('mpd._mpd').toggle
M.next = require('mpd._mpd').next
M.prev = require('mpd._mpd').prev

return M
