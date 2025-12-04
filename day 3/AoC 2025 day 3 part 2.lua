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
-- turns string into table of strings

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
]]--



--------------------------------------------------------------------------------------------------

function turnTwelveIndicesIntoNum(inpTab,indTab)
  
  local funcTab = {}
  
  for i = 1,#indTab
  do
    table.insert(funcTab,inpTab[indTab[i]])
  end
  -- table of strings -> single number
  
  return table.concat(funcTab)
end

--------------------------------------------------------------------------------------------------


function findIndexOfMaxValueBetweenTwoIndices(tab,Ind1,Ind2)
  -- inclusive
  -- chooses leftmost one
  
  
  local maxValue = math.max(table.unpack(tab,Ind1,Ind2))
  --print("max value between " .. Ind1 .. " and " .. Ind2 .. " is " .. maxValue)
  
  for i = Ind1,Ind2
  do
    if (tab[i] == maxValue)
    then
      --print("max value located at " .. i)
      return i
    end
  end
  
end



--------------------------------------------------------------------------------------------------

--[[
-- find max value in first set
-- set 1 goes from first value to n-11

indicesOfmaxValues = {}
indicesOfmaxValues[1] = findIndexOfMaxValueBetweenTwoIndices(testTable,1,(#testTable-11))
]]--


--------------------------------------------------------------------------------------------------



function findIndicesOfRemainingSets(tab,Ind)
  local funcTab = {Ind}
  
  for i=2,12
  do
    -- first index is previous index + 1
    -- last index is n-12+i
    --print("first index is " .. funcTab[i-1]+1)
    --print("last index is " .. #tab-12+i)
    --print("index of max value is " .. findIndexOfMaxValueBetweenTwoIndices(tab,(funcTab[i-1]+1),(#tab-12+i)))
    table.insert(funcTab,findIndexOfMaxValueBetweenTwoIndices(tab,(funcTab[i-1]+1),(#tab-12+i)))
    --print("table value is " .. funcTab[i])
    
  end
  
  return funcTab
end

--------------------------------------------------------------------------------------------------


--[[
randomTable = findIndicesOfRemainingSets(testTable,indicesOfmaxValues[1])
print_table(randomTable)

print(turnTwelveIndicesIntoNum(testTable,randomTable))
]]--



--------------------------------------------------------------------------------------------------



-- loop through every value in the string list table

maxJoltage = {}

for i = 1,#string_list
do
  
  local stringTable = sepString(string_list[i])
  
  
  local indexOfFirstMaxValue = findIndexOfMaxValueBetweenTwoIndices(stringTable,1,(#stringTable-11))
  
  
  
  local indicesOfmaxValues = {}
  
  indicesOfmaxValues = findIndicesOfRemainingSets(stringTable,indexOfFirstMaxValue)
  
  --print_table(indicesOfmaxValues)
  
  --print(turnTwelveIndicesIntoNum(stringTable,indicesOfmaxValues))
  table.insert(maxJoltage,turnTwelveIndicesIntoNum(stringTable,indicesOfmaxValues))
  
end

--------------------------------------------------------------------------------------------------

--print_table(maxJoltage)

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



