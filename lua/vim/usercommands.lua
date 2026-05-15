-- Utility function to create user commands
local function create_user_command(name, fn, opts)
  vim.api.nvim_create_user_command(name, fn, opts)
end

-- Copy all lines matching the current selection
create_user_command("CopyMatchedLines", function()
  local saved_v = vim.fn.getreg('v')

  vim.cmd('silent normal! gv"vy')
  local selected_text = vim.fn.getreg('v')

  vim.fn.setreg('v', saved_v)

  if not selected_text or selected_text == "" then
    print("No text selected")
    return
  end

  selected_text = vim.split(selected_text, '\n')[1]

  local all_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local matched_lines = {}

  for _, line in ipairs(all_lines) do
    if string.find(line, selected_text, 1, true) then
      table.insert(matched_lines, line)
    end
  end

  if #matched_lines > 0 then
    local final_text = table.concat(matched_lines, "\n") .. "\n"

    vim.fn.setreg('+', final_text)
    vim.fn.setreg('"', final_text)

    print(string.format("Copied %d lines containing '%s'", #matched_lines, selected_text))
  else
    print("0 matches found")
  end
end, { range = true })

-- Number of matches per search
create_user_command("Match", function(opts)
  local cmd = "%s/" .. opts.args .. "//gn"
  local success, err = pcall(function()
    return vim.cmd(cmd)
  end)

  if not success then
    print("0 matches")
  end
end, { nargs = 1 })

-- Local variable to store the a current word under the cursor
local current_match_id = nil

-- Highlight every word equals to the current word under the cursor
create_user_command("EqualWords", function()
  local windows = vim.api.nvim_list_wins()
  if #windows > 1 then
    return
  end

  if current_match_id then
    local success = pcall(vim.fn.matchdelete, current_match_id)
    current_match_id = nil

    if not success then
      pcall(vim.fn.matchdelete, -1)
      return
    end
  end

  local line = vim.fn.getline(".")
  local col = vim.fn.col(".")

  local start_col = col
  local end_col = col

  while start_col > 0 and line:sub(start_col, start_col):match("[%w_]") do
    start_col = start_col - 1
  end

  while end_col <= #line and line:sub(end_col, end_col):match("[%w_]") do
    end_col = end_col + 1
  end

  local word = line:sub(start_col + 1, end_col - 1)

  if word ~= "" then
    current_match_id = vim.fn.matchadd("Search", "\\<" .. word .. "\\>")
  end
end, {})
