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

