local getNames = function(table_val)
  local val = {}
  for k in pairs(table_val) do
    table.insert(val, k)
  end
  return val
end

return getNames
