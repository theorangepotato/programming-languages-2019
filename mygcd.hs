// run `ghci` in the command line
// then `:load mygcd.hs`
// then `mygcd 12 18`
// what happens for `mygcd 5 0?

mygcd :: Int -> Int -> Int
mygcd x y | x > y = mygcd (x-y) y
          | x < y = mygcd x (y-x)
          | otherwise = x