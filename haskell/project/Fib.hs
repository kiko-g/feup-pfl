import BigNumber
-- 1.1
fibRec :: (Integral a) => a -> a
fibRec 0 = 0
fibRec 1 = 1
fibRec n = fibRec (n - 2) + fibRec (n - 1)

-- 1.2
fibLista :: Int -> Int
fibLista 0 = 0
fibLista 1 = 1
fibLista n = (list !! (n - 1)) + (list !! (n - 2))
  where
    list = map fibLista [0 .. n]

-- 1.3
fibInfinitosAux :: [Int]
fibInfinitosAux = 0 : 1 : zipWith (+) (tail fibInfinitosAux) fibInfinitosAux

fibListaInfinita :: Int -> Int
fibListaInfinita n = last (take (n + 1) fibInfinitosAux)

-- 3
fibRecBN :: BigNumber -> BigNumber
fibRecBN [0] = [0]
fibRecBN [1] = [1]
fibRecBN bn = somaBN (fibRecBN (subBN bn [2])) (fibRecBN (subBN bn [1]))
