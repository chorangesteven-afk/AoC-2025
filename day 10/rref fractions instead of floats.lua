
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



function print_fractional_matrix(M)
  for r = 1,#M
  do
    for c = 1,#M[1]
    do
      if (M[r][c][2] == 1)
      then
        io.write(string.format("%d",M[r][c][1]))
        io.write(" | ")
      else
        io.write(string.format("%d %s %d",M[r][c][1],"/",M[r][c][2]))
        io.write(" | ")
      end
    end
    print()
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


function tableEqual(t1,t2)
  for i = 1,#t1
  do
    if (t1[i] ~= t2[i])
    then
      return false
    end
  end
  return true
end

--------------------------------------------------------------------------------------------------

function changeToFractions(M)
  for r = 1,#M
  do
    for c = 1,#M[1]
    do
      local tab = {M[r][c],1}
      M[r][c] = tab
    end
  end
end


--------------------------------------------------------------------------------------------------

function leftmostNonZeroCol(M,r)
  for c = 1,#M[1]
  do
    for r = r,#M
    do
      if (M[r][c][1] ~= 0)
      then
        return r,c
      end
    end
  end
end

--------------------------------------------------------------------------------------------------


function scaleRow(M,r,s)
  for c = 1,#M[1]
  do
    M[r][c][1] = M[r][c][1] * s[1]
    M[r][c][2] = M[r][c][2] * s[2]
    if ((M[r][c][2] < 0) and (M[r][c][1] > 0))
    then
      M[r][c][1] = M[r][c][1] * (-1)
      M[r][c][2] = M[r][c][2] * (-1)
    end
    if ((M[r][c][1] % M[r][c][2]) == 0)
    then
      M[r][c][1] = math.ceil(M[r][c][1] / M[r][c][2])
      M[r][c][2] = 1
    end
  end
end

--------------------------------------------------------------------------------------------------

function swapRows(M,r1,r2)
  M[r1],M[r2] = M[r2],M[r1]
end






--------------------------------------------------------------------------------------------------



function addTwoFractions(f1,f2)
  print("adding:")
  print_table(f1)
  print("to:")
  print_table(f2)
  local d1 = f1[2]
  local d2 = f2[2]
  local resF = {}
  
  f1[1] = f1[1] * d2
  f2[1] = f2[1] * d1
  
  
  resF[1] = f1[1] + f2[1]
  resF[2] = f2[2] * d1
  print("resulted in:")
  print_table(resF)
  --if ((resF[1] % resF[2]) == 0)
  --then
    --print("test")
    --resF[1] = math.ceil(resF[1] / resF[2])
    --resF[2] = 1
  --end
  reduceFraction(resF)
  print("reduced fraction:")
  print_table(resF)
  return resF
end



function addScalarRow(M,r1,s,r2)
  -- adds scalar of r1 to r2
  local dummyTable = {}
  local dummyTable2 = {}
  for i = 1,#M[r1]
  do
    table.insert(dummyTable,table.table_copy(M[r1][i]))
    table.insert(dummyTable2,table.table_copy(M[r2][i]))
  end
  
  --local dummyTable = table.table_copy(M[r1])
  --local dummyTable2 = table.table_copy(M[r2])
  for i = 1,#dummyTable
  do
    dummyTable[i][1] = dummyTable[i][1] * s[1]
    dummyTable[i][2] = dummyTable[i][2] * s[2]
  end
  print("table 1")
  print_table_table(dummyTable)
  print("table 2")
  print_table_table(dummyTable2)
  for c = 1,#M[1]
  do
    M[r2][c] = addTwoFractions(dummyTable2[c],dummyTable[c])
    --M[r2][c] = M[r2][c] + dummyTable[c]
  end
  print_fractional_matrix(M)
end





--------------------------------------------------------------------------------------------------


function eliminateAboveAndBelow(M,pr,pc)
  for r = 1,#M
  do
    if((r ~= pr) and (M[r][pc][1] ~= 0))
    then
      print("eliminating " .. r .. " " .. pc .. " using row " .. pr)
      local s = {-M[r][pc][1],M[r][pc][2]}
      print_table(s)
      print()
      addScalarRow(M,pr,s,r)
    end
  end
end


--------------------------------------------------------------------------------------------------

function onlyZeroRowsLeft(M,rs)
  for r = rs,#M
  do
    for c = 1,#M[1]
    do
      if (M[r][c][1] ~= 0)
      then
        print("there are nonzero rows left")
        return false
      end
    end
  end
  print("only nonzero rows left")
  return true
end

function euclid(f)
  if (f[1] > f[2])
  then
    local result = f[1]
    local result2 = f[2]
    while true
    do
      while (result >= result2)
      do
        result = result - result2
        --print("result is " .. result)
        if (result == 0)
        then
          return true,result2
        end
        if (result < 0)
        then
          return false
        end
        --print("result2 is " .. result2)
      end
      local dum = result2
      result2 = result
      --print("reuslt2 " .. result2)
      result = dum
      --print("result " .. result)
      --result,result2 = result2,result
    end
  
  end
  if (f[1] < f[2])
  then
    local result = f[2]
    local result2 = f[1]
    while true
    do
      while (result >= result2)
      do
        result = result - result2
        --print("result is " .. result)
        if (result == 0)
        then
          return true,result2
        end
        if (result < 0)
        then
          return false
        end
        --print("result2 is " .. result2)
      end
      local dum = result2
      result2 = result
      --print("reuslt2 " .. result2)
      result = dum
      --print("result " .. result)
      --result,result2 = result2,result
    end
  
  end
