/*---------------------------------------------------------------------
WUWBULOG2.P : Main Menu Login BuInt For Trans Data Citrix (GES) To GW
Copyright  : Safety Insurance Public Company Limited
             บริษัท ประกันคุ้มภัย จำกัด (มหาชน)
Create By  : Sarinya C.  A63-0319  24/12/2020    
Modify By : Sarinya C. A64-0217  20/05/2021 Change host => TMPMWSDBIP01       
-----------------------------------------------------------------------*/
IF NOT CONNECTED("BUInt") THEN DO: 

    /*CONNECT -db BUInt -H tmsth -S buint -N TCP NO-ERROR. /*Real*/*/  /*Comment A64-0217*/       
    CONNECT -db BUInt -H TMPMWSDBIP01 -S buint -N TCP NO-ERROR. /*Real*/      /*add A64-0217*/           
  /*connect BUInt    -H 16.90.20.216 -S 5022  -N TCP -U pdmgr0 -P pdmgr0. /*Non motor*/*/ /*UAT*/
END.
IF NOT CONNECTED("BUInt") THEN DO: 
    RETURN.
END.

IF NOT CONNECTED("CTXSTAT") OR NOT CONNECTED("CTXBRAN") THEN DO:
    RUN wuw\wuwlogst.
END.
IF NOT CONNECTED("CTXSTAT") OR NOT CONNECTED("CTXBRAN") THEN DO: 
    RETURN.
END.

ELSE RUN WUW\WUWGSEMU.
IF CONNECTED("BUInt")   THEN DISCONNECT BUInt.
IF CONNECTED("CTXSTAT") THEN DISCONNECT CTXSTAT.

