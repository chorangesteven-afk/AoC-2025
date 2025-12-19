--[[
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
this code is held together by the last of my sanity



wrote linear equation solver from scratch

used a table to represent fractions instead of messing with floats:
this was a mistake


















references:
Approach based on this post:
https://www.reddit.com/r/adventofcode/comments/1plzhps/2025_day_10_part_2_pivot_your_way_to_victory/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button

https://www.reddit.com/r/adventofcode/comments/1pl8nsa/2025_day_10_part_2_is_this_even_possible_without/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button

rref:
https://en.wikipedia.org/wiki/Gaussian_elimination#Example_of_the_algorithm
https://youtu.be/f1e2Zij6W3s?si=oFSIrO8g2sdCqxm2
https://youtu.be/WhH660cLDkA?si=2pos1M0JcHLkM9t4
https://youtu.be/mpimdNG9XsA?si=WaUGv04SwAscS7W8
https://www.deep-ml.com/problems/48?ref=yacinelearning
https://youtu.be/2j5Ic2V7wq4?si=PLg7WtptaZUXPz9q
https://youtu.be/HHCkV-0Hg8I?si=GHDUTwa3IQOZZWO7
https://youtu.be/DZJKDmAwynE?si=R8ePJDWDp3--8g-w
https://youtu.be/ShonVncOAB4?si=xWNLbDQV7cBu6rHP
calc:
https://planetcalc.com/8328/

euclid algo:
https://www.calculatorsoup.com/calculators/math/gcf.php


]]--












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

function table.table_copy(t)
   local t2 = {}
   -- iterate the array
   for k,v in pairs(t)
   do
      t2[k] = v
   end
   return t2
end

function sumTable(tab)
  local sum = 0
  for i = 1,#tab
  do
    sum = sum + tab[i]
  end
  return sum
end


sortByVal = function (entry1, entry2)
   return entry1.buttonVal < entry2.buttonVal
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

--------------------------------------------------------------------------------------------------

-- used in the rref algo to find the next row in the submatrix

