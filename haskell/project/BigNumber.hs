module BigNumber where

-- 2.1
type BigNumber = [Int]

-- 2.2
scanner :: String -> BigNumber
scanner ('-' : c : cs) = - read [c] : scanner cs
scanner str = map (\c -> read [c :: Char] :: Int) str

-- 2.3
output :: BigNumber -> String
output = concatMap show

-- 2.4 +++ fix negative numbers
-- fill number with left hand zeros so that BigNumbers can have same length
padLeftZeros :: BigNumber -> Int -> BigNumber
padLeftZeros (x : xs) n
  | x < 0 = x : padLeftZeros xs n
padLeftZeros x n
  | length x < n = padLeftZeros (0 : x) n
  | otherwise = x

-- fix sum carry out
carrySumRev :: BigNumber -> BigNumber
carrySumRev [] = []
carrySumRev [a]
  | a > 9 = (a -10) : [1]
  | otherwise = a : carrySumRev []
carrySumRev (a : b : rest)
  | a > 9 = a -10 : carrySumRev (b + 1 : rest)
  | otherwise = a : carrySumRev (b : rest)

carrySum :: BigNumber -> BigNumber
carrySum bn = reverse (carrySumRev (reverse bn))

-- numbers need to have the same length, so we pad them with zeros if need be
somaBNResult :: BigNumber -> BigNumber -> BigNumber
somaBNResult x y
  | length x == length y = zipWith (+) x y
  | length x > length y = zipWith (+) x (padLeftZeros y (length x))
  | otherwise = zipWith (+) (padLeftZeros x (length y)) y

somaBN :: BigNumber -> BigNumber -> BigNumber
somaBN x y = carrySum (somaBNResult x y)

-- 2.5 +++ fix negative numbers
subBN :: BigNumber -> BigNumber -> BigNumber
subBN x y
  | length x == length y = zipWith (-) x y
  | length x > length y = zipWith (-) x (padLeftZeros y (length x))
  | otherwise = zipWith (-) (padLeftZeros x (length y)) y

-- 2.6
-- get integer as list
intToList :: Int -> BigNumber
intToList n = reverse (intToListRev n)

intToListRev :: Int -> BigNumber
intToListRev 0 = []
intToListRev n = n `mod` 10 : intToListRev (n `div` 10)

--
padMulDivAux :: BigNumber -> Int -> BigNumber
padMulDivAux [] _ = []
padMulDivAux (x : xs) i = padMulDivAux xs (i + 1) ++ [x * 10 ^ i]

padMulDiv :: BigNumber -> BigNumber
padMulDiv bn = padMulDivAux (reverse bn) 0

mulCycle :: BigNumber -> BigNumber -> BigNumber
mulCycle [] _ = []
mulCycle _ [] = []
mulCycle xs (y : ys) = somaBN (intToList (sum (zipWith (*) (replicate (length xs) y) xs))) (mulCycle xs ys)

mulBN :: BigNumber -> BigNumber -> BigNumber
mulBN x y = mulCycle (padMulDiv x) (padMulDiv y)

-- 2.7
-- divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)
