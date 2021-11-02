-- 1.3
metades l = (take index l, drop index l)
  where
    index = length l `div` 2

-- 1.4 a)
last1 l = head (take (length l -1) l)

last2 l = head (reverse l)

-- 1.4 b)
init1 l = reverse (drop 1 (reverse l))

init2 l = reverse (tail (reverse l))

-- 1.6
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
classifica grade
  | grade <= 9 = "reprovado"
  | grade >= 10 && grade <= 12 = "suficiente"
  | grade >= 13 && grade <= 15 = "bom"
  | grade >= 16 && grade <= 18 = "muito bom"
  | grade >= 18 && grade <= 20 = "muito bom com distincao"
  | otherwise = error "Grade must be between 0 and 20"

-- 1.12
xor True True = False
xor True False = True
xor False True = True
xor False False = False

-- 1.14
curta1 l = length l <= 2

curta2 [] = True
curta2 [_] = True
curta2 [_,_] = True
curta2 l = False

-- 1.15
-- mediana x y z = 


-- 1.16
