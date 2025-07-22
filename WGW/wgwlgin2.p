/*---------------------------------------------------------------------
wgwlgin2.p : Main Menu Login BuInt For Export PDF
Copyright  : Safety Insurance Public Company Limited
             บริษัท ประกันคุ้มภัย จำกัด (มหาชน)
Create By  : Kridtiya i.A60-0495 Date. 11/12/2017   
             Check System Data base connect BUInt.....   
             
Modify BY  : Porntiwa T.  A62-0105  10/09/2019
           : แก้ไข Host เป็น tmsth         
Modify By : Sarinya C. A64-0217  20/05/2021 Change host => TMPMWSDBIP01  
-----------------------------------------------------------------------*/

IF NOT CONNECTED("BUInt") THEN DO: 
    /*RUN wuw\wuwlogbu.*/
    /*CONNECT -db BUInt -H tmsth -S buint -N TCP NO-ERROR.    /*Real Product */ */ /*Comment A64-0217*/    
    CONNECT -db BUInt -H TMPMWSDBIP01 -S buint -N TCP NO-ERROR.      /*Real Product */    /*add A64-0217*/        
    /*CONNECT -db BUInt -H wsbuint -S buint -N TCP NO-ERROR.                /*Real Product */ *//*Comment A62-0105*/
    /*connect BUInt -H 16.90.20.216 -S 5502 -N TCP -U pdmgr0 -P 95mJbWF.  /*Test*/*/
    /*CONNECT BUInt -H 16.90.20.201 -S 5022 -N TCP -U pdmgr0 -P pdmgr0. *//*Test  */
END.
IF CONNECTED ("BUInt") THEN DO:
        RUN  wgw/WGWBQPDF2. 
END.
ELSE DO:
    MESSAGE "Cannot connected Database buint Demilitarized zone."
        VIEW-AS ALERT-BOX ERROR BUTTONS OK TITLE "Invalid LOGON".
    RETURN.
END.
IF CONNECTED("BUInt") THEN DISCONNECT BUInt.
