proc foo*[T, W](A, B: openArray[T]; maxVal: W=W(0), unit: W=1.W): W =
  discard
echo foo("hi", "ho", unit=1.5)
