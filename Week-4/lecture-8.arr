use context dcic2024
include csv
include data-source
items = table: item :: String, x-coordinate :: Number, y-coordinate :: Number
  row: "Sword of Dawn",           23,  -87
  row: "Healing Potion",         -45,   12
  row: "Dragon Shield",           78,  -56
  row: "Magic Staff",             -9,   64
  row: "Elixir of Strength",      51,  -33
  row: "Cloak of Invisibility",  -66,    5
  row: "Ring of Fire",            38,  -92
  row: "Boots of Swiftness",     -17,   49
  row: "Amulet of Protection",    82,  -74
  row: "Orb of Wisdom",          -29,  -21
end

#This is the first problem
new_tablex = transform-column(items, "x-coordinate", lam(n): n * 0.1 end)
new_tablexandy = transform-column(new_tablex, "y-coordinate",lam(r): r * 0.1 end)

#This is the second problem
fun calc-distance(r :: Row) -> Number:
    rough-distance = num-sqrt(
      num-sqr(r["x-coordinate"]) + num-sqr(r["y-coordinate"]))
      num-exact(rough-distance)
end

better_table = build-column(new_tablexandy, "distance", calc-distance)
better_table
better_order = order-by(better_table, "distance", true)

better_order.row-n(0) #This is the closest item that is closest to the person

#This is the third problem
fun many_x(r :: String) -> String:
  string-repeat("X", string-length(r))
end
obscuretable = transform-column(items, "item", many_x)
obscuretable

#This is the fourth problem 





