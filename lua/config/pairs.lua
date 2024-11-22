local pairs = {
  ['('] = ')',
  ['['] = ']',
  ['{'] = '}',
  ["'"] = "'",
  ['"'] = '"',
}

local enders = {
  [';'] = {},
  [','] = {},
  [':'] = {},
}

local callback = function()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()

  local ender = ''
  local closing = ''

  for i = col, 0, -1 do
    local char = string.sub(line, i, i)

    if i == col and enders[char] ~= nil then
      ender = char
    elseif pairs[char] ~= nil then
      closing = closing .. pairs[char]
    else
      break
    end
  end

  local ret
  if string.len(closing) <= 0 then
    ret = '<cr>'
  elseif string.len(ender) > 0 then
    ret = '<bs>' .. '<cr><cr>' .. closing .. ender .. '<C-o>k<C-f>'
  else
    ret = '<cr><cr>' .. closing .. '<C-o>k<C-f>'
  end

  return ret
end

vim.keymap.set('i', '<cr>', callback, { remap = false, expr = true })

