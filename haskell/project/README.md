# Haskell Project

## TODO

- Div
- Responder alinea 4
- Final cleanup
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

Parte dos casos base `fibRec 0 = 0` e `fibRec 1 = 1` e recursivamente soma os pares fibonacci `(n-2)` e `(n-1)`.

#### FibLista

```haskell
fibLista :: Int -> Int -- 1.2
```

```haskell
fibLista 5
fibLista 10
fibLista 15
```

Parte dos casos base `fibRec 0 = 0` e `fibRec 1 = 1` e soma os pares fibonacci `n-2` e `(n-1)`, selecionado (usando `!!`) os elementos `n-2` e `n-1` da lista de fibonacci de `0` até `n`

#### FibListaInfinita

```haskell
fibListaInfinita :: Int -> Int
```

```haskell
fibListaInfinita 5
fibListaInfinita 10
fibListaInfinita 15
```

Este predicado usa uma função auxiliar `fibInfinitosAux` que cria uma lista infinita de números fibonacci, através do `zipWith (+)` recursivo de duas listas de fibonacci infinitas desfasadas por 1 casa (`lista` e `tail (lista)`). Por terem esse desfasamento, é possível criar uma lista de números fibonacci.

> 0 1 1 2 3 5 (...)
> &nbsp;&nbsp;&nbsp;0 1 1 2 3 5 (...)

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

Percorre todos os caracteres, e transforma-os em inteiros, resultando numa lista de inteiros entre `0` e `9`. Acrescenta o sinal negativo ao primeiro inteiro caso o primeiro char fosse `-`, após ter removido potenciais zeros à esquerda usando uma função auxiliar `removeLeftZeros`.

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

Percorre todos os dígitos de um `BigNumber`, transformando-os em chars e juntando-os numa string, tendo o cuidado de remover potenciais zeros à esquerda.

#### SomaBN

```haskell
somaBN :: BigNumber -> BigNumber -> BigNumber
```

```haskell
somaBN (scanner "32") (scanner "137")      -- 169
somaBN (scanner "123") (scanner "100")     -- 223
somaBN (scanner "123") (scanner "246")     -- 369
somaBN (scanner "123") (scanner "987")     -- 1110

somaBN (scanner "123") (scanner "-34")     -- 89
somaBN (scanner "123") (scanner "-130")    -- -7
somaBN (scanner "23") (scanner "-124")     -- -101

somaBN (scanner "-123") (scanner "33")     -- -90
somaBN (scanner "-123") (scanner "133")    -- 10
somaBN (scanner "-123") (scanner "124")    -- 1

somaBN (scanner "-123") (scanner "-33")     -- -156
somaBN (scanner "-123") (scanner "-133")    -- -256
somaBN (scanner "-9371") (scanner "-29358") -- -38729
```

Soma dois `BigNumbers`. Caso os números não sejam ambos positivos, transforma somas de sinais opostos em subtrações e no caso de serem ambos negativos inverte o sinal dos operandos e da soma final. Antes de somar as duas listas com `zipWith (+) bn1 bn2`, acrescenta zeros à esquerda ao número menos comprido, para as listas serem correspondentes. Processa os _carry outs_, subtraindo 10 a um dígito e acrescentar um ao próximo.

#### SubBN

```haskell
subBN :: BigNumber -> BigNumber -> BigNumber
```

```haskell
subBN (scanner "123") (scanner "123")     -- 0
subBN (scanner "123") (scanner "246")     -- -123
subBN (scanner "123") (scanner "12")      -- 111
subBN (scanner "9873") (scanner "8328")   -- 1545

subBN (scanner "123") (scanner "-33")     -- 156
subBN (scanner "123") (scanner "-133")    -- 256

subBN (scanner "-123") (scanner "44")     -- -156
subBN (scanner "-123") (scanner "144")    -- -256

subBN (scanner "-123") (scanner "-33")     -- -90
subBN (scanner "-123") (scanner "-133")    -- 10
```

Subtrai dois `BigNumbers`. Caso os números não sejam ambos positivos, transforma subtrações de sinais opostos em somas e no caso de serem ambos negativos inverte o sinal dos operandos e da subtração final. Antes de somar as duas listas com `zipWith (+) bn1 bn2`, acrescenta zeros à esquerda ao número menos comprido, para as listas serem correspondentes. Para além disso subtrai o maior número ao menor número. Processa os _carry outs_, subtraindo 10 a um dígito e acrescentar um ao próximo.

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

Parte dos casos base `fibRec 0 = 0` e `fibRec 1 = 1` e recursivamente soma os pares fibonacci `(n-2)` e `(n-1)`, usando somaBN.

#### FibListaBN

```haskell
fibListaBN :: BigNumber -> BigNumber
```

```haskell
fibListaBN (scanner "5")
fibListaBN (scanner "10")
fibListaBN (scanner "15")
```

Usa uma função nova `nthBN` para substituir o operador !! nos BigNumbers e partindo dos casos base `fibListaBN [0] = [0]` e `fibListaBN [1] = [1]`, soma os pares fibonacci `n-2` e `(n-1)`, selecionado com `nthBN` os elementos `n-2` e `n-1` da lista de fibonacci de `0` até infinito, já que para não ser infinito precisaríamos de ter o valor absoluto inteiro do BN `n`.

