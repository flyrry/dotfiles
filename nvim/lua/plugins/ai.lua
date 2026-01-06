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
    }
}
