use context dcic2024
include csv
include data-source
include lists
student_score = load-table:
  Name :: String,
  Surname :: String,
  Email :: String,
  Score :: Number
  source: csv-table-file("students_gate_exam_score.csv", default-options)
  sanitize Score using num-sanitizer
end
order-by(student_score, "Score", false)
order-by(student_score, "Score", false).row-n(0)
order-by(student_score, "Score", false).row-n(1)
order-by(student_score, "Score", false).row-n(2)

data Student:
  | student(name :: String, surname :: String, score :: Number)
end

s1 :: Student = student("Ethan", "Gray", 97)
s2 :: Student = student("Oscar", "Young", 92)
s3 :: Student = student("Adrian", "Bennet", 80)

scores = 
  link(s1.score, link(s2.score, link(s3.score, empty)))

scores

fun scores-count(l :: List) -> Number:
  doc: "this will count how many are greater than 90"
  cases (List) l:
    | empty => 0
    | link(f, r) => (if f > 90: 1 else: 0 end) + scores-count(r)
  end
  where:
  scores-count([list: 100, 91, 80]) is 2
  scores-count([list: 91, 80]) is 1
      scores-count([list: 80]) is 0
      scores-count([list: ]) is 0
end

scores-count(scores)

all-emails = student_score.get-column("Email")
all-emails


fun get-domain1(email :: String) -> String:
  doc: "this will split up the email and find the domain only"
  first-part = string-split(email, "@")
  better = first-part.get(1)
  better1 = string-split(better, ".")
  better1.get(0)
end

domains = map(get-domain1, all-emails)
uni-domain = distinct(domains)
uni-domain

fun replace-domain(email :: String) -> String:
  doc: "this will replace the ugly email with the better one"
  first-part = string-split(email, "@")
  username = first-part.get(0)
  domain = first-part.get(1)
  if domain == "nulondon.ac.uk":
    username + "@northeastern.edu"
  else:
    email
  end
end

all-emails-transformed = map(replace-domain, all-emails)

all-emails-transformed


