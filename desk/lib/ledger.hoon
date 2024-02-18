/-  *ledger
::check if transactions is valid
::make ledger.hoon
|%
:: takes list of tx, updates ledger 
++  make-ledger    
  |=  list-tx=(list tx)
  ^-  ledger
  =/  led=ledger  starting-state
  =/  counter  0
  |-
  ?:  =(counter (dec (lent list-tx)))
    led
::take index of counter on list to produce tx, apply list to ledger   
  %=  $
  counter  +(counter)
  led      (apply-transaction (snag counter list-tx) led)
  ==

::  %^  spin   need-have error here spin takes list and list-tx is list??  
::    list-tx
::    starting-state
::    apply-transaction

++  transaction-list
  ^-  (list tx)
  ~[[~zod ~nec 5] [~zod ~nec 5] [~nec ~bud 10]]

++  nodes
  ^-  (set account)
  %-  silt
  ^-  (list ship)
  ~[~zod ~nec ~bud ~wes]

++  starting-state
  ^-  ledger
  %-  molt          ::when to use %- vs (
  %+  turn
    ~(tap in nodes)
  |=  acc=account 
  ^-  [account balance]
  [acc (bex 6)]
  

++  apply-transaction
  |=  [=tx =ledger]
  ^-  ^ledger
  =/  bal1=balance  (~(got by ledger) src.tx)
  =/  bal2=balance  (~(got by ledger) des.tx)
  ?:  (verify-transaction bal1 amt.tx)
    =/  bal1=balance  (sub bal1 amt.tx)
  ~&  'balance can not be negative'
  !!
  =/  bal2=balance  (add bal2 amt.tx)
  =/  ledger  (~(put by ledger) src.tx bal1) 
  =/  ledger  (~(put by ledger) des.tx bal2) 
  ledger
:: verify balance wont be negative
++  verify-transaction
  |=  [bal1=balance txn=balance]
  ^-  ?
  ?:  (gte bal1 txn)
    &
      |
--
    