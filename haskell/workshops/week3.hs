import Data.Char

-- 3.1
func31 :: (a -> b) -> (a -> Bool) -> [a] -> [b]
func31 f p xs = map f (filter p xs)

-- 3.2
dec2int :: [Int] -> Int
dec2int = foldl (\acc x -> 10 * acc + x) 0

-- 3.3
zipWithR :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWithR _ [] _ = []
zipWithR _ _ [] = []
zipWithR f (x : xs) (y : ys) = f x y : zipWithR f xs ys

-- 3.4
myInsert :: Ord a => a -> [a] -> [a]
myInsert e [] = [e]
myInsert e (x : xs) | e < x = e : x : xs
myInsert e (x : xs) = x : myInsert e xs

myIsort :: Ord a => [a] -> [a]
myIsort = foldr myInsert []

-- 3.5 a)
myMaximum :: Ord a => [a] -> a
myMaximum = foldl1 (\x y -> max x y)

myMinimum :: Ord a => [a] -> a
myMinimum = foldl1 (\x y -> min x y)

-- 3.5 b)
myFoldl1 :: (a -> a -> a) -> [a] -> a
myFoldl1 f l = foldl f (head l) (tail l)

myFoldr1 :: (b -> b -> b) -> [b] -> b
myFoldr1 f l = foldr f (last l) (init l)

-- 3.6
mdcPair :: Int -> Int -> (Int, Int)
mdcPair a b = until (\(x, y) -> y == 0) (\(x, y) -> (y, x `mod` y)) (a, b)

mdc :: Int -> Int -> Int
mdc a b = fst (mdcPair a b)

-- 3.7 a)

-- 3.7 b)

-- 3.7 c)
myReverseR :: [a] -> [a]
myReverseR = foldr (\b c -> c ++ [b]) []

-- 3.7 d)
myReverseL :: [a] -> [a]
myReverseL = foldl (\b c -> c : b) []

-- 3.8 a)
palavras :: String -> [String]
palavras str = palavrasAux [] str

palavrasAux :: [String] -> String -> [String]
palavrasAux l "" = reverse l
palavrasAux l str = palavrasAux (word : l) (if length rest > 0 then tail rest else "")
  where
      word = takeWhile (\char -> char /= ' ') str
      rest = dropWhile (\char -> char /= ' ') str

-- 3.8 b)
despalavras :: [String] -> String
despalavras l = drop 1 (foldr (\word acc -> ' ' : (word ++ acc)) "" l)


