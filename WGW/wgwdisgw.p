/*---------
/* Disconnect Database GW */
Modify by   : Narin  14/10/2010    A52-0242 
   ��ػ��ѡ��� Connect Database GW  ��� Database local 
   1. DATABASE GW  ��� CONNECT �� ���ӡ�� DISCONNECT �͡ SIC_BRAN  �Ѻ  BRSTAT
      ��� �ӡ�� Conncet database : gw_safe  &  gw_stat
          sic_bran  --->  
          brstat    --->  gw_stat
   2. DATABASE Local Connect �ѧ��� 
          bransafe --->  -ld  brsic_bran
          brstat   --->  -ld  brstat
     Author program : wgwdisgw.p , wgwcongw.p , wgwconbk.p   
     1. wgwdisgw.p  ==> �ӡ�� disconnect database gw 
-----------*/

/*IF CONNECTED ("sic_bran")  THEN DISCONNECT sic_bran.   /*gw_safe*/  */
IF CONNECTED ("brstat")    THEN DISCONNECT brstat.     /*gw_stat*/



