

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
test[1] = {1,2}
test2 = {}
test2[1] = test[1]

print_table_table(test)
print_table_table(test2)

test[1][1] = 3

print_table_table(test)
print_table_table(test2)
]]--

--[[
print((-2)^3)

]]--
--[[
t = {1}
print(math.min(table.unpack(t)))

test = {}
test["test"] = {1,2}
print_table(test["test"])
]]--

--[[
sortByDist = function (entry1, entry2)
   return entry1[] < entry2[]
end
]]--
--[[
test = {}
test["a"] = 10
test["b"] = 1

for i,v in pairs(test)
do
  print(i,v)
end

table.sort(test)

for i,v in pairs(test)
do
  print(i,v)
end
]]--

--[[
test =  {{1,2}}

print_table_table(test)
test = nil
print(test)

]]--

--[[
for i = 1,5
do
  i = 2
  print(i)
end

]]--
--[[
a = 1
b = 2

a,b = b,a
print(a,b)

]]--

--[[
circuits = {{{boxNum = 1},{boxNum = 2}},{{boxNum = 3},{boxNum = 4}}}

for i = 1,#circuits[2]
do
  table.insert(circuits[1],circuits[2][i])
end


--table.insert(circuits[1],circuits[2])

print(circuits[1][4].boxNum)

for i,v in pairs(circuits[1])
do
  for j,b in pairs(v)
  do
    print(i,b)
  end
  print(i,v.boxNum)
end

]]--


--[[
test = {1,2,3}
--test[3] = nil
table.remove(test,2)

print_table(test)
]]--


--[[


-- function to create a partition
function partition(list, low, high,list2,list3)
   -- last element is a pivot
   local pivot = list[high]
   local i = low - 1 -- index of first element

   -- loop on elements of the partition
   for j = low, high - 1 do
      -- swap number if lower than pivot
      if list[j] <= pivot then
         i = i + 1
         list[i], list[j] = list[j], list[i]
         list2[i],list2[j] = list2[j],list2[i]
         list3[i],list3[j] = list3[j],list3[i]
      end
   end

   -- Swap list[i + 1] with list[high]
   list[i + 1], list[high] = list[high], list[i + 1]
   list2[i + 1], list2[high] = list2[high], list2[i + 1]
   list3[i + 1], list3[high] = list3[high], list3[i + 1]
   return i + 1  -- return the index to partition
end

function quick_sort(list, low, high,list2,list3)
   if low < high then
      -- Partition the list and get the partitioning index
      local pi = partition(list, low, high,list2,list3)

      -- Recursively quick sort elements before and after partition
      quick_sort(list, low, pi - 1,list2,list3)
      quick_sort(list, pi + 1, high,list2,list3)
   end
   return list,list2,list3
end


-- Example usage:
local numbers = {5, 1, 4, 2, 8}
local numberIndex1 = {"num1","num2","num3","num4","num5"}
local numberIndex2 = {"num5","num4","num3","num2","num1"}
local sorted_numbers,numberIndex1,numberIndex2 = quick_sort(numbers, 1, #numbers,numberIndex1,numberIndex2)
print("Sorted list:", table.concat(sorted_numbers, ", ")) -- Output: Sorted list: 1, 2, 4, 5, 8
print("Sorted list:", table.concat(numberIndex1, ", ")) -- Output: Sorted list: 1, 2, 4, 5, 8
print("Sorted list:", table.concat(numberIndex2, ", ")) -- Output: Sorted list: 1, 2, 4, 5, 8

]]--


circuits = {{{boxNum = 1}},{{boxNum = 2}}}

function addCirc1ToCirc2(circ1,circ2)
  for i,v in pairs(circ2)
  do
    table.insert(circ1,v)
  end
  return circ1
end

circuits[1] = addCirc1ToCirc2(circuits[1],circuits[2])
table.remove(circuits,2)
print(#circuits)

for i = 1,#circuits
do
  print("circuit " .. i .. " has:")
  for j,v in pairs(circuits[i])
  do
    print(v.boxNum)
  end
end










