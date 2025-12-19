

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
--[[

test = {
  {0,0,0},
  {0,0,0},
  {0,0,3},
}

test[1],test[3] = test[3],test[1]

print_table_table(test)print_table_table(test
]]--
--[[
for i = 1,10
do
  for  j= 1,10
  do
    if(j == 5)
    then
      if (i ~= 0)
      then
        print(i,j)
        break
      end
    end
  end
end
]]--
--[[
for i = 1,1
do
  print(i)
end
]]--

--[[
test = {
  {buttonNum = 1, buttonVal = 3},
  {buttonNum = 3, buttonVal = 2},
  {buttonNum = 2, buttonVal = 1},
}

for i,v in pairs(test)
do
  print(v.buttonNum,v.buttonVal)
end

sortByVal = function (entry1, entry2)
   return entry1.buttonVal < entry2.buttonVal
end

table.sort(test,sortByVal)
print()

for i,v in pairs(test)
do
  print(v.buttonNum,v.buttonVal)
end



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

t100 = {1,2,3,4}

print(valNotInTable(t100,3))


]]--

--[[
test1 = {1,1}

test2 = {1,1}
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

print(tableEqual(test1,test2))

]]--


--print(27/180)

--euclid's algorithim

test = {-14348907,3188646}
--test = {18,27}


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
        print("result is " .. result)
        if (result == 0)
        then
          return true,result2
        end
        if (result < 0)
        then
          return false
        end
        print("result2 is " .. result2)
      end
      local dum = result2
      result2 = result
      print("reuslt2 " .. result2)
      result = dum
      print("result " .. result)
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
        print("result is " .. result)
        if (result == 0)
        then
          return true,result2
        end
        if (result < 0)
        then
          return false
        end
        print("result2 is " .. result2)
      end
      local dum = result2
      result2 = result
      print("reuslt2 " .. result2)
      result = dum
      print("result " .. result)
      --result,result2 = result2,result
    end
  
  end
  
end

--print(euclid(test))

function reduceFraction(f)
  local bool10 = true
  if (f[1] < 0)
  then
    -- num is negative
    f[1] = f[1] * -1
    bool10 = false
  end
  local bool,two = euclid(f)
  if (bool)
  then
    if (bool10)
    then
      f[1] = math.ceil(f[1] / two)
      f[2] = math.ceil(f[2] / two)
    else
      f[1] = -1 * math.ceil(f[1] / two)
      f[2] = math.ceil(f[2] / two)
    end
  else
    return f
  end
end

reduceFraction(test)

print_table(test)








function addTwoFractions(f1,f2)
  local d1 = f1[2]
  local d2 = f2[2]
  local resF = {}
  
  f1[1] = f1[1] * d2
  f2[1] = f2[1] * d1
  
  
  resF[1] = f1[1] + f2[1]
  resF[2] = f2[2] * d1
  if ((resF[1] % resF[2]) == 0)
  then
    --print("test")
    --resF[1] = math.ceil(resF[1] / resF[2])
    --resF[2] = 1
  end
  reduceFraction(resF)
  return resF
end



f11 = {3,2}
f22 = {5,10}




























