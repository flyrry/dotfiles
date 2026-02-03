-- Change this single line to switch colorschemes
local active = 'onenord'

local colorschemes = {
    sonokai = {
        'sainnhe/sonokai',
        config = function()
            -- styles: 'default', 'atlantis', 'andromeda', 'shusia', 'maia', 'espresso'
            vim.g.sonokai_enable_italic = 1
            vim.cmd.colorscheme('sonokai')
        end,
    },
    ['gruvbox-material'] = {
        'sainnhe/gruvbox-material',
        config = function()
            vim.g.gruvbox_material_enable_italic = 1
            vim.g.gruvbox_material_background = 'hard'
            vim.g.gruvbox_material_foreground = 'original'
            vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
            vim.cmd.colorscheme('gruvbox-material')
        end,
    },
    tokyonight = {
        'folke/tokyonight.nvim',
        config = function()
            require('tokyonight').load({
                style = 'storm', -- storm, moon, night, day
            })
        end,
    },
    catppuccin = {
        'catppuccin/nvim',
        name = 'catppuccin',
        config = function()
            require('catppuccin').setup({
                flavour = 'frappe', -- latte, frappe, macchiato, mocha
            })
            vim.cmd.colorscheme('catppuccin')
        end,
    },
    nightfox = {
        'EdenEast/nightfox.nvim',
        config = function()
            vim.cmd.colorscheme('nordfox') -- nightfox, dayfox, dawnfox, duskfox, nordfox, terafox, carbonfox
        end,
    },
    nordic = {
        'AlexvZyl/nordic.nvim',
        config = function()
            vim.cmd.colorscheme('nordic')
        end,
    },
    onenord = {
        'rmehri01/onenord.nvim',
        config = function()
            vim.cmd.colorscheme('onenord')
        end,
    },
    nord = {
        'shaunsingh/nord.nvim',
        config = function()
            vim.cmd.colorscheme('nord')
        end,
    },
    oceanicnext = {
        'mhartington/oceanic-next',
        config = function()
            vim.cmd.colorscheme('OceanicNext')
        end,
    },
    bamboo = {
        'ribru17/bamboo.nvim',
        config = function()
            require('bamboo').setup({})
            require('bamboo').load()
        end,
    },
    edge = {
        'sainnhe/edge',
        config = function()
            vim.cmd.colorscheme('edge')
        end,
    },
}

-- Build the plugin specs with proper lazy/priority settings
local specs = {}
for name, spec in pairs(colorschemes) do
    spec.lazy = (name ~= active)
    spec.priority = 1000
    table.insert(specs, spec)
end

return specs
