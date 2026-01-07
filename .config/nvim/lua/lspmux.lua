local uv = vim.uv or vim.loop -- 'vim.uv' is the standard in Nvim 0.10+, fallback to 'vim.loop'

local M = {}

function M.ensure_lspmux_running()
  local HOST = "127.0.0.1"
  local PORT = 27631
  local BINARY = "lspmux"
  local ARGS = { "server" }

  -- 1. Create a TCP client to check the port
  local client = uv.new_tcp()

  client:connect(HOST, PORT, function(err)
    -- Clean up the handle immediately; we only used it to ping
    client:shutdown()
    client:close()

    if not err then
      -- No error means connection succeeded; server is already running.
      vim.schedule(function()
        vim.notify("lspmux is already running on port " .. PORT, vim.log.levels.INFO)
      end)
      return
    end

    -- If there is an error (e.g., connection refused), spawn the server.
    -- We use vim.schedule to ensure we are back on the main thread for process spawning.
    vim.schedule(function()
      local bin_path = vim.fn.exepath(BINARY)
      if bin_path == "" then
        vim.notify("Error: " .. BINARY .. " not found in PATH", vim.log.levels.ERROR)
        return
      end

      local handle, pid
      handle, pid = uv.spawn(bin_path, {
        args = ARGS,
        detached = true,          -- This makes it a new process group (daemonize)
        stdio = { nil, nil, nil } -- vital: disconnect IO so it doesn't hold Nvim open
      }, function(code, signal)
        -- This callback runs when the child exits, but since we detach,
        -- we rarely care about this logic here for a long-running server.
      end)

      if handle then
        -- Unref the handle: This tells Neovim's event loop NOT to wait 
        -- for this process to exit. This is what truly "detaches" it 
        -- from the editor session.
        uv.unref(handle)
        vim.notify("Spawned lspmux server (PID: " .. pid .. ")", vim.log.levels.INFO)
      else
        vim.notify("Failed to spawn lspmux", vim.log.levels.ERROR)
      end
    end)
  end)
end

-- Run the function immediately
-- M.ensure_lspmux_running()

return M
