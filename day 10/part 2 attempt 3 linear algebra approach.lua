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


sortByVal = function (entry1, entry2)
   return entry1.buttonVal < entry2.buttonVal
end

--------------------------------------------------------------------------------------------------

function leftmostNonZeroCol(M,r)
  for c = 1,#M[1]
  do
    for r = r,#M
    do
      if (M[r][c] ~= 0)
      then
        return r,c
      end
    end
  end
end

--------------------------------------------------------------------------------------------------


function swapRows(M,r1,r2)
  M[r1],M[r2] = M[r2],M[r1]
end

--------------------------------------------------------------------------------------------------


function addScalarRow(M,r1,s,r2)
  -- adds scalar of r1 to r2
  local dummyTable = table.table_copy(M[r1])
  for c = 1,#M[1]
  do
    dummyTable[c] = M[r1][c] * s
  end
  for c = 1,#M[1]
  do
    M[r2][c] = M[r2][c] + dummyTable[c]
  end
end


--------------------------------------------------------------------------------------------------


function eliminateAboveAndBelow(M,pr,pc)
  for r = 1,#M
  do
    if((r ~= pr) and (M[r][pc] ~= 0))
    then
      --print("eliminating " .. r .. " " .. pc .. " using row " .. pr)
      addScalarRow(M,pr,-M[r][pc],r)
    end
  end
  
end


--------------------------------------------------------------------------------------------------

