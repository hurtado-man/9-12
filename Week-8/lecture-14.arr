use context starter2024
data River:
  | merge(width :: Number, left :: River, right :: River)
  | stream(flow-rate :: Number)
end

# Example: A small river network
stream-a = stream(5)
stream-b = stream(3)
stream-c = stream(8)
merge-1 = merge(12, stream-a, stream-b)
main-river = merge(15, merge-1, stream-c)

# first problem 

fun count-streams(r :: River) -> Number:
  cases (River) r:
    | merge(width, left, right) => 0 + count-streams(left) + count-streams(right)
    | stream(flow) => 1
  end
where:
  count-streams(stream-a) is 1
  count-streams(main-river) is 3
end

# second problem 


fun max-width(r :: River) -> Number:
  cases (River) r:
    | merge(width, left, right) => num-max(width, num-max(max-width(left), max-width(right)))
    | stream(flow) => 0
  end
where:
  max-width(stream-a) is 0
  max-width(main-river) is 15
end

#Design a function widen-river that takes a river network and a number, and returns a new network where every merge point is wider by that amount.

fun widen-river(r :: River, n :: Number) -> River:
  cases (River) r: 
    | merge(width, left, right) => merge(width + n + widen-river(left, n), widen-river(right, n))
    | stream(flow) => stream(flow)
  end
where: 
  widen-river(stream-a, 2) is stream-a
end

#Design a function cap-flow that takes a river network and returns a new network where no stream has flow-rate above a given number (cap any higher values at the given number).

fun cap-flow(r :: River, n :: Number) -> River:
  cases (River) r:
    | merge(width, left, right) => merge(width, cap-flow(left, n), widen-river(right, n))
    | stream(flow) => stream(if flow > n: n else: flow end)
  end
where: cap-flow(stream-a, 3) is stream(3)
end

#Design a function has-large-stream that returns true if any stream in the network has flow-rate greater than 5.

fun has-large-stream(r :: River) -> Boolean:
  cases(River) r: 
    | merge(width, left, right) => has-large-stream(left) or has-large-stream(right)
    | stream(flow) => flow > 5
  end
  where:
  has-large-stream(stream-a) is false
end
      