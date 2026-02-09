-- Positives
-- ---------
-- Amazing action feedback
-- Extremely INSANE attention to detail by the developer
-- Different sounds are programmatically generated with chords, wavetype,
-- sustain, punch, frequency, arpeggio, decay, resonance, lowpass filter etc.
-- Verdict: WTF!?

-- Example: Play a C major chord (C4, E4, G4)
-- C4 (261.63 Hz): { wave_type = 1, base_freq = 261.63, env_decay = 0.1 },
-- E4 (329.63 Hz): { wave_type = 1, base_freq = 329.63, env_decay = 0.1 },
-- G4 (392.00 Hz): { wave_type = 1, base_freq = 392.00, env_decay = 0.1 }

-- Tip: Use https://sfxr.me/ to generate and preview sounds

---@type PlayerOne.Theme
local my_theme = {
  {
    event = "VimEnter",
    sound = {
      { wave_type = 1, base_freq = 523.25, env_attack = 0.0, env_sustain = 0.001, env_decay = 0.15 },
      { wave_type = 1, base_freq = 587.33, env_attack = 0.0, env_sustain = 0.001, env_decay = 0.15 },
      { wave_type = 1, base_freq = 659.25, env_attack = 0.0, env_sustain = 0.001, env_decay = 0.15 },
      { wave_type = 1, base_freq = 783.99, env_attack = 0.0, env_sustain = 0.001, env_decay = 0.15 },
    },
    callback = "append" -- Play notes sequentially
  },
  {
    event = "CursorMoved",
    sound = { wave_type = 1, base_freq = 440.0, env_attack = 0.0, env_sustain = 0.001, env_decay = 0.05 },
    -- callback = "play" -- Play immediately
    callback = function() end -- Do nothing
  },
  {
    event = "VimLeavePre",
    sound = {
      { wave_type = 1, base_freq = 1046.50, env_attack = 0.0, env_sustain = 0.02, env_decay = 0.1 },
      { wave_type = 1, base_freq = 1318.51, env_attack = 0.0, env_sustain = 0.02, env_decay = 0.08 },
      { wave_type = 1, base_freq = 0000.00, env_attack = 0.0, env_sustain = 0.02, env_decay = 0.08 },
    },
    callback = "play_and_wait",
  },
  {
    event = "BufWritePost",
    sound = {
      { wave_type = 2, base_freq = 636.7,  env_attack = 0.0, env_sustain = 0.001, env_decay = 0.15 },
      { wave_type = 2, base_freq = 523.25, env_attack = 0.0, env_sustain = 0.001, env_decay = 0.15 },
    },
    callback = "append",
  },
  {
    event = "TextChangedI",
    sound = { wave_type = 1, base_freq = 760.0, env_attack = 0.0, env_sustain = 0.001, env_decay = 0.05 },
  },
  {
    event = "TextYankPost",
    sound = {
      { wave_type = 1, base_freq = 1760.0, env_attack = 0.0, env_sustain = 0.001, env_decay = 0.15 },
      { wave_type = 1, base_freq = 2197.0, env_attack = 0.0, env_sustain = 0.001, env_decay = 0.15 },
    },
    callback = "append",
  },
  {
    event = "CmdlineEnter",
    sound = {
      { wave_type = 1, base_freq = 392.00, env_attack = 0.0, env_sustain = 0.001, env_decay = 0.05 },
      { wave_type = 1, base_freq = 523.25, env_attack = 0.0, env_sustain = 0.001, env_decay = 0.05 },
    },
    callback = "append",
  },
  {
    event = "CmdlineChanged",
    sound = { wave_type = 1, base_freq = 880.0, env_attack = 0.0, env_sustain = 0.001, env_decay = 0.05 },
  },
}

return {
  "jackplus-xyz/player-one.nvim",
  opts = {
    is_enabled = true,

    ---@type number Minimum interval between sounds in seconds (default: 0.05)
    ---Prevents sound overlapping and potential audio flooding when
    ---multiple keystrokes happen in rapid succession
    min_interval = 0.001,

    -- chiptune: Classic 8-bit game sounds (default)
    -- crystal: Clear, crystalline sounds with sparkling tones
    -- synth: Modern synthesizer sounds with smooth tones
    -- theme = "chiptune",
    theme = my_theme,
    master_volume = 0.2, -- 0.0 to 1.0
    theme_config = {
      chiptune = {
        CursorMoved = false,   -- cursor sounds (most commonly disabled)
        VimEnter = true,       -- startup melody for synth theme
        TextChangedI = true,   -- typing sounds
        CmdlineChanged = true, -- command line typing
      },
    },
  }
}
