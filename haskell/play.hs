-- mapM_ putStrLn (fizzbuzz [1..100])
fizzbuzz :: [Int] -> [String]
fizzbuzz [] = []
fizzbuzz (x : xs)
  | x `mod` 3 == 0 && x `mod` 5 == 0 = "FizzBuzz" : fizzbuzz xs
  | x `mod` 3 == 0 = "Fizz" : fizzbuzz xs
  | x `mod` 5 == 0 = "Buzz" : fizzbuzz xs
  | otherwise = show x : fizzbuzz xs
