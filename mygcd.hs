mygcd :: Int -> Int -> Int
mygcd x y | x > y = mygcd (x-y) y
          | x < y = mygcd x (y-x)
          | otherwise = x