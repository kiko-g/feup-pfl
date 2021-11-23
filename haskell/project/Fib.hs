import BigNumber

------------ 1.1 ------------
fibRec :: (Integral a) => a -> a
fibRec 0 = 0
fibRec 1 = 1
fibRec n = fibRec (n - 2) + fibRec (n - 1)

------------ 1.2 ------------
fibLista :: Int -> Int
fibLista 0 = 0
fibLista 1 = 1
fibLista n = (list !! (n - 2)) + (list !! (n - 1))
  where
    list = map fibLista [0 .. n]

------------ 1.3 ------------
fibInfinitosAux :: [Int]
fibInfinitosAux = 0 : 1 : zipWith (+) (tail fibInfinitosAux) fibInfinitosAux

fibListaInfinita :: Int -> Int
fibListaInfinita n = last (take (n + 1) fibInfinitosAux)

------------ 3.1 ------------
fibRecBN :: BigNumber -> BigNumber
fibRecBN [0] = [0]
fibRecBN [1] = [1]
fibRecBN bn = somaBN (fibRecBN (subBN bn [2])) (fibRecBN (subBN bn [1]))

nthBN :: [BigNumber] -> BigNumber -> BigNumber -- redefine !! operator for BigNumber
nthBN [] _ = []
nthBN (x : xs) [0] = x
nthBN (x : xs) index = nthBN xs (subBN index [1])

------------ 3.2 ------------
fibListaBN :: BigNumber -> BigNumber
fibListaBN [0] = [0]
fibListaBN [1] = [1]
fibListaBN bn = somaBN (nthBN list (subBN bn [2])) (nthBN list (subBN bn [1]))
  where
    list = [fibListaBN [x] | x <- [0 ..]]

------------ 3.3 ------------
fibInfinitosAuxBN :: [BigNumber]
fibInfinitosAuxBN = [0] : [1] : zipWith somaBN fibInfinitosAuxBN (tail fibInfinitosAuxBN)

fibListaInfinitaBN :: BigNumber -> BigNumber
fibListaInfinitaBN = nthBN fibInfinitosAuxBN
