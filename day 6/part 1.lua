--------------------------------------------------------------------------------------------------

function print_table(table)
  for i=1,#table
  do
    io.write(table[i] .. " ")
  end
  print()
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
--print(#input_table)

-- right now the table is made of 5 strings
-- split each string into its own table

input_table_table = {{},{},{},{},{}}

for i = 1,#input_table
do
  for j in string.gmatch(input_table[i], "%S+")
  do
   table.insert(input_table_table[i],j)
  end
end

print_table(input_table_table[5])
--print(#input_table_table[5])

--------------------------------------------------------------------------------------------------
-- perform the appropiate operation on each column

column_output = {}

for i = 1,1000
do
  if input_table_table[5][i] == "+"
  then
    local output = input_table_table[1][i] + input_table_table[2][i] + input_table_table[3][i] + input_table_table[4][i]
    table.insert(column_output,output)
  end
  if input_table_table[5][i] == "*"
  then
    local output = input_table_table[1][i] * input_table_table[2][i] * input_table_table[3][i] * input_table_table[4][i]
    table.insert(column_output,output)
  end
end

--------------------------------------------------------------------------------------------------

print_table(column_output)
print(#column_output)
print(column_output[1])

--------------------------------------------------------------------------------------------------

function sumTable(tab)
  local sum = 0
  for i = 1,#tab
  do
    sum = sum + tab[i]
  end
  return sum
end

--------------------------------------------------------------------------------------------------

print("sum is " .. sumTable(column_output))
