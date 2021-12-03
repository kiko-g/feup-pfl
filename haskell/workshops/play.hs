module Main where

import System.Random (randomRIO)

main :: IO ()
main = do
  num <- randomRIO (1, 1000)
  jogo num 1

jogo :: Int -> Int -> IO ()
jogo num cont =
  do
    putStrLn "Tentativa? "
    str <- getLine
    let tent = read str -- converte String -> Int
    if tent > num
      then do
        putStrLn "Demasiado alto!"
        jogo num (cont + 1)
      else
        if tent < num
          then do
            putStrLn "Demasiado baixo!"
            jogo num (cont + 1)
          else do
            putStr "Acertou em "
            putStrLn (show cont ++ " tentativas")