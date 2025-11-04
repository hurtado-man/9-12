use context starter2024
data TaxonomyTree:
  node(rank :: String, name :: String, children :: List<TaxonomyTree>)
end

# Example: Part of the cat family
lion = node("Species", "Panthera leo", [list: ])
tiger = node("Species", "Panthera tigris", [list: ])
leopard = node("Species", "Panthera pardus", [list: ])
panthera = node("Genus", "Panthera", [list: lion, tiger, leopard])

house-cat = node("Species", "Felis catus", [list: ])
wildcat = node("Species", "Felis silvestris", [list: ])
felis = node("Genus", "Felis", [list: house-cat, wildcat])

felidae = node("Family", "Felidae", [list: panthera, felis])


fun count-nodes(t :: TaxonomyTree) -> Number:
   1 + count-nodes-children(t.children)
where:
  count-nodes(lion) is 1
  count-nodes(panthera) is 4
  count-nodes(felis) is 3
  count-nodes(felidae) is 8
end

fun count-nodes-children(c :: List<TaxonomyTree>) -> Number:
  cases (List) c:
    | empty => 0
    | link(first, rest) =>
      count-nodes(first) + count-nodes-children(rest)
  end
end

fun count-leaves(t :: TaxonomyTree) -> Number:
  cases (List) t.children:
    | empty => 1
    | else => count-leaves-children(t.children)
  end
where:
  count-leaves(lion) is 1
  count-leaves(panthera) is 3
  count-leaves(felis) is 2
  count-leaves(felidae) is 5
end

fun count-leaves-children(c :: List<TaxonomyTree>) -> Number:
  cases (List) c:
    | empty => 0
    | link(first, rest) =>
      count-leaves(first) + count-leaves-children(rest)
  end
end

#Design a function count-species that takes a TaxonomyTree and counts the number of nodes with the rank Species.

fun count-species(t :: TaxonomyTree) -> Number:
  if t.rank == "Species":
    1
  else: 
    count-species-children(t.children)
  end
where:
  count-species(lion) is 1
  count-species(panthera) is 3
  count-species(felis) is 2
  count-species(felidae) is 5
end

fun count-species-children(c :: List<TaxonomyTree>) -> Number:
  cases (List) c:
    | empty => 0
    | link(first, rest) =>
      count-species(first) + count-species-children(rest)
  end
end


#Design a function count-rank which takes a TaxonomyTree and a rank string that returns the number of nodes with that rank.

fun count-rank(t :: TaxonomyTree, r :: String) -> Number:
  if t.rank == r:
    1
  else:
    count-rank-children(t.children, r)
  end
where:
  count-rank(lion, "Species") is 1
  count-rank(lion, "Genus") is 0
  count-rank(felis, "Species") is 2
  count-rank(felidae, "Family") is 1
end

fun count-rank-children(c :: List<TaxonomyTree>, r :: String) -> Number:
  cases (List) c:
    | empty => 0
    | link(first, rest) => 
      count-rank(first, r) + count-rank-children(rest, r)
  end
end

#Design a function taxon-height that returns the number of levels in the TaxonomyTree (root is level 1).
#Use a num-max to determine height as we do not need to count all the branches, just the longest one (the deepest leaf).

fun taxon-height(t :: TaxonomyTree) -> Number:
  1 + taxon-height-children(t.children)
where:
  taxon-height(lion) is 1
  taxon-height(panthera) is 2
  taxon-height(felis) is 2
  taxon-height(felidae) is 3
end

fun taxon-height-children(c :: List<TaxonomyTree>) -> Number:
  cases (List) c:
    | empty => 0
    | link(first, rest) => taxon-height(first)
  end
end

#Design a function all-names that returns a list of all names in the TaxonomyTree (duplicates are okay). You'll need an all-names and all-names-list functions.

#Use appendLinks to an external site. to add to the list of children rather than link to prevent nested lists because we will encounter empty along the tree many times



fun all-names(t :: TaxonomyTree) -> List:
  link(t.name, all-names-list(t.children))
end

fun all-names-list(c :: List<TaxonomyTree>) -> List<String>:
  cases (List) c:
    | empty => [list: ]
    | link(first, rest) => append(all-names(first), all-names-list(rest))
  end
end

all-names(lion)
all-names(felidae)