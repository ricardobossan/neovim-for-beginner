local api = vim.api

-- Highlight on yank
local yankGrp = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank()",
  group = yankGrp,
})

-- show cursor line only in active window
local cursorGrp = api.nvim_create_augroup("CursorLine", { clear = true })
api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, { pattern = "*", command = "set cursorline", group = cursorGrp })
api.nvim_create_autocmd(
  { "InsertEnter", "WinLeave" },
  { pattern = "*", command = "set nocursorline", group = cursorGrp }
)

-- go to last loc when opening a buffer
api.nvim_create_autocmd(
  "BufReadPost",
  { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)

-- Check if we need to reload the file when it changed
api.nvim_create_autocmd("FocusGained", { command = [[:checktime]] })

-- windows to close
api.nvim_create_autocmd("FileType", {
  pattern = {
    "help",
    "startuptime",
    "qf",
    "lspinfo",
    "vim",
    "OverseerList",
    "OverseerForm",
    "fugitive",
    "toggleterm",
    "floggraph",
    "git",
    "neotest-summary",
    "query",
    "tsplayground",
  },
  command = [[nnoremap <buffer><silent> q :close<CR>]],
})
api.nvim_create_autocmd("FileType", { pattern = "man", command = [[nnoremap <buffer><silent> q :quit<CR>]] })
api.nvim_create_autocmd("FileType", { pattern = "cheat", command = [[nnoremap <buffer><silent> q :bdelete!<CR>]] })

-- don't auto comment new line
api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

-- Fix highlight issue
api.nvim_create_autocmd("BufEnter", { command = [[syntax enable]] })
-- Generic autocommands bellow 
api.nvim_create_autocmd("FileType", { pattern = "markdown", command = [[filetype plugin on]] })
api.nvim_create_autocmd("FileType", { pattern = "markdown", command = [[let g:vim_markdown_folding_style_pythonic = 1]] })
api.nvim_create_autocmd("FileType", { pattern = "markdown", command = [[let g:vim_markdown_folding_level = 1]] })
api.nvim_create_autocmd("FileType", { pattern = "markdown", command = [[let g:vim_markdown_toc_autofit = 1]] })
api.nvim_create_autocmd("FileType", { pattern = "markdown", command = [[let g:vim_markdown_follow_anchor = 1]] })
api.nvim_create_autocmd("FileType", { pattern = "markdown", command = [[let g:vim_markdown_frontmatter = 1]] })
api.nvim_create_autocmd("FileType", { pattern = "markdown", command = [[let g:vim_markdown_toml_frontmatter = 1]] })
api.nvim_create_autocmd("FileType", { pattern = "markdown", command = [[let g:vim_markdown_json_frontmatter = 1]] })
api.nvim_create_autocmd("FileType", { pattern = "markdown", command = [[let g:vim_markdown_strikethrough = 1]] })
api.nvim_create_autocmd("FileType", { pattern = "markdown", command = [[let g:vim_markdown_new_list_item_indent = 2]] })
api.nvim_create_autocmd("FileType", { pattern = "markdown", command = [[let g:vim_markdown_edit_url_in = 'tab']] })
api.nvim_create_autocmd("FileType", { pattern = "markdown", command = [[set conceallevel=3]] })
api.nvim_create_autocmd("BufEnter", { command = [[set foldlevel=1]] })
api.nvim_create_autocmd("BufEnter", { command = [[set wrap linebreak]] })

