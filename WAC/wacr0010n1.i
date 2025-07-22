/* wacr0010n1.i : use for wacr0010.w                           */
/* Create by    : Benjaporn J. A59-0476 date 03/10/2016        */

DEF NEW SHARED VAR  jv_bran AS CHAR.  
DEF SHARED VAR nv_Fent AS DATE FORMAT "99/99/9999".
DEF SHARED VAR nv_Tent AS DATE FORMAT "99/99/9999".
DEF SHARED VAR nv_Type AS CHAR FORMAT "X(1)"      .

DEF SHARED VAR nv_jv      AS LOGICAL.
DEF SHARED VAR nv_source  AS CHAR FORMAT "X(2)".
DEF SHARED VAR nv_source2 AS CHAR FORMAT "X(2)".
DEF SHARED VAR nv_Pter    AS CHAR FORMAT "X(20)".

DEF VAR per_l     AS DECIMAL  FORMAT "->>9.99".
DEF VAR per_f     AS DECIMAL  FORMAT "->>9.99".
DEF VAR per_a     AS DECIMAL  FORMAT "->>9.99".

DEF VAR nv_insure AS CHAR     FORMAT "X(20)".
DEF VAR nv_acno   AS CHAR     FORMAT "X(7)" .
DEF VAR nv_payee  AS CHAR     FORMAT "X(25)".
DEF VAR nv_clicod LIKE XMM600.CLICOD.

DEF NEW SHARED VAR nv_surve  AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEF NEW SHARED VAR nv_tranC  AS DECIMAL FORMAT "->>,>>>,>>9.99".
DEF VAR nv_nature AS CHAR    FORMAT "X(2)" .
DEF VAR nv_req    AS CHAR    FORMAT "X(10)".
/*-------------------     For JV    -----------------------*/
DEF  NEW SHARED VAR  n_macc      AS  CHAR      FORMAT "X(16)".
DEF  NEW SHARED VAR  n_sacc1     AS  CHAR      FORMAT "X(6)".
DEF  NEW SHARED VAR  n_sacc2     AS  CHAR      FORMAT "X(6)".
DEF  NEW SHARED VAR  n_prgrp     AS  INTE      FORMAT "9".
DEF  NEW SHARED VAR  n_m1        AS  CHAR      FORMAT "X".
DEF  NEW SHARED VAR  n_m2        AS  CHAR      FORMAT "X(2)".
DEF  NEW SHARED VAR  n_m3        AS  CHAR      FORMAT "X(2)".
DEF  NEW SHARED VAR  n_m4#1      AS  CHAR      FORMAT "X(3)".
DEF  NEW SHARED VAR  n_m1_3      AS  CHAR      FORMAT "X(6)".
DEF  NEW SHARED VAR  n_m4#2      AS  CHAR      FORMAT "X(2)".
DEF  NEW SHARED VAR  n_m4#le     AS  CHAR      FORMAT "X(3)"  INIT "319".
DEF  NEW SHARED VAR  n_m4#fe     AS  CHAR      FORMAT "X(3)"  INIT "339".
DEF  NEW SHARED VAR  n_m4#ae     AS  CHAR      FORMAT "X(3)"  INIT "329".
DEF  NEW SHARED VAR  n_m4#lx     AS  CHAR      FORMAT "X(3)"  INIT "310".
DEF  NEW SHARED VAR  n_m4#fx     AS  CHAR      FORMAT "X(3)"  INIT "330".
DEF  NEW SHARED VAR  n_m4#ax     AS  CHAR      FORMAT "X(3)"  INIT "320".
DEF  NEW SHARED VAR  n_m4#e      AS  CHAR      FORMAT "X(3)"  INIT "119".
DEF  NEW SHARED VAR  n_m4#x      AS  CHAR      FORMAT "X(3)"  INIT "110".
DEF  NEW SHARED VAR  n_m1e       AS  CHAR      FORMAT "X(3)".
DEF  NEW SHARED VAR  n_m2e       AS  CHAR      FORMAT "X(2)".
DEF  NEW SHARED VAR  n_m4#1e     AS  CHAR      FORMAT "X(3)".
DEF  NEW SHARED VAR  n_m1_3e     AS  CHAR      FORMAT "X(6)".
DEF  NEW SHARED VAR  n_m4#2e     AS  CHAR      FORMAT "X(2)".
DEF  NEW SHARED VAR  n_m4##le    AS  CHAR      FORMAT "X(3)"  INIT "219".
DEF  NEW SHARED VAR  n_m4##fe    AS  CHAR      FORMAT "X(3)"  INIT "239".
DEF  NEW SHARED VAR  n_m4##ae    AS  CHAR      FORMAT "X(3)"  INIT "229".
DEF  NEW SHARED VAR  n_m4##lx    AS  CHAR      FORMAT "X(3)"  INIT "210".
DEF  NEW SHARED VAR  n_m4##fx    AS  CHAR      FORMAT "X(3)"  INIT "230".
DEF  NEW SHARED VAR  n_m4##ax    AS  CHAR      FORMAT "X(3)"  INIT "220".

