module Assignment3 where

-- code from Assigment 1&2
type Address = Integer
type Amount = Float
type TimeStamp = ((Int, Int, Int), (Int, Int, Int))
type Transaction = (Address, Amount, Address, TimeStamp)
type Ledger = [Transaction]

-- (1)
type VarName = String
-- (1)
data Exp = Var VarName | Val Integer | Add Exp Exp | Mul Exp Exp | Neg Exp deriving (Eq)
--  (1)
type Memory = VarName -> Integer
--  (2)
data Code = Assign VarName Exp
          | Transfer Address Exp
          | Conditional Exp (Code, Code)
          | While Exp Code
          | Seq Code Code
          | Empty
   deriving (Eq)
-- (3)
type SmartLedger = (Ledger, Address -> (Code, Memory))

--  (1a)
initialiseMemory :: Memory
initialiseMemory = \x -> 0
-- This function returns the value of a variable when given it's name.

-- (1b)
instance Show Exp where
  show (Val x) = show x  --If it's a value, convert it to string and show it
  show (Var n) = n -- If it's a variable name, return it
  show (Add exp1 exp2) = "(" ++ show exp1 ++ ") + (" ++ show exp2 ++ ")" --If it's a sum of 2 expressions. 1. obtain each expression as a string 2. and some brackets and '+'
  show (Mul exp1 exp2) = "(" ++ show exp1 ++ ") * (" ++ show exp2 ++ ")"
  show (Neg exp)  = " - (" ++ show exp ++ ")"

--  (1c)
evaluate :: Exp -> Memory -> Integer   --Memory is a function: Given a variable name, it returns a value.
evaluate (Val x) _ = x --If it's just a value, return it.
evaluate (Var varName) memory = memory varName --If it's a variable, return it's value from memory.
evaluate (Add exp1 exp2) memory = (evaluate exp1 memory) + (evaluate exp2 memory) --Calculate value of each expression. Then work the sum of the 2 values
evaluate (Mul exp1 exp2) memory = (evaluate exp1 memory) * (evaluate exp2 memory)
evaluate (Neg exp) memory = - (evaluate exp memory)

-- Example:  evaluate (Mul (Val 2) (Add (Var "x") (Val 10))) (initialiseMemory) =
-- (evaluate (Val 2) (initialiseMemory) ) * (evaluate (Add (Var "x") (Val 10)) (initialiseMemory))

--  evaluate (Add (Var "x") (Val 10)) (initialiseMemory) =
-- (evaluate (Var "x") (initialiseMemory)) + (evaluate (Val 10) (initialiseMemory))

--evaluate (Var "x") (initialiseMemory) = initialiseMemory "x" = 0
-- evaluate (Val 10) (initialiseMemory) = 10

-- (2a)
instance Show Code where
  show (Assign v e) = v ++ " = " ++ show e
  show (Transfer a e) = "transfer " ++ show e ++ " to " ++ show a
  show (Conditional e (c1, c2)) = "if " ++ show e ++ " then {" ++ show c1 ++ "} else {" ++ show c2 ++ "}"
  show (While e c) = "while " ++ show e ++ "\n\r{" ++ show c ++ "}"
  show (Seq c1 c2) = show c1 ++ "\n\r" ++ show c2
  show (Empty) = ""

-- (2b)
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

-- (3a)
initialSmartLedger :: SmartLedger
initialSmartLedger = ([], (\_ -> (Empty, initialiseMemory)))
-- Function returns empty SmartLedger
-- [] - empty Ledger
-- (\_ -> (Empty, initialiseMemory)) - function which returns empty Code and emty Memoru for any Address

--Functions to Call
q1a = initialiseMemory "x"
q1b = Mul (Val 2) (Add (Var "x") (Val 10))
q1c = evaluate (Mul (Val 2) (Add (Var "x") (Val 10))) (initialiseMemory)
q2a = Seq (Conditional (Var "x") (Assign "x" (Val 2), Assign "x" (Val 3))) (While (Var "x") (Seq (Assign "x" (Add (Var "x") (Neg (Val 1)))) (Transfer 1 (Mul (Val 2) (Add (Var "x") (Val 10))))))
q2b = snd (simulate (Seq (Conditional (Var "x") (Assign "x" (Val 2), Assign "x" (Val 3))) (While (Var "x") (Seq (Assign "x" (Add (Var "x") (Neg (Val 1)))) (Transfer 1 (Mul (Val 2) (Add (Var "x") (Val 10))))))) initialiseMemory)
q3a = fst initialSmartLedger
