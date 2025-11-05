use context dcic2024
include csv
include data-source

penguins = load-table:
  name :: Number,
  species :: String,
  island :: String,
  bill_length_mm :: Number,
  bill_depth_mm :: Number,
  flipper_length_mm :: Number, 
  body_mass_g :: Number,
  sex :: String,
  year :: Number
  source: csv-table-file("penguins.csv", default-options)
    #All of the sanitation below will make the number parts of the list numbers and not strings which is the go-to
  sanitize name using num-sanitizer
  sanitize bill_length_mm using num-sanitizer
  sanitize bill_depth_mm using num-sanitizer
  sanitize flipper_length_mm using num-sanitizer
  sanitize body_mass_g using num-sanitizer
  sanitize year using num-sanitizer
end

penguins
  
#Scalar Problem, which is getting a single answer that is a number value 

#Question 1: Find out which penguin has the greatest bill length, Find a box plot of each differnt bill length of Penguin , and find the average bill length using a list scalar code.

order-by(penguins, "bill_length_mm", false) #This is the function that will find the one with the greatest bill length since false means decreasing from highest to lowest.
order-by(penguins, "bill_length_mm", false).row-n(0)
#This will extract the row with the greatest bill length
#The penguin that has the greastest bill length is a male penguin from Gentoo Species on Biscoe Island with a bill length of 59.6

# box-plot(penguins, "bill_length_mm")
#This is a box plot of the bill lengths of all the penguins and the photo shows some data of the max, min, first quarter, third quarter and median

fun find-sum(l :: List) -> Number:
  doc: "This function will find the sum of the entire column, which is because to find the average it is sum/length"
  cases (List) l:
    | empty => 0 #if the list is empty then the number is 0 since there is no numbers to add up
    | link(f, r) => f + find-sum(r)#when the first number is taken away it is added to the function of the rest of the list and the process is repeated
  end
where:#These are concrete examples that show that my function is working
  find-sum([list: 1, 2, 3, 4]) is 10
  find-sum([list: 1, 2, 3]) is 6
  find-sum([list: 1, 2]) is 3
  find-sum([list: 1]) is 1
  find-sum([list: ]) is 0
end

fun find-len(l :: List) -> Number: 
  doc: "This function will find the length of the list which is needed to find the average in anbtoher function and so we can use these functions in the next one" 
  cases (List) l: 
    | empty => 0 #if the list is empty then it is zero and wont be counted toward the number of elements in the list
    | link(f, r) => 1 + find-len(r)#This is because whenever the first element is taken it will be counted as one and the process will repeat for the rest of the list until it is empty
  end
where:#These are all of the concrete examples that show that the code that I wrote works for all different types of list, full and empty 
  find-len([list: 1, 2, 3, 4]) is 4
  find-len([list: 1, 2, 3]) is 3
  find-len([list: 1, 2]) is 2
  find-len([list: 1]) is 1
  find-len([list: ]) is 0
end

fun find-avg(l :: List) -> Number:
  doc: "This will take in account the other two functions that I created and will use them to find the average bill lenght of all of the total penguins"
  cases (List) l:
    | empty => raise("This list cannot be empty, average cannot be found")
    | else => find-sum(l) / find-len(l)
  end
where: #These are all of the concrete examples that show that the code I wrote works for all different types of lists that are both full and empty 
  find-avg([list: 1, 2, 3, 4]) is 10 / 4
  find-avg([list: 1, 2, 3]) is 2
  find-avg([list: 1, 2]) is 3 / 2
  find-avg([list: 1]) is 1
  find-avg([list: ]) raises "This list cannot be empty, average cannot be found"
end
#Now that i have the code set up for the functions, now I just have to use the list of bill lengths as the imputs to get the output of the average number

all_bill_lengths = penguins.get-column("bill_length_mm")
#This sets the list of all of the bill lenghts to a variable that can later be called easier than writing the full thing out 
      

find-avg(all_bill_lengths)
#this is me finally putting the varaible of the list of bill lengths as a list into the function and it returning the average bill length for all of the penguins at 43.9927

#Transformation Problem - setting up a function that takes a list and returns another list with a transformation to the numbers

#Question 2 - Gentoo male penguins are needed for an experiment to check their mass, but the researchers need it in Kilograms instead of grams, filter the table to only have the male gentoo penguins and use list transformation to make a list of the body mass in kilograms, then create a new column for this new information in the filtered table

fun is-gentoo(r :: Row) -> Boolean:
  if r["species"] == "Gentoo":
    true
  else:
    false 
  end
where:
  is-gentoo(penguins.row-n(0)) is false
  is-gentoo(penguins.row-n(152)) is true
end

gentoo-only =filter-with(penguins, is-gentoo)

filter-with(gentoo-only, lam(r): if r["sex"] == "male": true else: false end end)

