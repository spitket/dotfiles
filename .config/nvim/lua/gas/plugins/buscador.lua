return {
  { 'folke/which-key.nvim', config = true },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      { 'nvim-telescope/telescope-file-browser.nvim' }
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = { prompt_position = "top" },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
            }
          }
        },
        extensions = {
          file_browser = {
            hijack_netrw = true,
            hidden = true,
            grouped = true,
          }
        }
      })

      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "-", ":Telescope file_browser<CR>", { silent = true })
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>fF", function() builtin.find_files({	hidden = true,
	no_ignore = true }) end, { desc = "Find File Hidden" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find Grep" })  
      vim.keymap.set("n", "<leader>fG", function() builtin.live_grep({ additional_args = function() return { "--hidden", "--no-ignore" } end }) end, { desc = "Find Grep Hidden" })    
      vim.keymap.set("n", "<leader>fx", builtin.treesitter, { desc = "Find Symbols" })
      vim.keymap.set("n", "<leader>fs", builtin.spell_suggest, { desc = "Find Spell" })

end
  }
}

