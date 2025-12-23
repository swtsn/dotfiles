local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
    config = function()
	    require("nvim-treesitter.configs").setup({
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
	      textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = {query = "@function.outer", desc = "Select function including definition & end"},
              ["if"] = {query = "@function.inner", desc = "Select function body only"},
              ["ac"] = {query = "@class.outer", desc = "Select class including definition"},
              ["ic"] = {query = "@class.inner", desc = "Select inner part of a class region"},
              ["as"] = {query = "@scope", query_group = "locals", desc = "Select language scope"},
            },
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V', -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            include_surrounding_whitespace = true,
          },
        },
	    })
      end,
    },
    {"nvim-treesitter/nvim-treesitter-textobjects",},
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
    {"neovim/nvim-lspconfig",
      dependencies = {
        "williamboman/mason.nvim",
      },
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
        "nvim-neotest/neotest-go",
		  },
		  config = function()
        vim.diagnostic.enable(true)
		    local neotest_ns = vim.api.nvim_create_namespace("neotest")
		    vim.diagnostic.config({
		      virtual_text = {
		        format = function(diagnostic)
		          local message =
		            diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
		          return message
		        end,
		      },
		    }, neotest_ns)
		    require("neotest").setup({
		      adapters = {
		        require("neotest-go"),
		      },
          output = {
            enabled = false,
          },
          output_panel = {
            enabled = true,
            open = "botright split | resize 25",
          },
		    })
		  end,
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
