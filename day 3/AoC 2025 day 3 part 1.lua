input = io.read("*a")

--print(type(input))

--------------------------------------------------------------------------------------------------

function print_table(table)
  for i=1,#table
  do
    io.write(table[i] .. " ")
  end
  print()
end

--print(input)

--------------------------------------------------------------------------------------------------

string_list = {}

--------------------------------------------------------------------------------------------------
-- separate by newline

for i in string.gmatch(input, "%C+") 
do
  table.insert(string_list,i)
end

--print(type(string_list))
--print_table(string_list)

--[[
for i=1,#string_list[1]
do
  table.insert(row, string_list[1][i])
end
]]--

--------------------------------------------------------------------------------------------------


function sepString(str)
  local ltable = {}
  for i in string.gmatch(str,'.')
  do
     table.insert(ltable, i)
  end
  return ltable
end



--------------------------------------------------------------------------------------------------


--[[
testTable = sepString(string_list[1])
io.write ("sep string: ")
print(table.unpack(testTable))
print("test " .. math.max(table.unpack(testTable)))

]]--


--------------------------------------------------------------------------------------------------

function indicesOfGlobalMaxExceptLast(tab)

  local indicesOfMaxValues = {}
  local maxValue = math.max(table.unpack(tab,1,#tab-1))

  for i = 1,#tab-1
  do
    if (tab[i] == maxValue)
    then
      table.insert(indicesOfMaxValues,i)
    end
  end
  return indicesOfMaxValues
end

--------------------------------------------------------------------------------------------------


--[[
testIndices = maxIndices(testTable)
print_table(testIndices)
minIndexOfGlobalMax = math.min(table.unpack(testIndices))
print("min index of max value " .. minIndexOfGlobalMax)
]]--



--------------------------------------------------------------------------------------------------


function maxRightOfMax(tab,minInd)
  local indicesOfMaxValues = {}
  local maxValue = math.max(table.unpack(tab,minInd+1))
  
  for i = minInd+1,#tab
  do
    if (tab[i] == maxValue)
    then
      table.insert(indicesOfMaxValues,i)
    end
  end
  return indicesOfMaxValues
end

--------------------------------------------------------------------------------------------------

--[[
minIndicesRightOfMax = maxRightOfMax(testTable,minIndexOfGlobalMax)
minIndex = math.min(table.unpack(minIndicesRightOfMax))
print("min index of max value to the right of other max value: " .. minIndex)
]]--


--------------------------------------------------------------------------------------------------

function turnTwoIndicesIntoNum(tab,Ind1,Ind2)
  --print(tab[Ind1])
  --print(tab[Ind2])
  local combination = table.unpack(tab,Ind1,Ind1) .. table.unpack(tab,Ind2,Ind2)
  return combination
end

--------------------------------------------------------------------------------------------------

--[[
print(turnTwoIndicesIntoNum(testTable,minIndexOfGlobalMax,minIndex))
]]--


--------------------------------------------------------------------------------------------------

-- loop through every value in the string list table

maxJoltage = {}

for i = 1,#string_list
do
  
  local stringTable = sepString(string_list[i])
  
  local globalMaxIndices = indicesOfGlobalMaxExceptLast(stringTable)
  local minIndexOfGlobalMax = math.min(table.unpack(globalMaxIndices))
  --print(minIndexOfGlobalMax)
  
  
  local minIndicesRightOfMax = maxRightOfMax(stringTable,minIndexOfGlobalMax)
  local minIndexOfOtherMax = math.min(table.unpack(minIndicesRightOfMax))
  
  table.insert(maxJoltage,turnTwoIndicesIntoNum(stringTable,minIndexOfGlobalMax,minIndexOfOtherMax))
  
end

--------------------------------------------------------------------------------------------------

--print("test: " .. maxJoltage[1])
print_table(maxJoltage)

--------------------------------------------------------------------------------------------------

function sumTable(tab)
  local sum = 0
  for i = 1,#tab
  do
    sum = sum + tab[i]
  end
  return sum
end
sum = sumTable(maxJoltage)
print("sum of max joltage is: " .. sum)


--------------------------------------------------------------------------------------------------