function returnNextRow(tab)
  --print("returning: " .. tab[#tab] + 1)
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

-- are two fractions represented by tables equal

function fractionTableEqual(t1,t2)
  for i = 1,#t1
  do
    if (tableEqual(t1[i],t2[i]) == false)
    then
      return false
    end
  end
  return true

end
--------------------------------------------------------------------------------------------------

--changes the matrix to a matrix of fractions

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

-- find the pivot index for rref algo

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

-- scale a row by a scalar

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



function mulTwoFrac(f1,f2)
  local f11 = table.table_copy(f1)
  local f22 = table.table_copy(f2)
  local Fres = {}

  Fres[1] = f11[1] * f22[1]
  Fres[2] = f11[2] * f22[2]
  return Fres
end
--------------------------------------------------------------------------------------------------

function swapRows(M,r1,r2)
  M[r1],M[r2] = M[r2],M[r1]
end






--------------------------------------------------------------------------------------------------

-- used to find greatest common factor
-- was used to simplify fractions

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

-- simplified fractions

function reduceFraction(f)
  --print("test")
  if (f[1] ~= 0)
  then
    --print("test2")
    local bool10 = true

    if (f[1] < 0)
    then
      -- num is negative
      --print("negative")
      f[1] = f[1] * -1
      bool10 = false
    end
    --print_table(f)
    local bool = true
    local two = 1
    if (f[1] ~= f[2])
    then
      bool,two = euclid(f)
    else
      bool = true
      two = 1
    end
    --print(bool)
    if (bool)
    then
      if (bool10)
      then
        --print("didn't re-negate")
        f[1] = math.ceil(f[1] / two)
        f[2] = math.ceil(f[2] / two)
      else
        --print("re-negate")
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


function addTwoFractions(f1,f2)
  local d1 = f1[2]
  local d2 = f2[2]
  local resF = {}

  f1[1] = f1[1] * d2
  f2[1] = f2[1] * d1


  resF[1] = f1[1] + f2[1]
  resF[2] = f2[2] * d1
  reduceFraction(resF)
  return resF
end

-- subtract fractions

function subTwoFractions(f1,f2)
  local d1 = f1[2]
  local d2 = f2[2]
  local resF = {}

  f1[1] = f1[1] * d2
  f2[1] = f2[1] * d1


  resF[1] = f1[1] - f2[1]
  resF[2] = f2[2] * d1
  return resF
end

-- is f1 (fraction 1) less fraction 2

function f1LessThanf2(f1,f2)
  local one = f1[1] / f1[2]
  local two = f2[1] / f2[2]
  if (one < two)
  then
    return true
  else
    return false
  end
end

-- add a scalar of row 1 to row2

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
  --print("table 1")
  --print_table_table(dummyTable)
  --print("table 2")
  --print_table_table(dummyTable2)
  for c = 1,#M[1]
  do
    M[r2][c] = addTwoFractions(dummyTable2[c],dummyTable[c])
    --M[r2][c] = M[r2][c] + dummyTable[c]
  end
  --print_fractional_matrix(M)
end





--------------------------------------------------------------------------------------------------

-- used in the rref algo to elimiate values above and below the pivot point

function eliminateAboveAndBelow(M,pr,pc)
  for r = 1,#M
  do
    if((r ~= pr) and (M[r][pc][1] ~= 0))
    then
      --print("eliminating " .. r .. " " .. pc .. " using row " .. pr)
      local s = {-M[r][pc][1],M[r][pc][2]}
      --print_table(s)
      --print()
      addScalarRow(M,pr,s,r)
    end
  end
end


--------------------------------------------------------------------------------------------------

-- used in rref algo
-- checks if all the remaining rows in the matrix are zero

function onlyZeroRowsLeft(M,rs)
  for r = rs,#M
  do
    for c = 1,#M[1]
    do
      if (M[r][c][1] ~= 0)
      then
        --print("there are nonzero rows left")
        return false
      end
    end
  end
  --print("only nonzero rows left")
  return true
end

--------------------------------------------------------------------------------------------------

-- fixes somes things in the rref matrix

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

    end
  end
end


--------------------------------------------------------------------------------------------------




function rref(M)
  local dontChangeTheseRows = {0}

  --print_table_table(M)
  --print()


  changeToFractions(M)




-- r1 is the first row the submatrix that can be modified

  local r1 = returnNextRow(dontChangeTheseRows)

	-- pivot index
	
  local r,c = leftmostNonZeroCol(M,r1)





  for c1 = c,#M[1]
  do
    local r1 = returnNextRow(dontChangeTheseRows)

    local r,c = leftmostNonZeroCol(M,r1)
    --print("r is " .. r)
    --print("c is " .. c)


		-- scales the row if the pivot value isn't 1
		
    if (not(tableEqual(M[r][c],{1,1})))
    then
      local s = {}
      if ((M[r][c][1] < 0) and (M[r][c][2] > 0))
      then
		-- flips negative from den to num
        s = {-M[r][c][2],-M[r][c][1]}
      else
        s = {M[r][c][2],M[r][c][1]}
      end
      --local s = {M[r][c][2],M[r][c][1]}
      --print("scaling row " .. r .. " by ")
      --print_table(s)
      scaleRow(M,r,s)
    end


    --print()
    --print_fractional_matrix(M)
    --print()

    --print("r is " .. r)
    --print("r1 is " .. r1)

		-- swaps row is the pivot value isn't on the highest row of the submatrix
		
    if (r ~= r1)
    then
      --print("swapping rows " .. r .. " with " .. r1)
      swapRows(M,r,r1)
    end


    --print_fractional_matrix(M)
    --print()

    local r,c = leftmostNonZeroCol(M,r1)
    --print("r is " .. r)
    --print("c is " .. c)

		-- eliminate values above and below the pivot index

    eliminateAboveAndBelow(M,r,c)

    --print_fractional_matrix(M)

		-- mark the current row as one that no longer needs to be checked

    table.insert(dontChangeTheseRows,r1)


    local r1 = returnNextRow(dontChangeTheseRows)

    fixUp(M)

    if (onlyZeroRowsLeft(M,r1))
    then
      break
    end



  end


  --print()
  --print_fractional_matrix(M)



end


--------------------------------------------------------------------------------------------------



-- finds the integer domains of how many times each button can be pressed
-- based on joltage counters

function baselineDomains(jolt,buttonsf)
  local tab = {}
  for i = 1,#buttonsf
  do
    table.insert(tab,0)
  end
  for i = 1,#jolt
  do
    local tab2 = {}
    -- counter 1 is associated with 5 and 6
    for j = 1,#buttonsf
    do
      for k = 1,#buttonsf[j]
      do
        if (jolt[i].buttonNum == buttonsf[j][k])
        then
          if (tab[j] == 0)
          then
            --print("button " .. j .. " associated with counter " .. jolt[i].buttonNum)
            table.insert(tab2,j)
          end
        end
      end
    end

    for j = 1,#tab2
    do
      tab[tab2[j]] = jolt[i].buttonVal
    end

    --print_table(tab)

  end
  return tab
end
--[[

t101 = baselineDomains(joltageRequirements[1],buttons[1])
print()
print_table(t101)
]]--

--------------------------------------------------------------------------------------------------




function nonzeroInSameCol(M,rf,cf)
  for r = 1,#M
  do
    if (r ~= rf)
    then
      if (M[r][cf][1] ~= 0)
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
    if (M[rf][c][1] ~= 0)
    then
      return true
    end
  end
  return false
end







--------------------------------------------------------------------------------------------------





--------------------------------------------------------------------------------------------------


-- finds which variables in the rref are free and which are basic

function findBasicandFreeVar(M)
  local basicVar = {}
  local freeVar = {}


  for c = 1,#M[1]-1
  do
    for r = 1,#M
    do
      if (M[r][c][1] ~= 0)
      then
        if ((c == 1) and (M[r][c][1] == 1))
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
        if (M[r][c][1] ~= 1)
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

--[[
local t1,t2 = findBasicandFreeVar(matrix)
print("basic var:")
print_table(t1)
print("free var:")
print_table(t2)
print("number of free var: " .. #t2)
]]--










--------------------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------------------

io.input("abcd.txt")

input = io.read("*all")

io.close()

input_table = {}

-- splits input by newline
for i in string.gmatch(input, "%C+") do
   table.insert(input_table,i)
end

--print("number of rows: " .. #input_table)

--print_table(input_table)




--[[
indicatorDesiredOutput = {}


--print(string.match(input_table[1],"[.#]+"))

for i = 1,#input_table
do
  local str = string.match(input_table[i],"[.#]+")
  local tab = sepString(str)
  --local tab2 = {}
  for j = 1,#tab
  do
    if (tab[j] == ".")
    then
      tab[j] = 0
    elseif (tab[j] == "#")
    then
      tab[j] = 1
    end
  end
  table.insert(indicatorDesiredOutput,tab)
end

--print_table_table(indicatorDesiredOutput)

]]--


joltageRequirements = {}

for i = 1,#input_table
do
  -- insert table for each machine
  table.insert(joltageRequirements,{})
  for joltValues in string.gmatch(input_table[i],"%{[%d,]+%}")
  do
    --print(joltValues)
    local inc = 1

    --local individualJoltageTable = {}
    for num in string.gmatch(joltValues,"%d+")
    do
      --print(num)
      --table.insert(individualJoltageTable,tonumber(num))
      table.insert(joltageRequirements[i],{})
      joltageRequirements[i][inc].buttonNum = inc
      joltageRequirements[i][inc].buttonVal = tonumber(num)
      inc = inc + 1
    end
    --table.insert(joltageRequirements,individualJoltageTable)
  end
end


--[[

x100 = 1

print(#joltageRequirements)
print(#joltageRequirements[x100])

for i = 1,#joltageRequirements[x100]
do
  print("machine " .. x100)
  print("button number " .. joltageRequirements[x100][i].buttonNum)
  print("button value " .. joltageRequirements[x100][i].buttonVal)
end
]]--







buttons = {}
--inc = 1

for i = 1,#input_table
do
  -- insert table for each machine
  table.insert(buttons,{})
  for buttValues in string.gmatch(input_table[i],"%([%d,]+%)")
  do
    --print(buttValues)
    --table.insert(buttons,{})

    local individualButtonTable = {}
    for num in string.gmatch(buttValues,"%d+")
    do
      --print(num+1)
      table.insert(individualButtonTable,tonumber(num)+1)
    end
    table.insert(buttons[i],individualButtonTable)
  end
end

print(#buttons)

--[[
print(#buttons[1])

for i = 1,#buttons[1]
do
  print_table(buttons[1][i])
end
]]--







--------------------------------------------------------------------------------------------------

totalButtonPresses = 0
totalButtonPresses2 = 0


-- main loop:
-- iterates through each machine


for m = 1,#buttons
do

	--------------------------------------------------------------------------------------------------

	-- initialize matrix
	
  matrix = {}

  for r = 1,#joltageRequirements[m]
  do
    table.insert(matrix,{})
    for c = 1,#buttons[m]+1
    do
      matrix[r][c] = 0
    end
  end

  --print_table_table(matrix)

--------------------------------------------------------------------------------------------------

	-- fills out matrix
	
  for i = 1,#buttons[m]
  do
    for j = 1,#buttons[m][i]
    do
      -- i is button number
      -- button 1 goes in 4th row, col 1
      -- button 2 go in 2,4th row, col 2
      matrix[buttons[m][i][j]][i] = 1

    end
  end

  --print(#matrix[m])
  for i = 1,#joltageRequirements[m]
  do
    -- assings button counter values to last col of matrix
    matrix[i][#matrix[1]] = joltageRequirements[m][i].buttonVal
  end

  print()
  print_table_table(matrix)



  --------------------------------------------------------------------------------------------------

	-- sort out joltage requirements
	-- used to find the most limiting domain for each variable
	
  table.sort(joltageRequirements[m],sortByVal)




  domains = baselineDomains(joltageRequirements[m],buttons[m])
  print()
  print_table(domains)
  print()

--------------------------------------------------------------------------------------------------


  rref(matrix)
  print()
  print("rref matrix:")
  print_fractional_matrix(matrix)

--------------------------------------------------------------------------------------------------


  local t1,t2 = findBasicandFreeVar(matrix)
  print()
  print("basic var:")
  print_table(t1)
  print("free var:")
  print_table(t2)
  print("number of free var: " .. #t2)





  --------------------------------------------------------------------------------------------------

	-- main solver:

  -- first check if no free variables -> solve normally
  local sum1 = 0

  if (#t2 == 0)
  then
		-- no free variables
		-- can be solved normally
    for r = 1,#matrix
    do
      sum1 = sum1 + matrix[r][#matrix[1]][1]
      totalButtonPresses = totalButtonPresses + matrix[r][#matrix[1]][1]
    end
    print("sum1 is " .. sum1)
  else
		-- free variables exist





-- initalizes free variables to zero

    -- fine outside of loop
    local freeVariableIterator = {}
    for i = 1,#t2
    do
      freeVariableIterator[i] = {0,1}
    end


    --[[
    local joltageSimulator = {}
    for i = 1,#matrix
    do
      joltageSimulator[i] = 0
    end
    ]]--

		-- gets the row that each button is on from the matrix
		-- used later on when solving for each variable
		
    -- fine outside of loop
    local basicVariableRows = {}
    for i = 1,#t1
    do
      table.insert(basicVariableRows,{})
      for r = 1,#matrix
      do
        if (tableEqual(matrix[r][t1[i]],{1,1}))
        then
          basicVariableRows[i].buttonNum = t1[i]
          basicVariableRows[i].row = r
        end
      end
    end

    --[[
    for i = 1,#basicVariableRows
    do
      print("button " .. basicVariableRows[i].buttonNum)
      print("is on row " .. basicVariableRows[i].row)
    end
    ]]--





    --local basicVariableButtonPresses = {}
    --local bool2 = true

    --for i = 1,#t1
    --do
      --local finalValue = table.table_copy(matrix[basicVariableRows[i].row][#matrix[1]])
      --for j = 1,#t2
      --do
        --local mulTable = mulTwoFrac(freeVariableIterator[j],table.table_copy(matrix[basicVariableRows[i].row][t2[j]]))
        --finalValue = subTwoFractions(finalValue,table.table_copy(mulTable))
      --end
      --if ((finalValue[1] / finalValue[2]) < 0)
      --then
        --print("basic variable is negative")
        --bool2 = false
      --end
      --basicVariableButtonPresses[i] = table.table_copy(finalValue)
    --end



    --[[

    for i = 1,#basicVariableButtonPresses
    do
      print("number of times basic variable " .. i .. " was pressed")
      print_table(basicVariableButtonPresses[i])
    end

    local buttonPressSum = {0,1}

    for i = 1,#basicVariableButtonPresses
    do
      buttonPressSum = addTwoFractions(table.table_copy(buttonPressSum),table.table_copy(basicVariableButtonPresses[i]))
    end
    for i = 1,#freeVariableIterator
    do
      buttonPressSum = addTwoFractions(table.table_copy(buttonPressSum),table.table_copy(freeVariableIterator[i]))
    end

    print("sum of button presses is:")
    print_table(buttonPressSum)

    ]]--


-- initialize the current machine min # of button presses
		
    currentMin = {math.huge,1}


		-- makes a table that has a free variable at the max value it can take
		-- used to stop the free variable incrementor loop
		
    -- outside loop
    local freeVariableMax = {}

    for i = 1,#t2
    do
      freeVariableMax[i] = {domains[t2[i]],1}
    end


    --[[
    for i = 1,#freeVariableMax
    do
      print_table(freeVariableMax[i])
    end
    ]]--

		-- loop doesn't do the last set of free variables naturally
		-- this bool makes the loop run one more time
		
    local bool1 = true

		-- free variable incrementor loop		
    repeat



			-- how many times each button is pressed
			
      local basicVariableButtonPresses = {}

			--------------------------------------------------------------------------------------------------
			
			-- initalizes to true
			-- if basic variable is negative or noninteger
			-- skips the rest of the solver and moves to the next set of free variables
			
      local bool2 = true

-- calculates how many times each basic variable would be pressed given the current set of free variables
			
      for i = 1,#t1
      do
        local finalValue = table.table_copy(matrix[basicVariableRows[i].row][#matrix[1]])
        for j = 1,#t2
        do
          local mulTable = mulTwoFrac(freeVariableIterator[j],table.table_copy(matrix[basicVariableRows[i].row][t2[j]]))
          finalValue = subTwoFractions(finalValue,table.table_copy(mulTable))
        end
        if ((finalValue[1] / finalValue[2]) < 0)
        then
          --print("basic variable is negative")
          bool2 = false
        end
		if (((finalValue[1] / finalValue[2]) % 1) ~= 0)
        then
          --print("non integer number of button presses")
          bool2 = false
        end
        basicVariableButtonPresses[i] = table.table_copy(finalValue)
      end

			--------------------------------------------------------------------------------------------------

			-- if basic variable is an integer and greater than or equal to zero -> continues
			
      if (bool2)
      then

        --[[
        for i = 1,#basicVariableButtonPresses
        do
          print("number of times basic variable " .. i .. " was pressed")
          print_table(basicVariableButtonPresses[i])
        end
        ]]--

				--------------------------------------------------------------------------------------------------
				-- gets the sum of all buttons presses (free and basic)
				
        local buttonPressSum = {0,1}

        for i = 1,#basicVariableButtonPresses
        do
          buttonPressSum = addTwoFractions(table.table_copy(buttonPressSum),table.table_copy(basicVariableButtonPresses[i]))
        end
        for i = 1,#freeVariableIterator
        do
          buttonPressSum = addTwoFractions(table.table_copy(buttonPressSum),table.table_copy(freeVariableIterator[i]))
        end

        --print("sum of button presses is:")
        --print_table(buttonPressSum)

				--------------------------------------------------------------------------------------------------

				-- compares sum to current machine min
				
        if (f1LessThanf2(buttonPressSum,currentMin))
        then
          currentMin = table.table_copy(buttonPressSum)
        end


				--------------------------------------------------------------------------------------------------
				
      end



      -- iterate through each free variable
        -- if current free variable is the max it can be -> do nothing and loop will naturally go to next free var
        -- if current one is not at max
          -- increase by one
          -- if on the 2nd or more free variable -> after incrementing, reset the other free variables

      -- make sure its checking only one at a time

      -- break if you can change a free variable
      for i = 1,#freeVariableIterator
      do
        --print("test1")
        --print("free variable number " .. i)
        if (not(tableEqual(freeVariableIterator[i],freeVariableMax[i])))
        then
          if (i > 1)
          then
            --print("test2")
            freeVariableIterator[i] = addTwoFractions(freeVariableIterator[i],{1,1})
            for j = 1,i-1
            do
              freeVariableIterator[j] = {0,1}
            end
            break
          else
            --print("test3")
            freeVariableIterator[i] = addTwoFractions(freeVariableIterator[i],{1,1})
            break
          end
        end
      end

      --print("free variables are:")
      --print_table_table(freeVariableIterator)

			
			-- makes the loop run one more time so it checks the final set of free variables

      if (fractionTableEqual(freeVariableIterator,freeVariableMax))
	then
        bool1 = not(bool1)
      end


			-- ends loop when all free variables are the max they can be
			-- it will have iterated through all of its possible values after this loop
			
    until((bool1) and (fractionTableEqual(freeVariableIterator,freeVariableMax)))


	  print("min of machine " .. m .. " is:")
	  print_table(currentMin)
	  totalButtonPresses2 = totalButtonPresses2 + (currentMin[1] / currentMin[2])





  end

	print("running total basic button presses: " .. totalButtonPresses)
	print("runnig total free buttons presses: " .. totalButtonPresses2)


  print("machine " .. m .. " done")


end



print("number of times a button was pressed: " .. totalButtonPresses)
print("number of times a button was pressed: " .. totalButtonPresses2)













