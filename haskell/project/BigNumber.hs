module BigNumber
  ( BigNumber (..),
  )
where

import Data.Int (Int64)
type BigNumber = [Int64]

scanner :: String -> BigNumber
scanner = map (\c -> read [c] :: Int64)

-- output :: BigNumber -> String
