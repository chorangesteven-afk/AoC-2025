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

--------------------------------------------------------------------------------------------------


input = io.read("*a")

input_table = {}

-- splits input by newline
for i in string.gmatch(input, "%C+") do
   -- print the substring
   table.insert(input_table,i)
end

print_table(input_table)
print("number of rows: " .. #input_table)

-- convert to 2d table

input_table_table = {}

for i = 1,#input_table
do
  table.insert(input_table_table,sepString(input_table[i]))
end

print_table_table(input_table_table)
print(#input_table_table[1])

--------------------------------------------------------------------------------------------------
-- iterate row by row
  -- iterate col by col
  -- update beam accordingly
    -- check if there's an S on the same col one row above
    -- if the curr value is a splitter and there's a beam above it -> add two beams to the side
    -- if the curr values is empty space and there's a beam above it -> curr value becomes a beam
    
    
  -- increment everytime the beam is split
  -- no splitters on final row

inc = 0
  
for i = 2,#input_table
do
  for j = 1,#input_table_table[1]
  do
    
    if (input_table_table[i-1][j] == "S")
    then
      input_table_table[i][j] = 1
    end
    if ((input_table_table[i][j] == "^") and (input_table_table[i-1][j] == 1))
    then
      inc = inc + 1
      input_table_table[i][j-1] = 1
      input_table_table[i][j+1] = 1
    end
    if ((input_table_table[i][j] == ".") and (input_table_table[i-1][j] == 1))
    then
      input_table_table[i][j] = 1
    end
  end
end

print_table_table(input_table_table)

--------------------------------------------------------------------------------------------------

print("beam split " .. inc .. " times")
