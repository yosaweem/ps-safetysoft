/*--- Begin Sayamol N. 19/9/2012 ---*/
/*---- End Sayamol N. 19/9/2012 ----*/
/*----   Modify by A56-0127 Sayamol N. 10/05/2013
      - Change global Variable from n_user, n_passwd 
        to n_glbrusr, n_glbrpwd
------*/
/* Modify By : Porntiwa T.  A62-0105  25/06/2019
             : Change Host => tmsth                  */

/*---A56-0127---
DEF     SHARED  VAR n_User     AS   CHAR.
DEF     SHARED  VAR n_Passwd   AS   CHAR.
-----------*/
DEF     VAR n_glbrusr     AS   CHAR.
DEF     VAR n_glbrpwd   AS   CHAR.

    /* connect sicfn  alpha4 */
    IF Not CONNECTED ("gl_bran") THEN 
        CONNECT -db gl_bran -H tmsth -S gl_bran -N TCP -U value(n_glbrusr) -P value(n_glbrpwd).
        /*CONNECT -db gl_bran -H alpha4 -S gl_bran -N TCP -U value(n_glbrusr) -P value(n_glbrpwd).*//*Comment A62-0105*/  
        /*---For TEST---*/
        /*---A56-0127---
        CONNECT -db gl_bran -H newapp -S gl_brantest -N TCP -U value(n_User) -P value(n_Passwd)  
        ----------*/                                                                             
         /*----------
        CONNECT -db gl_bran -H newapp -S gl_brantest -N TCP -U value(n_glbrusr) -P value(n_glbrpwd)  
        -cpinternal 620-2533 -cpstream 620-2533 NO-ERROR.
        ---*/
   


     IF NOT CONNECTED ("gl_bran") THEN DO:
             MESSAGE "gl_bran  not connect " VIEW-AS ALERT-BOX ERROR BUTTONS OK 
            TITLE "Invalid LOGON".
     END.