/*------------------------    End For JV    -------------------------*/

DEF NEW   SHARED VAR  nv_poltyp     AS  CHAR   FORMAT "X(4)".
DEF NEW   SHARED VAR  nv_policy     AS  CHAR   FORMAT "X(12)".
DEF VAR   nv_poldes   AS  CHAR      FORMAT "X(20)".
DEF VAR   nv_group    AS  CHAR      FORMAT "X(4)".
DEF VAR   nv_patycd   AS  CHAR      FORMAT "X(2)".
DEF VAR   n_dir_ri    AS  CHAR      FORMAT "X".
DEF VAR   n_poltyp    AS  CHAR      FORMAT "X(4)".
DEF VAR   nv_txt      AS  CHAR      FORMAT "X(60)".
DEF VAR   nv_etxt     AS  CHAR      FORMAT "X(80)".
DEF VAR   nv_fex      AS  LOGICAL.
DEF VAR   nv_Pter2    AS CHAR       FORMAT "X(20)".
DEF VAR   nv_actual   AS DECIMAL    FORMAT "->>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_total    AS  DECI  FORMAT "->>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_vat      AS  DECI  FORMAT "->,>>>,>>9.99".
DEF NEW SHARED VAR   nv_netvat   AS  DECI  FORMAT "->>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_tax      AS  DECI  FORMAT "->,>>>,>>9.99".
DEF NEW SHARED VAR   nv_netamt   AS  DECI  FORMAT "->>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_facri    AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_1st      AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_2nd      AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_qs5      AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_tfp      AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_eng      AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_mar      AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_xol      AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_rq       AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_mps      AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_btr      AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_otr      AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_fo1      AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_fo2      AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_fo3      AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_fo4      AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_ftr      AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_gros     AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_1sttot   LIKE CLM130.NETL_D.
DEF NEW SHARED VAR   nv_1stl     AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_1stf     AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_1sta     AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_2ndl     AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_2ndf     AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_2nda     AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_engl     AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_engf     AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_enga     AS  DECI  FORMAT "->>>,>>>,>>9.99".

DEF NEW SHARED VAR   nv_facl     AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_facf     AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_faca     AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_facerr   AS  DECI  FORMAT "->>>,>>>,>>9.99".
DEF NEW SHARED VAR   nv_oth      AS  DECI  FORMAT "->>>,>>>,>>9.99".   
DEF NEW SHARED VAR   nv_sumtot       LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sumnet       LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sumvat       LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sumtax       LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sumamt       LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sumtranC     LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sumsurve     LIKE CLM130.NETL_D. 

DEF NEW SHARED VAR   nv_sumfacri     LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sum1st       LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sum2nd       LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sumqs5       LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sumtfp       LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sumeng       LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sumfo1       LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sumfo2       LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sumfo3       LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sumfo4       LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sumrq        LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_summps       LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sumbtr       LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sumotr       LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sumftr       LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_summar       LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sumret       LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sumgros      LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sumxol       LIKE CLM130.NETL_D. 

DEF NEW SHARED VAR   nv_sum1stl      LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sum2ndl      LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sumengl      LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sum1stf      LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sum2ndf      LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sumengf      LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sum1sta      LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sum2nda      LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sumenga      LIKE CLM130.NETL_D. 

DEF NEW SHARED VAR   nv_sumfacl      LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sumfacf      LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sumfaca      LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sumerr       LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR   nv_sumoth       LIKE CLM130.NETL_D.  

