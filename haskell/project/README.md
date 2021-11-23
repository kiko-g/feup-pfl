# Haskell Project

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
```
fibRec 5
fibRec 10
fibRec 15
```

Parte dos casos base `fibRec 0 = 0` e `fibRec 1 = 1` e recursivamente soma os pares fibonacci `(n-2)` e `(n-1)`


#### FibLista

```haskell
fibLista :: Int -> Int -- 1.2
```
```
fibLista 5
fibLista 10
fibLista 15
```

Parte dos casos base `fibRec 0 = 0` e `fibRec 1 = 1` e soma os pares fibonacci `(n-2)` e `(n-1)`, usando os elementos `n-2` e `n-1` da lista de fibonacci de `0` até `n`

#### FibListaInfinita

```haskell
fibListaInfinita :: Int -> Int
```
```
fibListaInfinita 5
fibListaInfinita 10
fibListaInfinita 15
```
Este predicado usa uma função auxiliar *fibInfinitosAux* que cria uma lista infinita de números fibonacci, através do zip recursivo de duas listas de fibonacci infinitas desfasadas por 1 casa (lista e tail (lista))


#### Scanner

```haskell
scanner :: String -> BigNumber
```
```haskell
scanner "1234"
scanner "-1234"
scanner "0001234"
scanner "-0001234"
scanner "12345678901234567890"
```

#### Output

```haskell
output :: BigNumber -> String
```
```haskell
output [1,2,3,4]
output [-1,2,3,4]
output [0,0,0,1,2,3,4]
output [-0,0,0,1,2,3,4]
output [1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0]
```

#### SomaBN

```haskell
somaBN :: BigNumber -> BigNumber -> BigNumber
```
```

```

#### SubBN

```haskell
subBN :: BigNumber -> BigNumber -> BigNumber
```
```haskell

```

#### MulBN

```haskell
mulBN :: BigNumber -> BigNumber -> BigNumber
```
```haskell

```

#### DivBN

```haskell
divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)
```
```haskell

```


#### FibRecBN

```haskell
fibRecBN :: BigNumber -> BigNumber
```
```haskell
fibRecBN [5]
fibRecBN [10]
fibRecBN [15]
```

#### FibListaBN

```haskell
fibListaBN :: BigNumber -> BigNumber
```
```haskell
fibListaBN [5]
fibListaBN [10]
fibListaBN [15]
```

Usa uma função nova nthBN para substituir o operador !! nos BigNumbers e faz uso

#### FibListaInfinitaBN

```haskell
fibListaInfinitaBN :: BigNumber -> BigNumber
```
```haskell
fibListaInfinitaBN [5]
fibListaInfinitaBN [10]
fibListaInfinitaBN [15]
```


#### SafeDivBN

```haskell
safeDivBN :: BigNumber -> BigNumber -> Maybe (BigNumber, BigNumber)
```
```haskell

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

-- Cria uma lista infinita de números fibonacci, através do zip recursivo de duas listas de fibonacci desfasadas por 1 casa
```
