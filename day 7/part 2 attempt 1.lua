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

-- turns string into table of strings/characters

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

--------------------------------------------------------------------------------------------------


input = io.read("*a")

input_table = {}

-- splits input by newline
for i in string.gmatch(input, "%C+") do
   -- print the substring
   table.insert(input_table,i)
end

--print_table(input_table)
--print("number of rows: " .. #input_table)

-- convert to 2d table

input_table_table = {}

for i = 1,#input_table
do
  table.insert(input_table_table,sepString(input_table[i]))
end

--print_table_table(input_table_table)
--print(#input_table_table[1])

--------------------------------------------------------------------------------------------------

-- iterate timeline by timeline
  -- iterate row by row
    -- iterate col by col
    -- update beam accordingly
      -- check if there's an S on the same col one row above
      -- if the curr value is a splitter and there's a beam above it -> create a new timeline
        -- 1st timeline beam goes to the left
        -- 2nd timeline beam goes to the right
        -- copy the table but with the beam on the right side, insert into input3DTable
      -- if the curr values is empty space and there's a beam above it -> curr value becomes a beam
    
    
    -- increment everytime the beam is split
    -- no splitters on final row

input3DTable = {}
table.insert(input3DTable,input_table_table)
--inc = 0
--print(#input3DTable[1][2])


for i = 1,1
do
  for j = 2,#input3DTable[i]
  do
    for k = 1,#input3DTable[i][j]
    do
      --print("col is: " .. k)
      if (input3DTable[i][j-1][k] == "S")
      then
        input3DTable[i][j][k] = 1
      end
      if ((input3DTable[i][j][k] == "^") and (input3DTable[i][j-1][k] == 1))
      then
        
        --inc = inc + 1
        input3DTable[i][j][k+1] = 1
        --print("timeline is: " .. i)
        --print("row is: " .. j)
        local test = {}
        for l = 1,#input3DTable[i]
        do
          table.insert(test,table.table_copy(input3DTable[i][l]))
        end
        table.insert(input3DTable,test)
        input3DTable[i][j][k+1] = "."
        input3DTable[i][j][k-1] = 1
        --print_table_table(test)
        
        
      end
      if ((input3DTable[i][j][k] == ".") and (input3DTable[i][j-1][k] == 1))
      then
        input3DTable[i][j][k] = 1
      end
    end
  end
end

--------------------------------------------------------------------------------------------------

function beamInFinalRow(table)
  for k = 1,#table
  do
    if (table[k] == 1)
    then
      --print("true")
      return true
    end
  end
  return false
end
--------------------------------------------------------------------------------------------------


-- the same as any beam to the left of a splitter == false
function everyBeamToTheRightOfASplitter(t1,t2)
  local bool = true
  --print("ahh")
  --print_table_table(t1)
  --print_table(t2)
  for _, v in ipairs(t2)
  do
    --print(_,v)
    for k = 1,#t1[1]
    do
      --print(t1[v][k])
      if ((t1[v][k] == 1) and (t1[v][k+1] == "^"))
      then
        bool = false
        --print("test")
      end
    end
  end
  return bool
end

--------------------------------------------------------------------------------------------------

function everyRowWithSplitter(t)
  ahhhhh = {}
  for j = 2,#t
  do
    for k = 1,#t[j]
    do
      if (t[j][k] == "^")
      then
        table.insert(ahhhhh,j)
        goto continue
      end
    end
    ::continue::
  end
  --print_table(ahhhhh)
  return ahhhhh
end
--------------------------------------------------------------------------------------------------
-- on every row that has a splitter, every beam is to the right of the splitter

function finalTimeline(t)
  --print()
  --print_table_table(t)
  for j = 2,#t
  do
    for k = 1,#t[j]
    do
      if ((t[j][k] == "^") and (t[j][k-1] == 1))
      then
        --print("false")
        return false
      end
      if (beamInFinalRow(t[#t]) == false)
      then
        --print("false")
        return false
      end
      if ((beamInFinalRow(t[#t])) and (everyBeamToTheRightOfASplitter(t,everyRowWithSplitter(t))))
      then
        --print("true")
        return true
      end
    end
  end
end

--print(finalTimeline(input3DTable[2]))

--------------------------------------------------------------------------------------------------

function highestRow(t)
  for i = #t,1,-1
  do
    for j = 1,#t[1]
    do
      if (t[i][j] == 1)
      then
        --print("i is " .. i)
        return i
      end
    end
  end
end

--------------------------------------------------------------------------------------------------

currentTimeline = 2

while (finalTimeline(input3DTable[currentTimeline-1]) == false)
do
  --print("timeline is: " .. currentTimeline)
  for j = highestRow(input3DTable[currentTimeline])+1,#input3DTable[currentTimeline]
  do
    for k = 1,#input3DTable[currentTimeline][j]
    do
      --print("col is: " .. k)
      --[[
      if (input3DTable[currentTimeline][j-1][k] == "S")
      then
        input3DTable[currentTimeline][j][k] = 1
      end
      ]]--
      if ((input3DTable[currentTimeline][j][k] == "^") and (input3DTable[currentTimeline][j-1][k] == 1))
      then
        
        --inc = inc + 1
        input3DTable[currentTimeline][j][k+1] = 1
        --print("timeline is: " .. currentTimeline)
        --print("row is: " .. j)
        local test = {}
        for l = 1,#input3DTable[currentTimeline]
        do
          table.insert(test,table.table_copy(input3DTable[currentTimeline][l]))
        end
        table.insert(input3DTable,test)
        input3DTable[currentTimeline][j][k+1] = "."
        input3DTable[currentTimeline][j][k-1] = 1
        --print_table_table(test)
        
        
      end
      if ((input3DTable[currentTimeline][j][k] == ".") and (input3DTable[currentTimeline][j-1][k] == 1))
      then
        input3DTable[currentTimeline][j][k] = 1
      end
    end
  end
  currentTimeline = currentTimeline + 1
end


--------------------------------------------------------------------------------------------------

--print("timeline 1:")
--print_table_table(input3DTable[1])
--print("timeline 8:")
--print_table_table(input3DTable[40])
print(#input3DTable)

--------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------

