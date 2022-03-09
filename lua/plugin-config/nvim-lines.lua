vim.g.line_powerline_enable = 1
vim.g.line_nerdfont_enable = 1
vim.g.line_unnamed_filename='~'
vim.g.line_statusline_getters = {'v:lua.GitInfo', 'v:lua.CocErrCount', 'v:lua.GetFt'}

-- 基于coc-git的git状态展示
function GitInfo()
    local branch = vim.g.coc_git_status or ''
    local diff = vim.b.coc_git_status or ''
    return (string.len(branch) > 0 and string.format(" %s ", branch) or " none ")
        .. (string.len(diff) > 0 and string.format('%s ', vim.fn.trim(diff)) or '')
end

-- 基于coc的诊断结果展示
function CocErrCount()
    local coc_diagnostic_info = vim.b.coc_diagnostic_info or { error = 0, warning=0, hint=0 }
    return ( string.format(' E%d ', coc_diagnostic_info.error  ) )
        .. ( string.format('W%d ', coc_diagnostic_info.warning) )
        .. ( string.format('H%d ', coc_diagnostic_info.hint) )
end

-- 展示filetype
function GetFt()
    local ft = vim.api.nvim_eval('&ft')
    return string.format(' %s ', string.len(ft) > 0 and ft or '~')
end

--            
--vim.g.powerline_symbols = { light_right = '', dark_right = '', light_left = '', dark_left = '' }
vim.g.powerline_symbols = { light_right = '', dark_right = '', light_left = '', dark_left = '' }
vim.g.line_statusline_getters = {'v:lua.GitInfo', 'v:lua.CocErrCount', 'v:lua.GetFt'}
vim.g.line_hl = { none = 'NONE', light = 'NONE', dark = 'NONE', ['break'] = '244', space = 238 }
vim.api.nvim_command('au VimEnter * hi VimLine_Dark ctermfg=245'    )
vim.api.nvim_command('au VimEnter * hi VimLine_Buf_Dark ctermfg=245')
vim.api.nvim_command('au VimEnter * hi VimLine_Other ctermfg=245'   )
