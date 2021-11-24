# Haskell Project

## TODO

- Mul
- Div
- Responder alinea 4
- Cleanup + efficiency + error proofing
- Terminar docs

## Documentação e casos de teste

Esta secção segue o seguinte formato:

#### FunctionName

```haskell
functionName :: type -- id
```

```
testcase 1
testcase 2
testcase 3
...
```

Descrição do funcionamento do predicado.

---

#### FibRec

```haskell
fibRec :: (Integral a) => a -> a -- 1.1
```

```haskell
fibRec 5
fibRec 10
fibRec 15
```

Parte dos casos base `fibRec 0 = 0` e `fibRec 1 = 1` e recursivamente soma os pares fibonacci `(n-2)` e `(n-1)`

#### FibLista

```haskell
fibLista :: Int -> Int -- 1.2
```

```haskell
fibLista 5
fibLista 10
fibLista 15
```

Parte dos casos base `fibRec 0 = 0` e `fibRec 1 = 1` e soma os pares fibonacci `(n-2)` e `(n-1)`, usando os elementos `n-2` e `n-1` da lista de fibonacci de `0` até `n`

#### FibListaInfinita

```haskell
fibListaInfinita :: Int -> Int
```

```haskell
fibListaInfinita 5
fibListaInfinita 10
fibListaInfinita 15
```

Este predicado usa uma função auxiliar _fibInfinitosAux_ que cria uma lista infinita de números fibonacci, através do zip recursivo de duas listas de fibonacci infinitas desfasadas por 1 casa (lista e tail (lista))

#### Scanner

```haskell
scanner :: String -> BigNumber
```

```haskell
scanner "1234"
scanner "-1234"
scanner "0000"
scanner "0001234"
scanner "-0001234"
scanner "12345678901234567890"
```

#### Output

```haskell
output :: BigNumber -> String
```

```haskell
output [1,2,3,4] -- or output (scanner "1234")
output [-1,2,3,4]
output [0,0,0,0,0]
output [0,0,0,1,2,3,4]
output [1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0]
```

#### SomaBN

```haskell
somaBN :: BigNumber -> BigNumber -> BigNumber
```

```haskell
somaBN (scanner "32") (scanner "137")      -- 169
somaBN (scanner "123") (scanner "100")     -- 223
somaBN (scanner "123") (scanner "246")     -- 369
somaBN (scanner "123") (scanner "987")     -- 1110

somaBN (scanner "123") (scanner "-33")     -- 90
somaBN (scanner "123") (scanner "-132")    -- -9
somaBN (scanner "123") (scanner "-124")    -- -1

somaBN (scanner "-123") (scanner "33")     -- -90
somaBN (scanner "-123") (scanner "133")    -- 10
somaBN (scanner "-123") (scanner "124")    -- 1

somaBN (scanner "-123") (scanner "-33")     -- -156
somaBN (scanner "-123") (scanner "-133")    -- -256
somaBN (scanner "-9371") (scanner "-29358") -- -38729
```

#### SubBN

```haskell
subBN :: BigNumber -> BigNumber -> BigNumber
```

```haskell
subBN (scanner "123") (scanner "123")     -- 0
subBN (scanner "123") (scanner "246")     -- -123
subBN (scanner "123") (scanner "12")      -- 111

subBN (scanner "123") (scanner "-33")     -- 156
subBN (scanner "123") (scanner "-133")    -- 256

subBN (scanner "-123") (scanner "33")     -- -156
subBN (scanner "-123") (scanner "133")    -- -256

subBN (scanner "-123") (scanner "-33")     -- -90
subBN (scanner "-123") (scanner "-133")    -- 10
```

#### MulBN

```haskell
mulBN :: BigNumber -> BigNumber -> BigNumber
```

```haskell
mulBN (scanner "12") (scanner "24")       -- 288
mulBN (scanner "123") (scanner "12")      -- 1476
mulBN (scanner "123") (scanner "123")     -- 15129
mulBN (scanner "123") (scanner "246")     -- 30258

mulBN (scanner "123") (scanner "-33")     -- -4059
mulBN (scanner "123") (scanner "-133")    -- -16359

mulBN (scanner "-123") (scanner "33")     -- -4059
mulBN (scanner "-123") (scanner "133")    -- -16359

mulBN (scanner "-123") (scanner "-33")     -- 4059
mulBN (scanner "-123") (scanner "-133")    -- 16359
```

