
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

-- gmatch


function table.table_copy(t)
   local t2 = {}
   -- iterate the array
   for k,v in pairs(t) 
   do
      t2[k] = v
   end
   return t2
end

sortByVal = function (entry1, entry2)
   return entry1.buttonVal < entry2.buttonVal
end

table.sort(test,sortByVal)
-- quicksort: https://github.com/chorangesteven-afk/AoC-2025/blob/c6fc4dc8442ad44334af6251809fe7edbfaa814d/day%208/part%201%20attempt%202.lua


function valNotInTable(tab,val)
  for i = 1,#tab
  do
    if (tab[i] == val)
    then
      return false
    end
  end
  return true
end
