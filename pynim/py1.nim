import nimpy
let os = pyImport("os")
echo "Current dir is: ", os.getcwd().to(string)

# sum(range(1, 5))
let py = pyBuiltinsModule()
let s = py.sum(py.range(0, 5)).to(int)
assert s == 10

let np = pyImport("numpy")
let arr = np.array(py.list(py.range(0,5)))
let sq = np.sqrt(arr)
echo sq
echo type(sq)
