# AutoLog

A simple Neovim plugin that tracks your development activity and commits logs to a GitHub repository every 30 minutes.

## Installation

### Set-up:
You should create a github repository to store your logs. 

The directory where the logs are stored locally on your machine is ```~/.config/GithubActivityMon``` by default, this can be changed to whatever you want by changing ``` repo_path ``` path variable in config.lua.

Use your preferred plugin manager:

### With lazy.nvim:
```lua
return {
  "Boisghur/AutoLog",
  config = function()
    -- Call the setup function of your plugin
    require("AutoLog.lua.AutoLog").setup()
  end,
}
```

### With packer.nvim
```nvim
return require('packer').startup(function()
  use {
    'Boisghur/AutoLog',
    config = function()
      require('AutoLog.lua.AutoLog').setup()
    end
  }
end)
```

### With vim-plug
```vim
Plug 'Boisghur/AutoLog'
```

## Usage

Once installed, the plugin will automatically commit and push your activity log to a GitHub repository every 30 minutes.

You can configure the plugin's behavior by editing the ```config.lua``` or modifying the plugin's settings.

