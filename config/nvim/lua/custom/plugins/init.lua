-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'tpope/vim-sleuth',
  },
  {
    'mbbill/undotree',
    cmd = 'UndoTree',
    keys = { { '<C-u>', vim.cmd.UndotreeToggle, desc = 'Undo Tree Visualization Toggle' } },
    config = function()
      vim.g.undotree_DiffCommand = 'diff'
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    -- To avoid being surprised by breaking changes,
    -- I recommend you set a version range
    version = '^9',
    -- This plugin implements proper lazy-loading (see :h lua-plugin-lazy).
    -- No need for lazy.nvim to lazy-load it.
    lazy = false,
  },
}
