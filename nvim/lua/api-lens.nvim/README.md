# api-lens.nvim

A Neovim plugin to find all references of an API call for the backend project in this repository.

## Features

- Finds all references of an internal API call under the cursor.
- Automatically loads the necessary files for the LSP to find references.
- Displays the results in Telescope.

## Installation

Use your favorite package manager to install.

### lazy.nvim

```lua
{
  "/tmp/api-lens.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("api-lens.plugin").setup({
      keymap = "<leader>ar", -- optional
    })
  end,
}
```

## Usage

1.  Open a `Bootstrap.ts` file for one of the services.
2.  Place your cursor over an internal API call.
3.  Press the keymap you configured (or the default `<leader>ar`) or run the command `:FindApiReferences`.
4.  The references will be displayed in a Telescope window. 