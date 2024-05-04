local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local config = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local mpd = require('mpd._mpd')

local M = {}

function M.find_song(callback, opts)
  pickers
    .new(opts or {}, {
      finder = finders.new_table(mpd.songs()),
      sorter = config.generic_sorter(opts),
      attach_mappings = function(b, _)
        actions.select_default:replace(function()
          actions.close(b)
          local song = action_state.get_selected_entry()
          callback(song[1])
        end)

        return true
      end,
    })
    :find()
end

function M.actions(opts)
  pickers
    .new(opts or {}, {
      finder = finders.new_table({
        results = {
          { 'Next', mpd.next },
          { 'Previous', mpd.prev },
          {
            'Add',
            function()
              M.find_song(mpd.add)
            end,
          },
          { 'Clear', mpd.clear },
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
