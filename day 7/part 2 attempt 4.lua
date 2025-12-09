-- no tables
-- find where to modify str
-- make new str w/ desired modifications
-- save str

--------------------------------------------------------------------------------------------------

function print_table(table)
  for i=1,#table
  do
    io.write(table[i] .. " ")
  end
  print()
end

function replaceIndexOfString(originalString,index,replacementString)
  local funcString = string.format("%s%s%s", string.sub(originalString,1,index-1), replacementString, string.sub(originalString,index+1))
  return funcString
end

--------------------------------------------------------------------------------------------------



input = io.read("*a")
--print(input)

beam = "1"

--print(string.format("%s%s%s", string.sub(input,1,23), beam, string.sub(input,25)))

--print(string.sub(input,17))

--print(replaceIndexOfString(input,241,beam))

--print(string.find(input,"\n"))
rowLength = string.find(input,"\n")
print("rowlength is: " .. rowLength)

print(#input)

numberOfRows = (#input+1) / rowLength
print("number of rows: " .. numberOfRows)




--print(#input)
--exstr = string.format("%s%s%s", string.sub(input,1,rowLength+(rowLength/2)-1), beam, string.sub(input,rowLength+(rowLength/2)+1))
--print(#exstr)
timelines = {}
table.insert(timelines,replaceIndexOfString(input,(rowLength+(rowLength/2)),beam))
beamCoord = {rowLength+(rowLength/2)}

--print(beamCoord[1])

--print(timelines[1])

--print(string.sub(input,1,24))
--print(beam)
--print(string.sub(input,26))

--------------------------------------------------------------------------------------------------

everySplitter = {}
randomVariable1 = 0
while true
do
  randomVariable1 = string.find(timelines[1],"%^",randomVariable1+1)
  if randomVariable1 == nil then break end
  table.insert(everySplitter,randomVariable1)
end
--print_table(everySplitter)

everyNewline = {}
randomVariable2 = 0
while true
do
  randomVariable2 = string.find(timelines[1],"\n",randomVariable2+1)
  if randomVariable2 == nil then break end
  table.insert(everyNewline,randomVariable2)
end
print_table(everyNewline)

--------------------------------------------------------------------------------------------------

function everyBeam(str)
  local tab = {}
  local var = 0
  while true
  do
    var = string.find(str,"1",var+1)
    if var == nil then break end
    table.insert(tab,var)
  end
  return tab
end

--------------------------------------------------------------------------------------------------

function everyBeamToTheRightOfASplitter(str,t2)
  local bool = true
  
  for i = 1,#t2
  do
    -- if any beam has a splitter on the right
    if (string.sub(str,t2[i]+1,t2[i]+1) == "^")
    then
      bool = false
      return false
    end
  end
  return bool
end

--------------------------------------------------------------------------------------------------

function finalTimeline(str, beamIndex)
  local beamFinalRow = ((everyNewline[#everyNewline]+1 <= beamIndex) and (beamIndex <= #input))
  if (beamFinalRow == false)
  then
    return false
  end
  local abcde = everyBeamToTheRightOfASplitter(str,everyBeam(str))
  if (abcde == false)
  then
    return false
  end
  if ((beamFinalRow == true) and (abcde == true))
  then
    return true
  end
end


--------------------------------------------------------------------------------------------------

function indexToRowCol(ind)
  local tab = {}
  for i = 1,#everyNewline
  do
    if (((everyNewline[i]+1) <= ind) and (ind <= (everyNewline[i+1]-1)))
    then
      table.insert(tab,i+1)
      --print(ind - everyNewline[i])
      table.insert(tab,ind - everyNewline[i])
      return tab
    end
  end
  --return tab
end

--print_table(indexToRowCol(73))

--------------------------------------------------------------------------------------------------

function rowColToIndex(tab)
  local str = ""
  str = string.format("%d",(tab[1] - 1) * rowLength + tab[2])
  return str
end

--print(rowColToIndex({5,9}))

--------------------------------------------------------------------------------------------------

currentTimeline = 1


repeat
  --local timeline = 
  print("current timeline " .. currentTimeline)
  print("number of timelines " .. #timelines)
  local cursor = beamCoord[currentTimeline]
  local activeBeam = indexToRowCol(beamCoord[currentTimeline])
  local activeRow = activeBeam[1]
  --print("active row " .. activeRow)
  --print("cursor " .. cursor)
  print(timelines[currentTimeline])
  --local activeCol = activeBeam[2]
  
  for i = activeRow,numberOfRows
  do
    if (string.sub(timelines[currentTimeline],cursor+rowLength,cursor+rowLength) == "^")
    then
      
      --replaceIndexOfString(timelines[currentTimeline],cursor+17,"1")
      table.insert(timelines,replaceIndexOfString(timelines[currentTimeline],cursor+rowLength+1,"1"))
      table.insert(beamCoord,cursor+rowLength+1)
      
      --string.format("%s%s%s", string.sub(timelines[currentTimeline],1,cursor+rowLength-2), "1^.", string.sub(originalString,cursor+rowLength+2))
      timelines[currentTimeline] = string.format("%s%s%s", string.sub(timelines[currentTimeline],1,cursor+rowLength-2), "1^.", string.sub(timelines[currentTimeline],cursor+rowLength+2))
      cursor = cursor + rowLength-1
    end
    if (string.sub(timelines[currentTimeline],cursor+rowLength,cursor+rowLength) == ".")
    then
      
      --replaceIndexOfString(timelines[currentTimeline],cursor+rowLength,"1")
      timelines[currentTimeline] = replaceIndexOfString(timelines[currentTimeline],cursor+rowLength,"1")
      cursor = cursor + rowLength
      
    end
  end
  
  print()
  print(timelines[currentTimeline])
  
  currentTimeline = currentTimeline + 1
  
until (finalTimeline(timelines[currentTimeline-1],beamCoord[currentTimeline-1]) == true)

print(#timelines)


--------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------