#### DivBN

```haskell
divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)
```

```haskell
divBN (scanner "24") (scanner "12")       -- (2,0)
divBN (scanner "30") (scanner "12")       -- (2,6)
divBN (scanner "144") (scanner "12")      -- (12,0)
```

#### FibRecBN

```haskell
fibRecBN :: BigNumber -> BigNumber
```

```haskell
fibRecBN (scanner "5")
fibRecBN (scanner "10")
fibRecBN (scanner "15")
```

#### FibListaBN

```haskell
fibListaBN :: BigNumber -> BigNumber
```

```haskell
fibListaBN (scanner "5")
fibListaBN (scanner "10")
fibListaBN (scanner "15")
```

Usa uma função nova nthBN para substituir o operador !! nos BigNumbers e faz uso

#### FibListaInfinitaBN

```haskell
fibListaInfinitaBN :: BigNumber -> BigNumber
```

```haskell
fibListaInfinitaBN (scanner "5")
fibListaInfinitaBN (scanner "10")
fibListaInfinitaBN (scanner "15")
```

#### SafeDivBN

```haskell
safeDivBN :: BigNumber -> BigNumber -> Maybe (BigNumber, BigNumber)
```

```haskell
divBN (scanner "144") (scanner "12")      -- (12,0)
divBN (scanner "148") (scanner "12")      -- (12,4)
divBN (scanner "148") (scanner "0")       -- Nothing
```

## Estratégias

1. Definir o novo tipo como uma lista de inteiros: `type BigNumber = [Int]`
2. Para definir `scanner` recorremos ao `map` e `read` para percorrer todos os caracteres, tendo o cuidado de acrescentar o sinal negativo caso o primeiro char fosse `-`
3. Para definir `output` recorremos a `concatMap show` que percorre e junta num array de chars todos os digitos inteiros da lista passada como argumento
4. Para definir `somaBN` começámos por por verificar o comprimento das listas a somar. No caso de não serem iguais, acrescentamos zeros à esquerda no nº que necessita (com a função `padLeftZeros`) até o comprimento ser igual. O resultado é obtido usando `zipWith (+) n1 n2`. Tendo obtido o resultado, sem pensar nos `carry outs` das somas, pegamos nesse _BigNumber_ e usamos a função `carrySum` para lidar com as casas superiores a 9. Para facilitar as coisas também transfomamos as somas em casos mais. simples `(p.e.: -1 + -1 = - (1+1))` recorrendo a `changeSign`, `isPositive` e `isNegative`. Dessa forma transformamos algumas somas em operações `subBN` e vice-versa.
5. Para definir `subBN` usámos uma abordagem semelhante à da `somaBN`, exceto que neste caso usamos `carrySub`, onde verificamos também dígitos do _BigNumber_ resultante inferiores a 0. A restante lógica é semelhante à somaBN. Neste caso usamos `zipWith (-)` e algumas subtrações são transformadas em somas, por simplicidade.
6. `mulBN` utiliza `padMulDiv` que multiplica os elementos de um _BigNumber_ por `10^index`. Assim [1, 2, 3] passa a [100, 20, 3]. O resultado é calculado acumulando recursivamente os resultados de multiplicar cada digito do nº `a` pelo número `b`. Usamos `zipWith (*)` replicando o dígito em questão para uma lista do tamanho do nº a multiplicar. Assim [1, 2, 3] _ [3] internamente seria `zipWith (_) [100, 20, 3] [3, 3, 3]`.
7. `divBN`

## Resposta à alínea 4

> Compare as resoluções das alíneas 1 e 3 com tipos `(Int -> Int)`, `(Integer -> Integer)` e `(BigNumber -> BigNumber)`, comparando a sua aplicação a números grandes e verificando qual o maior número que cada uma aceita como argumento.

...

## Documentação de funções auxiliares

```haskell
fibInfinitosAux :: [Int]
fibInfinitosAux = 0 : 1 : zipWith (+) (tail fibInfinitosAux) fibInfinitosAux

-- Cria uma lista infinita de números fibonacci, através do zip recursivo de duas listas de fibonacci desfasadas por 1 casa
```