function returnNextRow(tab)
  --if (tab[1] == nil)
  --then
    --print("returning 1")
    --return 1
  --end
  --print("returning: " .. tab[#tab] + 1)
  return tab[#tab] + 1
end

--------------------------------------------------------------------------------------------------

function onlyZeroRowsLeft(M,rs)
  for r = rs,#M
  do
    for c = 1,#M[1]
    do
      if (M[rs][c] ~= 0)
      then
        --print("there are nonzero rows left")
        return false
      end
    end
  end
  --print("only nonzero rows left")
  return true
end

--------------------------------------------------------------------------------------------------



function nonzeroInSameCol(M,rf,cf)
  for r = 1,#M
  do
    if (r ~= rf)
    then
      if (M[r][cf] ~= 0)
      then
        return true
      end
    end
  end
  return false
end

function nonzeroToTheLeft(M,rf,cf)
  for c = cf-1,1,-1
  do
    if (M[rf][c] ~= 0)
    then
      return true
    end
  end
  return false
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
  table.insert(joltageRequirements,{})
  for joltValues in string.gmatch(input_table[i],"%{[%d,]+%}")
  do
    --print(joltValues)
    local inc = 1
  
    --local individualJoltageTable = {}
    for num in string.gmatch(joltValues,"%d+")
    do
      --print(num)
      --table.insert(individualJoltageTable,tonumber(num))
      table.insert(joltageRequirements[i],{})
      joltageRequirements[i][inc].buttonNum = inc
      joltageRequirements[i][inc].buttonVal = tonumber(num)
      inc = inc + 1
    end
    --table.insert(joltageRequirements,individualJoltageTable)
  end
end


--[[

x100 = 1

print(#joltageRequirements)
print(#joltageRequirements[x100])

for i = 1,#joltageRequirements[x100]
do
  print("machine " .. x100)
  print("button number " .. joltageRequirements[x100][i].buttonNum)
  print("button value " .. joltageRequirements[x100][i].buttonVal)
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
print(#buttons[1])

for i = 1,#buttons[1]
do
  print_table(buttons[1][i])
end
]]--







--------------------------------------------------------------------------------------------------

matrix = {}

for r = 1,#joltageRequirements[1]
do
  table.insert(matrix,{})
  for c = 1,#buttons[1]+1
  do
    matrix[r][c] = 0
  end
end

--print_table_table(matrix)



for i = 1,#buttons[1]
do
  for j = 1,#buttons[1][i]
  do
    -- i is button number
    -- button 1 goes in 4th row, col 1
    -- button 2 go in 2,4th row, col 2
    matrix[buttons[1][i][j]][i] = 1
    
  end
end

for i = 1,#joltageRequirements[1]
do
  -- assings button counter values to last col of matrix
  matrix[i][#matrix[1]] = joltageRequirements[1][i].buttonVal
end

print()
print_table_table(matrix)



--------------------------------------------------------------------------------------------------



for i = 1,#joltageRequirements
do
  table.sort(joltageRequirements[i],sortByVal)
end



--[[
x100 = 1

print(#joltageRequirements)
print(#joltageRequirements[x100])

for i = 1,#joltageRequirements[x100]
do
  print("machine " .. x100)
  print("button number " .. joltageRequirements[x100][i].buttonNum)
  print("button value " .. joltageRequirements[x100][i].buttonVal)
end
]]--


function baselineDomains(jolt,buttonsf)
  local tab = {}
  for i = 1,#buttonsf
  do
    table.insert(tab,0)
  end
  for i = 1,#jolt
  do
    local tab2 = {}
    -- counter 1 is associated with 5 and 6
    for j = 1,#buttonsf
    do
      for k = 1,#buttonsf[j]
      do
        if (jolt[i].buttonNum == buttonsf[j][k])
        then
          if (tab[j] == 0)
          then
            --print("button " .. j .. " associated with counter " .. jolt[i].buttonNum)
            table.insert(tab2,j)
          end
        end
      end
    end
    
    for j = 1,#tab2
    do
      tab[tab2[j]] = jolt[i].buttonVal
    end
    
    --print_table(tab)
    
  end
  return tab
end


t101 = baselineDomains(joltageRequirements[1],buttons[1])
print()
print_table(t101)










--------------------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------------------


function rref(M)
  
  local dontChangeTheseRows = {0}
  
  --print_table_table(M)
  --print()
  
  local r1 = returnNextRow(dontChangeTheseRows)
  local r,c = leftmostNonZeroCol(M,r1)
  


  for c1 = c,#M[1]
  do
    local r1 = returnNextRow(dontChangeTheseRows)
    
    local r,c = leftmostNonZeroCol(M,r1)
    --print("r is " .. r)
    --print("c is " .. c)
    
    if (r ~= r1)
    then
      --print("swapping rows " .. r .. " with " .. r1)
      swapRows(M,r,r1)
    end
    
    
    --print_table_table(M)
    --print()
    
    local r,c = leftmostNonZeroCol(M,r1)
    --print("r is " .. r)
    --print("c is " .. c)
    
    eliminateAboveAndBelow(M,r,c)
    
    table.insert(dontChangeTheseRows,r1)
    
    local r1 = returnNextRow(dontChangeTheseRows)
    
    if (onlyZeroRowsLeft(M,r1))
    then
      break
    end
    
  end
end


rref(matrix)
print()
print_table_table(matrix)









--------------------------------------------------------------------------------------------------




function findBasicandFreeVar(M)
  local basicVar = {}
  local freeVar = {}
  
  
  for c = 1,#M[1]-1
  do
    for r = 1,#M
    do
      if (M[r][c] ~= 0)
      then
        if ((c == 1) and (M[r][c] == 1))
        then
          if (nonzeroInSameCol(M,r,c))
          then
            table.insert(freeVar,c)
            break
          else
            table.insert(basicVar,c)
            break
          end
        end
        if (M[r][c] ~= 1)
        then
          table.insert(freeVar,c)
          break
        end
        if (nonzeroInSameCol(M,r,c))
        then
          table.insert(freeVar,c)
          break
        end
        if (nonzeroToTheLeft(M,r,c))
        then
          table.insert(freeVar,c)
          break
        end
        if ((nonzeroInSameCol(M,r,c) == false) and (nonzeroToTheLeft(M,r,c) == false))
        then
          table.insert(basicVar,c)
        end
      end
    end
  end
  
  return basicVar,freeVar
  
  
end


local t1,t2 = findBasicandFreeVar(matrix)
print("basic var:")
print_table(t1)
print("free var:")
print_table(t2)
print("number of free var: " .. #t2)



















--------------------------------------------------------------------------------------------------


-- first check if no free variables -> solve normally















--------------------------------------------------------------------------------------------------








































