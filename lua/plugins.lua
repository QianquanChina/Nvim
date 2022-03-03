return require('packer').startup(function()

    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    
    -- treesitter 高亮
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',  }

end)
