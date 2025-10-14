use context dcic2024
include csv
include data-source
flights_53 = load-table:
  rownames :: Number,
  dep_time :: Number,
  sched_dep :: Number,
  dep_delay :: Number,
  arr_time :: Number,
  sched_arr :: Number,
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
  source: csv-table-file("flights_sample53.csv", default-options)
  sanitize rownames using num-sanitizer
  sanitize dep_time using num-sanitizer
  sanitize sched_dep using num-sanitizer
  sanitize dep_delay using num-sanitizer
  sanitize arr_time using num-sanitizer
  sanitize sched_arr using num-sanitizer
  sanitize arr_delay using num-sanitizer
  sanitize air_time using num-sanitizer
  sanitize distance using num-sanitizer
  sanitize hour using num-sanitizer
  sanitize minute using num-sanitizer
end

#First problem
flights1_53 = transform-column(flights_53, "tailnum", lam(r): if r == "": "UKNOWN" else: r end end)

#Second problem
flights2_53 = transform-column(flights1_53, "dep_delay", lam(r): if r < 0: 0 else: r end end)
flights3_53 = transform-column(flights2_53, "arr_delay", lam(r): if r < 0: 0 else: r end end)
flights3_53

#Third problem 
# Trim spaces at both ends
fun trim(s :: String) -> String:
  doc: "Remove spaces from the given string."
  n = string-length(s)
  trim1 = if n == 0:
    ""
  else:
    string-replace(s, " ", "")
  end
  string-to-upper(trim1)
end

flights4_53 = transform-column(flights3_53, "carrier", trim)

fun HHMM(n :: Number) -> String:
  block:
  hour1 = num-floor(n / 100)
    hour2 = if hour1 < 10:
      "0" + num-to-string(hour1)
    else: 
      num-to-string(hour1) 
    end
  minute = num-modulo(n, 100)
    minute2 = if minute < 10:
      "0" + num-to-string(minute)
    else:
      num-to-string(minute)
    end
    hour2 + ":" + minute2
  end
end

flights5_53 = transform-column(flights4_53, "dep_time", HHMM)
flights5_53

flight6_53 = build-column(flights5_53, "dedup_key", lam(r): r["flight"] + "-" + r["carrier"] + "-" + r["dep_time"] end)
flight6_53

# freq-bar-chart(flight6_53, "dedup_key")


group(flight6_53, "dedup_key")
#Duplicates would be 4662-MQ-21:10, 316-WN-11:26, and 3895-WN-09:33

freq-bar-chart(flight6_53, "carrier")
histogram(flight6_53, "distance", 1)
scatter-plot(flight6_53, "air_time", "distance")

flight6_53.get-column("distance")

