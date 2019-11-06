## Blockchain in Haskell 

### Evaluate transaction Function
#### Example

evaluate (Mul (Val 2) (Add (Var "x") (Val 10))) (initialiseMemory) = <br>
(evaluate (Val 2) (initialiseMemory) ) * (evaluate (Add (Var "x") (Val 10)) (initialiseMemory)) <br>
evaluate (Add (Var "x") (Val 10)) (initialiseMemory) = <br>
(evaluate (Var "x") (initialiseMemory)) + (evaluate (Val 10) (initialiseMemory)) <br>
evaluate (Var "x") (initialiseMemory) = initialiseMemory "x" = 0 <br>
evaluate (Val 10) (initialiseMemory) = 10 <br>

### Simulate Function 

simulate :: Code -> Memory -> (Memory, [(Address, Amount)]) <br>
simulate (Assign v e) m = ((\x -> if x == v then (evaluate e m) else (m x)), []) <br>
--We would like to assign value of expression 'e' to 'v' variable. <br>
--1. We have to evaluate expression - (evaluate e m) <br>
--2. We have to update value of v in memory (\x -> if x == v then (evaluate e m) else (m x)) <br>
--3. We didnt have any transctions so list of transactions - []. <br>
simulate (Transfer a e) m = (m , [(a, fromInteger (evaluate e m))]) -- address, expression <br>
-- We want to transfer ammount (value of expression 'e') to address 'a' <br>
-- 1. Evaluate expression 'e' (evaulate e m) result is Integer, but amount should be float <br>
-- 2. Convert from integer to Float 'fromInteger' <br>
-- 3. list with our transaction - [(a, fromInteger (evaluate e m))] <br>
-- 4. we did't change any variables, so memory is same - m <br>
simulate (Conditional e (c1, c2)) m = if (evaluate e m) /= 0 then simulate c1 m else simulate c2 m <br>
-- if expression 'e' is not zero, we would like to execute code 'c1', otherwise code 'c2' <br>
-- 1. evaluate expression 'e' - (evaluate e m) <br>
-- 2. execute simulate for appropriate code (c1 or c2) <br>
simulate (While e c) m = if (evaluate e m) /= 0 then simulate (Seq (c) (While e c)) m else (m , []) <br>
-- we would like to execute code 'c' while expression 'e' is not zero <br>
-- 1. evaluate 'e' - (evaluate e m) <br>
-- 2. if 'e' is no zero <br>
-- then sequentialy execute code 'c' and cycle 'while' - simulate (Seq (c) (While e c)) m <br>
-- else 'do nothing' - just return same memory and empty list of transactions - (m , []) <br>
simulate (Seq c1 c2) m = let (new_m, t) = simulate c1 m <br>
                         in let (new_m1, t1) = simulate c2 new_m <br>
                            in (new_m1, t ++ t1) <br>
-- we would like to sequetialy execute code 'c1' and code 'c2' <br>
-- 1. execute code 'c1' - simulate c1 m <br>
-- result of execution is pair - (updated memory, list of transactions) : (new_m, t) <br>
--2. execute code 'c2' with updated memory - simulate c2 new_m <br>
-- result of execution is pair - (updated memory, list of transactions) : (new_m1, t1) <br>
-- 3. we have to return last memory state - new_m1 <br>
-- and list of transactions - t ++ t1 <br>
simulate (Empty) m = (m, []) <br>