DEF VAR  nb_sumtot       LIKE CLM130.NETL_D. 
DEF VAR  nb_sumnet       LIKE CLM130.NETL_D. 
DEF VAR  nb_sumvat       LIKE CLM130.NETL_D. 
DEF VAR  nb_sumtax       LIKE CLM130.NETL_D. 
DEF VAR  nb_sumamt       LIKE CLM130.NETL_D. 
DEF VAR  nb_sumtranC     LIKE CLM130.NETL_D. 
DEF VAR  nb_sumsurve     LIKE CLM130.NETL_D. 

DEF VAR  nb_sumfacri     LIKE CLM130.NETL_D. 
DEF VAR  nb_sum1st       LIKE CLM130.NETL_D. 
DEF VAR  nb_sum2nd       LIKE CLM130.NETL_D. 
DEF VAR  nb_sumqs5       LIKE CLM130.NETL_D. 
DEF VAR  nb_sumtfp       LIKE CLM130.NETL_D. 
DEF VAR  nb_sumeng       LIKE CLM130.NETL_D. 
DEF VAR  nb_sumfo1       LIKE CLM130.NETL_D. 
DEF VAR  nb_sumfo2       LIKE CLM130.NETL_D. 
DEF VAR  nb_sumfo3       LIKE CLM130.NETL_D. 
DEF VAR  nb_sumfo4       LIKE CLM130.NETL_D. 
DEF VAR  nb_sumrq        LIKE CLM130.NETL_D. 
DEF VAR  nb_summps       LIKE CLM130.NETL_D. 
DEF VAR  nb_sumbtr       LIKE CLM130.NETL_D. 
DEF VAR  nb_sumotr       LIKE CLM130.NETL_D. 
DEF VAR  nb_sumftr       LIKE CLM130.NETL_D. 
DEF VAR  nb_summar       LIKE CLM130.NETL_D. 
DEF VAR  nb_sumret       LIKE CLM130.NETL_D. 
DEF VAR  nb_sumgros      LIKE CLM130.NETL_D. 
DEF VAR  nb_sumxol       LIKE CLM130.NETL_D. 
DEF VAR  nb_sumoth       LIKE CLM130.NETL_D.  

DEF VAR  nd_sumtot       LIKE CLM130.NETL_D. 
DEF VAR  nd_sumnet       LIKE CLM130.NETL_D. 
DEF VAR  nd_sumvat       LIKE CLM130.NETL_D. 
DEF VAR  nd_sumtax       LIKE CLM130.NETL_D. 
DEF VAR  nd_sumamt       LIKE CLM130.NETL_D. 
DEF VAR  nd_sumtranC     LIKE CLM130.NETL_D. 
DEF VAR  nd_sumsurve     LIKE CLM130.NETL_D. 

DEF VAR  nd_sumfacri     LIKE CLM130.NETL_D. 
DEF VAR  nd_sum1st       LIKE CLM130.NETL_D. 
DEF VAR  nd_sum2nd       LIKE CLM130.NETL_D. 
DEF VAR  nd_sumqs5       LIKE CLM130.NETL_D. 
DEF VAR  nd_sumtfp       LIKE CLM130.NETL_D. 
DEF VAR  nd_sumeng       LIKE CLM130.NETL_D. 
DEF VAR  nd_sumfo1       LIKE CLM130.NETL_D. 
DEF VAR  nd_sumfo2       LIKE CLM130.NETL_D. 
DEF VAR  nd_sumfo3       LIKE CLM130.NETL_D. 
DEF VAR  nd_sumfo4       LIKE CLM130.NETL_D. 
DEF VAR  nd_sumrq        LIKE CLM130.NETL_D. 
DEF VAR  nd_summps       LIKE CLM130.NETL_D. 
DEF VAR  nd_sumbtr       LIKE CLM130.NETL_D. 
DEF VAR  nd_sumotr       LIKE CLM130.NETL_D. 
DEF VAR  nd_sumftr       LIKE CLM130.NETL_D. 
DEF VAR  nd_summar       LIKE CLM130.NETL_D. 
DEF VAR  nd_sumret       LIKE CLM130.NETL_D. 
DEF VAR  nd_sumgros      LIKE CLM130.NETL_D. 
DEF VAR  nd_sumxol       LIKE CLM130.NETL_D. 
DEF VAR  nd_sumoth       LIKE CLM130.NETL_D.     
/*-------------------    Fee  & Expense    ------------------------*/
DEF NEW SHARED VAR  nv_etotal    AS  DECIMAL   FORMAT "->>,>>>,>>9.99".

