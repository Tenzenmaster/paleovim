local callback = function()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()

  local ender = ''

  local count = 0
  for pos = col, 0, -1 do
    local sub = line:sub(pos, pos)

    if line:sub(pos, pos) == '{' then
      count = count + 1
    elseif pos == col and (sub == ';' or sub == ',' ) then
      ender = sub
    else
      break
    end
  end

  local ret = '<cr>'

  if count > 0 then
    ret = ''
    if ender:len() > 0 then
      ret = ret .. '<bs>'
    end

    ret = ret .. '<cr><cr>'
    for i = 1, count do
      ret = ret .. '}'
    end

    ret = ret .. ender .. '<C-o>k<C-f>'
  end

  return ret
end

vim.keymap.set('i', '<cr>', callback, { remap = false, expr = true })

