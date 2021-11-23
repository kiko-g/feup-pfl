data Arv a = No a (Arv a) (Arv a) | Vazia
  deriving (Show, Eq)

listar :: Arv a -> [a]
listar Vazia = []
listar (No x esq dir) = listar esq ++ [x] ++ listar dir

ordenada :: Ord a => Arv a -> Bool
ordenada arv = ascendente (listar arv)
  where
    ascendente [] = True
    ascendente [_] = True
    ascendente (x : y : xs) = x < y && ascendente (y : xs)

procurar :: Ord a => a -> Arv a -> Bool
procurar x Vazia = False -- não ocorre
procurar x (No y esq dir)
  | x == y = True -- encontrou
  | x < y = procurar x esq -- procura à esquerda
  | otherwise = procurar x dir -- procura à direita

inserir :: Ord a => a -> Arv a -> Arv a
inserir x Vazia = No x Vazia Vazia
inserir x (No y esq dir)
  | x == y = No y esq dir -- já ocorre; não insere
  | x < y = No y (inserir x esq) dir -- insere à esquerda
  | otherwise = No y esq (inserir x dir) -- insere à direita

construir :: Ord a => [a] -> Arv a
construir = foldr inserir Vazia

maisEsq :: Arv a -> a
maisEsq (No x Vazia _) = x
maisEsq (No _ esq _) = maisEsq esq

remover :: Ord a => a -> Arv a -> Arv a
remover _ Vazia = Vazia -- não ocorre
remover x (No y Vazia dir) -- um descendente
  | x == y = dir
remover x (No y esq Vazia) -- um descendente
  | x == y = esq
remover x (No y esq dir) -- dois descendentes
  | x < y = No y (remover x esq) dir
  | x > y = No y esq (remover x dir)
  | otherwise =
    let z = maisEsq dir
     in No z esq (remover z dir)

------- 4.7 -------
sumArv :: Num a => Arv a -> a
sumArv Vazia = 0
sumArv (No x esq dir) = x + sumArv esq + sumArv dir