DEF NEW SHARED VAR  nv_esumtot   LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR  nv_esumnet   LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR  nv_esumvat   LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR  nv_esumtax   LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR  nv_esumamt   LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR  nv_esumtranC LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR  nv_esumsurve LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR  nv_esumfacri LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR  nv_esum1st   LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR  nv_esum2nd   LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR  nv_esumqs5   LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR  nv_esumtfp   LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR  nv_esumeng   LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR  nv_esumfo1   LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR  nv_esumfo2   LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR  nv_esumfo3   LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR  nv_esumfo4   LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR  nv_esumrq    LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR  nv_esummps   LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR  nv_esumbtr   LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR  nv_esumotr   LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR  nv_esumftr   LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR  nv_esummar   LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR  nv_esumret   LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR  nv_esumgros  LIKE CLM130.NETL_D. 
DEF NEW SHARED VAR  nv_esumxol   LIKE CLM130.NETL_D. 

DEF NEW SHARED VAR  nv_esum1stl  LIKE CLM130.NETL_D.
DEF NEW SHARED VAR  nv_esum2ndl  LIKE CLM130.NETL_D.
DEF NEW SHARED VAR  nv_esumengl  LIKE CLM130.NETL_D.
DEF NEW SHARED VAR  nv_esum1stf  LIKE CLM130.NETL_D.
DEF NEW SHARED VAR  nv_esum2ndf  LIKE CLM130.NETL_D.
DEF NEW SHARED VAR  nv_esumengf  LIKE CLM130.NETL_D.
DEF NEW SHARED VAR  nv_esum1sta  LIKE CLM130.NETL_D.
DEF NEW SHARED VAR  nv_esum2nda  LIKE CLM130.NETL_D.
DEF NEW SHARED VAR  nv_esumenga  LIKE CLM130.NETL_D.

DEF NEW SHARED VAR  nv_esumfacl  LIKE CLM130.NETL_D.
DEF NEW SHARED VAR  nv_esumfacf  LIKE CLM130.NETL_D.
DEF NEW SHARED VAR  nv_esumfaca  LIKE CLM130.NETL_D.
DEF NEW SHARED VAR  nv_esumerr   LIKE CLM130.NETL_D.
DEF NEW SHARED VAR  nv_esumoth   LIKE CLM130.NETL_D.  

DEF NEW SHARED WORKFILE Wclm130 NO-UNDO
    FIELD BRANCH    AS    CHAR FORMAT "XX"
    FIELD DIR_RI    AS    CHAR FORMAT "X"
    FIELD POLICY    LIKE  CLM100.POLICY
    FIELD POLTYP    LIKE  CLM100.POLTYP
    FIELD GROUPTYP  LIKE  S0M005.KEY1
    FIELD NETL_D    LIKE  CLM130.NETL_D
    FIELD ENTDAT    LIKE  CLM130.ENTDAT
    FIELD TRNDAT    LIKE  CLM130.TRNDAT
    FIELD CLAIM     LIKE  CLM130.CLAIM
    FIELD TRNTY1    LIKE  CLM130.TRNTY1
    FIELD DOCNO     LIKE  CLM130.DOCNO
    FIELD CLITEM    LIKE  CLM130.CLITEM
    FIELD CLMANT    LIKE  CLM130.CLMANT
    FIELD CPC_CD    LIKE  CLM130.CPC_CD
    FIELD RELEAS    LIKE  CLM130.RELEAS
    FIELD rico      AS CHAR FORMAT "X(10)"
    FIELD riconam   AS CHAR FORMAT "X(50)"
    FIELD cedper    AS INT .

