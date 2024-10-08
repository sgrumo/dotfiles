local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"                                                 

if not (vim.uv or vim.loop).fs_stat(lazypath) then                                                           
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"                                                  
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }) 
    if vim.v.shell_error ~= 0 then                                                                             
	vim.api.nvim_echo({                                                                                      
	    { "Failed to clone lazy.nvim:\n", "ErrorMsg" },                                                        
	    { out, "WarningMsg" },                                                                                 
	    { "\nPress any key to exit..." },                                                                      
	}, true, {})                                                                                             
	vim.fn.getchar()                                                                                         
	os.exit(1)                                                                                               
    end                                                                                                        
end                                                                                                          

vim.opt.rtp:prepend(lazypath)                                                                                

require("lazy").setup({                                                                                      
    {	"rebelot/kanagawa.nvim",                                                                             
    config = function ()                                                                                 
	vim.cmd.colorscheme("kanagawa-dragon")                                                       
    end,                                                                                                 
},
{
    "nvim-treesitter/nvim-treesitter",
    config = function ()
	require("nvim-treesitter.configs").setup({
	    ensure_installed = { "lua", "elixir", "toml", "vim", "python", "vimdoc", "query", "rust", "go", "typescript", "html", "css"},

	    highlight = {
		enable = true,
	    },

	    incremental_selection = {
		enable = true,
	    },

	})
    end,
},
{
    "nvim-treesitter/nvim-treesitter-textobjects"
},
{
    "neovim/nvim-lspconfig",
    config = function() 
	local lspconfig = require("lspconfig")
    end
},
{
    "https://git.sr.ht/~swaits/zellij-nav.nvim",
    lazy = true,
    event = "VeryLazy",
    keys = {
	{ "<c-h>", "<cmd>ZellijNavigateLeft<cr>",  { silent = true, desc = "navigate left"  } },
	{ "<c-j>", "<cmd>ZellijNavigateDown<cr>",  { silent = true, desc = "navigate down"  } },
	{ "<c-k>", "<cmd>ZellijNavigateUp<cr>",    { silent = true, desc = "navigate up"    } },
	{ "<c-l>", "<cmd>ZellijNavigateRight<cr>", { silent = true, desc = "navigate right" } },
    },
    opts = {},
}, 

{
    "nvim-tree/nvim-web-devicons"
},
{
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
	"nvim-tree/nvim-web-devicons"
    },
    opts = { on_attach = on_attach_change, view = { width = 30 } },
    config = function()
	require("nvim-tree").setup {}
    end,
},
{
    "ThePrimeagen/harpoon",
    branch = "harpoon2", 
    dependencies = { "nvim-lua/plenary.nvim" }
},
{
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
    }
})
