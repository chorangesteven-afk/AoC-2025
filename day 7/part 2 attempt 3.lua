-- optimization ideas:
-- instead of evaluating every cell individually -> 
-- only evaluate what needs to be evaluated (active beam cell)
-- cache some values

-- simulate the beam inching down the stream
-- store the col of the beam
-- go row by row
-- if the next row is a splitter -> do whatever
-- if the next row is space -> do whatever

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

function stringTo2D(str)
  local t = {}
  local t2 = {}
  for i in string.gmatch(str, "%C+") do
   table.insert(t,i)
  end
  for i = 1,#t
  do
    table.insert(t2,sepString(t[i]))
  end
  return t2
end

function twoDToString(t)
  -- concatanate each row
  local t2 = {}
  for i = 1,#t
  do
    table.insert(t2,table.concat(t[i]))
  end
  local str = table.concat(t2,"\n")
  return str
end


--------------------------------------------------------------------------------------------------

input = io.read("*a")

input_table = {}

-- splits input by newline
for i in string.gmatch(input, "%C+") do
   table.insert(input_table,i)
end

rows = #input_table
print("number of rows: " .. #input_table)

input_table_table = stringTo2D(input)

print("number of columns: " .. #input_table_table[1])

-- 1st 2 rows looks the same for every timeline

input_table_table[2][math.ceil(#input_table_table[1] / 2)] = 1
--print(twoDToString(input_table_table))


--------------------------------------------------------------------------------------------------

timelines = {twoDToString(input_table_table)}
--print(timelines[1])
beamCoord = {{2,math.ceil(#input_table_table[1] / 2)}}



--------------------------------------------------------------------------------------------------

function beamInFinalRow(table)
  for k = 1,#table
  do
    if (table[k] == "1")
    then
      --print("true")
      return true
    end
  end
  return false
end
--------------------------------------------------------------------------------------------------


-- the same as any beam to the left of a splitter == false
function everyBeamToTheRightOfASplitter(t1,t2)
  local bool = true
  --print("ahh")
  --print_table_table(t1)
  --print_table(t2)
  for _, v in ipairs(t2)
  do
    --print(_,v)
    for k = 1,#t1[1]
    do
      --print(t1[v][k])
      if ((t1[v][k] == "1") and (t1[v][k+1] == "^"))
      then
        
        
        bool = false
        return false
        
      end
    end
  end
  return bool
end

--------------------------------------------------------------------------------------------------

function everyRowWithSplitter(t)
  ahhhhh = {}
  for j = 2,#t
  do
    for k = 1,#t[j]
    do
      if (t[j][k] == "^")
      then
        table.insert(ahhhhh,j)
        goto continue
      end
    end
    ::continue::
  end
  --print_table(ahhhhh)
  return ahhhhh
end
--------------------------------------------------------------------------------------------------
-- on every row that has a splitter, every beam is to the right of the splitter

function finalTimeline(t,i,a)
  --print()
  --print_table_table(t)
  if (a ~= #t)
  then
    return false
  end
  --[[
  if (beamInFinalRow(t[#t]) == false)
  then
    --print("false")
    return false
  end
  ]]--
  local aksdjhf = everyBeamToTheRightOfASplitter(t,i)
  if (aksdjhf == false)
  then
    return false
  end
  if ((a == #t) and (aksdjhf))
  then
    --print("true")
    return true
  end
end

--print(finalTimeline(input3DTable[2]))

--------------------------------------------------------------------------------------------------

function highestRow(t)
  for i = #t,1,-1
  do
    for j = 1,#t[1]
    do
      if (t[i][j] == "1")
      then
        --print("highest row is " .. i)
        return i
      end
    end
  end
end

--------------------------------------------------------------------------------------------------

currentTimeline = 1
splitterRows = everyRowWithSplitter(input_table_table)

repeat
  print("current timeline " .. currentTimeline)
  --print("number of timelines is " .. #timelines)
  --print(timelines[currentTimeline])
  local timelineTable = stringTo2D(timelines[currentTimeline])
  local activeBeamRow = beamCoord[currentTimeline][1]
  local activeBeamCol = beamCoord[currentTimeline][2]
  
  
  --[[
  local activeBeamRow = highestRow(timelineTable)
  for i = 1,#timelineTable[activeBeamRow]
  do
    if timelineTable[activeBeamRow][i] == "1"
    then
      activeBeamCol = i
      --print(activeBeamCol)
    end
  end
  ]]--

  for j = highestRow(timelineTable)+1,#timelineTable
  do
    if (timelineTable[j][activeBeamCol] == "^")
    then
        timelineTable[j][activeBeamCol+1] = "1"
        
        table.insert(timelines,twoDToString(timelineTable))
        table.insert(beamCoord,{j,activeBeamCol+1})
        
        timelineTable[j][activeBeamCol+1] = "."
        timelineTable[j][activeBeamCol-1] = "1"
        activeBeamCol = activeBeamCol - 1
        
    else
    --if (timelineTable[j][activeBeamCol] == ".")
    --then
      timelineTable[j][activeBeamCol] = "1"
    end
    activeBeamRow = j
  end
  
  --print(timelines[currentTimeline])
  currentTimeline = currentTimeline + 1
  
  
until (finalTimeline(timelineTable,splitterRows,activeBeamRow) == true)

--print(timelines[1])
print(#timelines)

--------------------------------------------------------------------------------------------------
