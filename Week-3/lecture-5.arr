use context starter2024
#This is me adding to the hat function 
fun choose-hat(temp-in-C :: Number) -> String:
  doc: "determines appropriate head gear, with above 27C a sun hat, below nothing"
  if temp-in-C >= 27:
    "sun hat"
  else if (10 <= temp-in-C) and (temp-in-C < 27):#This is me adding the conditions
    "no hat"
  else:
    "winter hat" #If nothing else then it is a winter hat
  end
end


fun choose-glasses(temp-in-C :: Number) -> String:
  doc: "this function will pick out glasses for certain termperature"
  if temp-in-C >= 27:
    "and wear glasses"
  else:
    "but dont wear sunglasses" #If nothing else then it is a winter hat
  end
end

#Combining the two together
fun choose-outfit(Temp :: Number) -> String:
  doc: "This will add both functions together"
  if Temp >= 27: 
    "sun hat and wear sun glasses"
  else if (10 <= Temp) and (Temp < 27):
    "No hat and no sunglasses"
  else:
    "winter hat"
  end
end
