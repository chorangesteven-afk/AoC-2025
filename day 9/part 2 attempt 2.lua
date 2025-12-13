--[[
unfortunately this method is too slow for: onecompiler.com and times out.
and I can't really think of a faster one.

this method iterates through:
  * each potential rectangle
  * the four corners of each rectangle
  * for each corner has to search through the vertices table to get matching ranges
]]--


--[[
check the edge line segments of each rectangle

make a list of points that are one out from the ori points
inspired from this video: https://youtu.be/tGxIUnLyVWU?si=rWyNOWRAtJDE7EYl&t=160
  iterate ccw and keep the orig polygon on the left for every turn
  going up the list of inputs seems to go ccw around the polygon


first look at the top edge of the rectangle:
  from the vertice points of the new outer domain find the y-range the top edge is b.w.
  imagine a vertical line at each pt
  the x value is gonna be the same for a vertical line
  compare that x value with the x value of the top right and top left corners of the rectangle
  
for the side edges compare the y value of the x-ranges of the points on the outer domain with the y values of the top and bot corners of the rectangle

assumptions:
 * assumes that no 3 subsequent points along the domain are colinear (all three pts being on the same vertical or horizontal line)
 * assuems that the max area rectangle does not have a length or width of 1

other helpful sources:
https://www.geeksforgeeks.org/cpp/point-in-polygon-in-cpp/
https://www.geeksforgeeks.org/dsa/how-to-check-if-a-given-point-lies-inside-a-polygon/
https://www.geeksforgeeks.org/dsa/check-if-two-given-line-segments-intersect/
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
--inputTableX = {}
--inputTableY = {}

for i = 1,#input_table_table
do
  --table.insert(inputTableX,tonumber(input_table_table[i][1]))
  --table.insert(inputTableY,tonumber(input_table_table[i][2]))
  input_table_table[i][1] = tonumber(input_table_table[i][1])
  input_table_table[i][2] = tonumber(input_table_table[i][2])
end
--print_table_table(input_table_table)
--print(#inputTableX)
--print(#inputTableY)


--------------------------------------------------------------------------------------------------



outerPolygonVertices = {}

--table.insert(outerPolygonVertices,{input_table_table[i][1],input_table_table[i][2]})

-- repeat whats in the loop this for the first and last points




if (input_table_table[1][2] == input_table_table[#input_table_table][2])
  then
    -- coming in to the current point with a horizontal line
    if (input_table_table[#input_table_table][1] > input_table_table[1][1])
    then
      -- coming in from the right
      if (input_table_table[2][2] > input_table_table[1][2])
      then
        -- leaving up
        table.insert(outerPolygonVertices,{input_table_table[1][1]+1,input_table_table[1][2]+1})
        
      else
        -- leaving down
        
        table.insert(outerPolygonVertices,{input_table_table[1][1]-1,input_table_table[1][2]+1})
        
      end
      
    else
      -- coming in from the left
      if (input_table_table[2][2] > input_table_table[1][2])
      then
        -- leaving up
        table.insert(outerPolygonVertices,{input_table_table[1][1]+1,input_table_table[1][2]-1})
        
      else
        -- leaving down
        
        table.insert(outerPolygonVertices,{input_table_table[1][1]-1,input_table_table[1][2]-1})
        
      end
      
      
    end
    
    
  else
    -- coming in to the current point with a vertical line
    
    if (input_table_table[#input_table_table][2] < input_table_table[1][2])
    then
      -- coming from the bottom
      if (input_table_table[2][1] < input_table_table[1][1])
      then
        -- leaving to the left
        
        table.insert(outerPolygonVertices,{input_table_table[1][1]+1,input_table_table[1][2]+1})
        
      else
        -- leaving to the right
        table.insert(outerPolygonVertices,{input_table_table[1][1]+1,input_table_table[1][2]-1})
        
      end
      
    else
      -- coming from the top
      
      if (input_table_table[2][1] < input_table_table[1][1])
      then
        -- leaving to the left
        table.insert(outerPolygonVertices,{input_table_table[1][1]-1,input_table_table[1][2]+1})
        
      else
        -- leaving to the right
        
        table.insert(outerPolygonVertices,{input_table_table[1][1]-1,input_table_table[1][2]-1})
      end
      
      
      
    end
    
    
    
  end











for i = 2,#input_table_table-1
do
  if (input_table_table[i][2] == input_table_table[i-1][2])
  then
    -- coming in to the current point with a horizontal line
    if (input_table_table[i-1][1] > input_table_table[i][1])
    then
      -- coming in from the right
      if (input_table_table[i+1][2] > input_table_table[i][2])
      then
        -- leaving up
        table.insert(outerPolygonVertices,{input_table_table[i][1]+1,input_table_table[i][2]+1})
        
      else
        -- leaving down
        
        table.insert(outerPolygonVertices,{input_table_table[i][1]-1,input_table_table[i][2]+1})
        
      end
      
    else
      -- coming in from the left
      if (input_table_table[i+1][2] > input_table_table[i][2])
      then
        -- leaving up
        table.insert(outerPolygonVertices,{input_table_table[i][1]+1,input_table_table[i][2]-1})
        
      else
        -- leaving down
        
        table.insert(outerPolygonVertices,{input_table_table[i][1]-1,input_table_table[i][2]-1})
        
      end
      
      
    end
    
    
  else
    -- coming in to the current point with a vertical line
    
    if (input_table_table[i-1][2] < input_table_table[i][2])
    then
      -- coming from the bottom
      if (input_table_table[i+1][1] < input_table_table[i][1])
      then
        -- leaving to the left
        
        table.insert(outerPolygonVertices,{input_table_table[i][1]+1,input_table_table[i][2]+1})
        
      else
        -- leaving to the right
        table.insert(outerPolygonVertices,{input_table_table[i][1]+1,input_table_table[i][2]-1})
        
      end
      
    else
      -- coming from the top
      
      if (input_table_table[i+1][1] < input_table_table[i][1])
      then
        -- leaving to the left
        table.insert(outerPolygonVertices,{input_table_table[i][1]-1,input_table_table[i][2]+1})
        
      else
        -- leaving to the right
        
        table.insert(outerPolygonVertices,{input_table_table[i][1]-1,input_table_table[i][2]-1})
      end
      
      
      
    end
    
    
    
  end
end





if (input_table_table[#input_table_table][2] == input_table_table[#input_table_table-1][2])
  then
    -- coming in to the current point with a horizontal line
    if (input_table_table[#input_table_table-1][1] > input_table_table[#input_table_table][1])
    then
      -- coming in from the right
      if (input_table_table[1][2] > input_table_table[#input_table_table][2])
      then
        -- leaving up
        table.insert(outerPolygonVertices,{input_table_table[#input_table_table][1]+1,input_table_table[#input_table_table][2]+1})
        
      else
        -- leaving down
        
        table.insert(outerPolygonVertices,{input_table_table[#input_table_table][1]-1,input_table_table[#input_table_table][2]+1})
        
      end
      
    else
      -- coming in from the left
      if (input_table_table[1][2] > input_table_table[#input_table_table][2])
      then
        -- leaving up
        table.insert(outerPolygonVertices,{input_table_table[#input_table_table][1]+1,input_table_table[#input_table_table][2]-1})
        
      else
        -- leaving down
        
        table.insert(outerPolygonVertices,{input_table_table[#input_table_table][1]-1,input_table_table[#input_table_table][2]-1})
        
      end
      
      
    end
    
    
  else
    -- coming in to the current point with a vertical line
    
    if (input_table_table[#input_table_table-1][2] < input_table_table[#input_table_table][2])
    then
      -- coming from the bottom
      if (input_table_table[1][1] < input_table_table[#input_table_table][1])
      then
        -- leaving to the left
        
        table.insert(outerPolygonVertices,{input_table_table[#input_table_table][1]+1,input_table_table[#input_table_table][2]+1})
        
      else
        -- leaving to the right
        table.insert(outerPolygonVertices,{input_table_table[#input_table_table][1]+1,input_table_table[#input_table_table][2]-1})
        
      end
      
    else
      -- coming from the top
      
      if (input_table_table[1][1] < input_table_table[#input_table_table][1])
      then
        -- leaving to the left
        table.insert(outerPolygonVertices,{input_table_table[#input_table_table][1]-1,input_table_table[#input_table_table][2]+1})
        
      else
        -- leaving to the right
        
        table.insert(outerPolygonVertices,{input_table_table[#input_table_table][1]-1,input_table_table[#input_table_table][2]-1})
      end
      
      
      
    end
    
    
    
  end


--print_table_table(outerPolygonVertices)





--------------------------------------------------------------------------------------------------








--------------------------------------------------------------------------------------------------








--------------------------------------------------------------------------------------------------

function returnYGivenX(x)
  local tab = {}
  
  for i = 2,#outerPolygonVertices
  do
    
    if (outerPolygonVertices[i-1][1] < outerPolygonVertices[i][1])
    then
      -- going right
      if ((outerPolygonVertices[i-1][1] <= x) and (x <= outerPolygonVertices[i][1]))
      then
        table.insert(tab,outerPolygonVertices[i][2])
      end
    else
      -- going left
      if ((outerPolygonVertices[i][1] <= x) and (x <= outerPolygonVertices[i-1][1]))
      then
        table.insert(tab,outerPolygonVertices[i][2])
      end
    end
    
  end
  
  return tab
end



function returnXGivenY(y)
  local tab = {}
  
  for i = 2,#outerPolygonVertices
  do
    if (outerPolygonVertices[i-1][2] < outerPolygonVertices[i][2])
    then
      -- going up
      if ((outerPolygonVertices[i-1][2] <= y) and (y <= outerPolygonVertices[i][2]))
      then
        table.insert(tab,outerPolygonVertices[i][1])
      end
    else
      -- going down
      if ((outerPolygonVertices[i][2] <= y) and (y <= outerPolygonVertices[i-1][2]))
      then
        table.insert(tab,outerPolygonVertices[i][1])
      end
    end
  end
  
  return tab
end







--------------------------------------------------------------------------------------------------


function invalidRect(x1,y1,x2,y2)
  local TL = {}
  local TR = {}
  local BL = {}
  local BR = {}
  if (x2 > x1)
  then
    -- pt 1 is on the left
    -- pt 2 is on the right
    if (y2 > y1)
    then
      -- pt 1 is on the bottom
      -- pt 2 is on the top
      TL = {x1,y2}
      TR = {x2,y2}
      BL = {x1,y1}
      BR = {x2,y1}
    else
      -- pt 1 is on the top
      -- pt 2 is on the bot
      TL = {x1,y1}
      TR = {x2,y1}
      BL = {x1,y2}
      BR = {x2,y2}
      
    end
    
    
    
  else
    -- pt 1 is on the right
    -- pt 2 is on the left
    
    if (y2 > y1)
    then
      -- pt 1 is on the bottom
      -- pt 2 is on the top
      TL = {x2,y2}
      TR = {x1,y2}
      BL = {x2,y1}
      BR = {x1,y1}
    else
      -- pt 1 is on the top
      -- pt 2 is on the bot
      TL = {x2,y1}
      TR = {x1,y1}
      BL = {x2,y2}
      BR = {x1,y2}
      
    end
    
    
    
    
    
    
    
    
    
  end
  
  --[[ top edge
  find every y-range the top corners are b.w.
  get the corresponding x-values
  for each x-value:
    check if it's greater than or equal to TL
    AND
    less than or equal to TR
  ]]--
  
  local tab1 = returnXGivenY(TL[2])
  
  
  for _,v in ipairs(tab1)
  do
    if ((TL[1] <= v) and (v <= TR[1]))
    then
      return true
    end
  end
  
  --[[ right edge
  
  find every x-range the right corners are b.w.
  get the corresponding y-values
  for each y-value:
    check if greater than or equal to BR
    AND
    less than or equal to TR
  ]]--

  local tab2 = returnYGivenX(BR[1])
  
  for _,v in ipairs(tab2)
  do
    if ((BR[2] <= v) and (v <= TR[2]))
    then
      return true
    end
  end
  
  --[[ bot edge
  find every y-range the bot corners are b.w.
  for each y-value:
    check if it's greater than or equal to BL
    AND
    less than or equal to BR
  ]]--
  
  local tab3 = returnXGivenY(BR[2])
  for _,v in ipairs(tab3)
  do
    if ((BL[1] <= v) and (v <= BR[1]))
    then
      return true
    end
  end
  
  --[[ left edge
  find every x-range the left corners are b.w.
  for each x-value:
    check if it's greater than or equal to BL
    AND
    less than or equal to TL
  ]]--
  
  local tab4 = returnYGivenX(BL[1])
  for _,v in ipairs(tab4)
  do
    if ((BL[2] <= v) and (v <= TL[2]))
    then
      return true
    end
  end
  
  
end



--------------------------------------------------------------------------------------------------




currentMax = 0


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










--------------------------------------------------------------------------------------------------
