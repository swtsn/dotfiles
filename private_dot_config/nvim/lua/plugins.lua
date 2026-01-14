local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- TODO: https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html
-- TODO: https://github.com/nvim-treesitter/nvim-treesitter/discussions/1917
-- TODO: https://github.com/ngalaiko/tree-sitter-go-template#neovim-integration-using-nvim-treesitter
require("lazy").setup({
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        style = "moon",
        transparent = true,
        dim_inactive = true,
        styles = {
  	      sidebars = "dark",
        },
        on_colors = function(colors)
  	      colors.fg_gutter = "#898da0"
        end,
      })
    vim.cmd.colorscheme("tokyonight")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
  },
  {
    "MeanderingProgrammer/treesitter-modules.nvim",
    config = function()
	    require("treesitter-modules").setup({
	      ensure_installed = {
          "bash", "c", "dockerfile", "git_config", "git_rebase",
          "gitattributes", "gitcommit", "gitignore", "go", "gomod", "gosum",
          "gotmpl", "helm", "hocon", "java", "jinja", "json", "kotlin", "lua", "make", "markdown",
          "python", "rego", "rust", "ssh_config", "terraform", "tmux",
          "typescript", "vim", "vimdoc", "query", "yaml",
	      },
	      auto_install = true,
	      highlight = {
	        enable = true,
	      },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<Leader>ss",
            node_incremental = "<Leader>si",
            scope_incremental = "<Leader>sc",
            node_decremental = "<Leader>sd",
          },
        },
	    })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    keys = {
      { "af", mode = { "x", "o" } },
      { "if", mode = { "x", "o" } },
      { "ac", mode = { "x", "o" } },
      { "ic", mode = { "x", "o" } },
      { "as", mode = { "x", "o" } },
    },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          enable = true,
          lookahead = true,
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          include_surrounding_whitespace = true,
        },
      })

      local select = require("nvim-treesitter-textobjects.select").select_textobject
      vim.keymap.set({ "x", "o" }, "af", function()
        select("@function.outer", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "if", function()
        select("@function.inner", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "ac", function()
        select("@class.outer", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "ic", function()
        select("@class.inner", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "as", function()
        select("@local.scope", "locals")
      end)
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = true
  },
  {
    "neovim/nvim-lspconfig",
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-lspconfig").setup{
        ensure_installed = {
          "bashls", "gopls", "jsonls", "kotlin_language_server", "pyright", "vimls",
        },
        automatic_installation = true,
      }
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
			require("go.format").goimports()
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()'
  },
	{
	  "nvim-neotest/neotest",
	  dependencies = {
	    "nvim-neotest/nvim-nio",
	    "nvim-lua/plenary.nvim",
	    "antoinemadec/FixCursorHold.nvim",
	    "nvim-treesitter/nvim-treesitter",
      -- Test adapters below this line
      -- "nvim-neotest/neotest-go",
      {
        "fredrikaverpil/neotest-golang",
            version = "2.3.0",
            build = function()
              vim.system({"go", "install", "gotest.tools/gotestsum@latest"}):wait() -- Optional, but recommended
            end,
	        },
    },
	  config = function()
      -- vim.diagnostic.enable(true)
	    -- local neotest_ns = vim.api.nvim_create_namespace("neotest")
	    -- vim.diagnostic.config({
	    --   virtual_text = {
	    --     format = function(diagnostic)
	    --       local message =
	    --         diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
	    --       return message
	    --     end,
	    --   },
	    -- }, neotest_ns)

      local golang_config = {
        runner = "gotestsum", -- Optional, but recommended
      }

	    require("neotest").setup({
	      adapters = {
	        require("neotest-golang")(golang_config),
	      },
        output = {
          enabled = true,
        },
        output_panel = {
          enabled = true,
          open = "botright split | resize 25",
        },
	    })
	  end,
	},
  {
    "saghen/blink.cmp",
    event = { "InsertEnter", "CmdwinEnter" },
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",

    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = "default" },

      appearance = {
        nerd_font_variant = "mono"
      },

      completion = { documentation = { auto_show = true } },

      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },

      fuzzy = { implementation = "prefer_rust_with_warning" }

    },
    opts_extend = { "sources.default" }
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  -- TODO: More configuration here
  -- {"lukas-reineke/indent-blankline.nvim",
  --  main = "ibl",
  --  opts = {},
  --  config = function()
  --     local highlight = {
  --         "CursorColumn",
  --         "Whitespace",
  --     }
  --     require("ibl").setup({
  --         indent = {
  --     	highlight = highlight,
  --     	char = ""
  --         },
  --         whitespace = {
  --             highlight = highlight,
  --             remove_blankline_trail = false,
  --         },
  --         scope = { enabled = false },
  --     })
  --  end,
  --  },
})
