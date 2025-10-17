use context starter2024
fun string-concat(l :: List) -> String:
  cases (List) l:
    | empty => ""
    | link(f, r) => f + string-concat(r)
  end
where:
  string-concat([list: "Hello", "World"]) is "HelloWorld"
  string-concat([list: "world"]) is "world"
  string-concat([list: ]) is ""
  
end


string-concat([list: "Hello", "world"])

fun strings-upper(p :: List) -> List:
  cases (List) p:
    | empty => empty
    | link(f, r) => link(string-to-upper(f), strings-upper(r))
  end
where:
  strings-upper([list: "hello", "world"]) is [list: "HELLO", "WORLD"]
  strings-upper([list: "hello"]) is [list: "HELLO"]
  strings-upper([list: ]) is [list: ]
    end
      

fun round-numbers(d :: List) -> List:
  cases (List) d:
    | empty => empty
    | link(f, r) => link(num-round(f), round-numbers(r))
  end
where: 
  round-numbers([list: 9.2, 8.6]) is [list: 9, 9]
  round-numbers([list: 8.6]) is [list: 9]
  round-numbers([list: ]) is [list: ]
end