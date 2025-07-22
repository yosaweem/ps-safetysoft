IF NOT CONNECTED ("TID") THEN 
     CONNECT -db TID -H TMSTH -S TID -N TCP. 
    /*CONNECT -db TID -H devserver -S TID -N TCP. */

 IF NOT CONNECTED ("TID") THEN DO:
             MESSAGE "TID  not connect " VIEW-AS ALERT-BOX ERROR BUTTONS OK 
            TITLE "Invalid LOGON".
 END.
