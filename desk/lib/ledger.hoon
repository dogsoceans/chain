/-  *ledger
|%
:: takes list of tx, updates ledger 
++  make-ledger    
  |=  list-tx=(list tx)
  ^-  ledger
  =/  led=ledger  starting-state
  =/  counter  0
  |-
  ~&  ~['counter' counter]
  ?:  =(counter (dec (lent list-tx)))
    led
  %=  $   
  counter  +(counter)
  led      (apply-transaction (snag counter list-tx) led)
  ==  
::  %^  spin   ::need-have error doesn't return just ledger  
::    list-tx
::    led
::    apply-transaction
::
++  transaction-list
  ^-  (list tx)
  ~[[~zod ~nec 100] [~zod ~nec 5] [~nec ~bud 10]]
::
++  nodes
  ^-  (set account)
  %-  silt
  ^-  (list ship)
  ~[~zod ~nec ~bud ~wes]
::
++  starting-state
  ^-  ledger
  %-  molt          
  %+  turn
    ~(tap in nodes)
  |=  acc=account 
  ^-  [account balance]
  [acc (bex 6)]
::
++  apply-transaction
  |=  [=tx =ledger]
  ^-  ^ledger
  ?.  (verify-transaction (~(got by ledger) src.tx) amt.tx)
    ledger
  =.  ledger  (~(put by ledger) src.tx (sub (~(got by ledger) src.tx) amt.tx))
  =.  ledger  (~(put by ledger) des.tx (add (~(got by ledger) des.tx) amt.tx))
  ledger
::  =/  bal1=balance  (~(got by ledger) src.tx) ::unsafe got
::  =/  bal2=balance  (~(got by ledger) des.tx)
::  ?.  (verify-transaction bal1 amt.tx)
::     ledger
::  =/  bal1=balance  (sub bal1 amt.tx)
::  =/  bal2=balance  (add bal2 amt.tx)
::  =/  ledger  (~(put by ledger) src.tx bal1) 
::  =/  ledger  (~(put by ledger) des.tx bal2) 
::  ledger

:: verify balance wont be negative
:: if balance is negative skip the invalid tx and store the tx in an error message and continue  
:: I dont know how to handle the invalidtx.. make-ledger returns a ledger not an error msg should i change that?
++  verify-transaction
  |=  [bal1=balance txn=balance]
  ^-  ?
  ?:  (gte bal1 txn)
    ~&  'valid bal'
    &
      ~&  ~['balance cant be negative' bal1 'amt.tx' txn] 
      |
--
    