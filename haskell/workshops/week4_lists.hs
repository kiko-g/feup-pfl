import Data.List (delete)

-- 4.1
crivo :: [Integer] -> [Integer]
crivo [] = []
crivo (p : xs) = p : crivo [x | x <- xs, mod x p /= 0]

primos :: [Integer]
primos = crivo [2 ..]

factores :: Int -> [Int]
factores n
  | toInteger n `elem` take n primos = [n]
  | otherwise = factor : factores (n `div` factor)
  where
    factor = findPrimoDiv n primos

findPrimoDiv :: Int -> [Integer] -> Int
findPrimoDiv n [] = error "No primes list given"
findPrimoDiv n (x : xs)
  | n `mod` fromIntegral x == 0 = fromIntegral x
  | otherwise = findPrimoDiv n xs

-- 4.2
calcPi1 :: Int -> Double
calcPi1 n = sum $ take n $ zipWith (/) (cycle [4, -4]) [1, 3 ..]

calcPi2 :: Int -> Double
calcPi2 n = 3 + sum (take (n -1) $ zipWith (/) (cycle [4, -4]) special)
  where
    special = zipWith (*) [2, 4 ..] $ zipWith (*) [3, 5 ..] [4, 6 ..]

-- 4.3
intercalar :: a -> [a] -> [[a]]
intercalar x ys = (x : ys) : intercalarAux x 1 ys

intercalarAux :: a -> Int -> [a] -> [[a]]
intercalarAux x i ys
  | i > length ys = []
  | otherwise = (take i ys ++ (x : drop i ys)) : intercalarAux x (i + 1) ys

-- 4.4
perms :: Eq a => [a] -> [[a]]
perms [] = []
perms [x] = [[x]]
perms xs = [x : ps | x <- xs, ps <- perms (delete x xs)]

-- 4.5

-- 4.6 a)
binom :: Integer -> Integer -> Integer
binom n k = product [1 .. n] `div` (product [1 .. k] * product [1 .. (n - k)])

pascalLine :: Int -> [Int]
pascalLine n = [fromInteger (binom (fromIntegral n) (fromIntegral k)) | k <- [0 .. n]]

pascal :: [[Int]]
pascal = [pascalLine n | n <- [0 ..]]

-- 4.6 b)
binomBetter :: Integer -> Integer -> Integer
binomBetter n k
  | k < (n - k) = div (product [(n - k + 1) .. n]) (product [1 .. k])
  | otherwise = div (product [(k + 1) .. n]) (product [1 .. (n - k)])

pascalLineBetter :: Int -> [Int]
pascalLineBetter n = 1 : [fromInteger (binomBetter (fromIntegral n) (fromIntegral k)) | k <- [1 .. n - 1]] ++ [1]

pascalBetter :: [[Int]]
pascalBetter = [pascalLineBetter n | n <- [0 ..]]
