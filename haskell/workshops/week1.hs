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
{- Defina uma função textual :: Int -> String para converter um número positivo
inferior a um milhão para a designação textual em Português. Baseado na solução no
livro "Introduction to Functional Programming" de Bird & Wadler, 1988. Vamos começar
por resolver um problema mais pequeno: converter para texto nºs inferiores a 100 (ie, até 2 algarismos).
Começamos por definir listas com a representação textual de numeros pequenos. -}

unidades :: [String]
unidades = ["zero", "um", "dois", "tres", "quatro", "cinco", "seis", "sete", "oito", "nove"]

dezADezanove :: [String]
dezADezanove = ["dez", "onze", "doze", "treze", "quatorze", "quinze", "dezasseis", "dezassete", "dezoito", "dezanove"]

dezenas :: [String]
dezenas = ["vinte", "trinta", "quarenta", "cinquenta", "sessenta", "setenta", "oitenta", "noventa"]

{- A função 'converte2' é composição de duas:
  * 'divide2' obtêm os algarimos;
  * 'combina2' combina o texto de cada algarismo.
  Usamos as operações de concatenação (++) e indexação de listas (!!) (note que os índices começam em zero.) -}
converte2 :: Int -> String
converte2 n | n < 100 = combina2 (divide2 n)
converte2 n = ""

divide2 :: Int -> (Int, Int)
divide2 n = (n `div` 10, n `mod` 10) -- (quociente,resto)

combina2 :: (Int, Int) -> String
combina2 (0, u) = unidades !! u
combina2 (1, u) = dezADezanove !! u
combina2 (d, 0) = dezenas !! (d -2)
combina2 (d, u) = dezenas !! (d -2) ++ " e " ++ unidades !! u

{- Em seguida, resolvemos o problema análogo para números até 3
algarismos. Necessitamos dos nomes em Português das centenas. -}
centenas :: [String]
centenas = ["cento", "duzentos", "trezentos", "quatrocentos", "quinhentos", "seiscentos", "setecentos", "oitocentos", "novecentos"]

{- A função de conversão, nos mesmos moldes da anterior.
   Note o tratamento especial do número 100.  -}
converte3 :: Int -> String
converte3 n | n < 1000 = combina3 (divide3 n)
converte3 n = ""

divide3 :: Int -> (Int, Int)
divide3 n = (n `div` 100, n `mod` 100)

combina3 :: (Int, Int) -> String
combina3 (0, n) = combina2 (divide2 n)
combina3 (1, 0) = "cem"
combina3 (c, 0) = centenas !! (c -1)
combina3 (c, n) = centenas !! (c -1) ++ " e " ++ combina2 (divide2 n)

{- Finalmente podemos resolver o problema para números
  até 6 algarismos, i.e. inferiores a 1 milhão.  -}
converte6 :: Int -> String
converte6 n | n < 1000000 = combina6 (divide6 n)
converte6 n = ""

divide6 :: Integral b => b -> (b, b)
divide6 n = (n `div` 1000, n `mod` 1000)

combina6 :: (Int, Int) -> String
combina6 (0, n) = converte3 n
combina6 (1, 0) = "mil"
combina6 (1, n) = "mil" ++ ligar n ++ converte3 n
combina6 (m, 0) = converte3 m ++ " mil"
combina6 (m, n) = converte3 m ++ " mil" ++ ligar n ++ converte3 n

{- Uma função auxiliar para escolher a partícula de ligação entre milhares e o restante (r).
Regra: colocamos "e" quando o resto é inferior a 100 ou múltiplo de 100; caso contrario, basta um espaço. -}
ligar :: Int -> String
ligar r
  | r < 100 || r `mod` 100 == 0 = " e "
  | otherwise = " "

-- A solução do exercício proposto é converte6.
converte :: Int -> String
converte = converte6
