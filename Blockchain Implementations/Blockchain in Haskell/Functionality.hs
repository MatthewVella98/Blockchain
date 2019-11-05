module Assignment2 where

-- Types from Part1 of this implementation
type Address = Int
type Amount = Float
type Balances = Address -> Amount


type TimeStamp = ((Int, Int, Int), (Int, Int, Int)) -- ((year, month, day), (hours, minutes, seconds))

type Transaction = (Address, Amount, Address, TimeStamp)

type Ledger = [Transaction]

type ExchangeRate = TimeStamp -> Float

-- Code from Part1 of this implementation
initBalances :: Balances
initBalances = \x -> 0

checkEnoughBalance :: Address -> Amount -> Balances -> Bool
checkEnoughBalance address amount balances = (balances address) >= amount

addToBalance :: Address -> Amount -> Balances -> Balances
addToBalance address amount balances = \x -> (if x == address then (balances address) + amount else balances x)

deductFromBalance :: Address -> Amount -> Balances -> Balances
deductFromBalance address amount balances = \x -> (if x == address then (balances address) - amount else balances x)

transfer :: Address -> Amount -> Address -> Balances -> Balances
transfer address1 amount address2 balances = addToBalance address2 amount (deductFromBalance address1 amount balances)

mine :: Amount -> Address -> Balances -> Balances
mine amount address balances = addToBalance address amount balances

------
showTimeStamp :: TimeStamp -> String
showTimeStamp ((year, month, day), (hours, minutes, seconds)) = show month ++ "/" ++ show day ++ "/" ++ show year ++ " " ++ show hours ++ "h" ++ show minutes ++ "m" ++ show seconds ++ "s"
 -- convert to string


before :: TimeStamp -> TimeStamp -> Bool
before (d1, t1) (d2, t2) = d1 < d2 || d1 == d2 && t1 < t2 -- compare tuples
-- Comparison operator for twin -tuples;
-- It compares 1st elem with 1st elem, if one elemet is greater, it returns, else it will
-- compare the next two ; 2nd elem with 2nd elem etc..


between :: (TimeStamp, TimeStamp) -> TimeStamp -> Bool
between (ts1, ts2) ts = before ts1 ts && before ts ts2
-- Using the before function we created above.


performTransaction :: Transaction -> Balances -> Balances
performTransaction (addr1, amount, addr2, _) balances =  if addr1 == 0 then mine amount addr2 balances else transfer addr1 amount addr2 balances
 -- if sender's address is zero - mining, otherwise - transfer transaction


ledgerToBalances :: Ledger -> Balances
ledgerToBalances ledger = foldl (\balances transaction -> performTransaction transaction balances) initBalances ledger
-- Start with initBalances as first value (all balances are zero) and the first transaction
-- from the list Ledger. When the function, performTransaction, performs the transaction,it returns the updated balances
-- and the updated balances will be used instead of the init balances, to perform the second transaction on the list,
-- this is repeated for all the transactions in the list.


ledgerValidTimeStamp :: Ledger -> Bool
ledgerValidTimeStamp ledger = foldl (\res ((_, _, _, ts1), (_, _, _, ts2)) -> res && before ts1 ts2) True (zip ledger (tail ledger))
-- \res will start as True as initial value (_, _, _, ts1)) = any transaction.
-- The 2 timestamps are taken from the 2 transactions given, and are compared using the before method.
-- If after comparing any transactions, the before method returns a false, ultimetely, a False is returned.
-- Else, If all timestamps are correct, a True is outputted.


ledgerValidBalances :: Ledger -> Bool
ledgerValidBalances ledger = fst (foldl (\(res, balances) (addr1, amount, addr2, ts) -> (if addr1 == 0 then res else res && (checkEnoughBalance addr1 amount balances), performTransaction (addr1, amount, addr2, ts) balances)) (True, initBalances) ledger)
-- fst: a functions which takes the first element in a tuple
-- If it's  a mining transaction, addr1 = 0, its True since can't leave sender without empty balance cause no sender exists
-- Else, res is initially True, and a check is done with checkEnoughBalance for address 1, if the user has enough balance,
-- it will return true since True && True = True. Else it will be false. The transaction is performed eitherway using method
-- performTransaction, finally outputting a tuple (Bool, Balances) , bool showing whether or not all transactions left the sender
-- with a negative balance, and the updated balances after all transactions. function fst is used to take the bool only.


