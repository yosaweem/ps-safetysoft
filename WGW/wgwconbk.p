/*---------
/* Connect Database Local  */
  Modify by   : Narin  18/10/2010    <A52-0242>
   ��ػ��ѡ��� Connect Database GW  ��� Database local 
   1. DATABASE GW  ��� CONNECT �� ���ӡ�� DISCONNECT �͡ SIC_BRAN  �Ѻ  BRSTAT
      ��� �ӡ�� Conncet database : gw_safe  &  gw_stat
          sic_bran  --->  
          brstat    --->  gw_stat
   2. DATABASE Local Connect �ѧ��� 
          bransafe --->  -ld  brsic_bran
          brstat   --->  -ld  brstat
     Author program : wgwdisgw.p , wgwcongw.p , wgwconbk.p
     3. wgwconbk.p  ==> �ӡ�� connect database local 
       
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
  
  
