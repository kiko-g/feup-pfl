module BigNumber where

------------------------ 2.1 ------------------------
type BigNumber = [Int]

------------------------ 2.2 ------------------------
removeLeftZeros :: String -> String
removeLeftZeros ('-' : '0' : ss) = removeLeftZeros ('-' : ss)
removeLeftZeros ('0' : ss) = removeLeftZeros ss
removeLeftZeros str = str

scanner :: String -> BigNumber
scanner ('-' : '0' : cs) = scanner ('-' : removeLeftZeros ('0' : cs))
scanner ('-' : c : cs) = - read [c] : map (\c -> read [c :: Char] :: Int) cs
scanner str = map (\c -> read [c :: Char] :: Int) (removeLeftZeros str)

------------------------ 2.3 ------------------------
output :: BigNumber -> String
output bn = removeLeftZeros (concatMap show bn)

------------------------ 2.4 ------------------------
-- fill number with left hand zeros until length is n (used so that BigNumbers can have same length)
padLeftZeros :: BigNumber -> Int -> BigNumber
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

-- fix sum result carry outs
carrySumRev :: BigNumber -> BigNumber
carrySumRev [] = []
carrySumRev [a]
  | a > 9 = (a - 10) : [1]
  | otherwise = a : carrySumRev []
carrySumRev (a : b : rest)
  | a > 9 = a - 10 : carrySumRev (b + 1 : rest)
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

------------------------ 2.5 ------------------------
-- fix sum result carry outs
carrySubRev :: BigNumber -> BigNumber
carrySubRev [] = []
carrySubRev [a] = [a]
carrySubRev (a : b : rest)
  | a > 9 = a - 10 : carrySubRev (b + 1 : rest)
  | a < 0 = a + 10 : carrySubRev (b - 1 : rest)
  | otherwise = a : carrySubRev (b : rest)

carrySub :: BigNumber -> BigNumber
carrySub bn = reverse (carrySubRev (reverse bn))

dealWithBiggerDraw :: BigNumber -> BigNumber -> Int -> (BigNumber, BigNumber)
dealWithBiggerDraw x y i | length x <= i = (x, y)
dealWithBiggerDraw [x] [y] _
  | x > y = ([x], [y])
  | otherwise = ([y], [x])
dealWithBiggerDraw x y i
  | a > b = (x, y)
  | a < b = (y, x)
  | otherwise = dealWithBiggerDraw x y (i + 1)
  where
    a = x !! i
    b = y !! i

dealWithBigger :: BigNumber -> BigNumber -> BigNumber
dealWithBigger x [] = x
dealWithBigger [] y = y
dealWithBigger (x : xs) (y : ys)
  | x > y = zipWith (-) (x : xs) (y : ys)
  | x < y = changeSign (zipWith (-) (y : ys) (x : xs))
  | otherwise = uncurry (zipWith (-)) pair
  where
    pair = dealWithBiggerDraw (x : xs) (y : ys) 0

subBNResult :: BigNumber -> BigNumber -> BigNumber
subBNResult x y
  | length x == length y = dealWithBigger x y
  | length x > length y = zipWith (-) x (padLeftZeros y (length x))
  | otherwise = zipWith (-) (padLeftZeros x (length y)) y

subBN :: BigNumber -> BigNumber -> BigNumber
subBN [] [] = []
subBN xs [] = xs
subBN [] ys = ys
subBN (x : xs) (y : ys)
  | isPositive (x : xs) && isPositive (y : ys) = carrySub (subBNResult (x : xs) (y : ys))
  | isPositive (x : xs) && isNegative (y : ys) = somaBN (x : xs) (- y : ys)
  | isNegative (x : xs) && isPositive (y : ys) = changeSign (somaBN (- x : xs) (y : ys))
  | otherwise = carrySub (subBNResult (- y : ys) (- x : xs))

------------------------ 2.6 ------------------------
-- muliply every digit by 10^i :: [1,2,3] becomes [100,20,3]
padMulDivAux :: BigNumber -> Int -> BigNumber
padMulDivAux [] _ = []
padMulDivAux (x : xs) i = padMulDivAux xs (i + 1) ++ [x * 10 ^ i]

padMulDiv :: BigNumber -> BigNumber
padMulDiv bn = padMulDivAux (reverse bn) 0

-- multiply every x by every y (after padding) and summing the result recursively
-- to make use of zipWith, y is replicated to match length of xs
-- 222 * 3 = zipWith (*) [200, 20, 2] [3,3,3]
mulCycle :: BigNumber -> BigNumber -> BigNumber
mulCycle [] _ = []
mulCycle _ [] = []
mulCycle xs (y : ys) = somaBN (scanner (output [sum (zipWith (*) (replicate (length xs) y) xs)])) (mulCycle xs ys)

mulBN :: BigNumber -> BigNumber -> BigNumber
mulBN x y = mulCycle (padMulDiv x) (padMulDiv y)

------------------------ 2.7 ------------------------
divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)
divBN x y = ([0], [0])
