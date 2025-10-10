use context starter2024
#this is me setting a trianlge to orange-triangle
orange-triangle = triangle(35, "solid", "orange")
print(orange-triangle)
#this is be evaluating the expression

#This is me setting the side length and colour as variables
sidelength = 35
blood-orange = "dark orange"
Solid = "solid"
square(sidelength, Solid, blood-orange)
#this is me using the variables instead of using only numbers and strings 
square(25, "solid", "dark-orange")#this is me showing that it ends up being the same

#I cannot set the same variable to another item as it does not make sense in the code 

Length = 300
width = 200
var Black-rectangle = rectangle(Length, width, "solid", "black")
radius = 50
Yellow-circle = circle(radius, "solid", "yellow")
overlay-align("center", "center", Yellow-circle, Black-rectangle)
#This is me using naming to make an image with naming
var a = rectangle(300, 200, "solid", "black")
var b = circle(50, "solid", "yellow")
overlay-align("center", "center", b, a)
# this is me using variables to show another way

#I have added names for length, width and radius instead of using the numbers 

#copying the yellow circles side by side
Yellow-circles = beside(circle(50, "solid", "yellow"), circle(50, "solid", "yellow"))
overlay-align("center", "center", Yellow-circles, Black-rectangle)
#This is me using naming to copy the circles side by side

Red-stripe = rectangle(300, 100, "solid", "red")
White-stripe = rectangle(300, 100, "solid", "white")
base-flag = above(White-stripe, Red-stripe)
blue-triangle = rotate(270, isosceles-triangle(200, 60, "solid", "blue"))

overlay-align("left", "center", blue-triangle, base-flag)