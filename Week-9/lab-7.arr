use context starter2024
data SensorNet:
  | hub(bandwidth :: Number, left :: SensorNet, right :: SensorNet)
  | sensor(rate :: Number)
end

# Example network
sA = sensor(60)
sB = sensor(120)
sC = sensor(45)

# You can construct larger networks like:
hub1 = hub(150, sA, sB)
core = hub(200, hub1, sC)

fun total-load(n :: SensorNet) -> Number:
  cases (SensorNet) n:
    | hub(bandwidth, left, right) => total-load(left) + total-load(right)
    | sensor(rate) => rate
  end
where:
  total-load(sA) is 60
  total-load(hub1) is 180
  total-load(core) is 225
end

fun fits-capacities(n :: SensorNet) -> Boolean:
  cases (SensorNet) n:
    | hub(bandwidth, left, right) => if bandwidth >= total-load(n): true else: false end
    | sensor(rate) => false
  end
where: 
  fits-capacities(hub1) is false
  fits-capacities(core) is false
end

fun deepest-depth(n :: SensorNet) -> Number:
cases(SensorNet) n:
    | hub(bandwidth, left, right) => 1 + deepest-depth(left) + deepest-depth(right)
    | sensor(rate) => 0
end
where: 
deepest-depth(core) is 2
deepest-depth(sA) is 0
  deepest-depth(hub1) is 1
end

fun apply-scale(n :: SensorNet, s :: Number) -> SensorNet:
  cases (SensorNet) n:
    | hub(bandwidth, left, right) => hub(bandwidth, apply-scale(left, s), apply-scale(right, s))
    | sensor(rate) => sensor(rate / s)
  end
where:
  apply-scale(sA, 2) is sensor(30)
  apply-scale(hub1, 2) is hub(150, sensor(30), sensor(60))
end

