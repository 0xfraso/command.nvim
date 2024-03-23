local api = require("command.api")
local config = require("command.config")

---@class Command
local M = {}

local function create_user_commands()
	vim.api.nvim_create_user_command("CommandSelect",      function () api.select_command() end,    { desc = "Command select command" })
	vim.api.nvim_create_user_command("CommandExecLast",    function () api.exec_last() end,         { desc = "Command exec last command" })
	vim.api.nvim_create_user_command("CommandPrompt",      function () api.prompt_command() end,    { desc = "Command prompt command" })
	vim.api.nvim_create_user_command("CommandPromptLast",  function () api.edit_last_command() end, { desc = "Command prompt last command" })
	vim.api.nvim_create_user_command("CommandEdit",        function () api.open_cache_file() end,   { desc = "Command edit commands file" })
end

---@param opts? Config
function M.setup(opts)
	config.setup(opts)

	create_user_commands()
end

return M
