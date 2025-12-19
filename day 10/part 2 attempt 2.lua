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

--[[
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

]]--


joltageRequirements = {}

for i = 1,#input_table
do
  -- insert table for each machine
  --table.insert(joltageRequirements,{})
  for joltValues in string.gmatch(input_table[i],"%{[%d,]+%}")
  do
    --print(joltValues)
    --table.insert(buttons,{})
  
    local individualJoltageTable = {}
    for num in string.gmatch(joltValues,"%d+")
    do
      --print(num)
      table.insert(individualJoltageTable,tonumber(num))
    end
    table.insert(joltageRequirements,individualJoltageTable)
  end
end

--[[
print(#joltageRequirements)
print(#joltageRequirements[1])

for j = 1,#joltageRequirements
do
  print_table(joltageRequirements[j])
end
]]--


buttons = {}
--inc = 1

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
local function combinations_with_repetition_gen(n, r)
    return coroutine.wrap(function()
        local current = {}

        local function backtrack(start)
            if #current == r then
                coroutine.yield({ table.unpack(current) })
                return
            end

            for i = start, n do
                table.insert(current, i)
                backtrack(i)
                table.remove(current)
            end
        end

        backtrack(1)
    end)
end

--[[
-- Example usage
tab = {}
for combo in combinations_with_repetition_gen(3, 2) do
  table.insert(tab,combo)
    --print(table.concat(combo, " "))
end
]]--

--------------------------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------------------------

correctCombinations = {}


for i = 1,#joltageRequirements
do
  local iT = {}
  --print(#joltageRequirements[i])
  for j = 1,#joltageRequirements[i]
  do
    iT[j] = 0
  end
  local maxButton = 0
  for j = 1,#buttons[i]
  do
    if (#buttons[i][j] > maxButton)
    then
      maxButton = #buttons[i][j]
    end
  end
  local joltageSum = sumTable(joltageRequirements[i])
  print(joltageSum)
  local inc1 = math.ceil(joltageSum / maxButton)
  
  local bool = true
  
  
  
  --print(#buttons[i])
  while bool
  --(tableNotEqual(iT,indicatorDesiredOutput))
  do
    
    local t100 = {}
    for combo in combinations_with_repetition_gen(#buttons[i],inc1) do
      table.insert(t100,combo)
    --print(table.concat(combo, " "))
    end
    
    
    --local t100 = combinations_with_repetition_iterative(#buttons[i],inc1)
    --print_table_table(t100)
    
    --print_table(combTable)
    j1 = 1
    while ((j1 <= #t100) and (bool))
    --for j = 1,#t100
    do
      local dummyTable = table.table_copy(iT)
      --print_table(dummyTable)
      for _,k in ipairs(t100[j1])
      --k = 1,#t100[j1]
      do
        for _,v in ipairs(buttons[i][k])
        do
          dummyTable[v] = dummyTable[v] + 1
        end
        --print_table(dummyTable)
      end
      --[[
      if (inc1 == 10)
      then
        print("i is " .. i)
        print("r is: " .. inc1)
      end
      ]]--
    
      --print("comparing")
      if (not(tableNotEqual(dummyTable,joltageRequirements[i])))
      then
        --print("test")
        table.insert(correctCombinations,t100[j1])
        bool = false
        --goto continue
      end
      j1 = j1 + 1
    end
    inc1 = inc1 + 1
  end
  --::continue::
  
  
  
end


--[[

tab = {1,2,2,2,4,4,4,5,6,6}
dummyTable = {0,0,0,0}
for _,k in ipairs(tab)
do
  print(k)
  for _,v in ipairs(buttons[1][k])
  do
    print(v)
    dummyTable[v] = dummyTable[v] + 1
  end
end
print_table(dummyTable)

]]--


print_table_table(correctCombinations)

sum = 0

for i = 1,#correctCombinations
do
  sum = sum + #correctCombinations[i]
end

print("answer is " .. sum)


--------------------------------------------------------------------------------------------------








