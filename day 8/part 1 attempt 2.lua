-- less complicated
-- run faster
-- iterate less

--------------------------------------------------------------------------------------------------

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

function distbwTwoPts(t1,t2)
  local dist = math.sqrt((t2[1] - t1[1])^2 + (t2[2] - t1[2])^2 + (t2[3] - t1[3])^2)
  return dist
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

--------------------------------------------------------------------------------------------------


input = io.read("*a")

input_table = {}

-- splits input by newline
for i in string.gmatch(input, "%C+") do
   table.insert(input_table,i)
end

print("number of rows: " .. #input_table)

input_table_table = {}
for i = 1,#input_table
do
  table.insert(input_table_table,{})
  for j in string.gmatch(input_table[i],'%d+')
  do
    table.insert(input_table_table[i], j)
  end
end

--print(#input_table_table)
--print_table_table(input_table_table)

--------------------------------------------------------------------------------------------------

-- need to know which distance is linked to which 2 boxes

--print("test")

boxes = {}
relBoxes = {}
distances = {}

for i = 1,#input_table
do
  for j = i+1,#input_table
  do
    
    
    local dist = distbwTwoPts(input_table_table[i],input_table_table[j])
    
    table.insert(boxes,i)
    table.insert(relBoxes,j)
    table.insert(distances,dist)
    
    
    
  end
end





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




boxesSorted = {}
relBoxesSorted = {}
distancesSorted = {}

distancesSorted,boxesSorted,relBoxesSorted = quick_sort(distances,1,#distances,boxes,relBoxes)

--print_table(boxesSorted)
--print_table(relBoxesSorted)
--print_table(distancesSorted)
n = 1000





--------------------------------------------------------------------------------------------------


-- make a linked list circuit for each unique number found in the pairs of closest boxes <- this isn't true

-- make a circuit for each unique box found in the first n pairs of closest boxes.

uniqueNum = {boxesSorted[1]}

for i = 1,n
do
  local boxUnique = true
  local relBoxUnique = true
  
  for j = 1,#uniqueNum
  do
    if (boxes[i] == uniqueNum[j])
    then
      boxUnique = false
    end
    if (relBoxes[i] == uniqueNum[j])
    then
      relBoxUnique = false
    end
    
  end
  
  if (boxUnique)
  then
    table.insert(uniqueNum,boxes[i])
  end
  if (relBoxUnique)
  then
    table.insert(uniqueNum,relBoxes[i])
  end
  
end

--print_table(uniqueNum)
--print("num of unique boxes " .. #uniqueNum)


--------------------------------------------------------------------------------------------------


circuits = {}

for i = 1,#uniqueNum
do
  table.insert(circuits,{})
  table.insert(circuits[i],{boxNum = uniqueNum[i]})
end


--------------------------------------------------------------------------------------------------



--circuits = {{{boxNum = 1}},{{boxNum = 2}}}

function addCirc1ToCirc2(circ1,circ2)
  for i,v in pairs(circ2)
  do
    table.insert(circ1,v)
  end
  return circ1
end

--circuits[1] = addCirc1ToCirc2(circuits[1],circuits[2])
--table.remove(circuits,2)
--print("number of circuits " .. #circuits)

for i = 1,#circuits
do
  --print("circuit " .. i .. " has:")
  for j,v in pairs(circuits[i])
  do
    --print(v.boxNum)
  end
end

--------------------------------------------------------------------------------------------------

function whatCircuitIsBoxIn(boxNum)
  for i = 1,#circuits
  do
    --print("circuit " .. i .. " has:")
    for j,v in pairs(circuits[i])
    do
      --print(v.boxNum)
      if (boxNum == v.boxNum)
      then
        return i
      end
    end
  end
end

--------------------------------------------------------------------------------------------------

-- connect together the n closest pairs of boxes and their circuits


for i = 1,n
do
  
  local circ1 = whatCircuitIsBoxIn(boxesSorted[i])
  local circ2 = whatCircuitIsBoxIn(relBoxesSorted[i])
  
  if(circ1 == circ2)
  then
    goto continue
  end
  
  circuits[circ1] = addCirc1ToCirc2(circuits[circ1],circuits[circ2])
  table.remove(circuits,circ2)
  
  ::continue::
  
end


for i = 1,#circuits
do
  --print("circuit " .. i .. " has:")
  for j,v in pairs(circuits[i])
  do
    --print(v.boxNum)
  end
end

circuitSize = {}

for i = 1,#circuits
do
  print("circuit " .. i .. " has " .. #circuits[i] .. " boxes")
  table.insert(circuitSize,#circuits[i])
end

table.sort(circuitSize)

print_table(circuitSize)



