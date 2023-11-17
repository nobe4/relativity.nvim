local M = {}

M.locations = {}

function M.mark(name)
	M.locations[name] = {
		when = vim.fn.undotree()["seq_cur"],
		where = {
			file = vim.api.nvim_buf_get_name(0),
			cursor = vim.api.nvim_win_get_cursor(0),
		},
	}
end

function M.list()
	vim.print(M.locations)
end

function M.travel(name)
	local location = M.locations[name]
	if location == nil then
		vim.notify("relativity.nvim: mark '" .. name .. "' not found", vim.log.levels.ERROR)
		return
	end

	vim.cmd.edit({ location.where.file, bang = true })
	vim.cmd("undo " .. location.when)
	vim.api.nvim_win_set_cursor(0, location.where.cursor)
end

return M
