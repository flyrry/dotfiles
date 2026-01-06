return {
    {
        'CopilotC-Nvim/CopilotChat.nvim',
        dependencies = {
            'github/copilot.vim',
            'nvim-lua/plenary.nvim'
        },
        build = "make tiktoken",
        opts = {
        }
    },
    {
        'carlos-algms/agentic.nvim',
        event = 'VeryLazy',
        opts = {
            provider = 'claude-acp',
        },
        keys = {
            {
                '<leader><Space>',
                function() require('agentic').toggle() end,
                mode = { 'n', 'v' },
                desc = 'Toggle Agentic Chat'
            },
            {
                '<leader>aa',
                function() require('agentic').add_selection_or_file_to_context() end,
                mode = { 'n', 'v' },
                desc = 'Add Selection/File to Agentic Chat Context'
            },
            {
                '<leader>an',
                function() require('agentic').new_session() end,
                mode = { 'n', 'v' },
                desc = 'New Agentic Chat Session'
            },
            {
                '<leader>as',
                function() require('agentic').stop_generation() end,
                mode = { 'n', 'v' },
                desc = 'Stop Agentic Generation'
            },
        }
    }
}
