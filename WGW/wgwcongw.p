/*------
/* Connect Database GW   */
   Author: 
       Narin  18/10/2010   <Assign A52-242>  
   ��ػ��ѡ��� Connect Database GW  ��� Database local 
   1. DATABASE GW  ��� CONNECT �� ���ӡ�� DISCONNECT �͡ SIC_BRAN  �Ѻ  BRSTAT
      ��� �ӡ�� Conncet database : gw_safe  &  gw_stat
          sic_bran  
          brstat    --->  gw_stat
   2. DATABASE Local Connect �ѧ��� 
          bransafe --->  -ld  brsic_bran
          brstat   --->  -ld  brstat
    Author program : wgwdisgw.p , wgwcongw.p , wgwconbk.p   
     2. wgwcongw.p  ==> �ӡ�� connect database gw   
------*/

 CONNECT gw_safe -H newapp -S gw_safe -N TCP 
                 -ld sic_bran   /*-ld sic_bran */ 
                 NO-ERROR.
   
 CONNECT gw_stat -H newapp -S gw_stat -N TCP 
                 
                 NO-ERROR.
   IF NOT CONNECTED ("gw_stat") THEN DO:
       MESSAGE "Not Connect DB GW GW_STAT".
   END. 

