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

  -- 彩虹括号
  rainbow = {

    enable = true,
    extended_mode = true,
    max_file_lines = nil,

    }
}

