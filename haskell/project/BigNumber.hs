module BigNumber
  ( BigNumber (..),
    scanner,
    output,
    somaBN,
    subBN,
    mulBN,
    divBN,
    safeDivBN,
  )
where

------------------------ 2.1 ------------------------
type BigNumber = [Int]

-----------------------------------------------------
------------ Generic Auxiliar functions -------------
-----------------------------------------------------
-- remove left hand zeros in string
removeLeftZeros :: String -> String
removeLeftZeros ('-' : '0' : ss) = removeLeftZeros ('-' : ss)
removeLeftZeros ('0' : ss) = removeLeftZeros ss
removeLeftZeros str = str

-- remove left hand zeros in BN
removeLeftZerosBN :: BigNumber -> BigNumber
removeLeftZerosBN (0 : xs) = xs
removeLeftZerosBN bn = bn

-- add hand zeros to a BN until length == n (used so that BigNumbers can have same length)
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
changeSign (0 : xs) = 0 : changeSign xs
changeSign (x : xs) = - x : xs

-- determine bigger BN number (2 functions below)
biggerDrawAux :: BigNumber -> BigNumber -> Int -> (BigNumber, BigNumber)
biggerDrawAux x y i | length x <= i = (x, y)
biggerDrawAux [x] [y] _
  | x > y = ([x], [y])
  | otherwise = ([y], [x])
biggerDrawAux x y i
  | a > b = (x, y)
  | a < b = (y, x)
  | otherwise = biggerDrawAux x y (i + 1)
  where
    a = x !! i
    b = y !! i

bigger :: BigNumber -> BigNumber -> (BigNumber, BigNumber)
bigger [] [] = ([], [])
bigger x [] = (x, [])
bigger [] y = ([], y)
bigger x y
  | isPositive x && isNegative y = (x, y)
  | isNegative x && isPositive y = (y, x)
  | (isPositive x && isPositive y) && (length x > length y) = (x, y)
  | (isPositive x && isPositive y) && (length x < length y) = (y, x)
  | (isNegative x && isNegative y) && (length x > length y) = (y, x)
  | (isNegative x && isNegative y) && (length x < length y) = (x, y)
bigger (x : xs) (y : ys)
  | x > y = (x : xs, y : ys)
  | x < y = (y : ys, x : xs)
  | isNegative (x : xs) && isNegative (y : ys) = (snd pairToSwitch, fst pairToSwitch)
  | otherwise = biggerDrawAux (x : xs) (y : ys) 0
  where
    pairToSwitch = biggerDrawAux (x : xs) (y : ys) 0

-----------------------------------------------------
------------------------ 2.2 ------------------------
-----------------------------------------------------
scanner :: String -> BigNumber
scanner ('-' : '0' : cs) = scanner ('-' : removeLeftZeros ('0' : cs))
scanner ('-' : c : cs) = - read [c] : map (\c -> read [c :: Char] :: Int) cs
scanner str = map (\c -> read [c :: Char] :: Int) (removeLeftZeros str)

-----------------------------------------------------
------------------------ 2.3 ------------------------
-----------------------------------------------------
output :: BigNumber -> String
output bn = removeLeftZeros (concatMap show bn)

-----------------------------------------------------
------------------------ 2.4 ------------------------
-----------------------------------------------------
-- fix sum result carry outs
carrySumRev :: BigNumber -> BigNumber
carrySumRev [] = []
carrySumRev [a]
  | a == 0 = []
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
  | length x > length y = zipWith (+) x y'
  | otherwise = zipWith (+) x' y
  where
    y' = padLeftZeros y (length x)
    x' = padLeftZeros x (length y)

somaBN :: BigNumber -> BigNumber -> BigNumber
somaBN xs [] = xs
somaBN [] ys = ys
somaBN (x : xs) (y : ys)
  | isPositive (x : xs) && isPositive (y : ys) = carrySum (somaBNResult (x : xs) (y : ys))
  | isPositive (x : xs) && isNegative (y : ys) = subBN (x : xs) (- y : ys)
  | isNegative (x : xs) && isPositive (y : ys) = subBN (y : ys) (- x : xs)
  | otherwise = changeSign (somaBN (- x : xs) (- y : ys))

-----------------------------------------------------
------------------------ 2.5 ------------------------
-----------------------------------------------------
-- fix sum result carry outs
carrySubRev :: BigNumber -> BigNumber
carrySubRev [] = []
carrySubRev [0] = []
carrySubRev [a] = [a]
carrySubRev x | x == replicate (length x) 0 = [0]
carrySubRev (a : b : rest)
  | a > 9 = a - 10 : carrySubRev (b + 1 : rest)
  | a < 0 = a + 10 : carrySubRev (b - 1 : rest)
  | otherwise = a : carrySubRev (b : rest)

carrySub :: BigNumber -> BigNumber
carrySub bn = reverse (carrySubRev (reverse (removeLeftZerosBN bn)))

subBNResult :: BigNumber -> BigNumber -> BigNumber
subBNResult x y
  | length x == length y && x == fst eqBigger = carrySub (uncurry (zipWith (-)) eqBigger)
  | length x == length y && y == fst eqBigger = changeSign (carrySub (uncurry (zipWith (-)) eqBigger))
  | length x > length y && x == fst gtBigger = carrySub (uncurry (zipWith (-)) gtBigger)
  | length x > length y && y == fst gtBigger = changeSign (carrySub (uncurry (zipWith (-)) gtBigger))
  | length x < length y && x == fst ltBigger = carrySub (uncurry (zipWith (-)) ltBigger)
  | otherwise = changeSign (carrySub (uncurry (zipWith (-)) ltBigger))
  where
    eqBigger = bigger x y
    gtBigger = bigger x (padLeftZeros y (length x))
    ltBigger = bigger y (padLeftZeros x (length y))

subBN :: BigNumber -> BigNumber -> BigNumber -- FIXME: check, its tricky
subBN [] [] = []
subBN xs [] = xs
subBN [] ys = ys
subBN (x : xs) (y : ys)
  | isPositive (x : xs) && isPositive (y : ys) = subBNResult (x : xs) (y : ys)
  | isPositive (x : xs) && isNegative (y : ys) = somaBN (x : xs) (- y : ys)
  | isNegative (x : xs) && isPositive (y : ys) = changeSign (somaBN (- x : xs) (y : ys))
  | otherwise = changeSign (subBN (- y : ys) (- x : xs))

-----------------------------------------------------
------------------------ 2.6 ------------------------
-----------------------------------------------------
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
mulCycle xs (y : ys) =
  somaBN
    (scanner (output [sum (zipWith (*) (replicate (length xs) y) xs)]))
    (mulCycle xs ys)

mulBN :: BigNumber -> BigNumber -> BigNumber -- FIXME: check, its almost 100%
mulBN x y = mulCycle (padMulDiv x) (padMulDiv y)

------------------------ 2.7 ------------------------
divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber) -- TODO: implement
divBN x y = ([0], [0]) 

------------------------  5. ------------------------
safeDivBN :: BigNumber -> BigNumber -> Maybe (BigNumber, BigNumber) -- FIXME: check when div is done
safeDivBN x y
  | y /= [0] = Just (divBN x y)
  | otherwise = Nothing

-----------------------------------------------------
---------------- Test functions -----------------
-----------------------------------------------------
