/*---------
/* Connect Database Local  */
  Modify by   : Narin  18/10/2010    <A52-0242>
   สรุปหลักการ Connect Database GW  และ Database local 
   1. DATABASE GW  ที่ CONNECT ได้ ให้ทำการ DISCONNECT ออก SIC_BRAN  กับ  BRSTAT
      และ ทำการ Conncet database : gw_safe  &  gw_stat
          sic_bran  --->  
          brstat    --->  gw_stat
   2. DATABASE Local Connect ดังนี้ 
          bransafe --->  -ld  brsic_bran
          brstat   --->  -ld  brstat
     Author program : wgwdisgw.p , wgwcongw.p , wgwconbk.p
     3. wgwconbk.p  ==> ทำการ connect database local 
       
-----------*/

  /*CONNECT c:\db_brok\bran\bransafe.db   -ld brsic_bran  -1 NO-ERROR.*/
  CONNECT c:\db_brok\bran\brstat.db                     -1 NO-ERROR. 
  
  IF NOT CONNECTED("brsic_bran") THEN DO:
      CONNECT c:\db_brok\bran\bransafe.db   -ld brsic_bran  -1 NO-ERROR.
      /*
     BELL. BELL. BELL. BELL.
     HIDE MESSAGE NO-PAUSE.
     MESSAGE "Not Connect DB sic_bran (brsic_bran)".
     PAUSE 5 NO-MESSAGE.
     RETURN.
      */
  END.
  
  IF NOT CONNECTED("brstat") THEN DO:
     BELL.  BELL.  BELL.  BELL.
     HIDE MESSAGE NO-PAUSE.
     MESSAGE "Not Connect DB stat (brstat)".
     PAUSE 5 NO-MESSAGE.
     RETURN.
  END.   
  
  
