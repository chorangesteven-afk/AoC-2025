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
   -- print the substring
   table.insert(input_table,i)
end
--print_table(input_table)
--print(input_table[1])
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

--print(input_table_table[1][3])
--print(#input_table_table)
--print_table_table(input_table_table)

--------------------------------------------------------------------------------------------------

-- oop approach

-- create an object for each circuit
-- each circuit obj will contain every box in the circuit and there position
-- create a function/method that merges two circ obj
-- given a box -> find what circuit its in

--------------------------------------------------------------------------------------------------

function distbwTwoPts(t1,t2)
  local dist = math.sqrt((t2[1] - t1[1])^2+(t2[2] - t1[2])^2+(t2[3] - t1[3])^2)
  return dist
end

--print(distbwTwoPts({1,0,0},{0,0,0}))

--------------------------------------------------------------------------------------------------

distancesTable = {}
distancesTable2 = {}

--{{box 1's distance to box 2 = 61561, box 1's distance to box 3 = 109274},{}}

for i = 1,#input_table
do
  --table.insert(distancesTable,{})
  for j = i+1,#input_table
  do
    
    
    local dist = distbwTwoPts(input_table_table[i],input_table_table[j])
    
    table.insert(distancesTable,{boxNum = i,relBoxNum = j, distance = dist})
    
    --table.insert(distancesTable,{boxNum = i,relBoxNum = j})
    table.insert(distancesTable2,dist)
    
    
    
    
    --table.insert(distancesTable[i],{relation = j,distance = dist})
    
    --distancesTable[i][j].relation = tostring(j)
    --distancesTable[i][j].distance = dist
    
    --print("box" .. i .. "DistanceToBox" .. j)
    --distancesTable[i]["box" .. i .. "DistanceToBox" .. j] = dist
    --table.insert(distancesTable[i],dist)
  end
end

--table.remove(distancesTable,#distancesTable)


--print(distancesTable[1].distance)

--print(#distancesTable)
--print(distancesTable[#distancesTable])
--print(distancesTable2[#distancesTable2])

--print(distancesTable[1][1].distance)

--print(distancesTable[1]["box1DistanceToBox2"])


--[[

for i,v in pairs(distancesTable)
do
  print("box number is " .. v.boxNum)
  print("rel box number is " .. v.relBoxNum)
  --print("rel box distance is " .. v.distance)
end

]]--


--[[
for i,v in pairs(distancesTable[1])
do
  for j,b in pairs(v)
  do
    print(i,b)
  end
end
]]--


--------------------------------------------------------------------------------------------------

--[[
print("test1")


sortByDist = function (entry1, entry2)
   return entry1.distance < entry2.distance
end



for i = 1,#distancesTable
do
  table.sort(distancesTable,sortByDist)
end

print("test")

]]--


table.sort(distancesTable2)

smallestDist = {}

for i = 1,1000
do
  table.insert(smallestDist,distancesTable2[i])
end


closestBoxes = {}

inc1 = 1

while true do
  if (inc1 == 1001)
  then
    break
  end
for i = 1,#distancesTable
do
  if (distancesTable[i].distance == smallestDist[inc1])
  then
    table.insert(closestBoxes,{boxNum = distancesTable[i].boxNum,relBoxNum = distancesTable[i].relBoxNum})
    inc1 = inc1 + 1
    goto continue
  end
end
::continue::
end


--print(closestBoxes[10].boxNum,closestBoxes[10].relBoxNum)

--print_table(distancesTable2)





--------------------------------------------------------------------------------------------------


--[[
for i,v in pairs(distancesTable)
do
  print("box number is " .. v.boxNum)
  print("rel box number is " .. v.relBoxNum)
  print("rel box distance is " .. v.distance)
end

]]--


-- add every box from circuit a to circuit b
-- what if they're in the same circuit


circuits = {}

for i = 1,#closestBoxes
do
  
  table.insert(circuits,{})
  table.insert(circuits[i],{boxNum = closestBoxes[i].boxNum})
  --table.insert(circuits[i],{})
  
end


for i = 1,#closestBoxes
do
  
  table.insert(circuits,{})
  table.insert(circuits[#closestBoxes+i],{boxNum = closestBoxes[i].relBoxNum})
  --table.insert(circuits[i],{})
  
end


--[[

for i = 1,#input_table
do
  table.insert(circuits,{})
  table.insert(circuits[i],{boxNum = i})
end
]]--



for i = 1,#circuits
do
  for j = 1,#circuits[i]
  do
    print("circuit " .. i .. " has box: ")
    print(circuits[i][j].boxNum)
  end
  --print("circuit " .. i)
  --print(circuits[i][1].boxNum)
end





function whatCircuitIsABoxIn(circuitsTable,boxNum)
  for i = 1,#circuitsTable
  do
    if (circuitsTable[i] == nil)
    then
      goto continue
    end
    for j = 1,#circuitsTable[i]
    do
      if (circuits[i][j].boxNum == boxNum)
      then
        return i
      end
    end
    ::continue::
  end
end

--print(whatCircuitIsABoxIn(circuits,10))












for i = 1,10
do
  --distancesTable[i].boxNum
  --print("relboxnum: " .. closestBoxes[i].relBoxNum)
  --local circuitA = distancesTable[i].boxNum
  --print(i)
  --print(distancesTable[i].boxNum)
  --print(whatCircuitIsABoxIn(circuits,distancesTable[i].boxNum))
  --print("box " .. distancesTable[i].boxNum .. " is in circuit " .. whatCircuitIsABoxIn(circuits,distancesTable[i].boxNum))

  local circuitOfBox1 = whatCircuitIsABoxIn(circuits,closestBoxes[i].boxNum)
  --local circuitB = closestBoxes[i].relBoxNum
  print("box 1: " .. closestBoxes[i].boxNum)
  print("box 2: " .. closestBoxes[i].relBoxNum)
  print(circuitOfBox1)
  
  local circuitOfBox2 = whatCircuitIsABoxIn(circuits,closestBoxes[i].relBoxNum)
  print(circuitOfBox2)
  
  print("adding " .. circuitOfBox2 .. " to " .. circuitOfBox1)
  
  if (circuitOfBox1 == circuitOfBox2)
  then
    goto continue
  end
  
  for j = 1,#circuits[circuitOfBox2]
  do
    table.insert(circuits[circuitOfBox1],circuits[circuitOfBox2][j])
  end
  
  --circuits[circuitOfBox2] = nil
  
  table.remove(circuits,circuitOfBox2)
  
  --[[
  for j = circuitOfBox2,#circuits-1
  do
    circuits[j] = circuits[j+1]
  end
  
  circuits[#circuits] = nil
  
  ]]--

  
  ::continue::
end

print("new number of circuits is " .. #circuits)

--table.sort(circuits)

for i = 1,#circuits
do
  --if (circuitsTable[i] == nil)
  --then
    --goto continue
  --end
  
  --print("circuit " .. i .. " has " .. #circuits[i] .. " boxes.")
  --print("circuit " .. i .. " has:")
  
  
  for j = 1,#circuits[i]
  do
    print("box: ")
    print(circuits[i][j].boxNum)
  end
  
  --::continue::
  --print("circuit " .. i)
  --print(circuits[i][1].boxNum)
end



-- find the 3 biggest circuits
sizeOfEachCircuit = {}

for i = 1,#circuits
do
  table.insert(sizeOfEachCircuit,#circuits[i])
end

table.sort(sizeOfEachCircuit)

print_table(sizeOfEachCircuit)


