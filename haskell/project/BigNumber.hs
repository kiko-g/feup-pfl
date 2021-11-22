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

-- 2.4 +++ need to fix carry for sum/sub
padLeftZeros :: BigNumber -> Int -> BigNumber
padLeftZeros (x : xs) n
  | x < 0 = x : padLeftZeros xs n
padLeftZeros x n
  | length x < n = padLeftZeros (0 : x) n
  | otherwise = x

somaBN :: BigNumber -> BigNumber -> BigNumber
somaBN x y
  | length x == length y = zipWith (+) x y
  | length x > length y = zipWith (+) x (padLeftZeros y (length x))
  | otherwise = zipWith (+) (padLeftZeros x (length y)) y

-- 2.5
subBN :: BigNumber -> BigNumber -> BigNumber
subBN x y
  | length x == length y = zipWith (-) x y
  | length x > length y = zipWith (-) x (padLeftZeros y (length x))
  | otherwise = zipWith (-) (padLeftZeros x (length y)) y

-- 2.6
algarismos :: Int -> BigNumber
algarismos n = reverse (algarismosRev n)

algarismosRev :: Int -> BigNumber
algarismosRev 0 = []
algarismosRev n = n `mod` 10 : algarismosRev (n `div` 10)

padMulDivAux :: BigNumber -> Int -> BigNumber
padMulDivAux [] _ = []
padMulDivAux (x : xs) i = padMulDivAux xs (i + 1) ++ [x * 10 ^ i]

padMulDiv :: BigNumber -> BigNumber
padMulDiv bn = padMulDivAux (reverse bn) 0

mulBNAux1 :: BigNumber -> BigNumber -> BigNumber
mulBNAux1 [] _ = []
mulBNAux1 _ [] = []
mulBNAux1 xs (y : ys) = somaBN (algarismos (sum (zipWith (*) (replicate (length xs) y) xs))) (mulBNAux1 xs ys)

mulBN :: BigNumber -> BigNumber -> BigNumber
mulBN x y = mulBNAux1 (padMulDiv x) (padMulDiv y)

-- 2.7
-- divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)
