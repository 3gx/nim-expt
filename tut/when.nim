when system.hostOS == "windows":
  var str = "running on Windows!"
elif system.hostOS == "linux":
  var str =  "running on Linux!"
elif system.hostOS == "macosx":
  var str = "running on Mac OS X!"
else:
  var str =  "unknown operating system"

echo str

