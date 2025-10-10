use context starter2024
# 1 T-Shirt Shop
(5 * 12) + 3
(7 * 12) + 3
# the results is that the price is more for the second one
(2 * (420 + 594)) * 0.10
# if you forget the () then it wont work due to an error

# 2 String Suprises
"Designs for everyone!"
# without the quotes on both sides it wont work
"red" + "blue"
# it turns into "redblue"
# you can't do 1 + "blue", there is an error

# 3 Make a Traffic light
# this will print the black rectangle for the background
rectangle(40, 100, "solid", "black")
var x = overlay-align("center", "top", circle(15, "solid", "red"), rectangle(40, 100, "solid", "black")) 
var y = overlay-align("center", "middle", circle(15, "solid", "yellow"), x)
overlay-align("center", "bottom", circle(15, "solid", "green"), y)
var z = overlay-align("center", "bottom", circle(15, "solid", "green"), y)
above(z, rectangle(5, 50, "solid", "gray"))
# I used the above code to make the stop-light above

# 4 Broken Code Hunt
# the error for the first one is that the numbers are not in the right order
#This printed a black rectangle because I have fixed the code
rectangle(50, 20, "solid", "black")
# above is the correct way
# the error for the second one is that there is supposed to be quotations around all strings
# this is printing out the red circle because i have fixed the code
circle(30, "solid", "red")

# 5 Create a Flag or Shield
var a = rectangle(300, 200, "solid", "light-blue")
var b = overlay-align("left", "top", star(50, "solid", "royal-blue"), a)
overlay-align("right", "top", rectangle(50, 200, "solid", "dark-red"), b)
# this is the flag
var c = rotate(45, square(100, "solid", "gray"))
var d = overlay-align("center", "center", star(55, "solid", "yellow"), c)
var e = overlay-align("center", "center", circle(10, "solid", "dark-red"), d)
overlay-align("middle", "middle", text("GO!", 10, "white"), e)
# this is my sheild

