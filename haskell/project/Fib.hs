-- 1.1
fibRec :: (Integral a) => a -> a
fibRec 0 = 0
fibRec 1 = 1
fibRec n = fibRec (n -2) + fibRec (n -1)

-- 1.2
fibLista :: Int -> Int
fibLista 0 = 0
fibLista 1 = 1
fibLista n = (list !! (n -1)) + (list !! (n -2))
  where
    list = map fibLista [0 .. n]

-- 1.3
fibAux :: [Int]
fibAux = 0 : 1 : [a + b | (a, b) <- zip fibAux (tail fibAux)]

fibListaInfinita :: Int -> [Int]
fibListaInfinita n = take (n + 1) fibAux
