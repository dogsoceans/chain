/-  *ledger
|%
:: takes list of tx, updates ledger 
++  make-ledger    
  |=  list-tx=(list tx)
  ^-  ledger
  =/  led=ledger  starting-state
  |-
  ?~  list-tx
    led
  $(led (apply-transaction i.list-tx led), list-tx t.list-tx)

++  transaction-list
  ^-  (list tx)
  ~[[~zod ~nec 3] [~zod ~nec 5] [~nec ~bud 10]]
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
::  handle crashes
++  apply-transaction
  |=  [=tx =ledger]
  ^-  ^ledger
  ?.  (verify-transaction tx ledger)
    ledger
  =/  bal1u  (~(get by ledger) src.tx)
  =/  bal1  
  ?~  bal1u  
    ~
  u.bal1u
  =/  bal2u  (~(get by ledger) des.tx)
  =/  bal2  
  ?~  bal2u  
    ~
  u.bal2u
  =.  ledger  (~(put by ledger) src.tx (sub bal1 amt.tx))
  =.  ledger  (~(put by ledger) des.tx (add bal2 amt.tx))
  ledger
::
++  verify-transaction
  |=  [=tx =ledger]
  ^-  ?
  ?~  (~(get by ledger) src.tx)
    |
  ?~  (~(get by ledger) des.tx)
    |
  (gte (~(got by ledger) src.tx) amt.tx) 
--

    