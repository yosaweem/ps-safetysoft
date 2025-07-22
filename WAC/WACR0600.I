/*---  Create By A53-0159  Sayamol N. ---*/
/*---------------------------------------*/
DEF VAR nv_insref AS CHAR FORMAT "X" INIT "".
DEF VAR nv_dir    AS CHAR FORMAT "X(3)" INIT "".
DEF VAR nv_polgrp AS CHAR FORMAT "X(6)" INIT "".
DEF VAR nv_polgrpdes AS CHAR FORMAT "X(30)" INIT "".
DEF VAR nv_grptypdes AS CHAR FORMAT "X(30)" INIT "".

DEF VAR nv_Out AS LOGICAL.

DEF VAR n_OutputFile_W AS CHAR FORMAT "X(50)" INIT "C:\EXP_CBC".
DEF VAR n_OutputFile_S AS CHAR FORMAT "X(50)" INIT "C:\EXP_CBCs".

DEF WORKFILE wagtprm_fil 
     FIELD polgrp    AS CHAR FORMAT "X(6)"
     FIELD grptyp    AS CHAR FORMAT "X(6)"
     FIELD acno      LIKE  agtprm_fil.acno
     FIELD agent     LIKE  agtprm_fil.agent
     FIELD TYPE      LIKE  agtprm_fil.TYPE
     FIELD ac_name   LIKE  agtprm_fil.ac_name
     FIELD polbran   LIKE  agtprm_fil.polbran
     FIELD credit    LIKE  agtprm_fil.credit
     FIELD trndat    LIKE  agtprm_fil.trndat
     FIELD duedat    LIKE  agtprm_fil.duedat
     FIELD trntyp    LIKE  agtprm_fil.trntyp
     FIELD docno     LIKE  agtprm_fil.docno
     FIELD poltyp    LIKE  agtprm_fil.poltyp
     FIELD policy    LIKE  agtprm_fil.policy
     FIELD endno     LIKE  agtprm_fil.endno
     FIELD comdat    LIKE  agtprm_fil.comdat
     FIELD expdat    AS DATE FORMAT "99/99/9999"
     FIELD premA     AS DEC FORMAT "->>,>>>,>>>,>>9.99" 
     FIELD commA     AS DEC FORMAT "->>,>>>,>>>,>>9.99" 
     FIELD balA      AS DEC FORMAT "->>,>>>,>>>,>>9.99" 
     FIELD retcA     AS DEC FORMAT "->>,>>>,>>>,>>9.99" 
     FIELD suspA     AS DEC FORMAT "->>,>>>,>>>,>>9.99" 
     FIELD netarA    AS DEC FORMAT "->>,>>>,>>>,>>9.99" 
     FIELD netothA   AS DEC FORMAT "->>,>>>,>>>,>>9.99" 
     FIELD baldet    AS DEC FORMAT "->>,>>>,>>>,>>9.99" EXTENT 7
     FIELD polgrpdes AS CHAR FORMAT "X(20)"
     FIELD grptypdes AS CHAR FORMAT "X(20)".

/* ช่อง 1 - 15  column 2 - 16 */
DEF VAR nl_Tprem    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nl_Ttax     AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nl_Tvat     AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nl_Tsbt     AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nl_Tstamp   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nl_Ttotal   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nl_Tcomm    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nl_Tnet     AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nl_Tretc    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nl_Tsusp    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nl_Tbal     AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nl_Tnetar   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nl_Tnetoth  AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.
DEF VAR nl_balDet   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 15.

/*ผลรวม 15 ช่อง  column 1 */
DEF VAR nl_TTprem   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nl_TTtax    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nl_TTvat    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nl_TTsbt    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nl_TTstamp  AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nl_TTtotal  AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nl_TTcomm   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nl_TTnet    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nl_TTretc   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nl_TTsusp   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nl_TTbal    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nl_TTnetar  AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nl_TTnetoth AS DECI FORMAT "->>,>>>,>>>,>>9.99".

DEF VAR totA_premA          AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.                  
DEF VAR totA_commA          AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.  
DEF VAR totA_balA           AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.    
DEF VAR totA_retcA          AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.   
DEF VAR totA_suspA          AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.   
DEF VAR totA_netarA         AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.   
DEF VAR totA_netothA        AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.    
DEF VAR totA_balDet         AS DEC FORMAT "->>,>>>,>>>,>>9.99" EXTENT 7.

DEF VAR totC_premA          AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.                  
DEF VAR totC_commA          AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.  
DEF VAR totC_balA           AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.    
DEF VAR totC_retcA          AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.   
DEF VAR totC_suspA          AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.   
DEF VAR totC_netarA         AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.   
DEF VAR totC_netothA        AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.    
DEF VAR totC_balDet         AS DEC FORMAT "->>,>>>,>>>,>>9.99" EXTENT 7.

DEF VAR totG_premA          AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.                  
DEF VAR totG_commA          AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.  
DEF VAR totG_balA           AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.    
DEF VAR totG_retcA          AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.   
DEF VAR totG_suspA          AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.   
DEF VAR totG_netarA         AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.   
DEF VAR totG_netothA        AS DEC FORMAT "->>,>>>,>>>,>>9.99" INIT 0.    
DEF VAR totG_balDet         AS DEC FORMAT "->>,>>>,>>>,>>9.99" EXTENT 7.

DEF VAR NO_expdat           AS DATE FORMAT "99/99/9999".
