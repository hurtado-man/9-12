use context dcic2024
include csv
include data-source

plant = load-table:
  plant_common-name :: String,
  location_latitude :: Number,
  location_longitide :: Number,
  date_sighted :: String,
  soil_type :: String,
  plant_height_cm :: Number,
  plant_color :: String
  source: csv-table-url("https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/plant_sightings.csv", default-options)
end


Glucose_levels = load-table:
  patient_id :: Number,
  glucose_level :: Number,
  date_time :: String,
  insulin_dose :: Number,
  exercise_duration :: Number,
  stress_level :: Number
  source: csv-table-file("glucose_levels.csv", default-options)
end

world-bank = load-table:
  country :: String,
  life-exp :: Number,
  gdp :: Number
  source: csv-table-url("https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/life_exp_gdp.csv", default-options)
  sanitize life-exp using num-sanitizer
  sanitize gdp using num-sanitizer
end

lr-plot(world-bank, "gdp", "life-exp")
scatter-plot(world-bank, "life-exp", "gdp")