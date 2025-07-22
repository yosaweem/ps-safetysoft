/*---------------------------------------------------------------------
WUWBULOG.P : Main Menu Login BuInt For Change Q To Policy and Print [On Web]
Copyright  : Safety Insurance Public Company Limited
             บริษัท ประกันคุ้มภัย จำกัด (มหาชน)
Create By  : Sarinya C.  A62-0248  27/05/2019             
Modify By  : Sarinya C.  A62-0105  18/09/2019 แก้ไข Host  
Modify By : Sarinya C. A64-0217  20/05/2021  Change host => TMPMWSDBIP01  
-----------------------------------------------------------------------*/
IF NOT CONNECTED("BUInt") THEN DO: 
   /*RUN wuw\wuwlogbu.*/
   /*CONNECT -db BUInt -H tmsth -S buint -N TCP NO-ERROR. /*Real*/*/ /*Comment A64-0217*/    
    CONNECT -db BUInt -H TMPMWSDBIP01 -S buint -N TCP NO-ERROR. /*Real*/    /*add A64-0217*/        
   /*CONNECT -db BUInt -H wsbuint -S buint -N TCP NO-ERROR. /*Real old*/*/
   /*connect BUInt -H 16.90.20.216 -S 5502 -N TCP -U pdmgr0 -P 95mJbWF. /*Test*/  */
   /*CONNECT BUInt -H 16.90.20.201 -S 5022 -N TCP -U pdmgr0 -P pdmgr0.  /*Test*/  */
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

ELSE RUN WUW\WUWMENPW.
/*ELSE RUN wuw\wuwvcnqd.*//*Comment Phorn*/
IF CONNECTED("BUInt")   THEN DISCONNECT BUInt.
IF CONNECTED("CTXSTAT") THEN DISCONNECT CTXSTAT.

