-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { "ryanoasis/vim-devicons" },
  { "hrsh7th/cmp-nvim-lsp-signature-help" },

  {
    "linux-cultist/venv-selector.nvim",
    cmd = "VenvSelect",
    opts = {},
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  {
    "epwalsh/obsidian.nvim",
    lazy = false,
    event = { "BufReadPre ~/Documents/NewBrain/**.md" },
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
    -- event = { "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md" },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    keys = {
      { "n", "gf", function()
        if require("obsidian").util.cursor_on_markdown_link() then
          return "<cmd>ObsidianFollowLink<CR>"
        else
          return "gf"
        end
      end
      }
    },
    config = function()
      require("obsidian").setup({
        dir = "~/Documents/NewBrain", -- no need to call 'vim.fn.expand' here

      }
      )
    end,
  },
  {
    "ThePrimeagen/harpoon",
    config = function()
      local harpoon = require "harpoon"

      harpoon.setup {}

      -- Mapping for Adding a File to Harpoon Mark
      vim.api.nvim_set_keymap('n', '<Leader>a', '<cmd>lua require("harpoon.mark").add_file()<CR>',
        { noremap = true, silent = true, desc = "harpoon add" })

      -- Mapping for Toggling Harpoon Quick Menu
      vim.api.nvim_set_keymap('n', '<Leader>h', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>',
        { noremap = true, silent = true, desc = "harpoon menu" })

      -- Mappings for Navigating Files using Numbers 1 to 5
      for i = 1, 5 do
        vim.api.nvim_set_keymap('n', '<space>' .. i, '<cmd>lua require("harpoon.ui").nav_file(' .. i .. ')<CR>',
          { noremap = true, silent = true, desc = "harpoon " .. i })
      end
    end
  }
  ,
  {
    "gbprod/yanky.nvim",
    dependencies = { { "kkharji/sqlite.lua", enabled = not jit.os:find("Windows") } },
    opts = function()
      local mapping = require("yanky.telescope.mapping")
      local mappings = mapping.get_defaults()
      mappings.i["<c-p>"] = nil
      return {
        highlight = { timer = 200 },
        ring = { storage = jit.os:find("Windows") and "shada" or "sqlite" },
        picker = {
          telescope = {
            use_default_mappings = false,
            mappings = mappings,
          },
        },
      }
    end,
    keys = {
      -- stylua: ignore
      {
        "<leader>p",
        function() require("telescope").extensions.yank_history.yank_history({}) end,
        desc =
        "Open Yank History"
      },
      {
        "y",
        "<Plug>(YankyYank)",
        mode = { "n", "x" },
        desc =
        "Yank text"
      },
      {
        "p",
        "<Plug>(YankyPutAfter)",
        mode = { "n", "x" },
        desc =
        "Put yanked text after cursor"
      },
      {
        "P",
        "<Plug>(YankyPutBefore)",
        mode = { "n", "x" },
        desc =
        "Put yanked text before cursor"
      },
      {
        "gp",
        "<Plug>(YankyGPutAfter)",
        mode = { "n", "x" },
        desc =
        "Put yanked text after selection"
      },
      {
        "gP",
        "<Plug>(YankyGPutBefore)",
        mode = { "n", "x" },
        desc =
        "Put yanked text before selection"
      },
      {
        "[y",
        "<Plug>(YankyCycleForward)",
        desc =
        "Cycle forward through yank history"
      },
      {
        "]y",
        "<Plug>(YankyCycleBackward)",
        desc =
        "Cycle backward through yank history"
      },
      {
        "]p",
        "<Plug>(YankyPutIndentAfterLinewise)",
        desc =
        "Put indented after cursor (linewise)"
      },
      {
        "[p",
        "<Plug>(YankyPutIndentBeforeLinewise)",
        desc =
        "Put indented before cursor (linewise)"
      },
      {
        "]P",
        "<Plug>(YankyPutIndentAfterLinewise)",
        desc =
        "Put indented after cursor (linewise)"
      },
      {
        "[P",
        "<Plug>(YankyPutIndentBeforeLinewise)",
        desc =
        "Put indented before cursor (linewise)"
      },
      {
        ">p",
        "<Plug>(YankyPutIndentAfterShiftRight)",
        desc =
        "Put and indent right"
      },
      {
        "<p",
        "<Plug>(YankyPutIndentAfterShiftLeft)",
        desc =
        "Put and indent left"
      },
      {
        ">P",
        "<Plug>(YankyPutIndentBeforeShiftRight)",
        desc =
        "Put before and indent right"
      },
      {
        "<P",
        "<Plug>(YankyPutIndentBeforeShiftLeft)",
        desc =
        "Put before and indent left"
      },
      {
        "=p",
        "<Plug>(YankyPutAfterFilter)",
        desc =
        "Put after applying a filter"
      },
      {
        "=P",
        "<Plug>(YankyPutBeforeFilter)",
        desc =
        "Put before applying a filter"
      },
    },
  }
}
