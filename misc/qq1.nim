import macros

macro check(ex: untyped) =
  # this is a simplified version of the check macro from the
  # unittest module.

  # If there is a failed check, we want to make it easy for
  # the user to jump to the faulty line in the code, so we
  # get the line info here:
  var info = ex.lineinfo

  # We will also display the code string of the failed check:
  var expString = ex.toStrLit

  # Finally we compose the code to implement the check:
  result = quote do:
    if not `ex`:
      echo `info` & ": Check failed: " & `expString`

check(2 == 4)
check(2 != 4)
