import Data.Char

-- 3.1
function :: (a -> b) -> (a -> Bool) -> [a] -> [b]
function f p xs = map f (filter p xs)

-- 3.2
dec2int :: [Int] -> Int
dec2int = foldl1 (\acc x -> acc * 10 + x)
-- dec2int list = foldr1 (\x acc -> acc*10 + x) (reverse list)

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
myAppend :: [a] -> [a] -> [a]
myAppend xs ys = foldr (:) ys xs

-- 3.7 b)
myConcat :: [[a]] -> [a]
myConcat = foldr (++) []

-- 3.7 c)
myReverseR :: [a] -> [a]
myReverseR = foldr (\x acc -> acc ++ [x]) []

-- 3.7 d)
myReverseL :: [a] -> [a]
myReverseL = foldl (\acc x -> x : acc) []

-- 3.7 e)
myElem :: Eq a => a -> [a] -> Bool
myElem e = foldl (\acc x -> x == e) False


-- 3.8 a)
palavras :: String -> [String]
palavras = palavrasAux []

palavrasAux :: [String] -> String -> [String]
palavrasAux l "" = reverse l
palavrasAux l str = palavrasAux (word : l) (if not (null rest) then tail rest else "")
  where
    word = takeWhile (/= ' ') str
    rest = dropWhile (/= ' ') str

-- 3.8 b)
despalavras :: [String] -> String
despalavras str = drop 1 (foldl (\acc word -> acc ++ " " ++ word) [] str)

-- 3.9