DEF NEW SHARED WORKFILE   Wclp  NO-UNDO
    FIELD dir_ri    AS    CHAR    FORMAT "X"
    FIELD bran      AS    CHAR    FORMAT "XX"
    FIELD poltyp    AS    CHAR    FORMAT "X(4)"
    FIELD poldes    AS    CHAR    FORMAT "X(20)"
    FIELD x_tot     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD x_net     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD x_vat     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD x_tax     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD x_amt     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD x_1st     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD x_2nd     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD x_facri   AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD x_qs5     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD x_tfp     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD x_mps     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD x_eng     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD x_mar     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD x_rq      AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD x_btr     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD x_otr     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD x_ftr     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD x_fo1     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD x_fo2     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD x_fo3     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD x_fo4     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD x_ret     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD x_gros    AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD x_xol     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD x_oth     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"   
    FIELD e_tot     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD e_net     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD e_vat     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD e_tax     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD e_amt     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD e_1st     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD e_2nd     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD e_facri   AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD e_qs5     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD e_tfp     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD e_mps     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD e_eng     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD e_mar     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD e_rq      AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD e_btr     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD e_otr     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD e_ftr     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD e_fo1     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD e_fo2     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD e_fo3     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD e_fo4     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD e_ret     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD e_gros    AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    FIELD e_xol     AS    DECI    FORMAT "->,>>>,>>>,>>9.99"
    /*june */                     
    FIELD e_osbh    AS    DECI    FORMAT "->,>>>,>>>,>>9.99" 
    FIELD e_tty     AS    DECI    FORMAT "->,>>>,>>>,>>9.99" 
    FIELD e_facbh   AS    DECI    FORMAT "->,>>>,>>>,>>9.99" 
    FIELD e_othbh   AS    DECI    FORMAT "->,>>>,>>>,>>9.99" 
    FIELD x_osbh    AS    DECI    FORMAT "->,>>>,>>>,>>9.99" 
    FIELD x_tty     AS    DECI    FORMAT "->,>>>,>>>,>>9.99" 
    FIELD x_facbh   AS    DECI    FORMAT "->,>>>,>>>,>>9.99" 
    FIELD x_othbh   AS    DECI    FORMAT "->,>>>,>>>,>>9.99" 
    /* june */                    
    FIELD e_oth     AS    DECI FORMAT "->,>>>,>>>,>>9.99".  