transactionsBetweenTimeStamps :: Ledger -> (TimeStamp, TimeStamp) -> Ledger
transactionsBetweenTimeStamps ledger (ts1, ts2) = [(addr1, amount, addr2, ts) | (addr1, amount, addr2, ts) <- ledger, between (ts1, ts2) ts]
-- List Comprehension: select transactions, from ledger, filter with between method .


transactionsExceedingAmount :: Ledger -> Amount -> Ledger
transactionsExceedingAmount ledger amount = filter (\(addr1, amnt, addr2, ts) -> amnt > amount) ledger
-- Select transactions from 'ledger' where amt > amount


ledgerInEuros :: Ledger -> Float -> Ledger
ledgerInEuros ledger rate = map (\(addr1, amount, addr2, ts) -> (addr1, amount * rate, addr2, ts)) ledger
-- map : for each element of the list 'ledger', peform the lambda (multiply each amount by the exchange rate constant)


ledgerInEurosOverTime :: Ledger -> ExchangeRate -> Ledger
ledgerInEurosOverTime ledger rate = map (\(addr1, amount, addr2, ts) -> (addr1, amount * (rate ts), addr2, ts)) ledger
-- multiply each amount by the exchange rate at the given time

-- Functions to call
q1_a = showTimeStamp ((2018, 11, 10), (11, 32, 45))
--"11/10/2018 11h32m45s"
q1_b = before ((2018, 11, 10), (11, 32, 45)) ((2019, 11, 10), (11, 32, 45))
 -- "True"
q1_c = between (((2018, 11, 10), (11, 32, 45)),((2019, 11, 10), (11, 32, 45)))  ((2018, 12, 10), (11, 32, 45))
 --True
q2_a = performTransaction (0, 10, 1, ((2018, 11, 10), (11, 32, 45))) initBalances 1
-- "10.0"
q2_b = ledgerToBalances [(0, 10, 1, ((2018, 11, 10), (11, 32, 45))), (1, 3, 2, ((2019, 11, 10), (11, 32, 45)))] 1
-- "7.0"
q2_c1 = ledgerValidTimeStamp [(0, 10, 1, ((2018, 11, 10), (11, 32, 45))), (1, 3, 2, ((2019, 11, 10), (11, 32, 45)))]
-- True
q2_c2 = ledgerValidBalances [(0, 10, 1, ((2018, 11, 10), (11, 32, 45))), (1, 3, 2, ((2019, 11, 10), (11, 32, 45)))]
 -- True
q2_d = transactionsBetweenTimeStamps [(0, 10, 1, ((2018, 11, 10), (11, 32, 45))), (1, 3, 2, ((2019, 11, 10), (11, 32, 45))), (1, 3, 2, ((2019, 12, 10), (11, 32, 45)))] (((2018, 11, 12), (11, 32, 45)), ((2019, 12, 10), (12, 32, 45)))
    --[(1,3.0,2,((2019,11,10),(11,32,45))),(1,3.0,2,((2019,12,10),(11,32,45)))]
q2_e = transactionsExceedingAmount [(0, 10, 1, ((2018, 11, 10), (11, 32, 45))), (1, 3, 2, ((2019, 11, 10), (11, 32, 45)))] 5
 -- [(0,10.0,1,((2018,11,10),(11,32,45)))]
q2_f = ledgerInEuros [(0, 10, 1, ((2018, 11, 10), (11, 32, 45))), (1, 3, 2, ((2019, 11, 10), (11, 32, 45)))] 3.2
--[(0,32.0,1,((2018,11,10),(11,32,45))),(1,9.6,2,((2019,11,10),(11,32,45)))]

fluctuate ((_, _, _),(_, _, s)) =1.5 + sin ((2 * pi *(fromInteger (toInteger s)))/60)
q2_g = ledgerInEurosOverTime [(0, 10, 1, ((2018, 11, 10), (11, 32, 45))), (1, 3, 2, ((2019, 11, 10), (11, 32, 45)))] fluctuate
-- [(0,5.0,1,((2018,11,10),(11,32,45))),(1,1.5,2,((2019,11,10),(11,32,45)))]
