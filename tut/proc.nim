proc yes(question: string) : bool =
  echo question, " (y/n)"
  while true:
    case readLine(stdin)
    of "y", "Y", "yes", "Yes": return true
    of "n", "N", "no", "No": return false
    else: echo "Please be clear: yes or no"

if yes("Q1"):
  echo "oops, Aye!"
else:
  echo "yup, No!"
