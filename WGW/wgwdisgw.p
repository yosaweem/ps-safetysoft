/*---------
/* Disconnect Database GW */
Modify by   : Narin  14/10/2010    A52-0242 
   สรุปหลักการ Connect Database GW  และ Database local 
   1. DATABASE GW  ที่ CONNECT ได้ ให้ทำการ DISCONNECT ออก SIC_BRAN  กับ  BRSTAT
      และ ทำการ Conncet database : gw_safe  &  gw_stat
          sic_bran  --->  
          brstat    --->  gw_stat
   2. DATABASE Local Connect ดังนี้ 
          bransafe --->  -ld  brsic_bran
          brstat   --->  -ld  brstat
     Author program : wgwdisgw.p , wgwcongw.p , wgwconbk.p   
     1. wgwdisgw.p  ==> ทำการ disconnect database gw 
-----------*/

/*IF CONNECTED ("sic_bran")  THEN DISCONNECT sic_bran.   /*gw_safe*/  */
IF CONNECTED ("brstat")    THEN DISCONNECT brstat.     /*gw_stat*/



