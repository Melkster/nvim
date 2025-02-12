--- Fixes the issue with some plugins making all configuration fields required
--- Adding `---@type PluginNameOptions | Any` above a plugin's `opts` makes all
--- fields optional.
---@class Any
---@field [string]? Any | any
