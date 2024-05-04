local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local config = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local mpd = require('mpd._mpd')

local M = {}

local function find(results, callback, opts)
  pickers
    .new(opts or {}, {
      finder = finders.new_table(results),
      sorter = config.generic_sorter(opts),
      attach_mappings = function(b, _)
        actions.select_default:replace(function()
          actions.close(b)
          local result = action_state.get_selected_entry()
          callback(result[1])
        end)

        return true
      end,
    })
    :find()
end

function M.song(opts)
  find(mpd.songs(), mpd.add, opts)
end

function M.album(opts)
  find(mpd.albums(), mpd.add_album, opts)
end

function M.actions(opts)
  pickers
    .new(opts or {}, {
      finder = finders.new_table({
        results = {
          { 'Next / Skip', mpd.next },
          { 'Previous', mpd.prev },
          { 'Add Song', M.song },
          { 'Add Album', M.album },
          { 'Clear Playlist', mpd.clear },
          { 'Pause', mpd.pause },
          { 'Play', mpd.play },
          { 'Toggle', mpd.toggle },
        },
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry[1],
            ordinal = entry[1],
          }
        end,
      }),
      sorter = config.generic_sorter(opts),
      attach_mappings = function(b, _)
        actions.select_default:replace(function()
          actions.close(b)
          local action = action_state.get_selected_entry()
          -- print(vim.inspect(action))
          action.value[2]()
        end)

        return true
      end,
    })
    :find()
end

return M
