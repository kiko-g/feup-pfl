# Haskell Project

## Casos de Teste

```haskell
-- 1.1
fibRec :: (Integral a) => a -> a

fibRec 5
fibRec 10
fibRec 15
```

```haskell
-- 1.2
fibLista :: Int -> Int

fibLista 5
fibLista 10
fibLista 15
```

```haskell
-- 1.3
fibListaInfinita :: Int -> Int

fibListaInfinita 5
fibListaInfinita 10
fibListaInfinita 15
```

```haskell
-- 2.2
scanner :: String -> BigNumber

```

```haskell
-- 2.3
output :: BigNumber -> String

```

```haskell
-- 2.4
somaBN :: BigNumber -> BigNumber -> BigNumber

```

```haskell
-- 2.5
subBN :: BigNumber -> BigNumber -> BigNumber

```

```haskell
-- 2.6
mulBN :: BigNumber -> BigNumber -> BigNumber

```

```haskell
-- 2.7
divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)

```

```haskell
-- 3 a)
fibRecBN :: BigNumber -> BigNumber

```

```haskell
-- 3 b)
fibListaBN :: BigNumber -> BigNumber

```

```haskell
-- 3 c)
fibListaInfinitaBN :: BigNumber -> BigNumber

```

## Documentação

```haskell
fibRec :: (Integral a) => a -> a

--
```

```haskell
fibLista :: Int -> Int

--
```

```haskell
fibListaInfinita :: Int -> Int

--
```

```haskell
scanner :: String -> BigNumber

--
```

```haskell
output :: BigNumber -> String

--
```

```haskell
somaBN :: BigNumber -> BigNumber -> BigNumber

--
```

```haskell
subBN :: BigNumber -> BigNumber -> BigNumber

--
```

```haskell
mulBN :: BigNumber -> BigNumber -> BigNumber

--
```

```haskell
divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)

--
```

```haskell
fibRecBN :: BigNumber -> BigNumber

--
```

```haskell
fibListaBN :: BigNumber -> BigNumber

--
```

```haskell
fibListaInfinitaBN :: BigNumber -> BigNumber

--
```

```haskell
safeDivBN :: BigNumber -> BigNumber -> Maybe (BigNumber, BigNumber)

--
```

## Estratégias

1. Definir o novo tipo como uma lista de inteiros: `type BigNumber = [Int]`
2. Para definir `scanner` recorremos ao `map` e `read` para percorrer todos os caracteres, tendo o cuidado de acrescentar o sinal negativo caso o primeiro char fosse `-`
3. Para definir `output` recorremos a `concatMap show` que percorre e junta num array de chars todos os digitos inteiros da lista passada como argumento
4. Para definir `somaBN` começámos por por verificar o comprimento das listas a somar. No caso de não serem iguais, acrescentamos zeros à esquerda no nº que necessita (com a função `padLeftZeros`) até o comprimento ser igual. O resultado é obtido usando `zipWith (+) n1 n2`. Tendo obtido o resultado, sem pensar nos `carry outs` das somas, pegamos nesse _BigNumber_ e usamos a função `carrySum` para lidar com as casas superiores a 9. Para facilitar as coisas também transfomamos as somas em casos mais. simples `(p.e.: -1 + -1 = - (1+1))` recorrendo a `changeSign`, `isPositive` e `isNegative`. Dessa forma transformamos algumas somas em operações `subBN` e vice-versa.
5. Para definir `subBN` usámos uma abordagem semelhante à da `somaBN`, exceto que neste caso usamos `carrySub`, onde verificamos também dígitos do *BigNumber* resultante inferiores a 0. A restante lógica é semelhante à somaBN. Neste caso usamos `zipWith (-)` e algumas subtrações são transformadas em somas, por simplicidade.
6. `mulBN` utiliza `padMulDiv` que multiplica os elementos de um _BigNumber_ por `10^index`. Assim [1, 2, 3] passa a [100, 20, 3]. O resultado é calculado acumulando recursivamente os resultados de multiplicar cada digito do nº `a` pelo número `b`. Usamos `zipWith (*)` replicando o dígito em questão para uma lista do tamanho do nº a multiplicar. Assim [1, 2, 3] * [3] internamente seria `zipWith (*) [100, 20, 3] [3, 3, 3]`.
7. `divBN`


## Resposta à alínea 4

> Compare as resoluções das alíneas 1 e 3 com tipos `(Int -> Int)`, `(Integer -> Integer)` e `(BigNumber -> BigNumber)`, comparando a sua aplicação a números grandes e verificando qual o maior número que cada uma aceita como argumento.

...

## Documentação de funções auxiliares

```haskell
fibInfinitosAux :: [Int]
fibInfinitosAux = 0 : 1 : zipWith (+) (tail fibInfinitosAux) fibInfinitosAux

-- Cria uma lista infinita de números fibonacci, através do zip recursivo de duas listas desfazadas por 1 casa
```
