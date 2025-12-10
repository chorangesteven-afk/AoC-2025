function removeIndex(tab,index)
  for i = index,#tab-1
  do
    tab[index] = tab[index + 1]
  end
  tab[#tab] = nil
  return tab
end
