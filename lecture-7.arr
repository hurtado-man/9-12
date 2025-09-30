use context dcic2024
include csv
include data-source
orders = table: time, amount #This is the table
  row: "08:00", 10.50
  row: "09:30", 5.75
  row: "10:15", 8.00
  row: "11:00", 3.95
  row: "14:00", 4.95
  row: "16:45", 7.95
end

fun is-morning(r :: Row) -> Boolean:
  doc: "this function finds out if the time in the table is in the morning"
  r["time"] < "12:00"
where:
  is-morning(orders.row-n(2)) is true
  is-morning(orders.row-n(4)) is false 
end

filter-with(orders, lam(r): r["time"] < "12:00" end) #This uses the lamda function so i dont have to create another function to find the times that are less than 12:00

order-by(orders, "time", false)
order-by(orders, "time", false).row-n(2)

photos = load-table:
  location :: String,
  subject :: String, 
  date :: String
  source: csv-table-url("https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/photos.csv", default-options)
end

filter-with(photos, lam(r): r["subject"] == "Forest" end)
order-by(photos, "date", true)
photo_number = count(photos, "location")
order-by(photo_number, "count", false)

freq-bar-chart(photos, "location")