use context starter2024
string-to-upper("hello cs2000")

circle(15, "solid", "blue")

rectangle(300, 100, "solid", "yellow")

overlay(circle(50, "solid", "blue"), rectangle(300, 100, "solid", "yellow"))

above(rectangle(300, 100, "solid", "green"), rectangle(300, 100, "solid", "purple"))

rotate(90, rectangle(100, 20, "solid", "red"))

rotate(270, rectangle(100, 20, "solid", "red"))

overlay( text( "STOP", 40, "white"),
  overlay(
  regular-polygon(40, 8, "outline", "white"),
    regular-polygon(40, 8, "solid", "red")))

overlay( text( "Manny", 40, "Red"), 
  rectangle(300, 100, "solid", "white"))


