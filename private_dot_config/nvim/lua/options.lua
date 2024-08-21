vim.g.mapleader = " "

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
vim.api.nvim_set_keymap("n", ",z", matchcmd, {noremap = true})
vim.api.nvim_set_keymap("n", ",x", ":match<CR>", {noremap = true})

-- Configure splits
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.api.nvim_set_keymap("n", ",w", "<c-w><Up><CR>", {noremap = true})
vim.api.nvim_set_keymap("n", ",s", "<c-w><Down><CR>", {noremap = true})
vim.api.nvim_set_keymap("n", ",a", "<c-w><Left><CR>", {noremap = true})
vim.api.nvim_set_keymap("n", ",d", "<c-w><Right><CR>", {noremap = true})

-- Vim tabs!
vim.api.nvim_set_keymap("n", ",.", ":tabnew<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", ".,", ":tabclose<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", ",q", ":tabp<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", ",e", ":tabn<CR>", {noremap = true})

-- Toggle the things
vim.api.nvim_set_keymap("n", "<C-N><C-N>", ":set invnumber<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<C-p><C-p>", ":set invpaste<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<C-w><C-w>", ":set invwrap<CR>", {noremap = true})

-- Neotest keymaps
vim.api.nvim_set_keymap("n", "<leader>tr", ':lua require("neotest").run.run()<CR>', {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>tf", ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>', {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>ts", ':lua require("neotest").run.stop()<CR>', {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>ta", ':lua require("neotest").run.attach()<CR>', {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>to", ':lua require("neotest").output_panel.open()<CR>', {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>ot", ':lua require("neotest").output_panel.toggle()<CR>', {noremap = true})


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

