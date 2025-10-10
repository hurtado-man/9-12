include csv
include data-source
include gdrive-sheets
#exercise 1


sheetID= "1LsHinDijGIMamDgsLp0FtxCJ5jc9GF92oXB17KsdDP8"
flight = load-spreadsheet(sheetID)




flights = load-table:
  rownames :: Number,
  dep_time :: Number,
  sched_dep_time :: Number,
  dep_delay :: Number,
  arr_time :: Number,
  sched_arr_time :: Number,
  arr_delay :: Number,
  carrier :: String,
  flight :: Number,
  tailnum :: String,
  origin :: String,
  dest :: String, 
  air_time :: Number, 
  distance :: Number, 
  hour :: Number,
  minute :: Number, 
  time_hour :: String
  source: flight.sheet-by-name("flights", true)
    
  sanitize rownames using num-sanitizer
  sanitize dep_time using num-sanitizer
  sanitize sched_dep_time using num-sanitizer
  sanitize dep_delay using num-sanitizer
  sanitize arr_time using num-sanitizer
  sanitize sched_arr_time using num-sanitizer
  sanitize flight using num-sanitizer
  sanitize air_time using num-sanitizer
  sanitize distance using num-sanitizer
  sanitize hour using num-sanitizer
  sanitize minute using num-sanitizer
end 

#this function will check the distance column and see if its more than 1500

fun is_long_flight(r :: Row) -> Boolean:
  doc: "This will check if the flight is longer than 1500"
  r["distance"] >= 1500
end 

#This will filter the flights and only keep the long flights 

long_flights = filter-with(flights, is_long_flight)

#This will order it by air time 

longest_flights = order-by(long_flights, "air_time", false)

#Extract the first row

longest_flights.row-n(0)

#exercise 2

fun is_delayed_departure(r :: Row) -> Boolean:
  doc: "this will check if the flight is delayed more than or equal to 30"
  r["dep_delay"] >= 30
end

fun is_morning_sched_dep(r :: Row) -> Boolean:
  doc: "This will check to see if the time is before noon"
  r["sched_dep_time"] < 1200
end

bad_delay = filter-with(flights, lam(r): r["dep_delay"] >= 30 end)
bad_morning_delay = filter-with(bad_delay, lam(r): r["sched_dep_time"] < 1200 end)
bad_morning_long_delayed_flights = filter-with(bad_morning_delay, lam(r): r["distance"] > 500 end)
#This above is creating the table that has more than 30 minute delays, before noon AND has a distance over 500, we linked all of these together using variables

ordered_table = order-by(bad_morning_long_delayed_flights, "dep_delay", false)#ordering it decending
ordered_table.row-n(0)
#extracting the highest one

#Exercise 3
new_table = transform-column(flights, "dep_delay", lam(r): if r < 0: 0 else: r end end)
new2_table = transform-column(new_table, "arr_delay", lam(r): if r < 0: 0 else: r end end)
#These 2 functions will make the arr delay and dep delay 0 if it is negative

new3_table = build-column(new2_table, "effective_speed", lam(r :: Row): if r["air_time"] < 0: 0 else: r["distance"] / (r["air_time"] / 60) end end)
#This builds the new column with the effective speed 

new4_table = order-by(new3_table, "effective_speed", false)
#ordering it decending
new4_table.row-n(0)
#extracting the highest one 

#Exercise 4
fun apply-arrival-discount(t :: Table) -> Table:
  doc: "This function will add the 20% discount if the arr_delay is in between 0 and 45"
  transform-column(t, "arr_delay", lam(n): if (n >= 0) and (n <= 45): 0.20 * n else: n end end)
end

discount_table = apply-arrival-discount(flights)
#making the discount apply to the flights table
discount2_table = transform-column(discount_table, "arr_delay", lam(n): if n < 0: 0 else: n end end)
discount3_table = transform-column(discount2_table, "dep_delay", lam(n): if n < 0: 0 else: n end end)
#This is going to make the arr delay and dep delay 0 if it is negative  

score_table = build-column(discount3_table, "on_time_score", lam(r :: Row): 100 - (r["dep_delay"] - r["arr_delay"]) - (r["air_time"] / 30) end) #This will build the new column
score2_table = transform-column(score_table, "on_time_score", lam(n): if n < 0: 0 else: n end end)
#This will make all of the scores 0 if they are negative 

score3_table = order-by(score2_table, "on_time_score", false)#ordering the scores decending
score4_table = order-by(score3_table, "distance", true)
#ordering the distance by accending

score4_table.row-n(0)#First place 
score4_table.row-n(1)#Second place




