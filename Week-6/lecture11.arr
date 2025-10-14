use context starter2024
data Status: 
  | todo
  | in-progress
  | done
end
data Priority:
  | low
  | medium
  | high
end
data Task:
  | task(description :: String, priority :: Priority, status :: Status)
  | note(description :: String, status :: Status)  
end

task-1 = task("Buy groceries", low, todo)
task-2 = task("Pay council tax", high, done)
note-1 = note("Post Office closes at 4:30", done)

data Temperature:
  | fahrenheit(degree :: Number)
  | celcius(degree :: Number) 
  | kelvin(degree :: Number)
end

degree-1 = kelvin(300)

fun to-celcius(T :: Temperature) -> Number:
  cases (Temperature) T:
    | fahrenheit(d) => (5 / 9) * (d - 32)
    | kelvin(d) => d - 273.15
  end
end

to-celcius(fahrenheit(80))

data WeatherReport:
  | sunny(temperature :: Number)
  | rainy(temperature :: Number, precipitation :: Number)
  | snowy(temperature :: Number, precipitation :: Number, wind-speed :: Number)
end

fun is-severe(W :: WeatherReport) -> String:
  cases (WeatherReport) W:
    | sunny(t) => if t > 35: "True" else: "False" end
    | rainy(t, p) => if p > 20: "True" else: "False" end
    | snowy(t, p, s) => if s > 30: "True" else: "False" end
  end
end
      
