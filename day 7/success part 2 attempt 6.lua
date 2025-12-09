-- dont save anything approach (kind've)
-- store the beam count of each cell
-- if a splitter is hit increases the beam count of the adj cells by 1
-- if a beam count of 2 hits a splitter that creates 4 timelines (twice for each beam count), increases the adj beam counts by n

-- problem is that is what iterating through each timeline 1 by 1 and there's like ~4*10^14 timelines
-- go at it in a way where you only scan the input once

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

print("number of rows " .. #input_table_table)
print("number of col " .. #input_table_table[1])
--input_table_table[2][8] = 1
--print_table_table(input_table_table)




--------------------------------------------------------------------------------------------------

cellBeamCount = {{}}

for i = 1,#input_table_table
do
  cellBeamCount[i] = {}
  for j = 1,#input_table_table[1]
  do
    cellBeamCount[i][j] = 0
  end
end

--print_table_table(cellBeamCount)
--print(#cellBeamCount)
--print(#cellBeamCount[1])

timelineCounter = 1

for i = 2,#input_table_table
do
  --print("row is " .. i)
  for j = 1,#input_table_table[1]
  do
    if (input_table_table[i-1][j] == "S")
    then
      cellBeamCount[i][j] = cellBeamCount[i][j] + 1
    end
    if ((input_table_table[i][j] == "^") and (cellBeamCount[i-1][j] >= 1))
    then
      
      local numOfNewTimelinesCreated = cellBeamCount[i-1][j]
      --print("num of new timelines " .. numOfNewTimelinesCreated)
      timelineCounter = timelineCounter + numOfNewTimelinesCreated
      --print()
      cellBeamCount[i][j-1] = cellBeamCount[i][j-1] + cellBeamCount[i-1][j]
      cellBeamCount[i][j+1] = cellBeamCount[i][j+1] + cellBeamCount[i-1][j]
      
    end
    if ((input_table_table[i][j] == ".") and (cellBeamCount[i-1][j] >= 1))
    then
      cellBeamCount[i][j] = cellBeamCount[i][j] + cellBeamCount[i-1][j]
    end
  end
end

print(timelineCounter)
--print_table_table(cellBeamCount)

--------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------

