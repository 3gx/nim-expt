import locks

template withLock(lock: Lock, body: untyped) =
  acquire lock
  try:
    body
  finally:
    release lock

var lock: Lock
initLock lock

withLock lock:
  echo "Do something that requires locking"
  echo "This might throw an exception"

