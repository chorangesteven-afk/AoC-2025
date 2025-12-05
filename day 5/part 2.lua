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

--------------------------------------------------------------------------------------------------
-- sepearate input by newline


for i in string.gmatch(input, "%C+") 
do
  table.insert(input_table,i)
end

--print_table(input_table)


--------------------------------------------------------------------------------------------------
-- separate ranges and ids

id_rangeTab = {}

for i = 1,#input_table
do
  if (string.find(input_table[i],"-") == nil)
  then
    goto continue
  else
    table.insert(id_rangeTab,input_table[i])
  end
  ::continue::
end

--print_table(id_rangeTab)


--------------------------------------------------------------------------------------------------

-- function: pass id range -> return first and last id as table

function id_range(str)
  local tempTable = {}
  for i in string.gmatch(str,'([^'..'-'..']+)') do
    --print(i)
    table.insert(tempTable,tonumber(i))
  end
  return tempTable
end

--------------------------------------------------------------------------------------------------

-- turn id range into a table of tables

for i = 1,#id_rangeTab
do
  id_rangeTab[i] = id_range(id_rangeTab[i])
end

--------------------------------------------------------------------------------------------------

print_table_table(id_rangeTab)

--------------------------------------------------------------------------------------------------

-- check if id is in a single range

function idIsInRange(id,rangeTab)
  --rangeTab[1] = tonumber(rangeTab[1])
  --rangeTab[2] = tonumber(rangeTab[2])
  --id = tonumber(id)
  --print("id is " .. id)
  --print("first is " .. rangeTab[1])
  --print("2nd is " .. rangeTab[2])
  if ((id >= rangeTab[1]) and (id <= rangeTab[2]))
  then
    --print("id " .. id .. " is less then or equal to  " .. rangeTab[2])
    --print("id " .. id .. " is greater than or equal to " .. rangeTab[1])
    return true
  else
    return false
  end
end

--------------------------------------------------------------------------------------------------

function entireIdRangeIsInOtherIdRange(idRange1,idRange2)
  -- if 1st value of 1st range is greater than or equal to 1st value of 2nd range
  -- and 
  -- 2nd value of 1st range is less than or equal to 2nd value of 2nd range
  if ((idRange1[1] >= idRange2[1]) and (idRange1[2] <= idRange2[2]))
  then
    return true
  else
    return false
  end
end

--------------------------------------------------------------------------------------------------

-- iterate through each id range
  -- compare id range to potentially every other id range
  -- 1st check if the entire id range is w/in the other id range -> set id range to zero, skip to next id range
  -- 2nd check if first id is in range -> change it accordingly
  -- 3rd check if second id is in range -> change accordingly
  -- 4th check if other range is contained w/in current range
  -- if none are true -> go to next range comparison

for i = 1,#id_rangeTab
do
  for j = i+1,#id_rangeTab
  do
    if entireIdRangeIsInOtherIdRange(id_rangeTab[i],id_rangeTab[j])
    then
      id_rangeTab[i] = {0,0}
      goto continue
    end
    if idIsInRange(id_rangeTab[i][1],id_rangeTab[j])
    then
      id_rangeTab[i][1] = id_rangeTab[j][2] + 1
    end
    if idIsInRange(id_rangeTab[i][2],id_rangeTab[j])
    then
      id_rangeTab[i][2] = id_rangeTab[j][1] - 1
    end
    if entireIdRangeIsInOtherIdRange(id_rangeTab[j],id_rangeTab[i])
    then
      id_rangeTab[j] = {0,0}
    end
  end
  ::continue::
end

print()
print()
print()
print()
print_table_table(id_rangeTab)


--------------------------------------------------------------------------------------------------

-- iterate through each id range
  -- insert into a table the differences between each range

differencesArr = {}

for i = 1,#id_rangeTab
do
  if ((id_rangeTab[i][1] == 0) and (id_rangeTab[i][2] == 0))
  then
    table.insert(differencesArr,0)
  elseif (id_rangeTab[i][1] ~= id_rangeTab[i][2])
  then
    table.insert(differencesArr,(id_rangeTab[i][2] - id_rangeTab[i][1]) + 1)
  elseif (id_rangeTab[i][1] == id_rangeTab[i][2])
  then
    table.insert(differencesArr,1)
  end
end

print_table(differencesArr)

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

--print("test " .. #differencesArr)
print("sum is " .. sumTable(differencesArr))

--------------------------------------------------------------------------------------------------

