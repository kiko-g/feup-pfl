import Data.Char

-- 2.1
sumIntSquares n = sum [x ^ 2 | x <- [1 .. n]]

-- 2.2 a)
aprox n = 4 * sum [(-1) ^ i / fromIntegral (2 * i + 1) | i <- [0 .. n]]

-- 2.2 b)
aprox2 n = sqrt (12 * sum [(-1) ^ i / fromIntegral (i + 1) ^ 2 | i <- [0 .. n]])

-- 2.3
dotprod la lb = sum [x * y | (x, y) <- zip la lb]

-- 2.4
divprop :: Integer -> [Integer]
divprop n = [x | x <- [1 .. n `div` 2], n `mod` x == 0]

-- 2.5
perfeitos :: Integer -> [Integer]
perfeitos n = [x | x <- [1 .. n], x == sum (divprop x)]

-- 2.6
pitagoricos :: Integer -> [(Integer, Integer, Integer)]
pitagoricos n =
  [ (x, y, z)
    | x <- [1 .. n],
      y <- [1 .. n],
      z <- [1 .. n],
      x ^ 2 + y ^ 2 == z ^ 2
  ]

-- 2.7

-- 2.9
intToChar :: Int -> Char
intToChar n = chr (n + ord 'A') -- CONVERTE INTEIRO PARA CHAR

charToInt :: Char -> Int
charToInt c = ord c - ord 'A' -- CONVERTE CHAR INTEIRO

-- DESCOLA K POSICOES
desloca :: Int -> Char -> Char
desloca k x
  | isUpper x = intToChar ((charToInt x + k) `mod` 26)
  | otherwise = x

cifra :: Int -> [Char] -> [Char]
cifra k s = [desloca k x | x <- s]