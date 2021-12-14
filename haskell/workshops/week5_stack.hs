module Stack
  ( Stack,
    push,
    pop,
    top,
    empty,
    isEmpty,
  )
where

newtype Stack a = Stk [a] deriving (Eq, Show)

push :: a -> Stack a -> Stack a
push x (Stk xs) = Stk (x : xs)

pop :: Stack a -> Stack a
pop (Stk (_ : xs)) = Stk xs
pop _ = error "Stack.pop: empty stack"

top :: Stack a -> a
top (Stk (x : _)) = x
top _ = error "Stack.top: empty stack"

empty :: Stack a
empty = Stk []

isEmpty :: Stack a -> Bool
isEmpty (Stk []) = True
isEmpty (Stk _) = False

-- 5.1
parent :: String -> Bool
parent str = parentAux str empty

parentAux :: String -> Stack Char -> Bool
parentAux [] stk = isEmpty stk
parentAux (ch : chs) stk
  | ch `elem` open = parentAux chs (push ch stk)
  | not (isEmpty stk) && or [top stk == a && ch == b | (a, b) <- joined] = parentAux chs (pop stk)
  | otherwise = parentAux chs stk -- skip
  where
    open = ['(', '{', '[']
    close = [')', '}', ']']
    joined = zip open close

-- 5.2
-- yikes
