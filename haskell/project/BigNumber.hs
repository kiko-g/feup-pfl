module BigNumber where

-- 2.1
type BigNumber = [Int]

-- 2.2
scanner :: String -> BigNumber
scanner ('-' : c : cs) = -read [c] : scanner cs
scanner str = map (\c -> read [c :: Char] :: Int) str

-- 2.3
output :: BigNumber -> String
output = concatMap show

-- 2.4
-- somaBN :: BigNumber -> BigNumber -> BigNumber

-- 2.5
-- subBN :: BigNumber -> BigNumber -> BigNumber

-- 2.6
-- mulBN :: BigNumber -> BigNumber -> BigNumber

-- 2.7
-- divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)
