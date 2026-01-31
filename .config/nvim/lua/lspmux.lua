local M = {}

-- Internal state to prevent re-definition and race conditions
local commands_created = false
local checking_lock = false

-- Configuration
local CONFIG = {
  host = '127.0.0.1',
  port = 27631,
  binary = 'lspmux',
}

local uv = vim.uv or vim.loop

-- Helper: Run a transient lspmux command
local function run_lspmux_cmd(args, title)
  if vim.fn.exepath(CONFIG.binary) == '' then
    vim.notify('lspmux binary not found in PATH', vim.log.levels.ERROR)
    return
  end

  vim.fn.jobstart({ CONFIG.binary, unpack(args) }, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if data then
        local msg = table.concat(data, '\n')
        -- Filter out empty newlines typical in job output
        msg = msg:gsub('^%s*(.-)%s*$', '%1')
        if msg ~= '' then
          vim.notify(msg, vim.log.levels.INFO, { title = 'Lspmux: ' .. title })
        end
      end
    end,
    on_stderr = function(_, data)
      if data then
        -- Only notify stderr if it actually contains text
        local msg = table.concat(data, '\n')
        msg = msg:gsub('^%s*(.-)%s*$', '%1')
        if msg ~= '' then
          vim.notify(msg, vim.log.levels.ERROR, { title = 'Lspmux Error' })
        end
      end
    end,
  })
end

function M.ensure_running()
  -- If we are already checking/spawning, don't run again.
  -- This protects against "nvim *.rs" triggering 5 parallel spawns.
  if checking_lock then
    return
  end
  checking_lock = true

  local client = uv.new_tcp()

  client:connect(CONFIG.host, CONFIG.port, function(err)
    client:shutdown()
    client:close()

    if not err then
      -- Connection successful, release lock and return
      checking_lock = false
      return
    end

    -- If connection failed, switch to main thread to spawn
    vim.schedule(function()
      local bin_path = vim.fn.exepath(CONFIG.binary)
      if bin_path == '' then
        vim.notify('Error: ' .. CONFIG.binary .. ' not found in PATH', vim.log.levels.ERROR)
        checking_lock = false
        return
      end

      local handle, pid
      handle, pid = uv.spawn(bin_path, {
        args = { 'server' },
        detached = true,
        stdio = { nil, nil, nil },
      }, function()
        -- Child process exit callback (rarely used for daemon)
      end)

      if handle then
        uv.unref(handle)
        vim.notify('Spawned lspmux server (PID: ' .. pid .. ')', vim.log.levels.INFO)
      else
        vim.notify('Failed to spawn lspmux', vim.log.levels.ERROR)
      end

      -- Release lock
      checking_lock = false
    end)
  end)
end

function M.create_commands()
  -- Guard clause: If commands are already created, stop immediately.
  if commands_created then
    return
  end

  vim.api.nvim_create_user_command('LspmuxRestart', function()
    run_lspmux_cmd({ 'restart' }, 'Restart')
  end, { desc = 'Restart the lspmux daemon' })

  vim.api.nvim_create_user_command('LspmuxReload', function()
    run_lspmux_cmd({ 'reload' }, 'Reload')
  end, { desc = 'Reload lspmux configuration' })

  vim.api.nvim_create_user_command('LspmuxStatus', function()
    run_lspmux_cmd({ 'status' }, 'Status')
  end, { desc = 'Show lspmux status' })

  commands_created = true
end

function M.setup()
  M.ensure_running()
  M.create_commands()
end

return M
