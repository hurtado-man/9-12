use context dcic2024
include csv
include data-source
fun leap-year(year :: Number) -> Boolean:
  doc: "This will calculate if the year will be a leap year"
  new_year = year / 4 
  num-is-integer(new_year)
where:#This below will test the function to see if it is working correctly
  leap-year(2024) is true
  leap-year(2023) is false
  leap-year(2028) is true
end

fun tick(number :: Number) -> Number:
  doc: "This will give the next second"
  ask:
    | number == 59 then: 0
    | number > 60 then: "error"
    | number < 60 then: number + 1
  end
where: 
  tick(59) is 0
  tick(50) is 51
end
    
fun rock-paper-scissors(Player_1 :: String, Player_2 :: String) -> String:
  doc: "This will determine who will win in this game"
  ask:
    | (Player_1 == Player_2) then: "Tie"
    | (Player_1 == "Rock") and (Player_2 == "Paper") then: "Player 2"
    | (Player_1 == "Rock") and (Player_2 == "Scissors") then: "Player 1"
    | (Player_2 == "Rock") and (Player_1 == "Paper") then: "Player 1"
    | (Player_2 == "Rock") and (Player_1 == "Scissors") then: "Player 2"
    | (Player_1 == "Paper") and (Player_2 == "Scissors") then: "Player 2"
    | (Player_1 == "Paper") and (Player_2 == "Rock") then: "Player 1"
    | (Player_2 == "Paper") and (Player_1 == "Scissors") then: "Player 1"
    | (Player_2 == "Paper") and (Player_1 == "Rock") then: "Player 2"
    | (Player_1 == "Scissors") and (Player_2 == "Rock") then: "Player 2"
    | (Player_1 == "Scissors") and (Player_2 == "Paper") then: "Player 1"
    | (Player_2 == "Scissors") and (Player_1 == "Rock") then: "Player 1"
    | (Player_2 == "Scissors") and (Player_1 == "Paper") then: "Player 2"
    | otherwise: "Invalid Choice"
  end
where:
  rock-paper-scissors("Rock", "Scissors") is "Player 1"
  rock-paper-scissors("Scissors", "Rock") is "Player 2"
  rock-paper-scissors("Fake", "Answer") is "Invalid Choice"
end

Planets = table: Name :: String, Distance :: Number
  row: "Mercury",	0.39
  row: "Venus",	0.72
  row: "Earth",	1
  row: "Mars",	1.52
  row: "Jupiter",	5.2
  row: "Saturn",	9.54
  row: "Uranus",	19.2
  row: "Neptune",	30.06
end
mars = Planets.row-n(3)
mars["Distance"]

something = load-table:
  year :: Number,
  day :: Number,
  month :: String,
  rate :: Number
  source: csv-table-file("boe_rates.csv", default-options)
  sanitize year using num-sanitizer
  sanitize day using num-sanitizer
  sanitize rate using num-sanitizer
end
median(something, "rate")
#The median rate is 5
modes(something, "rate")
#The mode is 4
something.increasing-by("rate")
#The minimum is 0.1
something.decreasing-by("rate")
#The maximum is 17

