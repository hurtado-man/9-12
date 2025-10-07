include csv
include data-source

voter-data =
  load-table: VoterID,DOB,Party,Address,City,County,Postcode
  source: csv-table-url("https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/voters.csv", default-options)
end

voter-data

fun normalize-data(s :: String) -> String:
  y = string-substring(s, 6, 10)
  m = string-substring(s, 3, 5)
  d = string-substring(s, 0, 2)
  y + "-" + m + "-" + d
  
end 
  
new_table = transform-column(voter-data, "DOB", normalize-data)
new_table

fun normalize-postcode(postcode :: String) -> String:
  upper_case = string-to-upper(postcode)
  if string-length(upper_case) == 6:
    last2 = string-substring(upper_case, 3, 6)
    first2 = string-substring(upper_case, 0, 3)
    first2 + " " + last2
  else if string-length(upper_case) == 7:
    last1 = string-substring(upper_case, 4, 7)
    first1 = string-substring(upper_case, 0, 4)
    first1 + " " + last1
  else: 
    postcode
  end
end

new2_table = transform-column(new_table, "Postcode", normalize-postcode)
new2_table
