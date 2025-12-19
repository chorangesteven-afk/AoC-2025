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

function sepString(str)
  local ltable = {}
  for i in string.gmatch(str,'.')
  do
     table.insert(ltable, i)
  end
  return ltable
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

function sumTable(tab)
  local sum = 0
  for i = 1,#tab
  do
    sum = sum + tab[i]
  end
  return sum
end

--------------------------------------------------------------------------------------------------


input = io.read("*a")

input_table = {}

-- splits input by newline
for i in string.gmatch(input, "%C+") do
   table.insert(input_table,i)
end

--print("number of rows: " .. #input_table)

--print_table(input_table)


indicatorDesiredOutput = {}


--print(string.match(input_table[1],"[.#]+"))

for i = 1,#input_table
do
  local str = string.match(input_table[i],"[.#]+")
  local tab = sepString(str)
  --local tab2 = {}
  for j = 1,#tab
  do
    if (tab[j] == ".")
    then
      tab[j] = 0
    elseif (tab[j] == "#")
    then
      tab[j] = 1
    end
  end
  table.insert(indicatorDesiredOutput,tab)
end

--print_table_table(indicatorDesiredOutput)

buttons = {}
inc = 1

for i = 1,#input_table
do
  -- insert table for each machine
  table.insert(buttons,{})
  for buttValues in string.gmatch(input_table[i],"%([%d,]+%)")
  do
    --print(buttValues)
    --table.insert(buttons,{})
  
    local individualButtonTable = {}
    for num in string.gmatch(buttValues,"%d+")
    do
      --print(num+1)
      table.insert(individualButtonTable,tonumber(num)+1)
    end
    table.insert(buttons[i],individualButtonTable)
  end
end

--[[

for i = 1,#buttons[1]
do
  print_table(buttons[1][i])
end
]]--





--------------------------------------------------------------------------------------------------

--[[
function combTable(numOfButtons,numOfPresses,whereToStart)
  
  local tab = {}
  
  for i = 1,numOfButtons
  do
    tab[i] = 0
  end
  
  
  -- base test
  if (numOfPresses == 1)
  then
    local tab1 = {}
    
    for i = whereToStart,numOfButtons
    do
      
      tab[i] = 1
      local tabCopy = table.table_copy(tab)
      table.insert(tab1,tabCopy)
      for i = 1,numOfButtons
      do
        tab[i] = 0
      end
    end
    
    return tab1
    
  else
    -- each step needs to distribute its tally amongst every button on and after where to start
    
    local tab2 = {}
    local tab3 = {}
    
    for i = whereToStart,numOfButtons
    do
      
      tab[i] = 1
      local tabCopy = table.table_copy(tab)
      table.insert(tab2,tabCopy)
      for i = 1,numOfButtons
      do
        tab[i] = 0
      end
    end
    
    -- put a tally of one at where to start
    
    --tab[whereToStart] = 1
    
    -- call the function with numOfPresses-1
    
    local tab1 = combTable(numOfButtons,numOfPresses-1,whereToStart)
    --print_table_table(tab1)
    
    -- add the tally table to each table returned from the function
    local tab3 = {}
    
    
    for i = 1,#tab2
    do
      for j = 1,#tab1
      do
        local tab4 = {}
        for k = 1,#tab1[j]
        do
          local x = tab2[i][k] + tab1[j][k]
          table.insert(tab4,x)
        end
        table.insert(tab3,tab4)
      end
    end
    
    
    
    
    
    for i = 1,#tab1
    do
      for j = 1,#tab1[i]
      do
        tab1[i][j] = tab1[i][j] + tab2[i][j]
      end
    end
    
  
    
    --print()
    --print_table_table(tab1)
  
    -- return those tables
    
    return tab3
    
    
  end
  
end

]]--


--print_table_table(combTable(3,1,1))
--combTable(5,2,1)
--print(#buttons[2])
--[[

tableOfComb = {}
numOfPresses = 3


if (numOfPresses == 1)
then
  local tab = combTable(#buttons[1],1,1)
  for j = 1,#tab
  do
    table.insert(tableOfComb,tab[j])
  end
else
  for i = 1,#buttons[1]
  do
    local tab = combTable(#buttons[1],numOfPresses,i)
    for j = 1,#tab
    do
      table.insert(tableOfComb,tab[j])
    end
  end
end

print_table_table(tableOfComb)

]]--


function genSparseTable(i,v,s)
  local tab = {}
  for i = 1,s
  do
    table.insert(tab,0)
  end
  tab[i] = v
  --print_table(tab)
  return tab
end

function tableNotEqual(t1,t2)
  for i = 1,#t1
  do
    if (t1[i] ~= t2[i])
    then
      return true
    end
  end
  return false
end

function rightMostNonZeroIndex(t)
  for i = #t,1,-1
  do
    if (t[i] ~= 0)
    then
      return i
    end
  end
end

function leftMostNonZeroIndex(t)
  for i = 1,#t
  do
    if (t[i] ~= 0)
    then
      return i
    end
  end
end




function combTable(numOfStacks,stackSize)
  
  local t1 = genSparseTable(1,stackSize,numOfStacks)
  local tf = genSparseTable(numOfStacks,stackSize,numOfStacks)
  local tableCollector = {}
  local globalTable = table.table_copy(t1)
  
  --print("testidk")
  --print_table(globalTable)
  
  local partition = {1,1}
  
  -- only save tables when partition is 1
  
  while (tableNotEqual(globalTable,tf))
  do
    if (partition[2] == 1)
    then
      --print("test1")
      local dummyTable = table.table_copy(globalTable)
      table.insert(tableCollector,dummyTable)
    end
    if (partition[2] == 0)
    then
      --print("test2")
      partition[2] = 1
    end
    if ((partition[2] ~= globalTable[numOfStacks]) and (partition[1] == numOfStacks))
    then
      --print("test3")
      partition[2] = globalTable[numOfStacks]
    end
    if ((partition[2] == globalTable[numOfStacks]) and (partition[1] == numOfStacks))
    then
      --print("test4")
      globalTable[numOfStacks] = 0
      local rI = rightMostNonZeroIndex(globalTable)
      globalTable[rI] = globalTable[rI] + partition[2]
      partition[1] = rI
      partition[2] = partition[2] + 1
    end
    --print("test5")
    globalTable[partition[1]] = globalTable[partition[1]] - partition[2]
    globalTable[partition[1]+1] = globalTable[partition[1]+1] + partition[2]
    partition[2] = 1
    partition[1] = partition[1] + 1
    --::continue::
  end
  table.insert(tableCollector,tf)

  return tableCollector

end


--local t100 = combTable(6,1)
--print(#t100)
--print_table_table(t100)








--------------------------------------------------------------------------------------------------

correctCombinations = {}

for i = 1,#indicatorDesiredOutput
do
  local iT = {}
  for j = 1,#indicatorDesiredOutput[i]
  do
    iT[j] = 0
  end
  local inc1 = 1
  --print(#buttons[i])
  while true
  --(tableNotEqual(iT,indicatorDesiredOutput))
  do
    local t100 = combTable(#buttons[i],inc1)
    for j = 1,#t100
    do
      local dummyTable = table.table_copy(iT)
      for k = 1,#t100[j]
      do
        if (t100[j][k] > 0)
        then
          for m = 1,t100[j][k]
          do
            for _,v in ipairs(buttons[i][k])
            do
              if (dummyTable[v] == 0)
              then
                dummyTable[v] = 1
              else
                dummyTable[v] = 0
              end
            end
          end
        end
      end
      --print_table(dummyTable)
      --print(inc1)
      if (not(tableNotEqual(dummyTable,indicatorDesiredOutput[i])))
      then
        print("test")
        table.insert(correctCombinations,t100[j])
        goto continue
      end
    end
    inc1 = inc1 + 1
  end
  ::continue::
  
  
  
end

print_table_table(correctCombinations)

sum = 0

for i = 1,#correctCombinations
do
  sum = sum + sumTable(correctCombinations[i])
end

print("answer is " .. sum)


--------------------------------------------------------------------------------------------------










