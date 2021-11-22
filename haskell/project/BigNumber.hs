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

-- 2.4
pad :: BigNumber -> Int -> BigNumber
pad (x : xs) n
  | x < 0 = x : pad xs n
pad x n
  | length x < n = pad (0 : x) n
  | otherwise = x

somaBN :: BigNumber -> BigNumber -> BigNumber
somaBN x y
  | length x == length y = zipWith (+) x y
  | length x > length y = zipWith (+) x (pad y (length x))
  | otherwise = zipWith (+) (pad x (length y)) y

-- 2.5
subBN :: BigNumber -> BigNumber -> BigNumber
subBN x y
  | length x == length y = zipWith (-) x y
  | length x > length y = zipWith (-) x (pad y (length x))
  | otherwise = zipWith (-) (pad x (length y)) y

-- 2.6
-- mulBN :: BigNumber -> BigNumber -> BigNumber

-- 2.7
-- divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)
