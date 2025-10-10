use context dcic2024
import math as M
import statistics as S
import lists as L
#List operations 
cafe-data =
  table: day, drinks-sold
    row: "Mon", 45
    row: "Tue", 30
    row: "Wed", 55
    row: "Thu", 40
    row: "Fri", 60
  end

discount-codes = [list: "NEWYEAR", "student", "NONE", "student", "VIP", "none"]
unique-codes = distinct(discount-codes)

fun is-real-code(code :: String) -> Boolean:
  not(string-to-lower(code) == "none")
end
real-codes = filter(is-real-code, unique-codes)

higher-codes = map(string-to-upper, real-codes)
 
# we have three different codes now

response = [list: "yes", "NO", "maybe", "Yes", "no", "Maybe"]
unique-codes1 = distinct(response)
unique-codes2= map(string-to-lower, unique-codes1)
unique-codes3= distinct(unique-codes2)
new_list = filter(lam(l): not(l == "maybe") end, unique-codes3)


#Loops 

numbers = [list: 1, 2, 3, 4, 5]

fun multiple(num-list :: List) -> Number block:
  var total=1
  for each(n from num-list):
    total := total * n
  end
  total
where: multiple([list: 1, 2]) is 2
end
multiple(numbers)


fun even-num-sum(num1-list :: List) -> Number:
  sum1 = filter(lam(l): num-modulo(l, 2) == 0 end, num1-list)
  M.sum(sum1)
end
      
even-num-sum(numbers)
  
list-number1 = [list: 2, 4, 5, 6, 7]

fun my-length(list-n :: List) -> Number block:
  var count1 = 0
  for each(n from list-n):
    count1 := count1 + 1
  end
  count1
end

my-length(list-number1)

fun my-doubles(new_list1 :: List) -> List block:
  var doubled = [list: ]
  for each(n from new_list1):
    doubled := doubled.append([list: n * 2])
  end 
  doubled
end

my-doubles(list-number1)

new1 = map(lam(r): r * 2 end, list-number1)
new1

list5 = [list: "helllo", "hi", "hola"]
fun my-string-lens(f :: List) -> List block:
  var num-string = [list: ]
  for each(n from f):
    num-string := num-string.append([list: string-length(n)])
  end
  num-string
end

my-string-lens(list5)

new2 = map(lam(v): string-length(v) end, list5)
new2

fun my-alternating(g :: List) -> List block:
      var alt_list = [list: ]
      for each(n from g):
        alt_list := alt_list.append([list: n + 2])
      end
      alt_list
end

my-alternating(numbers)