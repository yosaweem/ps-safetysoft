/*--- Begin Nattanicha K. A62-0281  20/11/2019 ---*/

DEF     SHARED  VAR n_User     AS   CHAR.
DEF     SHARED  VAR n_Passwd   AS   CHAR.

/* connect gloracle  Super Dome */
IF NOT CONNECTED ("gloracle") THEN 
   
   /*--- For Develop ---*/
    CONNECT -db gloracle -H 18.10.100.5 -S 4830 -N TCP -U value(n_user) -P value(n_passwd)  
    -cpinternal 620-2533 -cpstream 620-2533 NO-ERROR.
   /*-------------------*/

    /*--- For Production----  
     CONNECT -db glorcle -H tmsth -S 4830-N TCP -U value(n_user) -P value(n_passwd)  
    -cpinternal 620-2533 -cpstream 620-2533 NO-ERROR.
    ------------------------*/


 IF NOT CONNECTED ("gloracle") THEN DO:
         MESSAGE "gloracle  not connect " VIEW-AS ALERT-BOX ERROR BUTTONS OK 
        TITLE "Invalid LOGON".
 END.
