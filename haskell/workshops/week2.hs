import Data.Char

-- 2.1
sumIntSquares :: Int -> Int
sumIntSquares n = sum [x ^ 2 | x <- [1 .. n]]

-- 2.2 a)
aprox :: Int -> Double
aprox n = 4 * sum [(-1) ^ i / fromIntegral (2 * i + 1) | i <- [0 .. n]]

-- 2.2 b)
aprox2 :: Int -> Double
aprox2 n = sqrt (12 * sum [(-1) ^ i / fromIntegral (i + 1) ^ 2 | i <- [0 .. n]])

-- 2.3
dotprod :: [Float] -> [Float] -> Float
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
primo :: Integer -> Bool
primo n = length (divprop n) == 1

-- 2.8
binom :: Integer -> Integer -> Integer
binom n k = product [1 .. n] `div` (product [1 .. k] * product [1 .. (n - k)])

pascalAux :: Integer -> [Integer]
pascalAux n = [binom n x | x <- [0 .. n]]

pascal :: Integer -> [[Integer]]
pascal n = [pascalAux y | y <- [0 .. n]]

-- 2.9
intToChar :: Int -> Char
intToChar n = chr (n + ord 'A')

charToInt :: Char -> Int
charToInt c = ord c - ord 'A'

desloca :: Int -> Char -> Char
desloca k x
  | isUpper x = intToChar ((charToInt x + k) `mod` 26)
  | otherwise = x

cifra :: Int -> String -> String
cifra k s = [desloca k x | x <- s]

-- 2.10 a)
andR :: [Bool] -> Bool
andR [] = True
andR (x : xs) = x && andR xs

-- 2.10 b)
orR :: [Bool] -> Bool
orR [] = False
orR (x : xs) = x || orR xs

-- 2.10 c)
concatR :: [[a]] -> [a]
concatR [] = []
concatR ([] : ys) = concatR ys
concatR ((x : xs) : ys) = x : concatR (xs : ys)

-- 2.10 d)
replicateR :: Int -> a -> [a]
replicateR 0 x = []
replicateR n x = x : replicateR (n -1) x

-- 2.10 e)
selectiR :: [a] -> Int -> a
selectiR list 0 = head list
selectiR list i = selectiR (tail list) (i -1)

-- 2.10 f)
elemR :: Eq a => [a] -> a -> Bool
elemR [] _ = False
elemR (x : xs) k = (k == x) || elemR xs k

-- 2.11

-- 2.12
forte :: String -> Bool
forte s = length s >= 8 && any isUpper s && any isLower s && any isNumber s

forte1 :: String -> Bool
forte1 s = length s >= 8 && or (forteCaps s) && or (forteLow s) && or (forteNum s)

forteCaps :: String -> [Bool]
forteCaps = map isUpper

forteLow :: String -> [Bool]
forteLow = map isLower

forteNum :: String -> [Bool]
forteNum = map isNumber

-- 2.13
mindiv :: Int -> Int
mindiv n = mindivAux n 2

mindivAux :: Int -> Int -> Int
mindivAux n d
  | n `mod` d == 0 = d
  | fromIntegral d > sqrt (fromIntegral n) = n
  | otherwise = mindivAux n (d + 1)

primo2 :: Int -> Bool
primo2 n = mindiv n == n

-- 2.14 +++
nubR :: Eq a => [a] -> [a]
nubR (x : xs) = x : filter (/= x) (nubR xs)
nubR [] = []

-- 2.15
intersperse :: a -> [a] -> [a]
intersperse _ [] = []
intersperse _ [x] = [x]
intersperse sep (x : xs) = x : sep : intersperse sep xs

-- 2.16
algarismos :: Int -> [Int]
algarismos n = reverse (algarismosRev n)

algarismosRev :: Int -> [Int]
algarismosRev 0 = []
algarismosRev n = n `mod` 10 : algarismosRev (n `div` 10)

-- 2.17
toBits :: Int -> [Int]
toBits n = reverse (toBitsRev n)

toBitsRev :: Int -> [Int]
toBitsRev 0 = []
toBitsRev n = n `mod` 2 : toBitsRev (n `div` 2)

-- 2.18
fromBits :: [Int] -> Int
fromBits [] = 0
fromBits (x : xs) = x * (2 ^ (length (x : xs) - 1)) + fromBits xs

-- 2.19
mdc :: Int -> Int -> Int
mdc a b | b == 0 = a
mdc a b = mdc b (a `mod` b)

-- 2.20 a) +++
insertR :: Ord a => a -> [a] -> [a]
insertR e (x : xs) | e < x = e : x : xs
insertR e (x : xs) | e >= x = insertR e xs

-- 2.20 b)

-- 2.21

-- 2.22

-- 2.23
