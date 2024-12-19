# AutoLog

A simple Neovim plugin that tracks your development activity and commits logs to a GitHub repository every 30 minutes.

## Installation

### Set-up:
You should create a github repository to store your logs. 

The directory where the logs are stored locally on your machine is ```~/.config/GithubActivityMon``` by default, this can be changed to whatever you want by changing ``` repo_dir ``` path variable in init.lua.

Use your preferred plugin manager:

### With lazy.nvim:
```lua
require('lazy').setup({
  {
    "your-username/GithubActivityMon",
    config = function()
      require("GithubActivityMon")
    end
  }
})
```

### With packer.nvim
```nvim
return require('packer').startup(function()
  use {
    'your-username/GithubActivityMon',
    config = function()
      require('GithubActivityMon')
    end
  }
end)
```

### With vim-plug
```vim
Plug 'your-username/GithubActivityMon'
```

## Usage

Once installed, the plugin will automatically commit and push your activity log to a GitHub repository every 30 minutes.

You can configure the plugin's behavior by editing the init.lua or modifying the plugin's settings.

