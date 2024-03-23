local cfg = require("command.config")

local ok, _ = pcall(require, "toggleterm")
if not ok then
	return
end

local M = {
	last_command = nil,
}

-- Function to read a file and return lines as an array
local read_file_lines = function(filename)
	filename = filename or cfg.config.cache_file
	local file = io.open(filename or cfg.config.cache_file)
	if file then
		local lines = {}
		for line in file:lines() do
			table.insert(lines, line)
		end
		file:close()
		return lines
	else
		print("Error opening file:", filename)
		return nil
	end
end

function M.select_command()
	local cmds = read_file_lines() or {}
	if #cmds == 1 and cmds[0] == nil then
		vim.notify("No commands found in cache file", vim.log.levels.WARN)
		M.prompt_command()
	else
		if cfg.config.sort ~= "none" then
			table.sort(cmds, function(a, b)
				if cfg.config.sort == "asc" then
					return a:sub(1, 1) < b:sub(1, 1)
				else
					return a:sub(1, 1) > b:sub(1, 1)
				end
			end)
		end
		vim.ui.select(cmds, { prompt = "List of available commands: " }, function(cmd)
			if cmd ~= nil then
				M.exec(cmd)
			end
		end)
	end
end

---@param prompt? string pre populate prompt
function M.prompt_command(prompt)
	if not prompt then
		prompt = ""
	end
	local cmd = vim.split(vim.fn.input("Command: ", prompt or ""), " ", {})
	if table.concat(cmd, " ") == "" or cmd == nil then
		vim.notify("Please enter a valid command.", vim.log.levels.WARN)
		return
	end
	M.exec(table.concat(cmd, " "))
end

function M.exec_last(dir)
	M.exec(M.last_command, dir)
end

function M.exec(cmd, dir)
	if cmd == nil then
		M.prompt_command()
	end

	local opts = {
		cmd = cmd, -- command to execute when creating the terminal e.g. 'top'
		direction = dir or "tab", -- the layout for the terminal, same as the main config options
		close_on_exit = false,
		float_opts = {
			border = "single",
		},
		auto_scroll = true, -- automatically scroll to the bottom on terminal output
		autochdir = true,
	}

	if cmd == nil then
		return
	end

	M.last_command = cmd

	local Terminal = require("toggleterm.terminal").Terminal
	local term = Terminal:new(opts)
	term:toggle()
end

--- Opens cache file
function M.open_cache_file()
	vim.cmd("e " .. cfg.config.cache_file)
end

--- Opens cache file
function M.edit_last_command()
	M.prompt_command(M.last_command)
end

return M
