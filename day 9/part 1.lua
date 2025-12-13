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

--print_table_table(input_table_table)
--print(input_table_table[1][2])

--------------------------------------------------------------------------------------------------

function returnArea(x1,y1,x2,y2)
  local side1 = math.abs(x2-x1) + 1
  --if (side1 == 0)
  --then
    --side1 = 1
  --end
  local side2 = math.abs(y2-y1) + 1
  --if (side2 == 0)
  --then
    --side2 = 1
  --end
  local area = side1 * side2
  --print(area)
  return area
end

--------------------------------------------------------------------------------------------------

currentMax = 0

for i = 1,#input_table_table
do
  for j = i+1,#input_table_table
  do
    local area = returnArea(input_table_table[i][1],input_table_table[i][2],input_table_table[j][1],input_table_table[j][2])
    if (area > currentMax)
    then
      currentMax = area
    end
  end
end

print(currentMax)

--------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------
