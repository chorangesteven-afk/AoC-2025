--------------------------------------------------------------------------------------------------

function print_table(table)
  for i=1,#table
  do
    io.write(table[i] .. " ")
  end
  print()
end

--------------------------------------------------------------------------------------------------

input = io.read("*a")

input_table = {}

--------------------------------------------------------------------------------------------------
-- sepearate input by newline


for i in string.gmatch(input, "%C+") 
do
  table.insert(input_table,i)
end

--print_table(input_table)


--------------------------------------------------------------------------------------------------
-- separate ranges and ids

id_rangeTab = {}
ids = {}

for i = 1,#input_table
do
  if (string.find(input_table[i],"-") == nil)
  then
    table.insert(ids,input_table[i])
  else
    table.insert(id_rangeTab,input_table[i])
  end
end

--print_table(id_rangeTab)
--print_table(ids)

--------------------------------------------------------------------------------------------------

-- function: pass id range -> return first and last id as table

function id_range(str)
  local tempTable = {}
  for i in string.gmatch(str,'([^'..'-'..']+)') do
    --print(i)
    table.insert(tempTable,i)
  end
  return tempTable
end



--------------------------------------------------------------------------------------------------
-- check if id is in a single range

function idIsInRange(id,rangeTab)
  rangeTab[1] = tonumber(rangeTab[1])
  rangeTab[2] = tonumber(rangeTab[2])
  id = tonumber(id)
  if ((id >= rangeTab[1]) and (id <= rangeTab[2]))
  then
    --print("id " .. id .. " is less then or equal to  " .. rangeTab[2])
    --print("id " .. id .. " is greater than or equal to " .. rangeTab[1])
    return true
  else
    return false
  end
end




--------------------------------------------------------------------------------------------------

-- loop through every id
  -- check if its in any range

inc = 0
  
for i = 1,#ids
do
  for j = 1,#id_rangeTab
  do
    if idIsInRange(ids[i],id_range(id_rangeTab[j]))
    then
      --print(ids[i])
      --print(id_rangeTab[j])
      --print_table(id_range(id_rangeTab[j]))
      inc = inc + 1
      goto continue
    end
  end
  ::continue::
end


--------------------------------------------------------------------------------------------------

print("number of valid ids: " .. inc)

--------------------------------------------------------------------------------------------------

