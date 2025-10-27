use context dcic2024
#Write a function that converts Kilometers to Miles. A mile is 1.6 Kilometers. For example, 100 km is 62.5 miles and 250 km is 156.25 miles.

fun k-to-m(n :: Number) -> Number:
  doc: "this will calculate the km to m"
  (0.625 * n)
where: 
  k-to-m(100) is 62.5
  k-to-m(250) is 156.25
end

#Write a function that accepts an Air Quality Index aqi value and returns one of the following categories
# AQI	Category
# 0 - 50	Good
# 51 - 100	Moderate
# 101 - 150	Unhealthy
# 150+	Hazardous

fun aqi-to-cat(i :: Number) -> String:
  doc: "this will calculate the number to a specific catagory"
  if i < 0: 
    "AQI value not accepted"
  else if (i == 0) or (i <= 50):
    "Good"
  else if (i >= 51) and (i <= 100):
    "Moderate"
  else if (i >= 101) and (i <= 150):
    "Unhealthy"
  else if (i >= 151):
    "Hazardous"
  end
where:
    aqi-to-cat(10) is "Good"
    aqi-to-cat(60) is "Moderate"
    aqi-to-cat(125) is "Unhealthy"
    aqi-to-cat(200) is "Hazardous"
end

#Filter rows in the given table with the value "10" in the quantity column.

# Use the table below to write a table function called add-total that accepts a table with price and quantity columns and creates a new table adding a total column. The total column should be calculated using: price * quantity.

basket = table: item :: String, price :: Number, quantity :: Number
  row: "apple", 0.50, 10
  row: "orange", 0.75, 5
  row: "watermelon", 2.99, 2
end

basket


fun quantity(r :: Row) -> Boolean:
  doc: "this will check if the quantity is 10"
  if r["quantity"] == 10:
    true 
  else:
    false
  end
end


filter-with(basket, quantity)

build-column(basket, "total", lam(r): r["price"] * r["quantity"] end)