end

--print(euclid(test))

function reduceFraction(f)
  --print("test")
  if (f[1] ~= 0)
  then
    --print("test2")
    local bool10 = true
    
    if (f[1] < 0)
    then
      -- num is negative
      print("negative")
      f[1] = f[1] * -1
      bool10 = false
    end
    print_table(f)
    local bool = true
    local two = 1
    if (f[1] ~= f[2])
    then
      bool,two = euclid(f)
    else
      bool = true
      two = 1
    end
    print(bool)
    if (bool)
    then
      if (bool10)
      then
        print("didn't re-negate")
        f[1] = math.ceil(f[1] / two)
        f[2] = math.ceil(f[2] / two)
      else
        print("re-negate")
        f[1] = -1 * math.ceil(f[1] / two)
        f[2] = math.ceil(f[2] / two)
      end
    else
      return f
    end
  end
  --("test3")
  return f
end

function fixUp(M)
  for r = 1,#M
  do
    for c = 1,#M[1]
    do
      if ((M[r][c][1] == 0) and (M[r][c][2] ~= 1))
      then
        M[r][c][2] = 1
      end
      
      if ((M[r][c][1] % M[r][c][2]) == 0)
      then
        M[r][c][1] = math.ceil(M[r][c][1] / M[r][c][2])
        M[r][c][2] = 1
      end
      
      reduceFraction(M[r][c])
      
    end
  end
end











--------------------------------------------------------------------------------------------------

--[[
test = {
  {0,0,0,0,1,1,3},
  {0,1,0,0,0,1,5},
  {0,0,1,1,1,0,4},
  {1,1,0,1,0,0,7}
}
]]--


--[[
test = {
  {0,1,1,200},
  {1,1,0,19},
  {1,0,1,207},
  {1,0,1,207}
}
]]--



test = {
  {0,0,1,0,0,0,1,1,0,1,48},
  {1,1,0,0,0,1,0,0,0,0,31},
  {0,0,1,1,1,1,0,0,0,1,52},
  {0,1,0,0,0,1,0,0,1,0,26},
  {0,1,0,0,1,0,0,1,0,0,20},
  {1,0,0,1,1,0,1,0,1,1,57}, 
  {1,0,0,0,0,1,0,0,1,0,37}, 
  {0,1,0,0,1,0,1,1,0,0,26}
}

--[[
test = {
  {0,0,1,0,0,1,0,1,1,1,0,1,1,56},
  {1,0,0,1,0,1,1,1,0,1,1,0,0,67},
  {0,1,0,1,1,1,0,1,0,0,0,1,0,65},
  {0,0,0,0,1,1,0,1,0,0,0,1,1,39},
  {1,1,0,0,1,1,1,0,1,0,0,1,0,88},
  {0,0,0,1,1,0,1,1,0,0,1,0,1,65},
  {0,0,0,1,0,1,1,1,0,0,0,0,1,57},
  {0,0,1,0,1,1,1,1,0,1,0,1,1,64},
  {1,1,1,0,1,0,1,0,0,1,0,1,0,68},
  {0,0,1,0,0,0,1,1,0,0,0,0,1,34}
}
]]--



--------------------------------------------------------------------------------------------------




function rref(M)
  local dontChangeTheseRows = {0}
  
  print_table_table(M)
  print()
  
  
  changeToFractions(M)
  
  
  
  
  
  
  local r1 = returnNextRow(dontChangeTheseRows)
  local r,c = leftmostNonZeroCol(M,r1)
  
  
  
  
  
  for c1 = c,#M[1]
  do
    local r1 = returnNextRow(dontChangeTheseRows)
    
    local r,c = leftmostNonZeroCol(M,r1)
    print("r is " .. r)
    print("c is " .. c)
    
    if (not(tableEqual(M[r][c],{1,1})))
    then
      local s = {}
      if ((M[r][c][1] < 0) and (M[r][c][2] > 0))
      then
        s = {-M[r][c][2],-M[r][c][1]}
      else
        s = {M[r][c][2],M[r][c][1]}
      end
      --local s = {M[r][c][2],M[r][c][1]}
      print("scaling row " .. r .. " by ")
      print_table(s)
      scaleRow(M,r,s)
    end
    
    print()
    print_fractional_matrix(M)
    print()
    
    --print("r is " .. r)
    --print("r1 is " .. r1)
    if (r ~= r1)
    then
      print("swapping rows " .. r .. " with " .. r1)
      swapRows(M,r,r1)
    end
    
    
    print_fractional_matrix(M)
    print()
    
    local r,c = leftmostNonZeroCol(M,r1)
    print("r is " .. r)
    print("c is " .. c)
    
    
    eliminateAboveAndBelow(M,r,c)
    
    print_fractional_matrix(M)
    
    
    table.insert(dontChangeTheseRows,r1)
    
    
    local r1 = returnNextRow(dontChangeTheseRows)
    
    fixUp(M)
    
    if (onlyZeroRowsLeft(M,r1))
    then
      break
    end
    
    
    
  end

  
  print()
  print_fractional_matrix(M)

  
  
end



rref(test)




















