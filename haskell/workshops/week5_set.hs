import Data.List

-- 5.3
newtype UL a = UL [a] deriving (Eq, Show)

addUL :: Eq a => a -> UL a -> UL a
addUL x (UL []) = UL [x]
addUL x (UL set)
  | x `elem` set = UL set
  | otherwise = UL (set ++ [x])

removeUL :: Eq a => a -> UL a -> UL a
removeUL _ (UL []) = UL []
removeUL x (UL set)
  | x `elem` set = UL (Data.List.delete x set)
  | otherwise = UL set

-- 5.4
data Set a = Node a (Set a) (Set a) | Empty deriving (Show)

emptySet :: Set a
emptySet = Empty

insertSet :: Ord a => a -> Set a -> Set a
insertSet a Empty = Node a Empty Empty
insertSet a (Node b esq dir)
  | a < b = Node b (insertSet a esq) dir
  | a > b = Node b esq (insertSet a dir)
  | otherwise = Node b esq dir

memberSet :: Ord a => a -> Set a -> Bool
memberSet a Empty = False
memberSet a (Node b esq dir)
  | a < b = memberSet a esq
  | a == b = True
  | otherwise = memberSet a dir

unionSet :: Ord a => Set a -> Set a -> Set a
unionSet a Empty = a
unionSet Empty b = b
unionSet (Node val left right) b = unionSet left (unionSet right res)
  where
    res = if memberSet val b then b else insertSet val b
