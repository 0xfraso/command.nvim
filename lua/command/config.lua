local M = {
  ---@class Config
  ---@field cache_file string
  config = {
    cache_file = vim.fn.stdpath("cache") .. "/commands",
  }
}

---Bootstrap configuration
---@param opts? Config
function M.setup(opts)
	opts = opts or {}

	M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

return M
