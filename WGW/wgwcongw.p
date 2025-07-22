/*------
/* Connect Database GW   */
   Author: 
       Narin  18/10/2010   <Assign A52-242>  
   สรุปหลักการ Connect Database GW  และ Database local 
   1. DATABASE GW  ที่ CONNECT ได้ ให้ทำการ DISCONNECT ออก SIC_BRAN  กับ  BRSTAT
      และ ทำการ Conncet database : gw_safe  &  gw_stat
          sic_bran  
          brstat    --->  gw_stat
   2. DATABASE Local Connect ดังนี้ 
          bransafe --->  -ld  brsic_bran
          brstat   --->  -ld  brstat
    Author program : wgwdisgw.p , wgwcongw.p , wgwconbk.p   
     2. wgwcongw.p  ==> ทำการ connect database gw   
------*/

 CONNECT gw_safe -H newapp -S gw_safe -N TCP 
                 -ld sic_bran   /*-ld sic_bran */ 
                 NO-ERROR.
   
 CONNECT gw_stat -H newapp -S gw_stat -N TCP 
                 
                 NO-ERROR.
   IF NOT CONNECTED ("gw_stat") THEN DO:
       MESSAGE "Not Connect DB GW GW_STAT".
   END. 

