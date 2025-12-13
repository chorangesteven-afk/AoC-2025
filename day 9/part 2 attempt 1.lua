--[[
i gave up on this midway through because it always times out on onecompiler.com whenever it tries to sort the perimeter tables.

generate a table that stores the entire perimeter of the domain
sort by x and y values so you can use a more efficient searching algo when validating rectangle points.


Iterate along the right side of the rectangle:
  if the point you're on is more right than the rightmost point on the domain then that point on the rectangle is invalid

do the same for every edge of the rectangle to validate.

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

for i = 1,#input_table_table
do
  input_table_table[i][1] = tonumber(input_table_table[i][1])
  input_table_table[i][2] = tonumber(input_table_table[i][2])
end
--print_table_table(input_table_table)


--------------------------------------------------------------------------------------------------
-- generate the bounds

--bounds = {{input_table_table[1][1],input_table_table[1][2]}}
sortedBoundsXbyX = {input_table_table[1][1]}
sortedBoundsYbyX = {input_table_table[1][2]}
--sortedBoundsXbyY = {input_table_table[1][1]}
--sortedBoundsYbyY = {input_table_table[1][2]}

for i = 1,#input_table_table-1
do
  if (input_table_table[i+1][1] == input_table_table[i][1])
  then
    -- same col
    if (input_table_table[i+1][2] > input_table_table[i][2])
    then
      -- goes up
      local dy = input_table_table[i+1][2] - input_table_table[i][2]
      for j = 1,dy
      do
        --table.insert(bounds,{input_table_table[i][1],input_table_table[i][2]+j})
        table.insert(sortedBoundsXbyX,input_table_table[i][1])
        table.insert(sortedBoundsYbyX,input_table_table[i][2]+j)
        --table.insert(sortedBoundsXbyY,input_table_table[i][1])
        --table.insert(sortedBoundsYbyY,input_table_table[i][2]+j)
      end
    else
      -- goes down
      local dy = input_table_table[i][2] - input_table_table[i+1][2]
      for j = 1,dy
      do
        --table.insert(bounds,{input_table_table[i][1],input_table_table[i][2]-j})
        table.insert(sortedBoundsXbyX,input_table_table[i][1])
        table.insert(sortedBoundsYbyX,input_table_table[i][2]-j)
        --table.insert(sortedBoundsXbyY,input_table_table[i][1])
        --table.insert(sortedBoundsYbyY,input_table_table[i][2]-j)
      end
    end
  else
    -- same row
    if (input_table_table[i+1][1] > input_table_table[i][1])
    then
      -- goes right
      local dx = input_table_table[i+1][1] - input_table_table[i][1]
      --print("dx is " .. dx)
      for j = 1,dx
      do
        --print("j is " .. j)
        --print(input_table_table[i][1]+j)
        --table.insert(bounds,{input_table_table[i][1]+j,input_table_table[i][2]})
        table.insert(sortedBoundsXbyX,input_table_table[i][1]+j)
        table.insert(sortedBoundsYbyX,input_table_table[i][2])
        --table.insert(sortedBoundsXbyY,input_table_table[i][1]+j)
        --table.insert(sortedBoundsYbyY,input_table_table[i][2])
      end
    else
      -- goes left
      local dx = input_table_table[i][1] - input_table_table[i+1][1]
      for j = 1,dx
      do
        --table.insert(bounds,{input_table_table[i][1]-j,input_table_table[i][2]})
        table.insert(sortedBoundsXbyX,input_table_table[i][1]-j)
        table.insert(sortedBoundsYbyX,input_table_table[i][2])
        --table.insert(sortedBoundsXbyY,input_table_table[i][1]-j)
        --table.insert(sortedBoundsYbyY,input_table_table[i][2])
      end
    end
  end
end

-- connect the last and first points

if (input_table_table[#input_table_table][1] == input_table_table[1][1])
  then
    -- same col
    if (input_table_table[1][2] > input_table_table[#input_table_table][2])
    then
      -- goes up
      local dy = input_table_table[1][2] - input_table_table[#input_table_table][2]
      for j = 1,dy
      do
        ---table.insert(bounds,{input_table_table[#input_table_table][1],input_table_table[#input_table_table][2]+j})
        table.insert(sortedBoundsXbyX,input_table_table[#input_table_table][1])
        table.insert(sortedBoundsYbyX,input_table_table[#input_table_table][2]+j)
        --table.insert(sortedBoundsXbyY,input_table_table[#input_table_table][1])
        --table.insert(sortedBoundsYbyY,input_table_table[#input_table_table][2]+j)
      end
    else
      -- goes down
      local dy = input_table_table[#input_table_table][2] - input_table_table[1][2]
      for j = 1,dy
      do
        --table.insert(bounds,{input_table_table[#input_table_table][1],input_table_table[#input_table_table][2]-j})
        table.insert(sortedBoundsXbyX,input_table_table[#input_table_table][1])
        table.insert(sortedBoundsYbyX,input_table_table[#input_table_table][2]-j)
        --table.insert(sortedBoundsXbyY,input_table_table[#input_table_table][1])
        --table.insert(sortedBoundsYbyY,input_table_table[#input_table_table][2]-j)
      end
    end
  else
    -- same row
    if (input_table_table[1][1] > input_table_table[#input_table_table][1])
    then
      -- goes right
      local dx = input_table_table[1][1] - input_table_table[#input_table_table][1]
      print("dx is " .. dx)
      for j = 1,dx
      do
        --print("j is " .. j)
        --print(input_table_table[i][1]+j)
        --table.insert(bounds,{input_table_table[#input_table_table][1]+j,input_table_table[#input_table_table][2]})
        table.insert(sortedBoundsXbyX,input_table_table[#input_table_table][1]+j)
        table.insert(sortedBoundsYbyX,input_table_table[#input_table_table][2])
        --table.insert(sortedBoundsXbyY,input_table_table[#input_table_table][1]+j)
        --table.insert(sortedBoundsYbyY,input_table_table[#input_table_table][2])
      end
    else
      -- goes left
      local dx = input_table_table[#input_table_table][1] - input_table_table[1][1]
      for j = 1,dx
      do
        --table.insert(bounds,{input_table_table[#input_table_table][1]-j,input_table_table[#input_table_table][2]})
        table.insert(sortedBoundsXbyX,input_table_table[#input_table_table][1]-j)
        table.insert(sortedBoundsYbyX,input_table_table[#input_table_table][2])
        --table.insert(sortedBoundsXbyY,input_table_table[#input_table_table][1]-j)
        --table.insert(sortedBoundsYbyY,input_table_table[#input_table_table][2])
      end
    end
  end







--table.remove(bounds)
table.remove(sortedBoundsXbyX)
table.remove(sortedBoundsYbyX)
--table.remove(sortedBoundsXbyY)
--table.remove(sortedBoundsYbyY)

--print(#sortedBoundsXbyX)

--print_table_table(bounds)
--print()
--print()
--[[
for i = 1,#bounds
do
  io.write(string.format("%d %d\n",sortedBoundsXbyX[i],sortedBoundsYbyX[i]))
  io.write(string.format("%d %d\n",sortedBoundsXbyY[i],sortedBoundsYbyY[i]))
  --print(sortedBoundsXbyX[i])
  --print(sortedBoundsYbyX[i])
  --print(sortedBoundsXbyY[i])
  --print(sortedBoundsYbyY[i])
end
--print(#bounds)
print(#sortedBoundsXbyX)
print(#sortedBoundsYbyX)
print(#sortedBoundsXbyY)
print(#sortedBoundsYbyY)

]]--

--------------------------------------------------------------------------------------------------


-- function to create a partition
function partition(list, low, high,list2)
   -- last element is a pivot
   local pivot = list[high]
   local i = low - 1 -- index of first element

   -- loop on elements of the partition
   for j = low, high - 1 do
      -- swap number if lower than pivot
      if list[j] <= pivot then
         i = i + 1
         list[i], list[j] = list[j], list[i]
         list2[i],list2[j] = list2[j],list2[i]
         --list3[i],list3[j] = list3[j],list3[i]
      end
   end

   -- Swap list[i + 1] with list[high]
   list[i + 1], list[high] = list[high], list[i + 1]
   list2[i + 1], list2[high] = list2[high], list2[i + 1]
   --list3[i + 1], list3[high] = list3[high], list3[i + 1]
   return i + 1  -- return the index to partition
end

function quick_sort(list, low, high,list2)
   if low < high then
      -- Partition the list and get the partitioning index
      local pi = partition(list, low, high,list2)

      -- Recursively quick sort elements before and after partition
      quick_sort(list, low, pi - 1,list2)
      quick_sort(list, pi + 1, high,list2)
   end
   return list,list2
end


sortedBoundsXbyX1 = {}
sortedBoundsYbyX1 = {}
--sortedBoundsXbyY1 = {}
--sortedBoundsYbyY1 = {}

--distancesSorted,boxesSorted,relBoxesSorted = quick_sort(distances,1,#distances,boxes,relBoxes)

sortedBoundsXbyX1,sortedBoundsYbyX1 = quick_sort(sortedBoundsXbyX,1,#sortedBoundsYbyX,sortedBoundsYbyX)
--sortedBoundsYbyY1,sortedBoundsXbyY1 = quick_sort(sortedBoundsYbyY,1,#bounds,sortedBoundsXbyY)

--[[
for i = 1,#bounds
do
  io.write(string.format("%d %d\n",sortedBoundsXbyX1[i],sortedBoundsYbyX1[i]))
  --print(sortedBoundsXbyX[i])
  --print(sortedBoundsYbyX[i])
  --print(sortedBoundsXbyY[i])
  --print(sortedBoundsYbyY[i])
end
print()
print()
for i = 1,#bounds
do
  io.write(string.format("%d %d\n",sortedBoundsXbyY1[i],sortedBoundsYbyY1[i]))
  --print(sortedBoundsXbyX[i])
  --print(sortedBoundsYbyX[i])
  --print(sortedBoundsXbyY[i])
  --print(sortedBoundsYbyY[i])
end

]]--










--------------------------------------------------------------------------------------------------


--[[

function invalidRect(c1X,c1Y,c2X,c2Y)
  
  print("c1X is " .. c1X)
  print("c1Y is " .. c1Y)
  print("c2x is " .. c2X)
  print("c2Y is " .. c2Y)
  
  if (c2Y > c1Y)
  then
    -- c1 is a bot
    -- c2 is a top corner
    if (c2X > c1X)
    then
      print("c1 is a bot left")
      print("c2 is a top right corner")
      for i = 1,#input_table_table
      do
        
        
        if (input_table_table[i][1] > c1X)
        then
          return true
        end
        if (input_table_table[i][2] > c1Y)
        then
          return true
        end
        
        if (c2X > input_table_table[i][1])
        then
          return true
        end
        if (c2Y > input_table_table[i][2])
        then
          return true
        end
        
      end
    else
      print("c1 is a bot right")
      print("c2 is a top left")
      -- c1 is a bot right 
      -- c2 is a top left
      for i = 1,#input_table_table
      do
        
        
        if (c1X > input_table_table[i][1])
        then
          return true
        end
        if (input_table_table[i][2] > c1Y)
        then
          return true
        end
        
        if (input_table_table[i][1] > c2X)
        then
          
        end
        if (c2Y > input_table_table[i][2])
        then
          return true
        end
        
        
        
        
        
        
        
        
        
        
      end
    end
  else
    -- c1 is a top corner
    -- c2 is bot
    if (c2X > c1X)
    then
      print("c1 is a top left")
      print("c2 is a bot right")
      -- c1 is top left
      -- c2 is a bot right corner
      for i = 1,#input_table_table
      do
        if (input_table_table[i][1] > c1X)
        then
          print("test1 " .. i)
          return true
        end
        if (c1Y > input_table_table[i][2])
        then
          print("test2 " .. i)
          print(input_table_table[i][2])
          return true
        end
        
        if (c2X > input_table_table[i][1])
        then
          print("test3 " .. i)
          return true
        end
        if (input_table_table[i][2] > c2Y)
        then
          print("test4 " .. i)
          return true
        end
      end
    else
      print("c1 is a top right")
      print("c2 is a bot left")
      -- c1 is a top right corner
      -- c2 is bot left
      for i = 1,#input_table_table
      do
        
        
        if (c1X > input_table_table[i][1])
        then
          return true
        end
        if (c1Y > input_table_table[i][2])
        then
          return true
        end
        
        if (input_table_table[i][1] > c2X)
        then
          return true
        end
        if (input_table_table[i][2] > c2Y)
        then
          return true
        end
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
      end
    end
  end
  return false
end

]]--

--------------------------------------------------------------------------------------------------

function genRectBoundsTop(x1,y1,x2,y2)
  local tab = {}
  
  if (y2 > y1)
  then
    -- pt2 is on the top side
    if (x2 > x1)
    then
      -- pt2 is on the right side
      table.insert(tab,{x1,y2})
      local dx = x2 - x1
      for i = 1,dx
      do
        table.insert(tab,{x1+i,y2})
      end
    else
      -- p1 is on the right side
      table.insert(tab,{x2,y2})
      local dx = x1-x2
      for i = 1,dx
      do
        table.insert(tab,{x2+i,y2})
      end
    end
  else
    -- p1 is on the top side
    if (x2 > x1)
    then
      -- pt2 is on the right side
      table.insert(tab,{x1,y1})
      local dx = x2 - x1
      for i = 1,dx
      do
        table.insert(tab,{x1+i,y1})
      end
    else
      -- p1 is on the right side
      table.insert(tab,{x2,y1})
      local dx = x1-x2
      for i = 1,dx
      do
        table.insert(tab,{x2+i,y1})
      end
    end
  end
  
  
  return tab
  
end

function genRectBoundsRight(x1,y1,x2,y2)
  local tab = {}
  
  if (y2 > y1)
  then
    -- pt2 is on the top side
    if (x2 > x1)
    then
      -- pt2 is on the right side
      table.insert(tab,{x2,y1})
      local dy = y2-y1
      for i = 1,dy
      do
        table.insert(tab,{x2,y1+i})
      end
    else
      -- p1 is on the right side
      table.insert(tab,{x1,y1})
      local dy = y2 - y1
      for i = 1,dy
      do
        table.insert(tab,{x1,y1+i})
      end
    end
  else
    -- p1 is on the top side
    if (x2 > x1)
    then
      -- pt2 is on the right side
      table.insert(tab,{x2,y2})
      local dy = y1 - y2
      for i = 1,dy
      do
        table.insert(tab,{x2,y2+i})
      end
    else
      -- p1 is on the right side
      table.insert(tab,{x1,y2})
      local dx = y1 - y2
      for i = 1,dy
      do
        table.insert(tab,{x1,y2+i})
      end
    end
  end
  return tab
end

function genRectBoundsBot(x1,y1,x2,y2)
  
  local tab = {}
  
  if (y2 > y1)
  then
    -- pt2 is on the top side
    if (x2 > x1)
    then
      -- pt2 is on the right side
      table.insert(tab,{x1,y1})
      local dx = x2 - x1
      for i = 1,dx
      do
        table.insert(tab,{x1+i,y1})
      end
    else
      -- p1 is on the right side
      table.insert(tab,{x2,y1})
      local dx = x1 - x2
      for i = 1,dx
      do
        table.insert(tab,{x2+i,y1})
      end
    end
  else
    -- p1 is on the top side
    if (x2 > x1)
    then
      -- pt2 is on the right side
      table.insert(tab,{x1,y2})
      local dx = x2 - x1
      for i = 1,dx
      do
        table.insert(tab,{x1+i,y2})
      end
    else
      -- p1 is on the right side
      table.insert(tab,{x2,y2})
      local dx = x1-x2
      for i = 1,dx
      do
        table.insert(tab,{x2+i,y2})
      end
    end
  end
  
  return tab
  
end

function genRectBoundsLeft(x1,y1,x2,y2)
  
  local tab = {}
  
  
  if (y2 > y1)
  then
    -- pt2 is on the top side
    if (x2 > x1)
    then
      -- pt2 is on the right side
      table.insert(tab,{x1,y1})
      local dy = y2 - y1
      for i = 1,dy
      do
        table.insert(tab,{x1,y1+i})
      end
    else
      -- p1 is on the right side
      table.insert(tab,{x2,y1})
      local dy = y2 - y1
      for i = 1,dy
      do
        table.insert(tab,{x2,y1+i})
      end
    end
  else
    -- p1 is on the top side
    if (x2 > x1)
    then
      -- pt2 is on the right side
      table.insert(tab,{x1,y2})
      local dy = y1 - y2
      for i = 1,dy
      do
        table.insert(tab,{x1,y2+i})
      end
    else
      -- p1 is on the right side
      table.insert(tab,{x2,y2})
      local dx = y1 - y2
      for i = 1,dy
      do
        table.insert(tab,{x2,y2+i})
      end
    end
  end
  
  return tab
  
end





--------------------------------------------------------------------------------------------------

function invalidRect(x1,y1,x2,y2)
  
  
  local rectBoundsTop = genRectBoundsTop(x1,y1,x2,y2)
  local rectBoundsRight = genRectBoundsRight(x1,y1,x2,y2)
  local rectBoundsBot = genRectBoundsBot(x1,y1,x2,y2)
  local rectBoundsLeft = genRectBoundsLeft(x1,y1,x2,y2)
  
  --[[
  print_table_table(rectBoundsTop)
  print()
  print_table_table(rectBoundsRight)
  print()
  print_table_table(rectBoundsBot)
  print()
  print_table_table(rectBoundsLeft)
  print()
  ]]--

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
end




--invalidRect(input_table_table[1][1],input_table_table[1][2],input_table_table[3][1],input_table_table[3][2])





--------------------------------------------------------------------------------------------------

currentMax = 0

--[[
for i = 1,#input_table_table
do
  for j = i+1,#input_table_table
  do
    local x1 = input_table_table[i][1]
    local y1 = input_table_table[i][2]
    local x2 = input_table_table[j][1]
    local y2 = input_table_table[j][2]
    
    local width = math.abs(x2-x1) + 1
    if (width == 1)
    then
      goto continue
    end
    
    local height = math.abs(y2-y1) + 1
    if (height == 1)
    then
      goto continue
    end
    
  
    
    if (invalidRect(x1,y1,x2,y2))
    then
      goto continue
    end
    
    
    local area = width * height
    
    if (area > currentMax)
    then
      currentMax = area
    end
    ::continue::
  end
end

print(currentMax)
]]--



--------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------
