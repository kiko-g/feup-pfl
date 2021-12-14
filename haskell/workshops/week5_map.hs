module Map
  ( Map,
    emptyMap,
    insertMap,
    lookupMap,
  )
where

-- 5.6
data Map k v = Empty | Node (k, v) (Map k v) (Map k v) deriving (Show)

emptyMap :: Map k v
emptyMap = Empty

insertMap :: Ord k => k -> v -> Map k v -> Map k v
insertMap k v Empty = Node (k, v) Empty Empty
insertMap k v (Node (k1, v1) l r)
  | k < k1 = Node (k1, v1) (insertMap k v l) r
  | k > k1 = Node (k1, v1) l (insertMap k v r)
  | otherwise = Node (k, v) l r

lookupMap :: Ord k => k -> Map k v -> Maybe v
lookupMap _ Empty = Nothing
lookupMap k (Node (k1, v1) l r)
  | k < k1 = lookupMap k l
  | k > k1 = lookupMap k r
  | otherwise = Just v1
