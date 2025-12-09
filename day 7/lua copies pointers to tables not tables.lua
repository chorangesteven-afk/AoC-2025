

function print_table(table)
  for i=1,#table
  do
    io.write(table[i] .. " ")
  end
  print()
end

function print_table_table(tab)
  for i = 1,#tab
  do
    print_table(tab[i])
  end
end

--[[
test = {}
test[1] = {1,2,3}
table.insert(test,test[1])
--test[2] = test[1]

print_table(test[2])
test[1][1] = 2
print("table 1:")
print_table(test[1])
print("table 2:")
print_table(test[2])
]]--


-- function to get deep clone of passed table
function deepClone(original)
   local copy
   if orig_type == 'table' then
      -- create an empty table
      copy = {}
      -- loop through all entries	  
      for key, value in next, orig, nil do
         copy[deepClone(key)] = deepClone(value)
      end
      setmetatable(copy, deepClone(getmetatable(original)))
   else
      -- in case of number, string etc.
	  copy = original
   end
   -- return the cloned copy
   return copy
end

function table.table_copy(t)
   local t2 = {}
   -- iterate the array
   for k,v in pairs(t) 
   do
      t2[k] = v
   end
   return t2
end

--[[
-- original table
studentDetails = {
	student = { name = "Robert", age = 12},
	address = { city = "HYD", pincode = 500031}
}

-- cloned table
clonedTable = deepClone(studentDetails)

-- print an entry of cloned table
print(clonedTable.student.name)
]]--



test = {{1,2,3}}
var = table.table_copy(test[1])
table.insert(test,var)
print_table_table(test)
test[1][1] = 4
print(test[1][1])
print(test[2][1])
print_table_table(test)





numbers = { 20, 10, 30, 40, 50, 65, 12, 11}

for i, v in ipairs(numbers) do
   print(i, v)
end

















