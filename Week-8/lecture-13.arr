use context starter2024
fun my-pos-num(l):
  doc: "select for all positive numbers"
  cases (List) l:
    | empty => empty
    | link(f, r) => 
      ask:
        | f > 0 then: link(f, my-pos-num(r))
        | otherwise: my-pos-num(r)
      end
  end
where:
  my-pos-num([list: 1, -1, -2, 2]) is [list: 1, 2]
end



fun my-max(l):
  cases (List) l:
    | empty => raise("not defined for empty lists")
    | link(f, r) => 
      cases (List) r:
        | empty => f
        | link(fr, rr) => num-max(f, my-max(r))
      end
  end
where: 
  my-max([list: 1, 3, 4]) is 4
  my-max([list: ]) raises "not defined for empty lists"
end

fun my-running-sum(l):
  doc: "add up the numbers along a list"
  my-rs(0, l)
where:
  my-running-sum([list: 1, 2, 3]) is ([list: 1, 3, 6])
end

fun my-rs(acc, l):
  cases (List) l:
    | empty => empty
    | link(f, r) =>
      memory = f + acc
      link(memory, my-rs(memory, r))
  end
end


#Write a function called more-than-five which given a list of strings, creates a new list that contains only the elements with more than five characters

fun more-than-five(l :: List) -> List:
  cases (List) l:
    | empty => empty
    | link(f, r) => 
      ask: 
        | string-length(f) >= 5 then: link(f, more-than-five(r))
        | otherwise: more-than-five(r)
      end
  end
where:
  more-than-five([list: "hello", "world", "hi"]) is [list: "hello", "world"]
  more-than-five([list: "world", "hi"]) is [list: "world"]
  more-than-five([list: "hi"]) is [list: ]
  more-than-five([list: ]) is [list: ]
end

#Create a function called my-average that combines the my-len and my-sum functions from the last lecture. Develop your examples and raise an error when you encounter an empty list. (See 5.2.7.1 my-avg ExamplesLinks to an external site.)

fun my-sum(l):
  cases (List) l:
    | empty      => 0
    | link(f, r) => f + my-sum(r)
  end
end

fun my-len(l):
  cases (List) l:
    | empty      => 0
    | link(f, r) => 1 + my-len(r)
  end
end

fun my-avg(l):
  cases (List) l:
    | empty => raise("Can't do empty list")
    | else => my-sum(l) / my-len(l)
end
end


fun my-max-acc(l):
  m-m(0, l)
where:
  my-max-acc([list: 1, 2, 3]) is 3
end

fun m-m(acc, l):
  cases (List) l: 
    | empty => acc
    | link(f, r) =>
      ask: 
        | acc > f then: m-m(acc, r)
        | otherwise: m-m(f, r)
      end
  end
end


# fun my-alternating(l):
#   doc: "select all other elements" 
#   cases (List) l: 
#     | empty => empty
#     | link(f, r) => 
#       cases (List) r:
#         | empty => empty 
#         | link(fr, rr) => link(f, my-alternating(rr))
#       end
#   end
# where:
#   my-alternating([list: 1, 2, 3, 4]) is [list: 1, 3]
# end



fun my-alt(l, keep):
  cases (List) l:
    | empty => empty
    | link(f, r) =>
      if keep:
        link(f, my-alt(r, false))
      else:
        my-alt(r, true)
      end
  end
end

fun my-alternating(l):
  my-alt(l, true)
end