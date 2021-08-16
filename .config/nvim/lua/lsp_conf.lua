local vim = vim
local lspconfig = require('lspconfig')
require'lspinstall'.setup()

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap=true, silent=true }
	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gs', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	-- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	buf_set_keymap('n', 'dp', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', 'dn', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

	-- Set some keybinds conditional on server capabilities
	if client.resolved_capabilities.document_formatting then
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	elseif client.resolved_capabilities.document_range_formatting then
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end
	-- Set autocommands conditional on server_capabilities
	-- if client.resolved_capabilities.document_highlight then
	-- 	vim.api.nvim_exec([[
	-- 	hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
	-- 	hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
	-- 	hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
	-- 	augroup lsp_document_highlight
	-- 	autocmd! * <buffer>
	-- 	autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
	-- 	autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
	-- 	augroup END
	-- 	]], false)
	-- end
end

local DebounceRate = 400

local function setup_servers()

	local library = {}
	local path = vim.split(package.path, ";")

	-- this is the ONLY correct way to setup your path
	table.insert(path, "lua/?.lua")
	table.insert(path, "lua/?/init.lua")

	local function add(lib)
	  for _, p in pairs(vim.fn.expand(lib, false, true)) do
	    p = vim.loop.fs_realpath(p)
	    library[p] = true
	  end
	end

	-- add runtime
	add("$VIMRUNTIME")

	-- add your config
	add("~/.config/nvim")

	-- add plugins
	-- if you're not using packer, then you might need to change the paths below
	add("~/.local/share/nvim/site/pack/packer/opt/*")
	add("~/.local/share/nvim/site/pack/packer/start/*")



	local configs = {}
	configs['vim'] = {
			on_attach = on_attach;
			flags = {
				debounce_text_changes = DebounceRate;
			}
		}
	configs['lua'] = {
			on_attach = on_attach;
			flags = {
				debounce_text_changes = DebounceRate;
			},
			settings = {
				Lua = {
					filetypes = { "lua", };
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim" }
					};
					workspace = {
						-- Make the server aware of Neovim runtime files
						library = library,
						maxPreload = 3000,
						checkThirdParty = false,
						preloadFileSize = 50000
					};
					-- Do not send telemetry data containing a randomized but unique identifier
					telemetry = { enable = false };
				};
			};
		}
	configs['json'] = {
			on_attach = on_attach;
			settings = {
				jsonls = {
					filetypes = { "json", };
				};
			};
			flags = {
				debounce_text_changes = DebounceRate;
			}
		}
	configs['bash'] = {
			on_attach = on_attach;
			settings = {
				bashls = {
					filetypes = { "sh", "zsh" };
				};
			};
			flags = {
				debounce_text_changes = DebounceRate;
			}
		}
	configs['html'] = {
			on_attach = on_attach;
			settings = {
				html = {
					filetypes = { "html", "css" };
				};
			};
			flags = {
				debounce_text_changes = DebounceRate;
			}
		}
	configs['python'] = {
			on_attach = on_attach;
			settings = {
				python = {
					analysis = {
						autoSearchPaths = true;
						useLibraryCodeForTypes = true;
						stubPath = vim.env.HOME .. '/.local/share/python-type-stubs';
						typeshedPaths = vim.env.HOME .. '/.local/share/typeshed';
						autoImportCompletions = true;
					};
				};
			};
			flags = {
				debounce_text_changes = DebounceRate;
			}
		}
	local nvim_lsp = require('lspconfig')
	for server, config in pairs(configs) do
		if nvim_lsp[server] ~= nil then
			nvim_lsp[server].setup{
				on_attach = config.on_attach;
				settings = config.settings;
				flags = config.flags;
			}
		else
			dump(server .. ' not installed')
		end
	end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
	setup_servers() -- reload installed servers
	vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end


-- lsp fzf integration
require('lspfuzzy').setup {}

vim.g.lsp_utils_location_opts = {
	height = 24,
	mode = 'editor',
	preview = {
		title = 'Location Preview',
		border = true,
		coloring = true,
	},
	keymaps = {
		n = {
			['<C-n>'] = 'j',
			['<C-p>'] = 'k'
		}
	}
}
vim.g.lsp_utils_symbols_opts = {
	height = 0,
	mode = 'editor',
	preview = {
		title = 'Symbol Preview',
		border = true,
		coloring = true,
	},
	keymaps = {
		n = {
			['<C-n>'] = 'j',
			['<C-p>'] = 'k'
		}
	}
}

