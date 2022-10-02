require'nvim-treesitter.configs'.setup {

  -- 安装 language parser
  -- :TSInstallInfo 命令查看支持的语言
  ensure_installed = { "c", "cpp", "vim", "lua", "python" },

  -- 启用代码高亮功能
  highlight = {

      enable = true,
      additional_vim_regex_highlighting = false,

  },

  -- 启用增量选择
  incremental_selection = {

    enable  = true,
    keymaps = {

        init_selection   = '<CR>',
        node_incremental = '<CR>',
        node_decremental = '<BS>',

    }

  },

}

-- 解决和彩色括号冲突
vim.cmd[[ augroup rainbow]]
vim.cmd[[ au BufEnter *     hi      TSPunctBracket NONE]]
vim.cmd[[ au BufEnter *     hi link TSPunctBracket nonexistenthl]]
vim.cmd[[ au BufEnter *.lua hi      TSConstructor  NONE]]
vim.cmd[[ au BufEnter *.lua hi link TSConstructor  nonexistenthl]]
vim.cmd[[ augroup END]]
