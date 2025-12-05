--------------------------------------------------------------------------------------------------

function print_table(table)
  for i=1,#table
  do
    io.write(table[i] .. " ")
  end
  print()
end

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
--input

input = io.read("*a")


--print(input)

input_table = {}

--------------------------------------------------------------------------------------------------
-- sepearate input by newline


for i in string.gmatch(input, "%C+") 
do
  table.insert(input_table,i)
end

--------------------------------------------------------------------------------------------------
-- convert 1D table into 2D

for i = 1,#input_table
do
  input_table[i] = sepString(input_table[i])
end


--------------------------------------------------------------------------------------------------

function returnCell(tab,R,C)
  return tab[R][C]
end

--------------------------------------------------------------------------------------------------
-- returns 8 adj cells as a table

function generateEightAdjCellTable(funcTab,currRow,currCol)
  -- current cell will be set to zero
  -- no roll ->  set to zero
  -- roll -> set to one
  -- nil (outside bounds of table) -> set to zero
  
  local cellTable = {{},{},{}}
  
  --[[
  print(funcTab[currRow-1][currCol-1])
  cellTable[1][1] = funcTab[currRow-1][currCol-1]
  cellTable[1][2] = funcTab[currRow-1][currCol]
  cellTable[1][3] = funcTab[currRow-1][currCol+1]
  cellTable[2][1] = funcTab[currRow][currCol-1]
  cellTable[2][2] = 0
  cellTable[2][3] = funcTab[currRow][currCol+1]
  cellTable[3][1] = funcTab[currRow+1][currCol-1]
  cellTable[3][2] = funcTab[currRow+1][currCol]
  cellTable[3][3] = funcTab[currRow+1][currCol+1]
  ]]--

  for i = -1,1
  do
    for j = -1,1
    do
      if (pcall(returnCell,funcTab,currRow+i,currCol+j) == false)
      then
        cellTable[i+2][j+2] = 0
        goto continue
      elseif funcTab[currRow+i][currCol+j] == "."
      then
        cellTable[i+2][j+2] = 0
      elseif funcTab[currRow+i][currCol+j] == "@"
      then
        -- funcTab[][] == "@"
        cellTable[i+2][j+2] = 1
      else
        cellTable[i+2][j+2] = 0
      end
      ::continue::
      --print("curr value is " .. cellTable[i+2][j+2])
    end
  end
  
  
  cellTable[2][2] = 0
  
  return cellTable
end

--------------------------------------------------------------------------------------------------
-- is roll valid function

function isRollValid(funcTab,currRow,currCol)
  -- generate table
  -- count the number of ones in the table
  -- compare to 4
  
  local idkTable = generateEightAdjCellTable(funcTab,currRow,currCol)
  
  local inc = 0
  
  for i = 1,3
  do
    for j = 1,3
    do
      if idkTable[i][j] == 1
      then
        inc = inc + 1
      end
    end
  end
  
  if inc < 4
  then
    return true
  else
    return false
  end
  
  
  
end




--------------------------------------------------------------------------------------------------
-- function that returns bool if valid roll exists or not

function validRollExists(tab)
  for i = 1,#tab
  do
    for j = 1,#tab[1]
    do
      if tab[i][j] == "@"
      then
        if isRollValid(tab,i,j)
        then
          return true
        end
      end
    end
  end
  return false
end
--------------------------------------------------------------------------------------------------

function numberOfValidRolls(tab)
  
  local numberOfValidRolls = 0


  for i = 1,#tab
  do
    for j = 1,#tab[1]
    do
      if tab[i][j] == "@"
      then
        if isRollValid(tab,i,j)
        then
          numberOfValidRolls = numberOfValidRolls + 1
        end
      end
    end
  end
  
  return numberOfValidRolls
end


--------------------------------------------------------------------------------------------------

function validRollIndices(tab)
  
  local indexTable = {}
  
  for i = 1,#tab
  do
    for j = 1,#tab[1]
    do
      if tab[i][j] == "@"
      then
        if isRollValid(tab,i,j)
        then
          table.insert(indexTable,{i,j})
        end
      end
    end
  end
  
  return indexTable
end

--------------------------------------------------------------------------------------------------


function removeValidRolls(tab, indTab)
  
  for i = 1,#indTab
  do
    tab[indTab[i][1]][indTab[i][2]] = "."
  end
  
  return tab
end


--------------------------------------------------------------------------------------------------


-- while there's a valid roll -> loop
  -- record the number of valid rolls
  -- mark valid rolls
  -- remove valid rolls

rollsRemoved = 0

while validRollExists(input_table)
do
  --print("test")
  rollsRemoved = numberOfValidRolls(input_table) + rollsRemoved
  input_table = removeValidRolls(input_table, validRollIndices(input_table))
end



--------------------------------------------------------------------------------------------------

print(rollsRemoved)
