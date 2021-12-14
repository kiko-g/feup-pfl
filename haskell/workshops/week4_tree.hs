data Arv a = No a (Arv a) (Arv a) | Vazia deriving (Show, Eq)

-- 4.7
sumArv :: Num a => Arv a -> a
sumArv Vazia = 0
sumArv (No x esq dir) = x + sumArv esq + sumArv dir

-- 4.8
-- listarAsc (No 11 (No 3 (No 2 Vazia Vazia) (No 5 Vazia Vazia)) (No 19 (No 13 Vazia Vazia) (No 23 Vazia Vazia)))
listarAsc :: Arv a -> [a]
listarAsc Vazia = []
listarAsc (No x esq dir) = listarAsc esq ++ [x] ++ listarAsc dir

listarDesc :: Arv a -> [a]
listarDesc Vazia = []
listarDesc (No x esq dir) = listarDesc dir ++ [x] ++ listarDesc esq

-- 4.9
nivel :: Int -> Arv a -> [a]
nivel n Vazia = []
nivel 0 (No x _ _) = [x]
nivel n (No x arv1 arv2) = nivel (n-1) arv1 ++ nivel (n-1) arv2

-- 4.10
mapArv :: (a -> b) -> Arv a -> Arv b
mapArv f Vazia = Vazia
mapArv f (No x arv1 arv2) = No (f x) (mapArv f arv1) (mapArv f arv2)

-- 4.11
inserir :: Ord a => a -> Arv a -> Arv a
inserir x Vazia = No x Vazia Vazia
inserir x (No y esq dir)
  | x == y = No y esq dir -- já ocorre; não insere
  | x < y = No y (inserir x esq) dir -- insere à esquerda
  | otherwise = No y esq (inserir x dir) -- insere à direita

-- construir [3,1,2]
construir :: Ord a => [a] -> Arv a
construir = foldr inserir Vazia

-- construirEq [1,2,3,4,5,6,7]
-- Construção por particão binária
-- Pré-condição: a lista de valores deve estar por ordem crescente
construirEq :: [a] -> Arv a
construirEq [] = Vazia
construirEq xs = No x (construirEq xs') (construirEq xs'')
  where 
    n = length xs `div` 2
    xs' = take n xs
    x:xs'' = drop n xs
