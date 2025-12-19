
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

function table.table_copy(t)
   local t2 = {}
   -- iterate the array
   for k,v in pairs(t) 
   do
      t2[k] = v
   end
   return t2
end


--[[
test = {
  {0,0,0,0,1,1,3},
  {0,1,0,0,0,1,5},
  {0,0,1,1,1,0,4},
  {1,1,0,1,0,0,7}
}
]]--



test = {
  {0,1,1,1,1,0,0,0,0,1,0,1,63},
  {1,0,0,0,1,1,0,0,1,0,0,1,48},
  {1,1,1,1,1,1,0,0,0,0,1,0,62},
  {0,1,0,1,0,0,0,0,0,0,1,1,31},
  {1,0,0,1,1,0,0,0,1,1,1,1,52},
  {1,0,1,0,1,1,0,1,1,0,0,1,81},
  {0,1,0,0,1,1,0,0,1,0,0,0,57}, 
  {1,0,0,0,1,0,1,1,0,1,0,1,60},
  {1,1,0,0,1,0,0,0,1,1,0,1,65}, 
  {1,1,1,0,1,0,0,1,0,0,1,1,82}
}

--[[
test = {
  {0,0,0,0},
  {1,0,1,0},
  {0,0,0,0},
}
]]--
--[[
test = {
  {1,0,1,1,0,7},
  {0,0,0,1,1,5},
  {1,1,0,1,1,12},
  {1,1,0,0,1,7},
  {1,0,1,0,1,2}
}
]]--


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
  test[r1],test[r2] = test[r2],test[r1]
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


function scaleRow(M,r,s)
  for c = 1,#M[1]
  do
    M[r][c] = math.ceil(M[r][c] * s)
  end
end

--scaleRow(test,1,)



--------------------------------------------------------------------------------------------------


function eliminateAboveAndBelow(M,pr,pc)
  for r = 1,#M
  do
    if((r ~= pr) and (M[r][pc] ~= 0))
    then
      print("eliminating " .. r .. " " .. pc .. " using row " .. pr)
      print(-M[r][pc])
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
  print("returning: " .. tab[#tab] + 1)
  return tab[#tab] + 1
end

--------------------------------------------------------------------------------------------------

function onlyZeroRowsLeft(M,rs)
  for r = rs,#M
  do
    for c = 1,#M[1]
    do
      if (M[r][c] ~= 0)
      then
        print("there are nonzero rows left")
        return false
      end
    end
  end
  print("only nonzero rows left")
  return true
end

--------------------------------------------------------------------------------------------------


function rref(M)
  
  local dontChangeTheseRows = {0}
  
  print_table_table(M)
  print()
  
  local r1 = returnNextRow(dontChangeTheseRows)
  local r,c = leftmostNonZeroCol(M,r1)
  


  for c1 = c,#M[1]
  do
    local r1 = returnNextRow(dontChangeTheseRows)
    
    local r,c = leftmostNonZeroCol(M,r1)
    print("r is " .. r)
    print("c is " .. c)
    
    if (M[r][c] ~= 1)
    then
      scaleRow(M,r,(1/M[r][c]))
    end
    
    
    if (r ~= r1)
    then
      print("swapping rows " .. r .. " with " .. r1)
      swapRows(M,r,r1)
    end
    
    
    print_table_table(M)
    print()
    
    local r,c = leftmostNonZeroCol(M,r1)
    print("r is " .. r)
    print("c is " .. c)
    
    
    
    eliminateAboveAndBelow(test,r,c)
    
    table.insert(dontChangeTheseRows,r1)
    
    local r1 = returnNextRow(dontChangeTheseRows)
    
    if (onlyZeroRowsLeft(M,r1))
    then
      break
    end
    
  end
  


  print()
  print_table_table(test)

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
end


rref(test)

-- basic
  -- must be a 1
  -- zero everywhere else in the same colum
  -- zero to the left of the one
-- free
  -- multiple nonzero values in the same col
  -- value that isn't a 1 or 0

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


local t1,t2 = findBasicandFreeVar(test)

print("basic var:")
print_table(t1)
print("free var:")
print_table(t2)
print(#t2)









-- first check if no free variables -> solve normally





























