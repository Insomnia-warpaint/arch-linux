vim.cmd [[packadd packer.nvim]]
return require('packer').startup(
function()
    use 'wbthomason/packer.nvim'
    use 'morhetz/gruvbox'
    use 'kyazdani42/nvim-web-devicons'
    use { 'akinsho/bufferline.nvim', tag = "v2.*" }
    use 'nvim-lualine/lualine.nvim'
    use 'kyazdani42/nvim-tree.lua'
    use 'akinsho/toggleterm.nvim'
    use "neovim/nvim-lspconfig"
    use "williamboman/nvim-lsp-installer"
    use "nvim-treesitter/nvim-treesitter"
    use "windwp/nvim-autopairs"
    use "windwp/nvim-ts-autotag"
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-buffer"
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'

    require("nvim-lsp-installer").setup()
    require("toggleterm").setup()
    require("nvim-tree").setup()
    require("bufferline").setup()
    require("nvim-autopairs").setup()
    require('nvim-ts-autotag').setup()
    require'nvim-treesitter.configs'.setup {
        highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true
        },
    }

    require('lualine').setup{
        options = {
            theme  = 'gruvbox'
        },
        section_separators = {
            left = ''
            , right = ''
        },
        component_separators = {
            left = '',
            right =''
        }
    }

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
            virtual_text = {
              spacing = 4,
              prefix = ''
            }
       }
    )

    local luasnip = require('luasnip')
    local cmp = require('cmp')
    cmp.setup {
        snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            },
            ['<Tab>'] = cmp.mapping(
            function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(
            function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 's' }),
        }),
      sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'buffer' },
        { name = 'luasnip' },
      }
    }

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

    require'lspconfig'.clangd.setup {
      capabilities = capabilities,
    }
    require'lspconfig'.pyright.setup{
        capabilities = capabilities,
    }
    require'lspconfig'.vimls.setup{
        capabilities = capabilities,
    }
    require'lspconfig'.tsserver.setup{
        capabilities = capabilities
    }
    require'lspconfig'.vuels.setup{
        capabilities = capabilities
    }
    require'lspconfig'.sumneko_lua.setup{
        capabilities = capabilities,
    }
    require'lspconfig'.html.setup{
        capabilities = capabilities,
    }
    require'lspconfig'.rust_analyzer.setup{
        capabilities = capabilities,
    }
    require'lspconfig'.cssls.setup{
        capabilities = capabilities,
    }
    require'lspconfig'.sqlls.setup{
        capabilities = capabilities,
    }
    require'lspconfig'.bashls.setup{
        capabilities = capabilities,
    }
    require'lspconfig'.gopls.setup{
        capabilities = capabilities,
    }
end)