DEF VAR  n_fbran    AS    CHAR FORMAT "X(2)".
DEF VAR  n_lbran    AS    CHAR FORMAT "X(2)".
DEF VAR  n_di       AS    CHAR FORMAT "X".
DEF VAR  n_txt      AS    CHAR FORMAT "X(60)".
DEF VAR  n_Dtxt     AS    CHAR FORMAT "X(2)".
DEF VAR  n_Itxt     AS    CHAR FORMAT "X(2)".
DEF VAR  x_tot      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  x_net      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  x_vat      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  x_tax      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  x_amt      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  x_facri    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  x_1st      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  x_2nd      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  x_qs5      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  x_tfp      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  x_eng      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  x_fo1      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  x_fo2      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  x_fo3      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  x_fo4      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  x_rq       AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  x_mps      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  x_btr      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  x_otr      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  x_ftr      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  x_mar      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  x_ret      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  x_gros     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  x_xol      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  x_oth      AS    DECI FORMAT "->>>,>>>,>>9.99".   
DEF VAR  e_tot      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  e_net      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  e_vat      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  e_tax      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  e_amt      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  e_facri    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  e_1st      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  e_2nd      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  e_qs5      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  e_tfp      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  e_eng      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  e_fo1      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  e_fo2      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  e_fo3      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  e_fo4      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  e_rq       AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  e_mps      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  e_btr      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  e_otr      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  e_ftr      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  e_mar      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  e_ret      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  e_gros     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  e_xol      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  e_oth      AS    DECI FORMAT "->>>,>>>,>>9.99".   
DEF VAR  Dx_tot     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Dx_net     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Dx_vat     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Dx_tax     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Dx_amt     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Dx_facri   AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Dx_1st     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Dx_2nd     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Dx_qs5     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Dx_tfp     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Dx_eng     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Dx_fo1     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Dx_fo2     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Dx_fo3     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Dx_fo4     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Dx_rq      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Dx_mps     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Dx_btr     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Dx_otr     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Dx_ftr     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Dx_mar     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Dx_ret     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Dx_gros    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Dx_xol     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Dx_oth     AS    DECI FORMAT "->>>,>>>,>>9.99".   
DEF VAR  De_tot     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  De_net     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  De_vat     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  De_tax     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  De_amt     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  De_facri   AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  De_1st     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  De_2nd     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  De_qs5     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  De_tfp     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  De_eng     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  De_fo1     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  De_fo2     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  De_fo3     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  De_fo4     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  De_rq      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  De_mps     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  De_btr     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  De_otr     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  De_ftr     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  De_mar     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  De_ret     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  De_gros    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  De_xol     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  De_oth     AS    DECI FORMAT "->>>,>>>,>>9.99".   
DEF VAR  Ix_tot     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ix_net     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ix_vat     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ix_tax     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ix_amt     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ix_facri   AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ix_1st     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ix_2nd     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ix_qs5     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ix_tfp     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ix_eng     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ix_fo1     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ix_fo2     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ix_fo3     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ix_fo4     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ix_rq      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ix_mps     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ix_btr     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ix_otr     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ix_ftr     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ix_mar     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ix_ret     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ix_gros    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ix_xol     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ix_oth     AS    DECI FORMAT "->>>,>>>,>>9.99".  
DEF VAR  Ie_tot     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ie_net     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ie_vat     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ie_tax     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ie_amt     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ie_facri   AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ie_1st     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ie_2nd     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ie_qs5     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ie_tfp     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ie_eng     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ie_fo1     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ie_fo2     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ie_fo3     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ie_fo4     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ie_rq      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ie_mps     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ie_btr     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ie_otr     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ie_ftr     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ie_mar     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ie_ret     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ie_gros    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ie_xol     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ie_oth     AS    DECI FORMAT "->>>,>>>,>>9.99".  
DEF VAR  GTx_tot    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTx_net    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTx_vat    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTx_tax    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTx_amt    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTx_facri  AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTx_1st    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTx_2nd    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTx_qs5    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTx_tfp    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTx_eng    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTx_fo1    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTx_fo2    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTx_fo3    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTx_fo4    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTx_rq     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTx_mps    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTx_btr    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTx_otr    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTx_ftr    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTx_mar    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTx_ret    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTx_gros   AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTx_xol    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTx_oth    AS    DECI FORMAT "->>>,>>>,>>9.99".  
DEF VAR  GTe_tot    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTe_net    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTe_vat    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTe_tax    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTe_amt    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTe_facri  AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTe_1st    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTe_2nd    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTe_qs5    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTe_tfp    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTe_eng    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTe_fo1    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTe_fo2    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTe_fo3    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTe_fo4    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTe_rq     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTe_mps    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTe_btr    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTe_otr    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTe_ftr    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTe_mar    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTe_ret    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTe_gros   AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTe_xol    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTe_oth    AS    DECI FORMAT "->>>,>>>,>>9.99".  

DEF VAR  x_osbh     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  x_tty      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  x_facbh    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  x_othbh    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  e_osbh     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  e_tty      AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  e_facbh    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  e_othbh    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Dx_osbh    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Dx_tty     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Dx_facbh   AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Dx_othbh   AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  De_osbh    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  De_tty     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  De_facbh   AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  De_othbh   AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ix_osbh    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ix_tty     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ix_facbh   AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ix_othbh   AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ie_osbh    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ie_tty     AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ie_facbh   AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  Ie_othbh   AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTx_osbh   AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTx_tty    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTx_facbh  AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTx_othbh  AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTe_osbh   AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTe_tty    AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTe_facbh  AS    DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR  GTe_othbh  AS    DECI FORMAT "->>>,>>>,>>9.99".
                                                 
DEF STREAM ns1.  /* For Detail Output To Excel */
DEF STREAM ns2.  /* For Summary Output To Excel */

DEF VAR   nv_prtadj   AS CHAR FORMAT "X(60)".
DEF VAR   nv_adjnam   AS CHAR FORMAT "X(60)".
DEF VAR   nv_paydet   LIKE CLM130.PAYDET.
DEF VAR   nv_userid   LIKE CLM100.ENTID.
DEF VAR   nv_sts      LIKE CLM100.PADSTS.
DEF VAR   nv_releas   LIKE CLM130.RELEAS.
DEF VAR   nv_losdat   LIKE CLM100.LOSDAT.
DEF VAR   nv_intref   LIKE CLM120.INTREF.
DEF VAR   nv_coins    LIKE UWM100.COINS.
DEF VAR   nv_coper    LIKE UWM100.CO_PER.
DEF VAR   nv_closs    AS CHAR FORMAT "X(35)". 

