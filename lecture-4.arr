use context starter2024
#1 writing good doc strings
fun area(width :: Number, height :: Number):
  doc:"calculate the area of a rectangle"
  width * height
end

#2 function design process
#This below is me writing out how i found the equation
(5 * 5) + (10 * string-length("Go Team!"))
(7 * 5) + (10 * string-length("Hellow World"))
fun tshirt-cost(number :: Number, saying :: String):
  doc: "Calculate the price for number of shirts and what it says"
  (number * 5) + (10 * string-length(saying))
end

tshirt-cost(50, "hello world")

#3 function design 2
fun celsius-to-fahrenheit(celsius :: Number):
  doc: "calculate from celsius to fahrenheit"
  (celsius * (9 / 5)) + 32
end
check: celsius-to-fahrenheit(0) is 32
end

#4 function design 3
fun fahrenheit-to-celsius(fahrenheit :: Number):
  doc: "Calculate from fahrenheit to celsius"
  (fahrenheit - 32) * (5 / 9)
end
check: fahrenheit-to-celsius(32) is 0
end

#5 creating functions from expressions 
overlay-align("center", "center", text( "STOP", 40, "white"),
  overlay(
  regular-polygon(40, 8, "outline", "white"),
    regular-polygon(40, 8, "solid", "red")))
#This is the regular equation for a stop sign
fun color-stop(color :: String) -> Image:
  doc: "make different colored stop signs"
  overlay-align("center", "center", text( "STOP", 40, "white"),
  overlay(
  regular-polygon(40, 8, "outline", "white"),
      regular-polygon(40, 8, "solid", color)))
end

color-stop("green")