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
  doc: "this will create a function that will allow for the filtering of penguins to only be gentoo ones and it does this by having an if statement that will check the row element of species and make sure it is gentoo, if so, then it will allow it to be added to the table."
  if r["species"] == "Gentoo":#checking if the row is a gentoo
    true
  else:
    false 
  end
where:#These show concrete proof that the function I made is correct and is working with putting in specific rows from the penguin table
  is-gentoo(penguins.row-n(0)) is false
  is-gentoo(penguins.row-n(152)) is true
end

gentoo-only =filter-with(penguins, is-gentoo) #This will filter the table for the first step that gets rid of all of the penguins that arent gentoo, then setting it up to a variable so we can further edit this table to then get rid of the females, this is done in the next step.  

question2-table = filter-with(gentoo-only, lam(r): if r["sex"] == "male": true else: false end end) #this function takes the gentoo only table and further filters it so it gets rid of all of the females. This is done by using an unnamed lamda function that has an if statement inside of it that checks if the row for sex is male, if not then it is filtered out of the table therefore giving us the new table. setting this equal to the var question2-table allows for the use of the table to be easily aquired just by typing in the variable

penguin-mass = question2-table.get-column("body_mass_g") #this function extracts the entire mass column of the new table made and turns it into a list, and I set it equal to the varaible so we can use this list for the function that will be created.

fun fix-mass(l :: List) -> List:
  doc: "This function will take all of the items in the list and edit them so that all of their masses are divided by 1000 to make the correct unit kilograms"
  cases (List) l: #this will take each item from the list and seperate it from first and rest and allow each item to be divided by 100
    | empty => empty
    | link(f, r) => link(f / 100, fix-mass(r))
  end
where: #this where block shows concrete proof that the code that I wrote is successful 
  fix-mass([list: 100, 200, 300, 400]) is [list: 1, 2, 3, 4]
  fix-mass([list: 100, 200, 300]) is [list: 1, 2, 3]
  fix-mass([list: 100, 200]) is [list: 1, 2]
  fix-mass([list: 100]) is [list: 1]
  fix-mass([list: ]) is [list: ]
end

fix-mass(penguin-mass) #this function satisfies the question, transforming the list into kilograms by dividing all of the items by 100. Now the researchers can use this data created by my code for their experiments. 

build-column(question2-table, "body_mass_kg", lam(r): r["body_mass_g"] / 100 end)
#this function above adds to the question-2 table and adds a column that has the body mass in kg rather than g.

#List selection - setting up a function that takes a list and returns a list with only specific elements that are desired 

#Question 3 - Researchers are now interested in chinstrap penguins female penguins and want to know how many of those penguins have a foot length over 200mm. Use list selection to find how many of those penguins are there and then filter the table afterwards using a table filter to show the new table.

only_chinstrap = filter-with(penguins, lam(r): if r["species"] == "Chinstrap": true else: false end end) #This built in function uses an unnamed function to filter the table so that only the chinstrap species penguins will show up. this is set to the variable only_chinstrap so we can again use this table for the next filter. 

question-3-table = filter-with(only_chinstrap, lam(r): if r["sex"] == "female": true else: false end end)#This built in function uses an innamed function to filter the table so that only the female chinstrap species penguin will show up. this is set to the variable question-3-table so we can reference this table to extract a list. 

penguin_list = question-3-table.get-column("flipper_length_mm")
#This is the list of the extracted flipper lengths (mm) from the penguins that are desired from the question

fun large_foot(l :: List) -> List:
  doc: "This function will select the elements in the list that are greater than or equal to 200 mm which uses list selection"
  cases (List) l: #This will filter the elements and when it gets to empty then the result will be an empty list
    | empty => empty
    | link(f, r) =>#we have to split this up further becasue we have to check if f is over 200 first before we deal with r
      ask:
        | f >= 200 then: link(f, large_foot(r))
        | otherwise: large_foot(r)
      end
  end
where: #all of these show concrete proof that i am testing all of my functions and that this function is working
  large_foot([list: 100, 200, 300, 400]) is [list: 200, 300, 400]
  large_foot([list: 100, 200, 300]) is [list: 200, 300]
  large_foot([list: 100, 200]) is [list: 200]
  large_foot([list: 100]) is [list: ]
  large_foot([list: ]) is [list: ]
end


large_foot(penguin_list)#this is the result of the function that I have created and the answer is 200 and 202 for only two of the penguins which means that only 2 penguins have foot lengths that are equal to or above 200 mm. 

filter-with(question-3-table, lam(r): if r["flipper_length_mm"] >= 200: true else: false end end)#this is the last part of the question that filters the question 3 table of only chinstrap female penguins further to only include the ones whos flipper lengths are equal to or larger than 200. 

#accumulation - creating a function that takes in a list and does something to the list but only by going through each element while using memory

#question 4 - Researches now want to work with only the data from penguins from 0 <= x <= 300, as the data after penguin #300 are skewed heavily. Filter these penguins out. Then after that the researches want to know the largest even bill depth. 


threehun-penguins = filter-with(penguins, lam(r): if r["name"] > 300: false else: true end end)
#This is me filtering out the penguions after 300 which is what the question asked. I did this by using an unamed lambda function inside the filter with function that gets rid of all of the penguins after name 300.

fun float-to-int(n :: Number) -> Number:
  num-round(n)
end

threehun-penguins3 = transform-column(threehun-penguins, "bill_depth_mm", float-to-int)
  

penguin_list4 = threehun-penguins3.get-column("bill_depth_mm") #this will extract the column bill depth mm from the correct table since we had to filter out all of the penguins over 300. I did this by using the get column function that will allow for the extraction of the column as a list.




fun my-even-acc(lis :: List):
  doc: "this function is an accumulator and this part of the function is the main one that calls another function that will compare the last element to the current one being read"
  m-even(0, lis)#this is the accumulator function
where:#these are all of my examples that show concrete proof that the function I created is working for not only the list extracted but for handmade lists too that I created.
  my-even-acc([list: 1, 2, 3, 4, 5]) is 4
  my-even-acc([list: 4, 5, 6, 7, 8]) is 8
  my-even-acc([list: 121, 3535, 354, 32435]) is 354
end

fun m-even(acc, lis):
  doc: "this is the second part of the function which is the most important part because it is going to compare the new value to the last value so that if it is larger and even, that will be the number assigned to acc."
  cases (List) lis:
    | empty => acc #if the list is empty than the highest things will also be the acc
    | link(f, r) => if num-modulo(f, 2) == 0:
        num-max(f, my-even-acc(r))#this is checking if the nunber is even and higher than the last element
      else: my-even-acc(r)
      end
end
end

my-even-acc(penguin_list4)



