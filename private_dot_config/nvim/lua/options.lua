vim.g.mapleader = " "
vim.g.python3_host_prog = '/Users/swatson/ff/work/dev/shims/python/python'

-- Sane defaults
vim.opt.number = true
vim.opt.scrolloff = 10
vim.opt.termguicolors = true
vim.opt.wrap = false

-- Synchronizes the system clipboard with neovim's clipboard
vim.opt.clipboard="unnamedplus"

-- Visual Block Settings
vim.opt.virtualedit = "block"

-- New window for in-progress commands
vim.opt.inccommand = "split"

-- Matching and highlighting
vim.opt.gdefault = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

-- " Show and hide extra whitespace
local whitespacepattern = [[/\s\+$/]]
local matchcmd = ":match ExtraWhitespace " .. whitespacepattern .. "<cr>"
vim.keymap.set("n", ",z", matchcmd, {noremap = true})
vim.keymap.set("n", ",x", ":match<CR>", {noremap = true})

-- Configure splits
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.keymap.set("n", ",w", "<c-w><Up><CR>", {noremap = true})
vim.keymap.set("n", ",s", "<c-w><Down><CR>", {noremap = true})
vim.keymap.set("n", ",a", "<c-w><Left><CR>", {noremap = true})
vim.keymap.set("n", ",d", "<c-w><Right><CR>", {noremap = true})

-- Vim tabs!
vim.keymap.set("n", ",.", ":tabnew<CR>", {noremap = true})
vim.keymap.set("n", ".,", ":tabclose<CR>", {noremap = true})
vim.keymap.set("n", ",q", ":tabp<CR>", {noremap = true})
vim.keymap.set("n", ",e", ":tabn<CR>", {noremap = true})

-- Toggle the things
vim.keymap.set("n", "<C-N><C-N>", ":set invnumber<CR>", {noremap = true})
vim.keymap.set("n", "<C-p><C-p>", ":set invpaste<CR>", {noremap = true})
vim.keymap.set("n", "<C-w><C-w>", ":set invwrap<CR>", {noremap = true})

-- Neotest keymaps
vim.keymap.set("n", "<leader>tr", ':lua require("neotest").run.run()<CR>', {noremap = true})
vim.keymap.set("n", "<leader>tf", ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>', {noremap = true})
vim.keymap.set("n", "<leader>ts", ':lua require("neotest").run.stop()<CR>', {noremap = true})
vim.keymap.set("n", "<leader>ta", ':lua require("neotest").run.attach()<CR>', {noremap = true})
vim.keymap.set("n", "<leader>to", ':lua require("neotest").output.open({ enter = true })<CR>', {noremap = true})
vim.keymap.set("n", "<leader>ot", ':lua require("neotest").output_panel.toggle()<CR>', {noremap = true})

-- Refactor keybindings
vim.keymap.set("n", "<leader>lr", ':lua vim.lsp.buf.rename()<CR>', {noremap = true})

-- Configure gotmpl for template injection. Further information can be found at the following links:
-- https://github.com/ngalaiko/tree-sitter-go-template#neovim-integration-using-nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter/discussions/1917
vim.filetype.add({
  extension = {
    gotmpl = 'gotmpl',
  },
  pattern = {
    [".*/templates/.*%.tpl"] = "helm",
    [".*/templates/.*%.ya?ml"] = "helm",
    ["helmfile.*%.ya?ml"] = "helm",
  },
})

-- Configure diagnostics
vim.diagnostic.enable(true)
vim.diagnostic.config({
  virtual_lines = true,
})

-- Statusline
--vim.opt.statusline=%<%f\ %m\ %h%r%=%b\ 0x%B\ \ %l,%c%V\ %P



--
--


-- Need to test
-- set background=light  " background light, so foreground not bold
-- set ruler             " display row, column and % of document
-- set showcmd           " show partial commands in the status line
-- set showmatch         " show matching () {} etc.
-- set showmode          " show current mode
-- set laststatus=2      " always show the bottom status bar
--
--
--

