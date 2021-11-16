-- 3.1
func31 :: (a -> b) -> (a -> Bool) -> [a] -> [b]
func31 f p xs = map f (filter p xs)

-- 3.2
dec2int :: [Int] -> Int
dec2int = foldl (\x y -> 10 * x + y) 0

-- 3.3
zipWithR :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWithR _ [] _ = []
zipWithR _ _ [] = []
zipWithR f (x : xs) (y : ys) = f x y : zipWithR f xs ys

-- 3.4
insertH :: Ord a => a -> [a] -> [a]
insertH e [] = [e]
insertH e (x : xs) | e < x = e : x : xs
insertH e (x : xs) = x : insertH e xs

isortH :: Ord a => [a] -> [a]
isortH = foldr insertH []

-- 3.5

-- 3.6
mdcPair :: Int -> Int -> (Int, Int)
mdcPair a b = until (\(x, y) -> y == 0) (\(x, y) -> (y, x `mod` y)) (a,b)

mdc :: Int -> Int -> Int
mdc a b = fst (mdcPair a b)

-- 3.7
reverseHR :: [a] -> [a]
reverseHR = foldr (\b c -> c ++ [b]) []

reverseHL :: [a] -> [a]
reverseHL = foldl (\b c -> c : b) []


-- 3.8
palavras :: String -> [String]
palavras str = [str, "aaa" ++ str]