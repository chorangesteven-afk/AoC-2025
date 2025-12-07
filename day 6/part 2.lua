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
   -- print the substring
   table.insert(input_table,i)
end

operators = input_table[#input_table]
operatorsTable = {}

for i in string.gmatch(operators, "%S+")
do
 table.insert(operatorsTable,i)
end

print_table(operatorsTable)
print("number of operators " .. #operatorsTable)
--print_table(input_table)
print("test " .. #input_table)
--print(input_table[3])

print(#input_table[1])
print(#input_table[2])
print(#input_table[3])
print(#input_table[4])
--print(#input_table[5])
--print(string.sub(input_table[1], 1,1))

--------------------------------------------------------------------------------------------------

-- go char by char (col by col)
-- skip every multiple of 5 (blank columns) - wrong
-- check if the entire column is blank
-- if its a space, do nothing
-- o.w. insert into table like a stack
-- after the last row of numbers, convert the table to a string


function columnIsBlank(tab,col)
  local bool = true
  for i = 1,#tab-1
  do
    if (string.sub(tab[i], col,col) ~= " ")
    then
      bool = false
    end
  end
  return bool
end


Values = {}
lastSetOfValues = {}
x = #input_table

for i = 1,#input_table[1]
do
  if (columnIsBlank(input_table,i))
  then
    table.insert(Values,lastSetOfValues)
    lastSetOfValues = {}
    --inc = inc + 1
    --print("i is: " .. i)
    goto continue
  else
    
    local colValue = {}
    
    for j = 1,#input_table-1
    do
      if (string.sub(input_table[j], i,i) == " ")
      then
        goto test
      else
        table.insert(colValue,string.sub(input_table[j], i,i))
        --print_table(colValue)
      end
      ::test::
    end
    --print(inc)
    colValue = tonumber(table.concat(colValue))
    table.insert(lastSetOfValues,colValue)
  end
  ::continue::
end

table.insert(Values,lastSetOfValues)


--------------------------------------------------------------------------------------------------

--print_table(Values[1])
--print(Values[1][1] + Values[1][2] + Values[1][3])
print_table_table(Values)

print("number of values " .. #Values)
--print("aaaaaaaaaaaaaaaaa" .. Values[200])

--------------------------------------------------------------------------------------------------


function productTable(tab,operator)
  local out = 1
  
  for i = 1,#tab
  do
    out = out * tab[i]
  end
  return out
end

function sumTable(tab)
  local sum = 0
  for i = 1,#tab
  do
    sum = sum + tab[i]
  end
  return sum
end

results = {}

for i = 1,#operatorsTable
do
  if operatorsTable[i] == "*"
  then
    --print(i)
    table.insert(results,productTable(Values[i]))
  end
  if operatorsTable[i] == "+"
  then
    --print(i)
    table.insert(results,sumTable(Values[i]))
  end
end

print_table(results)

--------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------

print("sum is " .. sumTable(results))

