-- 1.1

-- 1.2

-- 1.3
metades :: [a] -> ([a], [a])
metades l = (take index l, drop index l)
  where
    index = length l `div` 2

-- 1.4 a)
last1 :: [a] -> a
last1 l = head (take (length l -1) l)

last2 :: [a] -> a
last2 l = head (reverse l)

-- 1.4 b)
init1 :: [a] -> [a]
init1 l = reverse (drop 1 (reverse l))

init2 :: [a] -> [a]
init2 l = reverse (tail (reverse l))

-- 1.5
binom :: (Fractional a, Enum a) => a -> a -> a
binom n k = product [1 .. n] / (product [1 .. k] * product [1 .. (n - k)])

-- 1.6
raizes :: (Ord a, Floating a) => a -> a -> a -> (a, a)
raizes a b c = ((- b - b24ac) / (2 * a), (- b + b24ac) / (2 * a))
  where
    b24ac =
      if (b * b - 4 * a * c) < 0
        then error "Invalid numbers provided"
        else sqrt (b * b - 4 * a * c)

-- 1.7
{-
a) List of chars :t ['a','b','c']
b) Tuple of 3 chars :t ('a','b','c')
c) List of Tuples of 1 Bool and 1 Char :t [(False, '0'), (True, '1')]
d) Tuple of 1 List of Bool and 1 List of Char :t ([False, True], ['0', '1'])
e) List of List -> List functions :t [tail, init, reverse]
f) List of Bool -> Bool functions :t [id, not]
-}

-- 1.8

-- 1.9
classifica :: (Ord a, Num a) => a -> [Char]
classifica grade
  | grade <= 9 = "reprovado"
  | grade >= 10 && grade <= 12 = "suficiente"
  | grade >= 13 && grade <= 15 = "bom"
  | grade >= 16 && grade <= 18 = "muito bom"
  | grade >= 18 && grade <= 20 = "muito bom com distincao"
  | otherwise = error "Grade must be between 0 and 20"

-- 1.10

-- 1.11

-- 1.12
xor :: Bool -> Bool -> Bool
xor True True = False
xor True False = True
xor False True = True
xor False False = False

-- 1.13

-- 1.14
curta1 :: Foldable t => t a -> Bool
curta1 l = length l <= 2

curta2 :: [a] -> Bool
curta2 [] = True
curta2 [_] = True
curta2 [_, _] = True
curta2 l = False

-- 1.15
-- mediana x y z = 2

-- 1.16
