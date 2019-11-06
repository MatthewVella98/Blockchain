## Blockchain in Haskell 

### Evaluate transaction Function
### Example

evaluate (Mul (Val 2) (Add (Var "x") (Val 10))) (initialiseMemory) =
(evaluate (Val 2) (initialiseMemory) ) * (evaluate (Add (Var "x") (Val 10)) (initialiseMemory))
evaluate (Add (Var "x") (Val 10)) (initialiseMemory) =
(evaluate (Var "x") (initialiseMemory)) + (evaluate (Val 10) (initialiseMemory))
evaluate (Var "x") (initialiseMemory) = initialiseMemory "x" = 0
evaluate (Val 10) (initialiseMemory) = 10

### Simulate Function 

simulate :: Code -> Memory -> (Memory, [(Address, Amount)]) --
simulate (Assign v e) m = ((\x -> if x == v then (evaluate e m) else (m x)), [])
--We would like to assign value of expression 'e' to 'v' variable.
--1. We have to evaluate expression - (evaluate e m)
--2. We have to update value of v in memory (\x -> if x == v then (evaluate e m) else (m x))
--3. We didnt have any transctions so list of transactions - [].
simulate (Transfer a e) m = (m , [(a, fromInteger (evaluate e m))]) -- address, expression
-- We want to transfer ammount (value of expression 'e') to address 'a'
-- 1. Evaluate expression 'e' (evaulate e m) result is Integer, but amount should be float
-- 2. Convert from integer to Float 'fromInteger'
-- 3. list with our transaction - [(a, fromInteger (evaluate e m))]
-- 4. we did't change any variables, so memory is same - m
simulate (Conditional e (c1, c2)) m = if (evaluate e m) /= 0 then simulate c1 m else simulate c2 m
-- if expression 'e' is not zero, we would like to execute code 'c1', otherwise code 'c2'
-- 1. evaluate expression 'e' - (evaluate e m)
-- 2. execute simulate for appropriate code (c1 or c2)
simulate (While e c) m = if (evaluate e m) /= 0 then simulate (Seq (c) (While e c)) m else (m , [])
-- we would like to execute code 'c' while expression 'e' is not zero
-- 1. evaluate 'e' - (evaluate e m)
-- 2. if 'e' is no zero
-- then sequentialy execute code 'c' and cycle 'while' - simulate (Seq (c) (While e c)) m
-- else 'do nothing' - just return same memory and empty list of transactions - (m , [])
simulate (Seq c1 c2) m = let (new_m, t) = simulate c1 m
                         in let (new_m1, t1) = simulate c2 new_m
                            in (new_m1, t ++ t1)
-- we would like to sequetialy execute code 'c1' and code 'c2'
-- 1. execute code 'c1' - simulate c1 m
-- result of execution is pair - (updated memory, list of transactions) : (new_m, t)
--2. execute code 'c2' with updated memory - simulate c2 new_m
-- result of execution is pair - (updated memory, list of transactions) : (new_m1, t1)
-- 3. we have to return last memory state - new_m1
-- and list of transactions - t ++ t1
simulate (Empty) m = (m, [])


