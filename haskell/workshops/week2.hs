import Data.Char

-- 2.1
sumIntSquares :: Int -> Int
sumIntSquares n = sum [x ^ 2 | x <- [1 .. n]]

-- 2.2 a)
aprox :: Int -> Double
aprox n = 4 * sum [(-1) ^ i / fromIntegral (2 * i + 1) | i <- [0 .. n]]

-- 2.2 b)
aprox2 :: Int -> Double
aprox2 n = sqrt (12 * sum [(-1) ^ i / fromIntegral (i + 1) ^ 2 | i <- [0 .. n]])

-- 2.3
dotprod :: [Float] -> [Float] -> Float
dotprod la lb = sum [x * y | (x, y) <- zip la lb]

-- 2.4
divprop :: Integer -> [Integer]
divprop n = [x | x <- [1 .. n `div` 2], n `mod` x == 0]

-- 2.5
perfeitos :: Integer -> [Integer]
perfeitos n = [x | x <- [1 .. n], x == sum (divprop x)]

-- 2.6
pitagoricos :: Integer -> [(Integer, Integer, Integer)]
pitagoricos n = [(x, y, z) | x <- vs, y <- vs, z <- vs, x ^ 2 + y ^ 2 == z ^ 2]
  where
    vs = [1 .. n]

-- 2.7
primo :: Integer -> Bool
primo n = length (divprop n) == 1

-- 2.8
binom :: Integer -> Integer -> Integer
binom n k = product [1 .. n] `div` (product [1 .. k] * product [1 .. (n - k)])

pascalAux :: Integer -> [Integer]
pascalAux n = [binom n x | x <- [0 .. n]]

pascal :: Integer -> [[Integer]]
pascal n = [pascalAux y | y <- [0 .. n]]

-- 2.9
intToChar :: Int -> Char
intToChar n = chr (n + ord 'A')

charToInt :: Char -> Int
charToInt c = ord c - ord 'A'

desloca :: Int -> Char -> Char
desloca k x
  | isUpper x = intToChar ((charToInt x + k) `mod` 26)
  | otherwise = x

cifra :: Int -> String -> String
cifra k s = [desloca k x | x <- s]

-- 2.10 a)
and' :: [Bool] -> Bool
and' xs = foldr (&&) True xs

-- 2.10 b)
or' :: [Bool] -> Bool
or' xs = foldr (||) False xs

-- 2.10 c)
concat' :: [[a]] -> [a]
concat' [] = []
concat' ([] : ys) = concat' ys
concat' ((x : xs) : ys) = x : concat' (xs : ys)

-- 2.10 d)
replicate' :: Int -> a -> [a]
replicate' 0 x = []
replicate' n x = x : replicate' (n -1) x

-- 2.10 e)
selecti' :: [a] -> Int -> a
selecti' list 0 = head list
selecti' list i = selecti' (tail list) (i -1)

-- 2.10 f)
elem' :: Eq a => [a] -> a -> Bool
elem' [] _ = False
elem' (x : xs) k = k == x || elem' xs k

-- 2.11

-- 2.12
forte :: String -> Bool
forte s = length s >= 8 && any isUpper s && any isLower s && any isNumber s

forte1 :: String -> Bool
forte1 s = length s >= 8 && or (forteCaps s) && or (forteLow s) && or (forteNum s)
  where
    forteLow = map isLower
    forteNum = map isNumber
    forteCaps = map isUpper

-- 2.13
mindiv :: Int -> Int
mindiv n = mindivAux n 2

mindivAux :: Int -> Int -> Int
mindivAux n d
  | n `mod` d == 0 = d
  | fromIntegral d > sqrt (fromIntegral n) = n
  | otherwise = mindivAux n (d + 1)

primo2 :: Int -> Bool
primo2 n = mindiv n == n

-- 2.14
-- take an element and next iteration
-- will receive a list without any ocurrence of it
nub' :: Eq a => [a] -> [a]
nub' [] = []
nub' (x : xs) = x : nub' [a | a <- xs, a /= x]

-- 2.15
intersperse :: a -> [a] -> [a]
intersperse _ [] = []
intersperse _ [x] = [x]
intersperse sep (x : xs) = x : sep : intersperse sep xs

-- 2.16
algarismos :: Int -> [Int]
algarismos n = reverse (algarismosRev n)

algarismosRev :: Int -> [Int]
algarismosRev 0 = []
algarismosRev n = n `mod` 10 : algarismosRev (n `div` 10)

-- 2.17
toBits :: Int -> [Int]
toBits n = reverse (toBitsRev n)

toBitsRev :: Int -> [Int]
toBitsRev 0 = []
toBitsRev n = n `mod` 2 : toBitsRev (n `div` 2)

-- 2.18
fromBits :: [Int] -> Int
fromBits [] = 0
fromBits (x : xs) = x * 2 ^ (length (x : xs) - 1) + fromBits xs

-- 2.19
mdc :: Int -> Int -> Int
mdc a b
  | b == 0 = a
  | otherwise = mdc b (a `mod` b)

-- 2.20 a)
insert' :: Ord a => a -> [a] -> [a]
insert' e [] = [e]
insert' e (x : xs)
  | e < x = e : x : xs
  | otherwise = x : insert' e xs

-- 2.20 b)
isort' :: Ord a => [a] -> [a]
isort' [] = []
isort' [x] = [x]
isort' (x : xs) = insert' x (isort' xs)

-- 2.21
minimum' :: Ord a => [a] -> a
minimum' [] = error "Found empty list"
minimum' [a] = a
minimum' (x : y : xs)
  | x < y = minimum' (x : xs)
  | otherwise = minimum' (y : xs)

delete' :: Eq a => a -> [a] -> [a]
delete' _ [] = []
delete' e (x : xs)
  | x == e = xs
  | otherwise = x : delete' e xs

ssort :: Ord a => [a] -> [a]
ssort [] = []
ssort [x] = [x]
ssort xs = e : ssort (delete' e xs)
  where
    e = minimum' xs

-- 2.22
merge :: Ord a => [a] -> [a] -> [a]
merge xs [] = xs
merge [] ys = ys
merge (x : xs) (y : ys)
  | x < y = x : merge xs (y : ys)
  | otherwise = y : merge (x : xs) ys

metades :: [a] -> ([a], [a])
metades xs = splitAt index xs
  where
    index = length xs `div` 2

msort :: Ord a => [a] -> [a]
msort [] = []
msort [x] = [x]
msort [a, b]
  | a < b = [a, b]
  | otherwise = [b, a]
msort l = merge (msort xs) (msort ys)
  where
    split = metades l
    xs = fst split
    ys = snd split

-- 2.23
addPoly :: [Int] -> [Int] -> [Int]
addPoly l [] = l
addPoly [] l = l
addPoly xs ys = zipWith (+) xs ys
