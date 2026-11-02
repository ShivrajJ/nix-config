-- Inline Mermaid diagrams in markdown, rendered by merman-cli (no Chromium).
--
-- Setup:
--   * ~/.local/bin/mmdc is a shim that execs `merman-cli mmdc`, so
--     diagram.nvim's hardcoded "mmdc" lookup is satisfied without
--     @mermaid-js/mermaid-cli / Puppeteer.
--   * image.nvim draws the resulting PNG with Kitty's graphics protocol
--     (Ghostty, Kitty, WezTerm) using the ImageMagick CLI processor.
return {
  {
    '3rd/image.nvim',
    -- Loaded on demand as a dependency of diagram.nvim (markdown files).
    opts = {
      backend = 'kitty', -- Ghostty/Kitty/WezTerm; use 'ueberzug' otherwise
      processor = 'magick_cli', -- uses the `magick` CLI, no luarocks needed
      integrations = {
        markdown = { enabled = true },
        neorg = { enabled = false },
      },
      max_width_window_percentage = 100,
      max_height_window_percentage = 80,
      -- Upscale the rendered PNG in the terminal. Raise/lower to taste.
      scale_factor = 1.5,
      window_overlap_clear_enabled = true,
      tmux_show_only_in_active_window = true,
    },
  },
  {
    '3rd/diagram.nvim',
    dependencies = { '3rd/image.nvim' },
    ft = { 'markdown', 'norg' },
    -- opts is a function so the integration module is require'd only after
    -- the plugin is on the runtimepath.
    opts = function()
      return {
        integrations = {
          require('diagram.integrations.markdown'),
        },
        renderer_options = {
          mermaid = {
            theme = 'dark',
            background = 'transparent',
            scale = 3,
            -- The mmdc shim already injects --font-file/--font-system off.
            -- Add extra merman-cli flags here if needed, e.g.
            -- cli_args = { '--presentation-profile', 'merman-modern' },
          },
        },
      }
    end,
  },
}
