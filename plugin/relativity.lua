if vim.g.relativity_init == 1 then
	return
end
vim.g.relativity_init = 1

local relativity = require("relativity.init")

vim.api.nvim_create_user_command("RLMark", function(opts)
	relativity.mark(opts.fargs[1])
end, { nargs = 1 })

vim.api.nvim_create_user_command("RLTravel", function(opts)
	relativity.travel(opts.fargs[1])
end, {
	nargs = 1,
	complete = function()
		return relativity.location_names()
	end,
})

vim.api.nvim_create_user_command("RLList", relativity.list, {})
vim.api.nvim_create_user_command("RLTest", function()
	vim.print(relativity.location_names())
end, {})