#### FibListaInfinitaBN

```haskell
fibListaInfinitaBN :: BigNumber -> BigNumber
```

```haskell
fibListaInfinitaBN (scanner "5")
fibListaInfinitaBN (scanner "10")
fibListaInfinitaBN (scanner "15")
```

Este predicado usa uma função auxiliar `fibInfinitosAuxBN` que cria uma lista infinita de `BigNumbers` fibonacci, através do `zipWith somaBN` recursivo de duas listas de fibonacci infinitas desfasadas por 1 casa (`lista` e `tail (lista)`). Por terem esse desfasamento, é possível criar uma lista de números fibonacci.

> [0] [1] [1] [2] [3] [5] (...)
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[0] [1] [1] [2] [3] [5] (...)

````

#### SafeDivBN

```haskell
safeDivBN :: BigNumber -> BigNumber -> Maybe (BigNumber, BigNumber)
````

```haskell
divBN (scanner "144") (scanner "12")      -- (12,0)
divBN (scanner "148") (scanner "12")      -- (12,4)
divBN (scanner "148") (scanner "0")       -- Nothing
```

Executa a divisão quando o divisor não é 0, caso contrário retorna `Nothing`

## Estratégias

1. Definir o novo tipo como uma lista de inteiros: `type BigNumber = [Int]`
2. Para definir `scanner` recorremos ao `map` e `read` para percorrer todos os caracteres, transformando-os em inteiros, tendo o cuidado de acrescentar o sinal negativo caso o primeiro char fosse `-` e removendo potenciais zeros à esquerda usando uma função auxiliar `removeLeftZeros`.
3. Para definir `output` recorremos a `concatMap show` que percorre e junta num array de chars todos os digitos inteiros da lista passada como argumento, tendo o cuidado de remover potenciais zeros à esquerda, recorrendo à função auxiliar `removeLeftZeros`.
4. Para definir `somaBN` começámos por criar predicados auxiliares

   - `changeSign` para mudar de sinal.
   - `isPositive` e `isNegative` para verificar sinal dos BNs
   - `padLeftZeros` que acrescenta zeros à esquerda, já que no caso de "somarmos listas" de tamanho diferente, é preciso acrescentar zeros à esquerda num dos operandos até o comprimento ser igual.

   O resultado é obtido usando `zipWith (+) n1 n2`. Tendo obtido o resultado, sem pensar nos `carry outs` das somas, pegamos nesse _BigNumber_ e usamos a função `carrySum` para lidar com as casas superiores a 9 e outros casos críticos para o resultado final. A nossa implementação de `somaBN` funciona como uma espécie de "router" de resultado:

   - caso `x` e `y` sejam ambos positivos é feita uma soma normal com `sumBNResult`.
   - caso `x` tenha sinal diferente de `y`, a soma é transformada em subtração (`subBN`)
   - caso ambos `x` e `y` sejam ambos negativos a soma é transformada em - `- ((-x) + (-y))`

5. Para definir `subBN` usámos uma abordagem semelhante à da `somaBN` com as seguintes diferenças relevantes:

   - Usamos `carrySub`, que verifica dígitos do _BigNumber_ resultante inferiores a 0 e mais alguns casos críticos para o resultado.
   - É usado `zipWith (-)` e algumas subtrações são transformadas em somas, por simplicidade.
   - Criamos uma função auxiliar `bigger` que se encarrega de retornar um par dos números ordenados, sabendo assim que número é maior e tornando mais fácil a subtração.

6. Para implementar `mulBN` seguimos os seguintes passos.
   - Começamos por criar uma função axuiliar, `padMulBN`, que acrescenta aos elementos de um _BigNumber_ (invertido) zeros `index` vezes. Assim [1, 2, 3] passa a [100, 20, 3].
   - O próximo passo é gerir a lógica da multiplicação, de maneira apenas pensarmos em multiplicações de números positivos:
     - caso ambos os operandos sejam positivos faz-se uma multiplicação normal.
     - caso os operandos tenham sinais opostos, inverte-se o sinal do número negativo e também o sinal da operação final.
     - caso os operandos sejam ambos negativos, trocam-se ambos os sinais.
   - De seguida temos de recorrer ao predicado auxiliar `bigger` que devolve um par ordenado (a,b), isto é `a > b` (exceto se `a == b`). Assim sabemos sobre que número temos de usar `padMulBN`. `123 * 45 = [100,20,30] * 5` + `([100,20,30] * 4) * 10`.
   - É necessário somar todas as operações de multiplicar e para isso usamos `somaBN` e também acrescentamos zeros à lista das multiplicações intermédias caso seja preciso. Pegando no exemplo acima: `123 * 45` seria igual a `([100,20,30] * 5) ++ []` + `([100,20,30] * 4) ++ [0]`. Ou seja, acrescentamos `i` zeros dependendo do índice do dígito operando mais pequeno (invertido) em que nos encontramos.
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
