-- this looks for a launch.json debug adapter file in vscode to use to help run the debugger
require('dap.ext.vscode').load_launchjs()

local dap = require('dap')

local dap_install = require("dap-install")
local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()

dap_install.setup{
  -- installation_path = '/tmp/test_dap_install',
	installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
  verbosely_call_debuggers = true
}

for _, debugger in ipairs(dbg_list) do
	dap_install.config(debugger, {})
end

-- dap.adapters.netcoredbg = {
--     type = "executable",
--     command = XDG_DATA_HOME .. "/vimspector-config/gadgets/linux/netcoredbg/netcoredbg",
--     args = {
--         "--interpreter=vscode",
--         string.format("--engineLogging=%s/netcoredbg.engine.log", XDG_CACHE_HOME),
--         string.format("--log=%s/netcoredbg.log", XDG_CACHE_HOME),
--     },

dap.adapters.netcoredbg = {
  type = 'executable',
  -- command = '/Users/nicholasmahe/Desktop/netcoredbg/',
  command = '/Users/nicholasmahe/Downloads/netcoredbg/netcoredbg',
  args = {'--interpreter=vscode'}
}

dap.configurations.cs ={
  {
    type = "netcoredbg",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
        return vim.fn.input('Path to dll (I wrote this) ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
    stopAtEntry = true
  }
}
