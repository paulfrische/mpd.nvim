# mpd.nvim
Control your music from inside neovim.

`mpd.nvim` allows you to control [mpd](https://www.musicpd.org/) from inside Neovim via Telescope.

## Usage
### Setup
```lua
require('mpd').setup({
  host = '127.0.0.1',
  port = '6600', -- is quite possible that you use another port for mpd
})
```

### Telescope
```lua
require('mpd').actions(opts)   -- opts are used for telescope picker
require('mpd').find_song(opts) -- keeping it `nil` is a good default
require('mpd').find_album(opts)
```

### Other Functions
```lua
require('mpd').pause() -- pause currently playing song
require('mpd').play() -- resume/start playing
require('mpd').toggle() -- toggle pause/play
require('mpd').next() -- skip song/play next
require('mpd').prev() -- previous song
```
