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

function M.location_names()
	local names = {}
	local n = 0

	for k, _ in pairs(M.locations) do
		vim.print(k)
		n = n + 1
		names[n] = k
	end

	vim.print(names)
	return table.sort(names)
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
