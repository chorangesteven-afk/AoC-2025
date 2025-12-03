input = io.read()

--print(string.find(input,','))
--print(string.match(input,','))

-- print table function-------------------------------

function print_table(table)
  --print(table[1])
  for i=1,#table
  do
    io.write(table[i] .. " ")
  end
  print()
end


--------------------------------------------------------------

id_string_list = {}

--------------------------------------------------------------
-- remove commas

for i in string.gmatch(input,'([^'..','..']+)') do
  table.insert(id_string_list,i)
end

--[[
for i=1,#id_string_list do
  print(id_string_list[i])
end
io.write(id_string_list[1])
print()
]]--
--print_table(id_string_list)

-- function: pass id range -> return first and last id as table-------------------------------

function id_range(str)
  local tempTable = {}
  for i in string.gmatch(str,'([^'..'-'..']+)') do
    --print(i)
    table.insert(tempTable,i)
  end
  return tempTable
end

--[[
var = id_range(id_string_list[1])
for i = 1,#var do
  io.write(var[i] .. ' ')
end
print()
]]--

-- even odd function------------------------------------------------------

function is_even(num)
  if num % 2 == 0
  then
    return true
  else
    return false
  end
end

-- function: check if id is invalid, returns bool -----------------------------------------
-- part 1
--[[
function is_invalid(id)
  id = tostring(id)
  --print("id being checked is: " .. id)
  if is_even(#id) == false
  then
    --print('odd')
    return false
  else
    -- split number in half
    --print(id)
    --print(type(id))
    local half = #id/2
    --print(half)
    local slice1 = string.sub(id,1,half)
    --print("slice1 is: " .. slice1)
    local slice2 = string.sub(id,half+1,#id)
    --print(slice2)
    if slice1 == slice2
    then
      --print("is invalide")
      return true
    end 
  end
end
]]--


--------------------------------------------------------------

function evenlyslicedstring(str,div,slicelength)
  -- return a table, length of table is # of slices
  local funcTable = {}
  
  for i=1,div
  do
    local endofSlice = slicelength*i
    local startofSlice = endofSlice - slicelength + 1
    table.insert(funcTable,string.sub(str,startofSlice,endofSlice))
  end
  
  return funcTable
  
end


--temp = evenlyslicedstring("1011",2,2)
--print_table(temp)







function checkUniformTable(tab)
  -- check if the first val in the table is equal to every other value.
  for i = 1,#tab
  do
    if tab[1] ~= tab[i]
    then
      return false
    end
  end
  return true
end



--print("test table is: " .. tostring(checkUniformTable(temp)))



--------------------------------------------------------------
-- part 2

function is_invalid(id)
  id = tostring(id)
  local half = #id/2
  --print(half)
  local returnBool = false
  for i = 1,math.ceil(half)
  -- iterates through range of slice lengths
  do
    -- check if table is evenly divisible by the slice length
    
    if ( ((#id/i) % 1) ~= 0 )
    then 
      --print("i is: " .. i .. " #id: " .. #id)
      goto continue
    end
    if (#id == 1)
    then
      --print("id length is 1, id is: " .. id)
      goto continue
    end
    
    
    local div = #id / i
    --print("div is: "..div)
    
    local slice_table = evenlyslicedstring(id,div,i)
    --print_table(slice_table)
    
    if checkUniformTable(slice_table)
    then
      return true
    end
    
    
    
    
    
    
    
    
    
    ::continue::
  end
  return returnBool
end
--[[
test = is_invalid('1111112')
print("idk: " .. tostring(test))
]]--

--[[
for i=1,10 do
  if i % 2 == 0 then goto continue end
  print(i)
  ::continue::
end
]]--

---------------------------------------------------------------------------------------------


-- iterate through each id in the range then log each invalid id

-- loop through id range
    --loop through each id in the range

invalid_ids = {}

for i = 1,#id_string_list
do
  local range = id_range(id_string_list[i])
  local startingID = range[1]
  startingID = tonumber(startingID)
  local endingID = range[2]
  endingID = tonumber(endingID)
  --print("starting id is: " .. startingID)
  --print(endingID)
  for j = startingID,endingID
  do
    if is_invalid(j)
    then
      --print(j)
      table.insert(invalid_ids,j)
    end
  end
end

---------------------------------------------------------------------------------------------

--print("invalide id: " .. invalid_ids[2])

--print("invalid ids:")
--print_table(invalid_ids)

-- sum invalid ids--------------------------------------------------------------

sum = 0
for i = 1,#invalid_ids
do
  sum = sum + invalid_ids[i]
end
print("sum of invalid ids is: " .. sum)