DEF VAR  nv_vtype   AS CHAR INIT     "VR".  /*--voucher receipt in ProcMotorCzr104--*/
DEF VAR  n_paycd    AS CHAR FORMAT   "x(02)".
DEF VAR  n_vatrate  AS DECI.
DEF VAR  n_taxrate  AS DECI.
DEF VAR  nv_trndat  AS DATE FORMAT "99/99/99" .
DEF VAR  nv_insname AS CHAR FORMAT "X(50)" INIT "".   
DEF VAR  nv_enetvat AS DECI FORMAT "->,>>>,>>>,>>>,>>>,>>9.99". 

DEF VAR nv_osbh     AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nv_facbh    AS DECI  FORMAT ">,>>>,>>>,>>9.99-".
DEF VAR nv_ttybh    AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nv_othbh    AS DECI  FORMAT ">,>>>,>>>,>>9.99-".

DEF VAR nv_esumosbh   AS DECI  FORMAT ">,>>>,>>>,>>9.99-".
DEF VAR nv_esumtty    AS DECI  FORMAT ">,>>>,>>>,>>9.99-".
DEF VAR nv_esumfacbh  AS DECI  FORMAT ">,>>>,>>>,>>9.99-".
DEF VAR nv_esumothbh  AS DECI  FORMAT ">,>>>,>>>,>>9.99-".

DEF VAR nv_sumosbh   AS DECI  FORMAT ">,>>>,>>>,>>9.99-". 
DEF VAR nv_sumtty    AS DECI  FORMAT ">,>>>,>>>,>>9.99-". 
DEF VAR nv_sumfacbh  AS DECI  FORMAT ">,>>>,>>>,>>9.99-". 
DEF VAR nv_sumothbh  AS DECI  FORMAT ">,>>>,>>>,>>9.99-". 

DEF VAR nb_sumosbh   AS DECI  FORMAT ">,>>>,>>>,>>9.99-".
DEF VAR nb_sumtty    AS DECI  FORMAT ">,>>>,>>>,>>9.99-".
DEF VAR nb_sumfacbh  AS DECI  FORMAT ">,>>>,>>>,>>9.99-".
DEF VAR nb_sumothbh  AS DECI  FORMAT ">,>>>,>>>,>>9.99-".

DEF VAR nd_sumosbh   AS DECI  FORMAT ">,>>>,>>>,>>9.99-".
DEF VAR nd_sumtty    AS DECI  FORMAT ">,>>>,>>>,>>9.99-".
DEF VAR nd_sumfacbh  AS DECI  FORMAT ">,>>>,>>>,>>9.99-".
DEF VAR nd_sumothbh  AS DECI  FORMAT ">,>>>,>>>,>>9.99-".
/*---------------------------------*/
/* june */
DEF VAR nv_clmpaid   AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nv_duefr     AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nv_dueto     AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nv_totfac    AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nv_receive   AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nv_osres     AS DECI  FORMAT ">,>>>,>>>,>>9.99-".

DEF VAR nv_sumclpaid   AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nv_sumduefr    AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nv_sumdueto    AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nv_sumttfac    AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nv_sumrec      AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nv_sumosres    AS DECI  FORMAT ">,>>>,>>>,>>9.99-".

DEF VAR nv_esumclpaid  AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nv_esumduefr   AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nv_esumdueto   AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nv_esumttfac   AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nv_esumrec     AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nv_esumosres   AS DECI  FORMAT ">,>>>,>>>,>>9.99-".
                                                           
DEF VAR nb_sumclpaid AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nb_sumduefr  AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nb_sumdueto  AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nb_sumttfac  AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nb_sumrec    AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nb_sumosres  AS DECI  FORMAT ">,>>>,>>>,>>9.99-". 

DEF VAR nd_sumclpaid AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nd_sumduefr  AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nd_sumdueto  AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nd_sumttfac  AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nd_sumrec    AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nd_sumosres  AS DECI  FORMAT ">,>>>,>>>,>>9.99-".
