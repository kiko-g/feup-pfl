module BigNumber where

-- 2.1 type
type BigNumber = [Int]

-- 2.2 scanner
scanner :: String -> BigNumber
scanner ('-' : c : cs) = - read [c] : scanner cs
scanner str = map (\c -> read [c :: Char] :: Int) str

-- 2.3 output
output :: BigNumber -> String
output = concatMap show

-- 2.4 soma
-- fill number with left hand zeros so that BigNumbers can have same length
padLeftZeros :: BigNumber -> Int -> BigNumber
padLeftZeros (x : xs) n
  | x < 0 = x : padLeftZeros xs n
padLeftZeros x n
  | length x < n = padLeftZeros (0 : x) n
  | otherwise = x

-- check if big number is negative
isPositive :: BigNumber -> Bool
isPositive bn = head bn >= 0

-- check if big number is positive
isNegative :: BigNumber -> Bool
isNegative bn = head bn < 0

-- change sign of big number
changeSign :: BigNumber -> BigNumber
changeSign [] = []
changeSign (x : xs) = - x : xs

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
somaBN [] [] = []
somaBN xs [] = xs
somaBN [] ys = ys
somaBN (x : xs) (y : ys)
  | isPositive (x : xs) && isPositive (y : ys) = carrySum (somaBNResult (x : xs) (y : ys))
  | isPositive (x : xs) && isNegative (y : ys) = subBN (x : xs) (- y : ys)
  | isNegative (x : xs) && isPositive (y : ys) = subBN (y : ys) (- x : xs)
  | otherwise = changeSign (carrySum (somaBNResult (- x : xs) (- y : ys)))

-- 2.5 sub
carrySubRev :: BigNumber -> BigNumber
carrySubRev [] = []
carrySubRev [a]
  | a > 9 = (a - 10) : [1]
  | otherwise = a : carrySubRev []
carrySubRev (a : b : rest)
  | a > 9 = a - 10 : carrySubRev (b + 1 : rest)
  | (a < 0) && ((b - 1) == 0) = a + 10 : carrySubRev rest
  | a < 0 = a + 10 : carrySubRev (b - 1 : rest)
  | otherwise = a : carrySubRev (b : rest)

carrySub :: BigNumber -> BigNumber
carrySub bn = reverse (carrySubRev (reverse bn))

subBNResult :: BigNumber -> BigNumber -> BigNumber
subBNResult x y
  | length x == length y = zipWith (-) x y
  | length x > length y = zipWith (-) x (padLeftZeros y (length x))
  | otherwise = zipWith (-) (padLeftZeros x (length y)) y

subBN :: BigNumber -> BigNumber -> BigNumber
subBN [] [] = []
subBN xs [] = xs
subBN [] ys = ys
subBN (x : xs) (y : ys)
  | isPositive (x : xs) && isPositive (y : ys) = carrySub (subBNResult (x : xs) (y : ys))
  | isPositive (x : xs) && isNegative (y : ys) = somaBN (x : xs) (- y : ys)
  | isNegative (x : xs) && isPositive (y : ys) = changeSign (somaBN (y : ys) (- x : xs))
  | otherwise = changeSign (carrySub (subBNResult (- x : xs) (- y : ys)))

-- 2.6 mul
-- get integer as list
-- intToList :: Int -> BigNumber
-- intToList n = reverse (intToListRev n)

-- intToListRev :: Int -> BigNumber
-- intToListRev 0 = []
-- intToListRev n = n `mod` 10 : intToListRev (n `div` 10)

-- every number gets multiplied by 10*i :: [1,2,3] becomes [100,20,3]
padMulDivAux :: BigNumber -> Int -> BigNumber
padMulDivAux [] _ = []
padMulDivAux (x : xs) i = padMulDivAux xs (i + 1) ++ [x * 10 ^ i]

padMulDiv :: BigNumber -> BigNumber
padMulDiv bn = padMulDivAux (reverse bn) 0

mulCycle :: BigNumber -> BigNumber -> BigNumber
mulCycle [] _ = []
mulCycle _ [] = []
mulCycle xs (y : ys) = somaBN (scanner (output [sum (zipWith (*) (replicate (length xs) y) xs)])) (mulCycle xs ys) -- maybe use intToList

mulBN :: BigNumber -> BigNumber -> BigNumber
mulBN x y = mulCycle (padMulDiv x) (padMulDiv y)

-- 2.7
-- divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)
