/*---------------------------------------------------------------------
wuwbulg1.p : Main Menu Gen Policy and Query Policy Web Service
Copyright  : Safety Insurance Public Company Limited
             บริษัท ประกันคุ้มภัย จำกัด (มหาชน)
Create By  : Kridtiya i. A64-0187 Date. 19/04/2021
             โปรแกรม สำหรับ Connect database เพื่อเข้าระบบ    
-----------------------------------------------------------------------*/
IF NOT CONNECTED("BUInt") THEN DO: 
    /*RUN wuw\wuwlogbu.*/
    /*CONNECT -db BUInt -H tmsth -S buint -N TCP NO-ERROR. */   /*Real*/ 
    /*connect BUInt -H 10.35.176.37  -S 5502 -N TCP -U pdmgr0 -P 95mJbWF.   /*Test*/*/
     connect BUInt -H ctxdb  -S 61760 -N TCP NO-ERROR.

END.
IF NOT CONNECTED("gwctx") THEN DO: 
    /*RUN wuw\wuwlogbu.*/
    /*CONNECT -db BUInt -H tmsth -S buint -N TCP NO-ERROR. */   /*Real*/ 
    /*CONNECT gwctx     -H 10.35.176.37  -S 10011 -N TCP -U pdmgr0 -P pdmgr0.*/
     CONNECT gwctx     -H ctxdb  -S 10011 -N TCP NO-ERROR.
END.

IF NOT CONNECTED("BUInt") THEN DO: 
    MESSAGE "Not Connect Database BUInt !!!" VIEW-AS ALERT-BOX.
    RETURN.
END.
IF NOT CONNECTED("gwctx") THEN DO: 
    MESSAGE "Not Connect Database gwctx !!!" VIEW-AS ALERT-BOX.
    RETURN.
END.
IF NOT CONNECTED("CTXSTAT") OR NOT CONNECTED("CTXBRAN") THEN DO:
    RUN wuw\wuwlogst.
END.
IF NOT CONNECTED("CTXSTAT") OR NOT CONNECTED("CTXBRAN") THEN DO: 
    RETURN.
END.
ELSE RUN wgw\wgwreweb. 
IF CONNECTED("BUInt")   THEN DISCONNECT BUInt.
IF CONNECTED("CTXSTAT") THEN DISCONNECT CTXSTAT.
IF CONNECTED("CTXBRAN") THEN DISCONNECT CTXBRAN.
