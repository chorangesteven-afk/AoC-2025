-- when splitter encountered, update the beam to the left, save new timeline with beam to the right

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

rowLength = string.find(input,"\n")
print("rowlength is: " .. rowLength)

print(#input + 1)

numberOfRows = (#input+1) / rowLength
print("number of rows: " .. numberOfRows)

primeTimeline = replaceIndexOfString(input,rowLength+(rowLength/2),"1")

print(primeTimeline)




whereIsTheBeam = {rowLength+(rowLength/2)}
print("beam is at " .. whereIsTheBeam[1])
--print(string.sub(primeTimeline,whereIsTheBeam[1]))




--------------------------------------------------------------------------------------------------

everyNewline = {}
randomVariable2 = 0
while true
do
  randomVariable2 = string.find(input,"\n",randomVariable2+1)
  if randomVariable2 == nil then break end
  table.insert(everyNewline,randomVariable2)
end
--print_table(everyNewline)


everySplitter = {}
randomVariable1 = 0
while true
do
  randomVariable1 = string.find(input,"%^",randomVariable1+1)
  if randomVariable1 == nil then break end
  table.insert(everySplitter,randomVariable1)
end
print_table(everySplitter)
print(#everySplitter)

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


--------------------------------------------------------------------------------------------------

function beamIsAtBottomRow(ind)
  local beamFinalRow = ((everyNewline[#everyNewline]+1 <= ind) and (ind <= #input))
  return beamFinalRow
end

--print(beamIsAtBottomRow(250))
--------------------------------------------------------------------------------------------------

function finalTimeline(timeline)
  
end

--------------------------------------------------------------------------------------------------

currentTimeline = 1




while true
do
  if currentTimeline  > #whereIsTheBeam then break end
  
  --print("current timeline is " .. currentTimeline)
  --print("number of timelines " .. #whereIsTheBeam)
  --print("where is the beam " .. whereIsTheBeam[currentTimeline])
  --print("same col 1 row below the beam: " .. whereIsTheBeam[currentTimeline] + rowLength)
  --print(string.sub(input,whereIsTheBeam[currentTimeline] + rowLength,whereIsTheBeam[currentTimeline] + rowLength))
  
  repeat
    
    --print("where is the beam at " .. whereIsTheBeam[currentTimeline])
    
    if (string.sub(input,whereIsTheBeam[currentTimeline] + rowLength,whereIsTheBeam[currentTimeline] + rowLength) == "^")
    then
      
      
      table.insert(whereIsTheBeam,whereIsTheBeam[currentTimeline] + rowLength + 1)
      
      whereIsTheBeam[currentTimeline] = whereIsTheBeam[currentTimeline] + rowLength  - 1
      
      goto continue
      
    end
    if (string.sub(input,whereIsTheBeam[currentTimeline] + rowLength,whereIsTheBeam[currentTimeline] + rowLength) == ".")
    then
      whereIsTheBeam[currentTimeline] = whereIsTheBeam[currentTimeline] + rowLength
    end
    
    ::continue::
    
    
  until (beamIsAtBottomRow(whereIsTheBeam[currentTimeline]))
  
  currentTimeline = currentTimeline + 1
  
  
end

print("final number of timelines " .. #whereIsTheBeam)


--------------------------------------------------------------------------------------------------

