/******************************************************************/
/* WACSTATE.P  : CZR3103.P STATEMENT CLAIM PAID To Excel (Summary) */
/*               for Profit center report                         */
/* create by   : B.Phattranit  on 25/05/05  A48-0268              */
/* connect     : stat, sic_test                                   */
/*------------------------------------------------------------------
 Modify By : TANTAWAN C.   14/01/2008   [A500178]
             ปรับ FORMAT branch เพื่อรองรับการขยายสาขา
--------------------------------------------------------------------*/
/******************************************************************/

DEF INPUT PARAMETER nv_Fent AS DATE FORMAT "99/99/9999".
DEF INPUT parameter nv_Tent AS DATE FORMAT "99/99/9999".
DEF INPUT PARAMETER nv_Pter AS CHAR FORMAT "X(20)".
DEF INPUT parameter nv_typ  AS  INT  FORMAT "9"  .


DEF VAR per_l     AS DECIMAL  FORMAT ">>9.99".
DEF VAR per_f     AS DECIMAL  FORMAT ">>9.99".
DEF VAR per_a     AS DECIMAL  FORMAT ">>9.99".

DEF VAR nv_insure AS CHAR     FORMAT "X(20)".
/*--- A500178 ---
DEF VAR nv_acno   AS CHAR     FORMAT "X(7)" .
------*/
DEF VAR nv_acno   AS CHAR     FORMAT "X(10)" .
DEF VAR nv_payee  AS CHAR     FORMAT "X(25)".

DEF NEW SHARED VAR nv_surve  AS DECIMAL FORMAT ">>,>>>,>>9.99".
DEF NEW SHARED VAR nv_tranC  AS DECIMAL FORMAT ">>,>>>,>>9.99".
DEF VAR nv_nature AS CHAR    FORMAT "X(2)" .
DEF VAR nv_req    AS CHAR    FORMAT "X(10)".

DEF VAR I         AS INTEGER INITIAL 0  FORMAT ">>>9.".
DEF VAR J         AS INTEGER INITIAL 0  FORMAT ">>>9" .
DEF VAR nv_time   AS CHAR               FORMAT "X(5)" .
DEF VAR nv_swith  AS LOGICAL.
    
DEF VAR n_write1   AS CHAR  FORMAT "X(15)".
DEF VAR nv_output  AS CHAR  FORMAT "X(15)".
DEF VAR nv_output2 AS CHAR  FORMAT "X(15)".

/*-------------------     For JV    -----------------------*/
DEF   VAR  n_macc     AS  CHAR  FORMAT "X(16)".
DEF   VAR  n_sacc1    AS  CHAR  FORMAT "X(6)".
DEF   VAR  n_sacc2    AS  CHAR  FORMAT "X(6)".
DEF   VAR  n_prgrp    AS  INTE  FORMAT "9".
DEF   VAR  n_m1       AS  CHAR  FORMAT "X".
DEF   VAR  n_m2       AS  CHAR  FORMAT "X(2)".
DEF   VAR  n_m3       AS  CHAR  FORMAT "X(2)".
DEF   VAR  n_m4#1     AS  CHAR  FORMAT "X(3)".
DEF   VAR  n_m1_3     AS  CHAR  FORMAT "X(6)".
DEF   VAR  n_m4#2     AS  CHAR  FORMAT "X(2)".
DEF   VAR  n_m4#le    AS  CHAR  FORMAT "X(3)"  INIT "319".
DEF   VAR  n_m4#fe    AS  CHAR  FORMAT "X(3)"  INIT "339".
DEF   VAR  n_m4#ae    AS  CHAR  FORMAT "X(3)"  INIT "329".
DEF   VAR  n_m4#lx    AS  CHAR  FORMAT "X(3)"  INIT "310".
DEF   VAR  n_m4#fx    AS  CHAR  FORMAT "X(3)"  INIT "330".
DEF   VAR  n_m4#ax    AS  CHAR  FORMAT "X(3)"  INIT "320".
DEF   VAR  n_m4#e     AS  CHAR  FORMAT "X(3)"  INIT "119".
DEF   VAR  n_m4#x     AS  CHAR  FORMAT "X(3)"  INIT "110".
DEF   VAR  n_m1e      AS  CHAR  FORMAT "X(3)".
DEF   VAR  n_m2e      AS  CHAR  FORMAT "X(2)".
DEF   VAR  n_m4#1e    AS  CHAR  FORMAT "X(3)".
DEF   VAR  n_m1_3e    AS  CHAR  FORMAT "X(6)".
DEF   VAR  n_m4#2e    AS  CHAR  FORMAT "X(2)".
DEF   VAR  n_m4##le   AS  CHAR  FORMAT "X(3)"  INIT "219".
DEF   VAR  n_m4##fe   AS  CHAR  FORMAT "X(3)"  INIT "239".
DEF   VAR  n_m4##ae   AS  CHAR  FORMAT "X(3)"  INIT "229".
DEF   VAR  n_m4##lx   AS  CHAR  FORMAT "X(3)"  INIT "210".
DEF   VAR  n_m4##fx   AS  CHAR  FORMAT "X(3)"  INIT "230".
DEF   VAR  n_m4##ax   AS  CHAR  FORMAT "X(3)"  INIT "220".
/*------------------------    End For JV    -------------------------*/

DEF VAR  n_branch     AS  CHAR  FORMAT "X(2)".
DEF VAR  nv_poltyp    AS  CHAR  FORMAT "X(4)". 
DEF VAR  nv_policy    AS  CHAR  FORMAT "X(12)".
DEF VAR   nv_poldes   AS  CHAR  FORMAT "X(20)".
DEF VAR   nv_group    AS  CHAR  FORMAT "X(4)".
DEF VAR   nv_patycd   AS  CHAR  FORMAT "X(2)".
DEF VAR   n_dir_ri    AS  CHAR  FORMAT "X".
DEF VAR   n_poltyp    AS  CHAR  FORMAT "X(4)".
DEF VAR   nv_txt      AS  CHAR  FORMAT "X(60)".
DEF VAR   nv_etxt     AS  CHAR  FORMAT "X(80)".
DEF VAR   nv_fex      AS  LOGICAL.

DEF VAR   nv_total    AS DECIMAL    FORMAT "->>,>>>,>>9.99".
DEF VAR   nv_vat      AS DECIMAL    FORMAT "->,>>>,>>9.99".
DEF VAR   nv_netvat   AS DECIMAL    FORMAT "->>,>>>,>>9.99".
DEF VAR   nv_tax      AS DECIMAL    FORMAT "->,>>>,>>9.99".
DEF VAR   nv_netamt   AS DECIMAL    FORMAT "->>,>>>,>>9.99".

DEF VAR   nv_facri    AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_1st      AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_2nd      AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_qs5      AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_tfp      AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_eng      AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_mar      AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_ret      AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_xol      AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_rq       AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_mps      AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_btr      AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_otr      AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_fo1      AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_fo2      AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_fo3      AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_fo4      AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_ftr      AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_gros     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".

DEF VAR   nv_1sttot   LIKE CLM130.NETL_D. /*AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".*/
DEF VAR   nv_1stl     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_1stf     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_1sta     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_2ndl     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_2ndf     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_2nda     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_engl     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_engf     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_enga     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".

DEF VAR   nv_facl     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_facf     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_faca     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_facerr   AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".

DEF VAR   nv_sum1stl  LIKE CLM130.NETL_D. /*AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".*/
DEF VAR   nv_sum2ndl  LIKE CLM130.NETL_D. /*AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".*/
DEF VAR   nv_sumengl  LIKE CLM130.NETL_D. /*AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".*/
DEF VAR   nv_sum1stf  LIKE CLM130.NETL_D. /*AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".*/
DEF VAR   nv_sum2ndf  LIKE CLM130.NETL_D. /*AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".*/
DEF VAR   nv_sumengf  LIKE CLM130.NETL_D. /*AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".*/
DEF VAR   nv_sum1sta  LIKE CLM130.NETL_D. /*AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".*/
DEF VAR   nv_sum2nda  LIKE CLM130.NETL_D. /*AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".*/
DEF VAR   nv_sumenga  LIKE CLM130.NETL_D. /*AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".*/

DEF VAR   nv_sumfacl  LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR   nv_sumfacf  LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR   nv_sumfaca  LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR   nv_sumerr   LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/

DEF VAR  nv_sumtot    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_sumnet    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_sumvat    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_sumtax    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_sumamt    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_sumtranC  LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_sumsurve  LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/

DEF VAR  nv_sumfacri  LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_sum1st    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_sum2nd    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_sumqs5    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_sumtfp    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_sumeng    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_sumfo1    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_sumfo2    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_sumfo3    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_sumfo4    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_sumrq     LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_summps    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_sumbtr    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_sumotr    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_sumftr    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_summar    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_sumret    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_sumgros   LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_sumxol    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/

DEF VAR  nb_sumtot    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nb_sumnet    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nb_sumvat    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nb_sumtax    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nb_sumamt    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nb_sumtranC  LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nb_sumsurve  LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/

DEF VAR  nb_sumfacri  LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nb_sum1st    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nb_sum2nd    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nb_sumqs5    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nb_sumtfp    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nb_sumeng    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nb_sumfo1    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nb_sumfo2    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nb_sumfo3    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nb_sumfo4    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nb_sumrq     LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nb_summps    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nb_sumbtr    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nb_sumotr    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nb_sumftr    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nb_summar    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nb_sumret    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nb_sumgros   LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nb_sumxol    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/

DEF VAR  nd_sumtot    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nd_sumnet    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nd_sumvat    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nd_sumtax    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nd_sumamt    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nd_sumtranC  LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nd_sumsurve  LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/

DEF VAR  nd_sumfacri  LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nd_sum1st    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nd_sum2nd    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nd_sumqs5    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nd_sumtfp    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nd_sumeng    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nd_sumfo1    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nd_sumfo2    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nd_sumfo3    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nd_sumfo4    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nd_sumrq     LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nd_summps    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nd_sumbtr    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nd_sumotr    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nd_sumftr    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nd_summar    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nd_sumret    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nd_sumgros   LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nd_sumxol    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/

/*-------------------     Fee  & Expense    ------------------------*/
DEF VAR  nv_esum1stl  LIKE CLM130.NETL_D. /*AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esum2ndl  LIKE CLM130.NETL_D. /*AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esumengl  LIKE CLM130.NETL_D. /*AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esum1stf  LIKE CLM130.NETL_D. /*AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esum2ndf  LIKE CLM130.NETL_D. /*AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esumengf  LIKE CLM130.NETL_D. /*AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esum1sta  LIKE CLM130.NETL_D. /*AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esum2nda  LIKE CLM130.NETL_D. /*AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esumenga  LIKE CLM130.NETL_D. /*AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".*/

DEF VAR  nv_esumfacl  LIKE CLM130.NETL_D. /*AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esumfacf  LIKE CLM130.NETL_D. /*AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esumfaca  LIKE CLM130.NETL_D. /*AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esumerr   LIKE CLM130.NETL_D. /*AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".*/

DEF VAR   nv_etotal   AS  DECIMAL   FORMAT "->>,>>>,>>9.99".
DEF VAR   nv_evat     AS  DECIMAL   FORMAT "->,>>>,>>9.99".
DEF VAR   nv_enetvat  AS  DECIMAL   FORMAT "->>,>>>,>>9.99".
DEF VAR   nv_etax     AS  DECIMAL   FORMAT "->,>>>,>>9.99".
DEF VAR   nv_enetamt  AS  DECIMAL   FORMAT "->>,>>>,>>9.99".

DEF VAR   nv_efacri   AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_e1st     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_e2nd     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_eqs5     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_etfp     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_eeng     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_emar     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_eret     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_exol     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_erq      AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_emps     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_ebtr     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_eotr     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_efo1     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_efo2     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_efo3     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_efo4     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_eftr     AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".
DEF VAR   nv_egros    AS  DECIMAL   FORMAT "->>>,>>>,>>9.99".

DEF VAR  nv_esumtot   LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esumnet   LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esumvat   LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esumtax   LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esumamt   LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esumtranC LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/

DEF VAR  nv_esumfacri LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esum1st   LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esum2nd   LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esumqs5   LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esumtfp   LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esumeng   LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esumfo1   LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esumfo2   LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esumfo3   LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esumfo4   LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esumrq    LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esummps   LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esumbtr   LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esumotr   LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esumftr   LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esummar   LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esumret   LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esumgros  LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/
DEF VAR  nv_esumxol   LIKE CLM130.NETL_D. /*AS DECIMAL FORMAT "->>>,>>>,>>9.99".*/

DEF WORKFILE Wclm130 NO-UNDO
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
    FIELD RELEAS    LIKE  CLM130.RELEAS.

DEF STREAM ns1.

/*--- Add for K.Somsak (CL) ---*/
DEF VAR   nv_prtadj   AS CHAR FORMAT "X(60)".
DEF VAR   nv_adjnam   AS CHAR FORMAT "X(60)".
DEF VAR   nv_paydet   LIKE CLM130.PAYDET.
DEF VAR   nv_userid   LIKE CLM100.ENTID FORMAT "x(7)".  /*--- A500178 --- เพิ่ม FORMAT "X(7)" ---*/
DEF VAR   nv_sts      LIKE CLM100.PADSTS.
DEF VAR   nv_releas   LIKE CLM130.RELEAS.
DEF VAR   nv_losdat   LIKE CLM100.LOSDAT.
DEF VAR   nv_intref   LIKE CLM120.INTREF FORMAT "x(10)" .  /*--- A500178 --- เพิ่ม FORMAT "X(10)" ---*/
DEF VAR   nv_coins    LIKE uwm100.coins.
DEF VAR   nv_coper    LIKE uwm100.co_per.
/*--- End for K.Somsak ---*/
DEF VAR   nv_acno1    LIKE CLM100.ACNO1 FORMAT "X(10)". /*--- A500178 --- เพิ่ม FORMAT "X(10)" ---*/
DEF VAR   nv_prodc    AS   CHAR FORMAT "X(60)".
DEF VAR   nv_row      AS   INT   INIT  0.

/*--- A500178 ---*/
DEF VAR nv_dirpol AS CHAR.
DEF VAR nv_brnpol AS CHAR.
/*--- A500178 ---*/

nv_time = STRING (TIME,"HH:MM").
OUTPUT STREAM ns1  TO VALUE(nv_Pter).
PUT  STREAM  ns1  "ID;PND"  SKIP.

/*---ส่วนหัว report ----
nv_row = nv_row + 1.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K"   '"' "Branch"             '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X2;K"   '"' "Policy type"        '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X3;K"   '"' "Policy desc."       '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X4;K"   '"' "Group type"         '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X5;K"   '"' "Policy"             '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X6;K"   '"' "Inward/Direct"      '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X7;K"   '"' "Claim"              '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X8;K"   '"' "Acc.no."            '"'   SKIP.  /*A47-0140*/
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X9;K"   '"' "Producer"           '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X10;K"  '"' "Loss date"          '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X11;K"  '"' "Nature"             '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X12;K"  '"' "PV/CF"              '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X13;K"  '"' "Req.no."            '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X14;K"  '"' "Entry date"         '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X15;K"  '"' "paid date"          '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X16;K"  '"' "Total claim"        '"'   SKIP.  /*A47-0140*/
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X17;K"  '"' "Survey Fee"         '"'   SKIP.  /*A47-0140*/
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X18;K"  '"' "Netvat"             '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X19;K"  '"' "Vat"                '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X20;K"  '"' "Tax 3%"             '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X21;K"  '"' "Netamt"             '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X22;K"  '"' "1st Treaty"         '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X23;K"  '"' "2nd Treaty"         '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X24;K"  '"' "Fac. RI"            '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X25;K"  '"' "Q.S. 5%"            '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X26;K"   '"' "TFP"               '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X27;K"   '"' "MPS"               '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X28;K"   '"' "Eng.Fac."          '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X29;K"   '"' "Marine O/P"        '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X30;K"   '"' "R.Q."              '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X31;K"   '"' "BTR"               '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X32;K"   '"' "OTR"               '"'   SKIP.  /*A47-0140*/
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X33;K"   '"' "FTR"               '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X34;K"   '"' "F/O I"             '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X35;K"  '"' "F/O II"             '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X36;K"  '"' "F/O III"            '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X37;K"  '"' "F/O IV"             '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X38;K"  '"' "RET"                '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X39;K"  '"' "Gross RET"          '"'   SKIP.  /*A47-0140*/
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X40;K"  '"' "XOL"                '"'   SKIP.  /*A47-0140*/
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X41;K"  '"' "Acno"               '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X42;K"  '"' "Payee"              '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X43;K"  '"' "Clicod"             '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X44;K"  '"' "User ID"            '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X45;K"  '"' "Adjustor"           '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X46;K"  '"' "Detail"             '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X47;K"  '"' "Release"            '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X48;K"  '"' "Status"             '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X49;K"  '"' "Coins. "            '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X50;K"  '"' "Co %  "             '"'   SKIP.
-------*/

FOR EACH CLM130 USE-INDEX CLM13003                    WHERE
             CLM130.Trndat                >= nv_Fent  AND
             CLM130.Entdat                >= nv_Fent  AND
             CLM130.Entdat                <= nv_Tent  AND
             CLM130.Trnty1                =  "X"      AND
             CLM130.Releas                =  Yes      
             /*  AND  jeab
             SUBSTRING(CLM130.CLAIM,2,1)  >= nv_Fbrn  AND
             SUBSTRING(CLM130.CLAIM,2,1)  <= nv_Tbrn   */
NO-LOCK :
  
  IF CLM130.NETL_D = 0  OR CLM130.NETL_D = ? THEN NEXT .

  /*--jeab
  IF (SUBSTRING(CLM130.CLAIM,3,2)  = "70"  OR
     SUBSTRING(CLM130.CLAIM,3,2)   = "72"  OR
     SUBSTRING(CLM130.CLAIM,3,2)   = "73") THEN NEXT.
  ---*/

    IF nv_typ = 2 THEN DO: /* non-motor all not 30,01 */
       IF (SUBSTRING(CLM130.CLAIM,3,2) = "70"  OR   /* Check Policy Type */
          SUBSTRING(CLM130.CLAIM,3,2)  = "72"  OR
          SUBSTRING(CLM130.CLAIM,3,2)  = "73"  OR  /* CMIP  */
          SUBSTRING(CLM130.CLAIM,3,2)  = "74"  OR  /* CMIP  */
          SUBSTRING(CLM130.CLAIM,3,2)  = "30"  OR  /* CMIP  */
          SUBSTRING(CLM130.CLAIM,3,2)  = "01"  OR  /* CMIP  */
          SUBSTRING(CLM130.CLAIM,3,2)  = "   ") THEN NEXT .
    END.
    ELSE IF nv_typ = 3 THEN DO:  /* 30,01 */
       IF (SUBSTRING(CLM130.CLAIM,3,2) <>  "01"  AND
          SUBSTRING(CLM130.CLAIM,3,2)  <>  "30") THEN NEXT.
    END.
    ELSE DO:
       IF (SUBSTRING(CLM130.CLAIM,3,2) <> "70"  and  /* Check Policy Type */
          SUBSTRING(CLM130.CLAIM,3,2)  <> "72"  and
          SUBSTRING(CLM130.CLAIM,3,2)  <> "73"  and  /* CMIP  */
          SUBSTRING(CLM130.CLAIM,3,2)  <> "74" )  /* CMIP  */  THEN NEXT.
    END.

     DISP "Process policy : " clm130.claim WITH COLOR BLACK/WHITE NO-LABEL  
    TITLE "PROCESS..." WIDTH 50 FRAME BMain VIEW-AS DIALOG-BOX.

  FIND CLM100 USE-INDEX CLM10001     WHERE
       CLM100.CLAIM  = CLM130.CLAIM
  NO-LOCK NO-ERROR NO-WAIT.

  IF AVAILABLE CLM100 THEN DO:

    /*--- A500178 ---*/
    IF SUBSTRING(clm100.policy,1,1) = "D" OR
       SUBSTRING(clm100.policy,1,1) = "I" THEN DO:
        ASSIGN
            nv_dirpol = SUBSTRING(policy,1,1)
            nv_brnpol = SUBSTRING(policy,2,1).
    END.
    ELSE 
        ASSIGN
            nv_dirpol = "D"
            nv_brnpol = SUBSTRING(policy,1,2).

    /*--- A500178 ---*/

    CREATE WCLM130.
    ASSIGN
        /*--- A500178 ---
        WCLM130.BRANCH = SUBSTRING(CLM100.POLICY,2,1)
        WCLM130.POLICY = CLM100.POLICY
        WCLM130.DIR_RI = SUBSTRING(CLM100.POLICY,1,1)
        ------*/
        WCLM130.BRANCH = CAPS(nv_brnpol)
        WCLM130.POLICY = CLM100.POLICY
        WCLM130.DIR_RI = CAPS(nv_dirpol)
        /*--- A500178 ---*/
        WCLM130.CLAIM  = CLM130.CLAIM
        WCLM130.ENTDAT = CLM130.ENTDAT
        WCLM130.TRNDAT = CLM130.TRNDAT
        WCLM130.TRNTY1 = CLM130.TRNTY1
        WCLM130.DOCNO  = CLM130.DOCNO
        WCLM130.CLITEM = CLM130.CLITEM
        WCLM130.CLMANT = CLM130.CLMANT
        WCLM130.CPC_CD = CLM130.CPC_CD
        WCLM130.NETL_D = CLM130.NETL_D
        WCLM130.RELEAS = CLM130.RELEAS.

                        /* WCLM130.POLTYP */
    FIND FIRST UWM100   WHERE
        UWM100.POLICY = CLM100.POLICY
    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE UWM100 THEN
       WCLM130.POLTYP = UWM100.POLTYP.

                        /* WCLM130.GROUPTYP */
    FIND S0M005 USE-INDEX S0M00501    WHERE
         S0M005.KEY2 = WCLM130.POLTYP
    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE S0M005 THEN
       WCLM130.GROUPTYP = S0M005.KEY1.
  END.
END.  /* FOR EACH CLM130 */

FIND FIRST WCLM130 NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE WCLM130 THEN DO:
  HIDE MESSAGE NO-PAUSE.
  MESSAGE "Not found Data Process".
  BELL.   BELL.   BELL.   BELL.
  BELL.   BELL.   BELL.   BELL.
  PAUSE 10 NO-MESSAGE.
  RETURN.
END.


FOR EACH WCLM130 NO-LOCK 
    BREAK BY WCLM130.DIR_RI
          BY WCLM130.BRANCH
          BY SUBSTRING(WCLM130.POLTYP,2,2)
          BY WCLM130.POLICY
          BY WCLM130.ENTDAT 
:

   IF FIRST-OF(WCLM130.DIR_RI) THEN
      n_dir_ri   = WCLM130.DIR_RI.

   IF FIRST-OF(WCLM130.BRANCH) THEN DO:
      n_branch  = WCLM130.BRANCH.

   END. /* FIRST-OF(WCLM130.BRANCH) */

   IF FIRST-OF(SUBSTRING(WCLM130.POLTYP,2,2)) THEN
      n_poltyp   = WCLM130.POLTYP.

   FIND CLM100 USE-INDEX CLM10001     WHERE
        CLM100.CLAIM  = WCLM130.CLAIM
   NO-LOCK NO-ERROR NO-WAIT.
   IF NOT AVAILABLE CLM100 THEN NEXT.

   ASSIGN
       nv_coins  = NO
       nv_coper  = 0.
   FIND LAST UWM100 USE-INDEX UWM10001 WHERE
        UWM100.POLICY = CLM100.POLICY
   NO-LOCK NO-ERROR NO-WAIT.
   IF AVAILABLE UWM100 THEN DO:

      nv_coins  = UWM100.COINS.

      IF UWM100.COINS  = YES  AND
         UWM100.CO_PER <> 0   THEN
         nv_coper = 100 - UWM100.CO_PER.
   END.

   ASSIGN
       nv_policy = WCLM130.POLICY
       nv_poltyp = WCLM130.POLTYP
       nv_group  = WCLM130.GROUPTYP
       nv_insure = CLM100.NAME1
       nv_req    = WCLM130.TRNTY1 + "-" + WCLM130.DOCNO
       nv_userid = CLM100.ENTID
       nv_releas = WCLM130.RELEAS
       nv_sts    = CLM100.PADSTS
       nv_losdat = CLM100.LOSDAT
       nv_acno1  = CLM100.ACNO1.

   FIND XMM031 USE-INDEX XMM03101    WHERE
        XMM031.POLTYP = WCLM130.POLTYP
   NO-LOCK NO-ERROR NO-WAIT.
   IF AVAILABLE XMM031 THEN
      nv_poldes = XMM031.POLDES.
   ELSE nv_poldes = "".

   FIND CLM120 USE-INDEX CLM12001       WHERE
        CLM120.CLAIM  = WCLM130.CLAIM    AND
        CLM120.CLMANT = WCLM130.CLMANT   AND
        CLM120.CLITEM = WCLM130.CLITEM
   NO-LOCK NO-ERROR NO-WAIT.
   IF NOT AVAILABLE CLM120 THEN NEXT.

   nv_nature = CLM120.LOSS.
   nv_intref = CLM120.INTREF.

   ASSIGN
       nv_total  = 0
       nv_etotal = 0.

   IF CLM120.LOSS  = "FE" OR CLM120.LOSS  = "EX"
   THEN DO:
      nv_etotal    =  WCLM130.NETL_D.  /* Fee & Expense */
      nv_fex       =  YES.
   END.
   ELSE DO:
      nv_total     =  WCLM130.NETL_D.  /* Paid */
      nv_fex       =  NO.
   END.

   ASSIGN
       nv_prodc    = ""
       nv_adjnam   = ""
       nv_prtadj   = "".

   FIND FIRST XMM600 USE-INDEX XMM60001 WHERE
              XMM600.ACNO = nv_acno1
   NO-LOCK NO-ERROR NO-WAIT.
   IF AVAILABLE XMM600 THEN DO:
      nv_prodc     = TRIM(XMM600.NAME).
   END.

   FIND FIRST XTM600 USE-INDEX XTM60001 WHERE
        XTM600.ACNO = nv_intref
   NO-LOCK NO-ERROR NO-WAIT.
   IF AVAILABLE XTM600 THEN DO:
      IF XTM600.NTITLE = " " THEN
         nv_adjnam  = TRIM(XTM600.NAME).
      ELSE
         nv_adjnam  = TRIM(XTM600.NTITLE) + " " + TRIM(XTM600.NAME).
   END.
   IF CLM100.S_NO <> " " THEN
         nv_prtadj  = STRING(TRIM(nv_adjnam) + "(" + CLM100.S_NO + ")" ).
   ELSE
         nv_prtadj = nv_adjnam.

   FIND CLM200 USE-INDEX CLM20001        WHERE
        CLM200.TRNTY1 = WCLM130.TRNTY1    AND
        CLM200.DOCNO  = WCLM130.DOCNO
   NO-LOCK NO-ERROR NO-WAIT.
   IF AVAILABLE CLM200 THEN DO:
        ASSIGN
           nv_acno   = CLM200.ACNO
           nv_payee  = TRIM(CLM200.NTITLE) + TRIM(CLM200.NAME).

        /*--- find Vat, Tax 3% ---*/
        FIND FIRST XMM600 USE-INDEX XMM60001 WHERE
                   XMM600.ACNO = CLM200.ACNO
        NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE XMM600 THEN DO:

           ASSIGN
               nv_netvat = 0
               nv_vat    = 0
               nv_tax    = 0
               nv_netamt = 0.

           /*IF nv_total <> 0 THEN DO: */         /* Paid */
           IF nv_fex = no THEN DO:
              CASE xmm600.clicod:
                WHEN "EX" THEN DO:            /* EX : External Survey */
                      IF nv_total  <  1000    THEN
                      ASSIGN nv_netvat  =  nv_total / (1.07)
                             nv_vat     =  nv_total - nv_netvat
                             nv_tax     =  0
                             nv_netamt  =  nv_total.
                      ELSE
                      ASSIGN nv_netvat  =  nv_total / (1.07)
                             nv_vat     =  nv_total - nv_netvat
                             nv_tax     =  nv_netvat * (0.03)
                             nv_netamt  =  nv_total - nv_tax.
                   END.
                WHEN "HN" THEN DO:            /* HN : Hospital With TAX */
                      IF nv_total   < 1000       THEN
                        ASSIGN nv_vat     =  0
                               nv_tax     =  0
                               nv_netamt  = nv_total.
                      ELSE
                        ASSIGN nv_tax     = nv_total * (0.03)
                               nv_netamt  = nv_total - nv_tax.
                   END.
                OTHERWISE  nv_netamt = nv_total.   /*--- ค่าที่ออกยอดเต็ม ---*/
              END CASE.

           END. /* paid */
           ELSE DO:
           /*IF nv_etotal <> 0 THEN DO:*/              /* Fee & Expense */
              CASE xmm600.clicod:
                WHEN "EX" THEN DO:            /* EX : External Survey */
                      IF nv_etotal  <  1000    THEN
                      ASSIGN nv_netvat  =  nv_etotal / (1.07)
                             nv_vat     =  nv_etotal - nv_netvat
                             nv_tax     =  0
                             nv_netamt  =  nv_etotal.
                      ELSE
                      ASSIGN nv_netvat  =  nv_etotal / (1.07)
                             nv_vat     =  nv_etotal - nv_netvat
                             nv_tax     =  nv_netvat * (0.03)
                             nv_netamt  =  nv_etotal - nv_tax.
                   END.
                WHEN "HN" THEN DO:            /* HN : Hospital With TAX */
                      IF nv_etotal   < 1000       THEN
                        ASSIGN nv_vat     =  0
                               nv_tax     =  0
                               nv_netamt  = nv_etotal.
                      ELSE
                        ASSIGN nv_tax     = nv_etotal * (0.03)
                               nv_netamt  = nv_etotal - nv_tax.
                   END.
                OTHERWISE  nv_netamt = nv_etotal.   /*--- ค่าที่ออกยอดเต็ม ---*/
              END CASE.

           END. /* fee & expense */

        END. /* Find xmm600 */
   END. /* Find clm200 */

   ASSIGN
       nv_patycd = ""
       nv_tranC  = 0
       nv_paydet = "".

   FIND FIRST CLM130 USE-INDEX CLM13001  WHERE
        CLM130.TRNTY1 = WCLM130.TRNTY1 AND
        CLM130.DOCNO  = WCLM130.DOCNO  AND
        CLM130.CLAIM  = WCLM130.CLAIM
   NO-LOCK NO-ERROR NO-WAIT.
   IF AVAILABLE CLM130 THEN DO:
                                    /* PV/CF */
      nv_patycd   = CLM130.PATYCD.

      nv_paydet   = CLM130.PAYDET.  /* Pay Detail */

                                    /* Transfer Claim */
      IF clm130.patycd <> 'PV' AND
         clm130.patycd <> 'CF'
      THEN  nv_tranC  = CLM130.NETL_D.

   END.  /* FIND CLM130 */

   /*------------   Find  Reinsurance   -------------*/
   ASSIGN
        nv_facri   = 0    nv_1st    = 0
        nv_2nd     = 0    nv_qs5    = 0
        nv_tfp     = 0    nv_eng    = 0
        nv_mar     = 0    nv_ret    = 0
        nv_xol     = 0    nv_rq     = 0

        nv_fo1     = 0    nv_fo2    = 0
        nv_fo3     = 0    nv_fo4    = 0
        nv_ftr     = 0

        nv_mps     = 0    nv_btr    = 0
        nv_otr     = 0    nv_gros   = 0

        nv_facl    = 0
        nv_facf    = 0
        nv_faca    = 0
        nv_facerr  = 0 .

   FOR EACH CLM300  USE-INDEX CLM30001 WHERE
       CLM300.CLAIM = WCLM130.CLAIM
   NO-LOCK :

     /*----- เช็คเงื่อนไขการคำนาณเงิน แต่ละ Reinsurer -------
     1. กรณีที่ค่า netvat = 0   จะเอาค่า total ไปคิดคำนวณ
     2. กรณีที่ค่า netvat <> 0  จะเอาค่า netvat ไปคิดคำนวณ
     --------------------------------------------------*/

     /*IF nv_total <> 0 THEN DO:*/           /* Paid */
     IF nv_fex = no THEN DO:
       IF nv_netvat <> 0 THEN DO:
          /* FAC RI */
          IF Clm300.csftq = "F" THEN DO:
             nv_facri = nv_facri + (Clm300.risi_p * nv_netvat) / 100.

             IF SUBSTRING (Clm300.rico,1,2) = "0F" THEN DO:
                FIND XMM600 USE-INDEX XMM60001 WHERE
                     XMM600.ACNO = Clm300.rico
                NO-LOCK NO-ERROR NO-WAIT.
                IF NOT AVAILABLE XMM600 THEN DO:
                   nv_facerr = nv_facerr + (clm300.risi_p * nv_netvat) / 100.    /* Fac. Error */
                END.
                ELSE DO:
                   IF XMM600.ACCCOD  = "RA" THEN
                      nv_faca = nv_faca + (clm300.risi_p * nv_netvat) / 100.  /* Fac. Asian */
                   ELSE IF XMM600.ACCCOD = "RF" THEN
                      nv_facf = nv_facf + (clm300.risi_p * nv_netvat) / 100.  /* Fac. Foreign */
                   ELSE nv_facerr = nv_facerr + (clm300.risi_p * nv_netvat) / 100.
                END. /* find xmm600 */
             END. /* clm130.rico = "0F" */

             IF SUBSTRING (Clm300.rico,1,2) = "0D" THEN
                nv_facl = nv_facl + (clm300.risi_p * nv_netvat) / 100.

          END. /* clm300.csftq = "F" */

          /* 1st Surplus */
          IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
             SUBSTRING (Clm300.rico,6,2) = "01"
          THEN  nv_1st   = (Clm300.risi_p * nv_netvat) / 100.

          /* 2nd Surplus */
          IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
             SUBSTRING (Clm300.rico,6,2) = "02" AND
             NOT (WCLM130.POLTYP = "M80"  OR WCLM130.POLTYP = "M81" OR
                  WCLM130.POLTYP = "M82"  OR WCLM130.POLTYP = "M83" OR
                  WCLM130.POLTYP = "M84"  OR WCLM130.POLTYP = "M85" OR
                  WCLM130.POLTYP = "C90")
          THEN  nv_2nd    = (Clm300.risi_p * nv_netvat) / 100.

          /* THAI RI */
          IF SUBSTRING (Clm300.rico,1,4) = "STAT"
          THEN  nv_qs5  = (Clm300.risi_p * nv_netvat) / 100.

          /* TFP */
          IF SUBSTRING (Clm300.rico,1,3)  = "0QA"
          THEN  nv_tfp  = (Clm300.risi_p * nv_netvat) / 100.

          /* ENG. FAC */
          IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
             SUBSTRING (Clm300.rico,6,2) = "02" AND
             (WCLM130.POLTYP = "M80" OR WCLM130.POLTYP = "M81"  OR
              WCLM130.POLTYP = "M82" OR WCLM130.POLTYP = "M83"  OR
              WCLM130.POLTYP = "M84" OR WCLM130.POLTYP = "M85")
          THEN  nv_eng  = (Clm300.risi_p * nv_netvat) / 100.

          /* MARINE O/P */
          IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
             SUBSTRING (Clm300.rico,6,2) = "02" AND
             WCLM130.POLTYP = "C90"
          THEN  nv_mar   = (Clm300.risi_p * nv_netvat) / 100.

          /* RET. */
          IF SUBSTRING (Clm300.rico,1,4) = "0RET"
          THEN  nv_ret  = (Clm300.risi_p * nv_netvat) / 100.

          /* R.Q. */
          IF SUBSTRING (Clm300.rico,1,3) = "0RQ"
          THEN  nv_rq   = (Clm300.risi_p * nv_netvat) / 100.

          /* F/O I */
          IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
             SUBSTRING(Clm300.rico,6,2) = "F1"
          THEN  nv_fo1  = (Clm300.risi_p * nv_netvat) / 100.

          /* F/O II */
          IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
             SUBSTRING(Clm300.rico,6,2) = "F2"
          THEN  nv_fo2  = (Clm300.risi_p * nv_netvat) / 100.

          /* F/O III */
          IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
             SUBSTRING(Clm300.rico,6,2) = "F3"
          THEN DO:
                IF LOOKUP (WCLM130.POLTYP,"M80,M81,M82,M83,M84,M85") <> 0
                THEN
                    /*--- บวกเพิ่มเข้าใน Engineer ---*/
                    nv_eng  = nv_eng + (Clm300.risi_p * nv_netvat) / 100.
                ELSE
                    /*--- FO3 ไม่รวม Engineer ---*/
                    nv_fo3  = (Clm300.risi_p * nv_netvat) / 100.
          END.

          /* F/O IV */
          IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
             SUBSTRING(Clm300.rico,6,2) = "F4"
          THEN  nv_fo4  = (Clm300.risi_p * nv_netvat) / 100.

          /* FTR */
          IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
             SUBSTRING(Clm300.rico,6,2) = "FT"
          THEN  nv_ftr  = (Clm300.risi_p * nv_netvat) / 100.

          /* MPS */
          IF SUBSTRING(clm300.rico,1,3) = "0PS" AND
             SUBSTRING(clm300.rico,6,2) = "01"
          THEN  nv_mps  = (clm300.risi_p * nv_netvat) / 100.

          /* BTR */
          IF SUBSTRING(clm300.rico,1,2) = "0T" AND
             SUBSTRING(clm300.rico,6,2) = "FB"
          THEN  nv_btr  = (clm300.risi_p * nv_netvat) / 100.

          /* OTR */
          IF SUBSTRING(clm300.rico,1,2) = "0T" AND
             SUBSTRING(clm300.rico,6,2) = "FO"
          THEN  nv_otr  = (clm300.risi_p * nv_netvat) / 100.

          /* GROSS RET. */
          nv_gros = (nv_netvat - nv_facri
                               - nv_1st
                               - nv_2nd
                               - nv_qs5
                               - nv_tfp
                               - nv_eng
                               - nv_mar
                               - nv_rq
                               - nv_fo1
                               - nv_fo2
                               - nv_fo3
                               - nv_fo4
                               - nv_ftr
                               - nv_mps
                               - nv_btr
                               - nv_otr).

          /* XOL. */
          IF nv_gros > 5000000 THEN
             ASSIGN
                nv_xol  = nv_gros - 5000000
                nv_gros = 5000000.

       END.      /* nv_netvat <> 0 */
       ELSE DO:  /* nv_netvat = 0 */
          /* FAC RI */
          IF Clm300.csftq = "F" THEN DO:
             nv_facri = nv_facri + (Clm300.risi_p * nv_total) / 100.

             IF SUBSTRING (Clm300.rico,1,2) = "0F" THEN DO:
                FIND XMM600 USE-INDEX XMM60001 WHERE
                     XMM600.ACNO = Clm300.rico
                NO-LOCK NO-ERROR NO-WAIT.
                IF NOT AVAILABLE XMM600 THEN DO:
                   nv_facerr = nv_facerr + (clm300.risi_p * nv_total) / 100.     /* Fac. Error */
                END.
                ELSE DO:
                   IF XMM600.ACCCOD  = "RA" THEN
                      nv_faca = nv_faca + (clm300.risi_p * nv_total) / 100.   /* Fac. Asian */
                   ELSE IF XMM600.ACCCOD = "RF" THEN
                      nv_facf = nv_facf + (clm300.risi_p * nv_total) / 100.   /* Fac. Foreign */
                   ELSE nv_facerr = nv_facerr + (clm300.risi_p * nv_total) / 100.
                END. /* find xmm600 */
             END. /* clm130.rico = "0F" */

             IF SUBSTRING (Clm300.rico,1,2) = "0D" THEN
                nv_facl =  nv_facl + (clm300.risi_p * nv_total) / 100.

          END. /* clm300.csftq = "F" */

          /* 1st Surplus */
          IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
             SUBSTRING (Clm300.rico,6,2) = "01"
          THEN  nv_1st   = (Clm300.risi_p * nv_total) / 100.

          /* 2nd Surplus */
          IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
             SUBSTRING (Clm300.rico,6,2) = "02" AND
             NOT (WCLM130.POLTYP = "M80"  OR WCLM130.POLTYP = "M81" OR
                  WCLM130.POLTYP = "M82"  OR WCLM130.POLTYP = "M83" OR
                  WCLM130.POLTYP = "M84"  OR WCLM130.POLTYP = "M85" OR
                  WCLM130.POLTYP = "C90")
          THEN  nv_2nd    = (Clm300.risi_p * nv_total) / 100.

          /* THAI RI */
          IF SUBSTRING (Clm300.rico,1,4) = "STAT"
          THEN  nv_qs5  = (Clm300.risi_p * nv_total) / 100.

          /* TFP */
          IF SUBSTRING (Clm300.rico,1,3)  = "0QA"
          THEN  nv_tfp  = (Clm300.risi_p * nv_total) / 100.

          /* ENG. FAC */
          IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
             SUBSTRING (Clm300.rico,6,2) = "02" AND
             (WCLM130.POLTYP = "M80" OR WCLM130.POLTYP = "M81"  OR
              WCLM130.POLTYP = "M82" OR WCLM130.POLTYP = "M83"  OR
              WCLM130.POLTYP = "M84" OR WCLM130.POLTYP = "M85")
          THEN  nv_eng  = (Clm300.risi_p * nv_total) / 100.

          /* MARINE O/P */
          IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
             SUBSTRING (Clm300.rico,6,2) = "02" AND
             WCLM130.POLTYP = "C90"
          THEN  nv_mar   = (Clm300.risi_p * nv_total) / 100.

          /* RET. */
          IF SUBSTRING (Clm300.rico,1,4) = "0RET"
          THEN  nv_ret  = (Clm300.risi_p * nv_total) / 100.

          /* R.Q. */
          IF SUBSTRING (Clm300.rico,1,3) = "0RQ"
          THEN  nv_rq   = (Clm300.risi_p * nv_total) / 100.

          /* F/O I */
          IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
             SUBSTRING(Clm300.rico,6,2) = "F1"
          THEN  nv_fo1  = (Clm300.risi_p * nv_total) / 100.

          /* F/O II */
          IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
             SUBSTRING(Clm300.rico,6,2) = "F2"
          THEN  nv_fo2  = (Clm300.risi_p * nv_total) / 100.

          /* F/O III */
          IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
             SUBSTRING(Clm300.rico,6,2) = "F3"
          THEN DO:
                IF LOOKUP (WCLM130.POLTYP,"M80,M81,M82,M83,M84,M85") <> 0
                THEN
                    /*--- บวกเพิ่มเข้าใน Engineer ---*/
                    nv_eng  = nv_eng + (Clm300.risi_p * nv_total) / 100.
                ELSE
                    /*--- FO3 ไม่รวม Engineer ---*/
                    nv_fo3  = (Clm300.risi_p * nv_total) / 100.
          END.

          /* F/O IV */
          IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
             SUBSTRING(Clm300.rico,6,2) = "F4"
          THEN  nv_fo4  = (Clm300.risi_p * nv_total) / 100.

          /* FTR */
          IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
             SUBSTRING(Clm300.rico,6,2) = "FT"
          THEN  nv_ftr  = (Clm300.risi_p * nv_total) / 100.

          /* MPS */
          IF SUBSTRING(clm300.rico,1,3) = "0PS" AND
             SUBSTRING(clm300.rico,6,2) = "01"
          THEN  nv_mps  = (clm300.risi_p * nv_total) / 100.

          /* BTR */
          IF SUBSTRING(clm300.rico,1,2) = "0T" AND
             SUBSTRING(clm300.rico,6,2) = "FB"
          THEN  nv_btr  = (clm300.risi_p * nv_total) / 100.

          /* OTR */
          IF SUBSTRING(clm300.rico,1,2) = "0T" AND
             SUBSTRING(clm300.rico,6,2) = "FO"
          THEN  nv_otr  = (clm300.risi_p * nv_total) / 100.

          /* GROSS RET. */
          nv_gros = (nv_total  - nv_facri
                               - nv_1st
                               - nv_2nd
                               - nv_qs5
                               - nv_tfp
                               - nv_eng
                               - nv_mar
                               - nv_rq
                               - nv_fo1
                               - nv_fo2
                               - nv_fo3
                               - nv_fo4
                               - nv_ftr
                               - nv_mps
                               - nv_btr
                               - nv_otr).

          /* XOL. */
          IF nv_gros > 5000000 THEN
             ASSIGN
                nv_xol  = nv_gros - 5000000
                nv_gros = 5000000.

       END.     /* nv_netvat = 0 */
     END.
     ELSE DO:
     /*IF nv_etotal <> 0 THEN DO:*/        /* fee & expense */
       IF nv_netvat <> 0 THEN DO:
          /* FAC RI */
          IF Clm300.csftq = "F" THEN DO:
             nv_facri = nv_facri + (Clm300.risi_p * nv_netvat) / 100.

             IF SUBSTRING (Clm300.rico,1,2) = "0F" THEN DO:
                FIND XMM600 USE-INDEX XMM60001 WHERE
                     XMM600.ACNO = Clm300.rico
                NO-LOCK NO-ERROR NO-WAIT.
                IF NOT AVAILABLE XMM600 THEN DO:
                   nv_facerr = nv_facerr + (clm300.risi_p * nv_netvat) / 100.      /* Fac. Error */
                END.
                ELSE DO:
                   IF XMM600.ACCCOD  = "RA" THEN
                      nv_faca = nv_faca + (clm300.risi_p * nv_netvat) / 100.    /* Fac. Asian */
                   ELSE IF XMM600.ACCCOD = "RF" THEN
                      nv_facf = nv_facf + (clm300.risi_p * nv_netvat) / 100.    /* Fac. Foreign */
                   ELSE nv_facerr = nv_facerr + (clm300.risi_p * nv_netvat) / 100.
                END. /* find xmm600 */
             END. /* clm130.rico = "0F" */

             IF SUBSTRING (Clm300.rico,1,2) = "0D" THEN
                    nv_facl = nv_facl + (clm300.risi_p * nv_netvat) / 100.
             
          END. /* clm300.csftq = "F" */

          /* 1st Surplus */
          IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
             SUBSTRING (Clm300.rico,6,2) = "01"
          THEN  nv_1st   = (Clm300.risi_p * nv_netvat) / 100.

          /* 2nd Surplus */
          IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
             SUBSTRING (Clm300.rico,6,2) = "02" AND
             NOT (WCLM130.POLTYP = "M80"  OR WCLM130.POLTYP = "M81" OR
                  WCLM130.POLTYP = "M82"  OR WCLM130.POLTYP = "M83" OR
                  WCLM130.POLTYP = "M84"  OR WCLM130.POLTYP = "M85" OR
                  WCLM130.POLTYP = "C90")
          THEN  nv_2nd    = (Clm300.risi_p * nv_netvat) / 100.

          /* THAI RI */
          IF SUBSTRING (Clm300.rico,1,4) = "STAT"
          THEN  nv_qs5  = (Clm300.risi_p * nv_netvat) / 100.

          /* TFP */
          IF SUBSTRING (Clm300.rico,1,3)  = "0QA"
          THEN  nv_tfp  = (Clm300.risi_p * nv_netvat) / 100.

          /* ENG. FAC */
          IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
             SUBSTRING (Clm300.rico,6,2) = "02" AND
             (WCLM130.POLTYP = "M80" OR WCLM130.POLTYP = "M81"  OR
              WCLM130.POLTYP = "M82" OR WCLM130.POLTYP = "M83"  OR
              WCLM130.POLTYP = "M84" OR WCLM130.POLTYP = "M85")
          THEN  nv_eng  = (Clm300.risi_p * nv_netvat) / 100.

          /* MARINE O/P */
          IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
             SUBSTRING (Clm300.rico,6,2) = "02" AND
             WCLM130.POLTYP = "C90"
          THEN  nv_mar   = (Clm300.risi_p * nv_netvat) / 100.

          /* RET. */
          IF SUBSTRING (Clm300.rico,1,4) = "0RET"
          THEN  nv_ret  = (Clm300.risi_p * nv_netvat) / 100.

          /* R.Q. */
          IF SUBSTRING (Clm300.rico,1,3) = "0RQ"
          THEN  nv_rq   = (Clm300.risi_p * nv_netvat) / 100.

          /* F/O I */
          IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
             SUBSTRING(Clm300.rico,6,2) = "F1"
          THEN  nv_fo1  = (Clm300.risi_p * nv_netvat) / 100.

          /* F/O II */
          IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
             SUBSTRING(Clm300.rico,6,2) = "F2"
          THEN  nv_fo2  = (Clm300.risi_p * nv_netvat) / 100.

          /* F/O III */
          IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
             SUBSTRING(Clm300.rico,6,2) = "F3"
          THEN DO:
                IF LOOKUP (WCLM130.POLTYP,"M80,M81,M82,M83,M84,M85") <> 0
                THEN
                    /*--- บวกเพิ่มเข้าใน Engineer ---*/
                    nv_eng  = nv_eng + (Clm300.risi_p * nv_netvat) / 100.
                ELSE
                    /*--- FO3 ไม่รวม Engineer ---*/
                    nv_fo3  = (Clm300.risi_p * nv_netvat) / 100.
          END.

          /* F/O IV */
          IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
             SUBSTRING(Clm300.rico,6,2) = "F4"
          THEN  nv_fo4  = (Clm300.risi_p * nv_netvat) / 100.

          /* FTR */
          IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
             SUBSTRING(Clm300.rico,6,2) = "FT"
          THEN  nv_ftr  = (Clm300.risi_p * nv_netvat) / 100.

          /* MPS */
          IF SUBSTRING(clm300.rico,1,3) = "0PS" AND
             SUBSTRING(clm300.rico,6,2) = "01"
          THEN  nv_mps  = (clm300.risi_p * nv_netvat) / 100.

          /* BTR */
          IF SUBSTRING(clm300.rico,1,2) = "0T" AND
             SUBSTRING(clm300.rico,6,2) = "FB"
          THEN  nv_btr  = (clm300.risi_p * nv_netvat) / 100.

          /* OTR */
          IF SUBSTRING(clm300.rico,1,2) = "0T" AND
             SUBSTRING(clm300.rico,6,2) = "FO"
          THEN  nv_otr  = (clm300.risi_p * nv_netvat) / 100.

          /* GROSS RET. */
          nv_gros = (nv_netvat  - nv_facri
                                - nv_1st
                                - nv_2nd
                                - nv_qs5
                                - nv_tfp
                                - nv_eng
                                - nv_mar
                                - nv_rq
                                - nv_fo1
                                - nv_fo2
                                - nv_fo3
                                - nv_fo4
                                - nv_ftr
                                - nv_mps
                                - nv_btr
                                - nv_otr).

          /* XOL. */
          IF nv_gros > 5000000 THEN
             ASSIGN
                nv_xol  = nv_gros - 5000000
                nv_gros = 5000000.

       END.      /* nv_netvat <> 0 */
       ELSE DO:  /* nv_netvat =  0 */
          /* FAC RI */
          IF Clm300.csftq = "F" THEN DO:
             nv_facri = nv_facri + (Clm300.risi_p * nv_etotal) / 100.

             IF SUBSTRING (Clm300.rico,1,2) = "0F" THEN DO:
                FIND XMM600 USE-INDEX XMM60001 WHERE
                     XMM600.ACNO = Clm300.rico
                NO-LOCK NO-ERROR NO-WAIT.
                IF NOT AVAILABLE XMM600 THEN DO:
                   nv_facerr = nv_facerr + (clm300.risi_p * nv_etotal) / 100.      /* Fac. Error */
                END.
                ELSE DO:
                   IF XMM600.ACCCOD  = "RA" THEN
                      nv_faca = nv_faca + (clm300.risi_p * nv_etotal) / 100.    /* Fac. Asian */
                   ELSE IF XMM600.ACCCOD = "RF" THEN
                      nv_facf = nv_facf + (clm300.risi_p * nv_etotal) / 100.    /* Fac. Foreign */
                   ELSE nv_facerr = nv_facerr + (clm300.risi_p * nv_etotal) / 100.
                END. /* find xmm600 */
             END. /* clm130.rico = "0F" */

             IF SUBSTRING (Clm300.rico,1,2) = "0D" THEN
                nv_facl = nv_facl + (clm300.risi_p * nv_etotal) / 100.

          END. /* clm300.csftq = "F" */

          /* 1st Surplus */
          IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
             SUBSTRING (Clm300.rico,6,2) = "01"
          THEN  nv_1st   = (Clm300.risi_p * nv_etotal) / 100.

          /* 2nd Surplus */
          IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
             SUBSTRING (Clm300.rico,6,2) = "02" AND
             NOT (WCLM130.POLTYP = "M80"  OR WCLM130.POLTYP = "M81" OR
                  WCLM130.POLTYP = "M82"  OR WCLM130.POLTYP = "M83" OR
                  WCLM130.POLTYP = "M84"  OR WCLM130.POLTYP = "M85" OR
                  WCLM130.POLTYP = "C90")
          THEN  nv_2nd    = (Clm300.risi_p * nv_etotal) / 100.

          /* THAI RI */
          IF SUBSTRING (Clm300.rico,1,4) = "STAT"
          THEN  nv_qs5  = (Clm300.risi_p * nv_etotal) / 100.

          /* TFP */
          IF SUBSTRING (Clm300.rico,1,3)  = "0QA"
          THEN  nv_tfp  = (Clm300.risi_p * nv_etotal) / 100.

          /* ENG. FAC */
          IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
             SUBSTRING (Clm300.rico,6,2) = "02" AND
             (WCLM130.POLTYP = "M80" OR WCLM130.POLTYP = "M81"  OR
              WCLM130.POLTYP = "M82" OR WCLM130.POLTYP = "M83"  OR
              WCLM130.POLTYP = "M84" OR WCLM130.POLTYP = "M85")
          THEN  nv_eng  = (Clm300.risi_p * nv_etotal) / 100.

          /* MARINE O/P */
          IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
             SUBSTRING (Clm300.rico,6,2) = "02" AND
             WCLM130.POLTYP = "C90"
          THEN  nv_mar   = (Clm300.risi_p * nv_etotal) / 100.

          /* RET. */
          IF SUBSTRING (Clm300.rico,1,4) = "0RET"
          THEN  nv_ret  = (Clm300.risi_p * nv_etotal) / 100.

          /* R.Q. */
          IF SUBSTRING (Clm300.rico,1,3) = "0RQ"
          THEN  nv_rq   = (Clm300.risi_p * nv_etotal) / 100.

          /* F/O I */
          IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
             SUBSTRING(Clm300.rico,6,2) = "F1"
          THEN  nv_fo1  = (Clm300.risi_p * nv_etotal) / 100.

          /* F/O II */
          IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
             SUBSTRING(Clm300.rico,6,2) = "F2"
          THEN  nv_fo2  = (Clm300.risi_p * nv_etotal) / 100.

          /* F/O III */
          IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
             SUBSTRING(Clm300.rico,6,2) = "F3"
          THEN DO:
                IF LOOKUP (WCLM130.POLTYP,"M80,M81,M82,M83,M84,M85") <> 0
                THEN
                    /*--- บวกเพิ่มเข้าใน Engineer ---*/
                    nv_eng  = nv_eng + (Clm300.risi_p * nv_etotal) / 100.
                ELSE
                    /*--- FO3 ไม่รวม Engineer ---*/
                    nv_fo3  = (Clm300.risi_p * nv_etotal) / 100.
          END.

          /* F/O IV */
          IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
             SUBSTRING(Clm300.rico,6,2) = "F4"
          THEN  nv_fo4  = (Clm300.risi_p * nv_etotal) / 100.

          /* FTR */
          IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
             SUBSTRING(Clm300.rico,6,2) = "FT"
          THEN  nv_ftr  = (Clm300.risi_p * nv_etotal) / 100.

          /* MPS */
          IF SUBSTRING(clm300.rico,1,3) = "0PS" AND
             SUBSTRING(clm300.rico,6,2) = "01"
          THEN  nv_mps  = (clm300.risi_p * nv_etotal) / 100.

          /* BTR */
          IF SUBSTRING(clm300.rico,1,2) = "0T" AND
             SUBSTRING(clm300.rico,6,2) = "FB"
          THEN  nv_btr  = (clm300.risi_p * nv_etotal) / 100.

          /* OTR */
          IF SUBSTRING(clm300.rico,1,2) = "0T" AND
             SUBSTRING(clm300.rico,6,2) = "FO"
          THEN  nv_otr  = (clm300.risi_p * nv_etotal) / 100.

          /* GROSS RET. */
          nv_gros = (nv_etotal - nv_facri
                               - nv_1st
                               - nv_2nd
                               - nv_qs5
                               - nv_tfp
                               - nv_eng
                               - nv_mar
                               - nv_rq
                               - nv_fo1
                               - nv_fo2
                               - nv_fo3
                               - nv_fo4
                               - nv_ftr
                               - nv_mps
                               - nv_btr
                               - nv_otr).

          /* XOL. */
          IF nv_gros > 5000000 THEN
             ASSIGN
                nv_xol  = nv_gros - 5000000
                nv_gros = 5000000.

       END. /* nv_netvat = 0 */
     END.

   END.   /* FOR EACH CLM300 */
   /*-----------    End of Find Reinsurance   -------------*/

    /*---
    nv_row = nv_row + 1.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K"   '"' wclm130.branch     '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X2;K"   '"' nv_poltyp          '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X3;K"   '"' nv_poldes          '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X4;K"   '"' nv_group           '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X5;K"   '"' nv_policy          '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X6;K"   '"' Substr(wclm130.claim,1,1)      '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X7;K"   '"' wclm130.claim      '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X8;K"   '"' nv_acno1           '"'   SKIP.  /*A47-0140*/
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X9;K"   '"' nv_prodc           '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X10;K"  '"' nv_losdat          '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X11;K"  '"' nv_nature          '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X12;K"  '"' nv_patycd          '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X13;K"  '"' nv_req             '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X14;K"  '"' wclm130.entdat     '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X15;K"  '"' wclm130.trndat     '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X16;K"   nv_total              SKIP.  /*A47-0140*/
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X17;K"   nv_etotal             SKIP.  /*A47-0140*/
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X18;K"   nv_netvat             SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X19;K"   nv_vat                SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X20;K"   nv_tax                SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X21;K"   nv_netamt             SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X22;K"   nv_1st                SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X23;K"   nv_2nd                SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X24;K"   nv_facri              SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X25;K"   nv_qs5                SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X26;K"   nv_tfp                SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X27;K"   nv_mps                SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X28;K"   nv_eng                SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X29;K"   nv_mar                SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X30;K"   nv_rq                 SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X31;K"   nv_btr                SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X32;K"   nv_otr                SKIP.  /*A47-0140*/
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X33;K"   nv_ftr                SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X34;K"   nv_fo1                SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X35;K"   nv_fo2                SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X36;K"   nv_fo3                SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X37;K"   nv_fo4                SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X38;K"   nv_ret                SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X39;K"   nv_gros               SKIP.  /*A47-0140*/
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X40;K"   nv_xol                SKIP.  /*A47-0140*/
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X41;K"  '"' nv_acno            '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X42;K"  '"' nv_payee           '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X43;K"  '"' xmm600.clicod      '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X44;K"  '"' nv_userid          '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X45;K"  '"' nv_prtadj          '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X46;K"  '"' nv_paydet          '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X47;K"  '"' nv_releas          '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X48;K"  '"' nv_sts             '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X49;K"  '"' nv_coins           '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X50;K"   nv_coper             SKIP.
    ----*/

   /*----------    Sum of Line    -------------*/
   IF nv_fex = yes THEN DO:
      ASSIGN
         nv_esumtot   = nv_esumtot   + nv_etotal
         nv_esumnet   = nv_esumnet   + nv_netvat
         nv_esumvat   = nv_esumvat   + nv_vat
         nv_esumtax   = nv_esumtax   + nv_tax
         nv_esumamt   = nv_esumamt   + nv_netamt
         nv_esumtranC = nv_esumtranC + nv_tranC
         nv_esumfacri = nv_esumfacri + nv_facri
         nv_esum1st   = nv_esum1st   + nv_1st
         nv_esum2nd   = nv_esum2nd   + nv_2nd
         nv_esumqs5   = nv_esumqs5   + nv_qs5
         nv_esumtfp   = nv_esumtfp   + nv_tfp
         nv_esumeng   = nv_esumeng   + nv_eng
         nv_esumfo1   = nv_esumfo1   + nv_fo1
         nv_esumfo2   = nv_esumfo2   + nv_fo2
         nv_esumfo3   = nv_esumfo3   + nv_fo3
         nv_esumfo4   = nv_esumfo4   + nv_fo4
         nv_esumrq    = nv_esumrq    + nv_rq
         nv_esummps   = nv_esummps   + nv_mps
         nv_esumbtr   = nv_esumbtr   + nv_btr
         nv_esumotr   = nv_esumotr   + nv_otr
         nv_esumftr   = nv_esumftr   + nv_ftr
         nv_esummar   = nv_esummar   + nv_mar
         nv_esumret   = nv_esumret   + nv_ret
         nv_esumgros  = nv_esumgros  + nv_gros
         nv_esumxol   = nv_esumxol   + nv_xol .

   END.  /* nv_fex = yes */
   ELSE DO:
      ASSIGN
         nv_sumtot   = nv_sumtot   + nv_total
         nv_sumnet   = nv_sumnet   + nv_netvat
         nv_sumvat   = nv_sumvat   + nv_vat
         nv_sumtax   = nv_sumtax   + nv_tax
         nv_sumamt   = nv_sumamt   + nv_netamt
         nv_sumtranC = nv_sumtranC + nv_tranC
         nv_sumfacri = nv_sumfacri + nv_facri
         nv_sum1st   = nv_sum1st   + nv_1st
         nv_sum2nd   = nv_sum2nd   + nv_2nd
         nv_sumqs5   = nv_sumqs5   + nv_qs5
         nv_sumtfp   = nv_sumtfp   + nv_tfp
         nv_sumeng   = nv_sumeng   + nv_eng
         nv_sumfo1   = nv_sumfo1   + nv_fo1
         nv_sumfo2   = nv_sumfo2   + nv_fo2
         nv_sumfo3   = nv_sumfo3   + nv_fo3
         nv_sumfo4   = nv_sumfo4   + nv_fo4
         nv_sumrq    = nv_sumrq    + nv_rq
         nv_summps   = nv_summps   + nv_mps
         nv_sumbtr   = nv_sumbtr   + nv_btr
         nv_sumotr   = nv_sumotr   + nv_otr
         nv_sumftr   = nv_sumftr   + nv_ftr
         nv_summar   = nv_summar   + nv_mar
         nv_sumret   = nv_sumret   + nv_ret
         nv_sumgros  = nv_sumgros  + nv_gros
         nv_sumxol   = nv_sumxol   + nv_xol .

   END.
   /*------------   End of Sum Line  ----------*/


   /*------------   Sum Of Branch   -----------*/
   ASSIGN
      nb_sumtot   = nb_sumtot   + nv_total
      nb_sumsurve = nb_sumsurve + nv_etotal
      nb_sumnet   = nb_sumnet   + nv_netvat
      nb_sumvat   = nb_sumvat   + nv_vat
      nb_sumtax   = nb_sumtax   + nv_tax
      nb_sumamt   = nb_sumamt   + nv_netamt
      nb_sumtranC = nb_sumtranC + nv_tranC
      nb_sumfacri = nb_sumfacri + nv_facri
      nb_sum1st   = nb_sum1st   + nv_1st
      nb_sum2nd   = nb_sum2nd   + nv_2nd
      nb_sumqs5   = nb_sumqs5   + nv_qs5
      nb_sumtfp   = nb_sumtfp   + nv_tfp
      nb_sumeng   = nb_sumeng   + nv_eng
      nb_sumfo1   = nb_sumfo1   + nv_fo1
      nb_sumfo2   = nb_sumfo2   + nv_fo2
      nb_sumfo3   = nb_sumfo3   + nv_fo3
      nb_sumfo4   = nb_sumfo4   + nv_fo4
      nb_sumrq    = nb_sumrq    + nv_rq
      nb_summps   = nb_summps   + nv_mps
      nb_sumbtr   = nb_sumbtr   + nv_btr
      nb_sumotr   = nb_sumotr   + nv_otr
      nb_sumftr   = nb_sumftr   + nv_ftr
      nb_summar   = nb_summar   + nv_mar
      nb_sumret   = nb_sumret   + nv_ret
      nb_sumgros  = nb_sumgros  + nv_gros
      nb_sumxol   = nb_sumxol   + nv_xol.
   /*----------  End Of Sum Branch  -----------*/


   /*----------  Sum Of Dir_Ri      -----------*/
   ASSIGN
      nd_sumtot   = nd_sumtot   + nv_total
      nd_sumsurve = nd_sumsurve + nv_etotal
      nd_sumnet   = nd_sumnet   + nv_netvat
      nd_sumvat   = nd_sumvat   + nv_vat
      nd_sumtax   = nd_sumtax   + nv_tax
      nd_sumamt   = nd_sumamt   + nv_netamt
      nd_sumtranC = nd_sumtranC + nv_tranC
      nd_sumfacri = nd_sumfacri + nv_facri
      nd_sum1st   = nd_sum1st   + nv_1st
      nd_sum2nd   = nd_sum2nd   + nv_2nd
      nd_sumqs5   = nd_sumqs5   + nv_qs5
      nd_sumtfp   = nd_sumtfp   + nv_tfp
      nd_sumeng   = nd_sumeng   + nv_eng
      nd_sumfo1   = nd_sumfo1   + nv_fo1
      nd_sumfo2   = nd_sumfo2   + nv_fo2
      nd_sumfo3   = nd_sumfo3   + nv_fo3
      nd_sumfo4   = nd_sumfo4   + nv_fo4
      nd_sumrq    = nd_sumrq    + nv_rq
      nd_summps   = nd_summps   + nv_mps
      nd_sumbtr   = nd_sumbtr   + nv_btr
      nd_sumotr   = nd_sumotr   + nv_otr
      nd_sumftr   = nd_sumftr   + nv_ftr
      nd_summar   = nd_summar   + nv_mar
      nd_sumret   = nd_sumret   + nv_ret
      nd_sumgros  = nd_sumgros  + nv_gros
      nd_sumxol   = nd_sumxol   + nv_xol.
   /*----------  End Of Sum Dir_Ri     ---------*/


   IF  LAST-OF(SUBSTRING(WCLM130.POLTYP,2,2))  THEN DO:
        nv_row = nv_row + 1.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K"   '"' "TOTAL : "     '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X2;K"   '"' n_dir_ri       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X3;K"   '"' "BRANCH : "    '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X4;K"   '"' n_branch       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X5;K"   '"' n_poltyp       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X6;K"   '"' " - Paid"      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X10;K"  '"' nv_sumtot      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X12;K"  '"' nv_sumnet      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X13;K"  '"' nv_sumvat      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X14;K"  '"' nv_sumtax      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X15;K"  '"' nv_sumamt      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X10;K"  '"' nv_sum1st      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X11;K"  '"' nv_sum2nd      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X12;K"  '"' nv_sumfacri    '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X13;K"  '"' nv_sumqs5      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X14;K"  '"' nv_sumtfp      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X15;K"  '"' nv_summps      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X16;K"  '"' nv_sumeng      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X17;K"  '"' nv_summar       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X18;K"  '"' nv_sumrq        '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X19;K"  '"' nv_sumbtr       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X20;K"  '"' nv_sumotr       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X21;K"  '"' nv_sumftr       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X22;K"  '"' nv_sumfo1       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X23;K"  '"' nv_sumfo2       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X24;K"  '"' nv_sumfo3       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X25;K"  '"' nv_sumfo4       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X26;K"  '"' nv_sumret       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X27;K"  '"' nv_sumgros      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X28;K"  '"' nv_sumxol       '"'   SKIP.

        nv_row = nv_row + 1.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K"   '"' "TOTAL : "     '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X2;K"   '"' n_dir_ri       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X3;K"   '"' "BRANCH : "    '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X4;K"   '"' n_branch       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X5;K"   '"' n_poltyp       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X6;K"   '"' " - Fee & Expense "      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X10;K"  '"' nv_esumtot      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X12;K"  '"' nv_esumnet      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X13;K"  '"' nv_esumvat      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X14;K"  '"' nv_esumtax      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X15;K"  '"' nv_esumamt      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X10;K"  '"' nv_esum1st      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X11;K"  '"' nv_esum2nd      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X12;K"  '"' nv_esumfacri    '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X13;K"  '"' nv_esumqs5      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X14;K"  '"' nv_esumtfp      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X15;K"  '"' nv_esummps      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X16;K"  '"' nv_esumeng      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X17;K"  '"' nv_esummar       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X18;K"  '"' nv_esumrq        '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X19;K"  '"' nv_esumbtr       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X20;K"  '"' nv_esumotr       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X21;K"  '"' nv_esumftr       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X22;K"  '"' nv_esumfo1       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X23;K"  '"' nv_esumfo2       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X24;K"  '"' nv_esumfo3       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X25;K"  '"' nv_esumfo4       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X26;K"  '"' nv_esumret       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X27;K"  '"' nv_esumgros      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X28;K"  '"' nv_esumxol       '"'   SKIP.

        ASSIGN
           nv_txt       = ""
           nv_sumtot    = 0        nv_sumfo1     = 0
           nv_sumnet    = 0        nv_sumfo2     = 0
           nv_sumvat    = 0        nv_sumfo3     = 0
           nv_sumtax    = 0        nv_sumfo4     = 0
           nv_sumamt    = 0        nv_sumrq      = 0
           nv_sumtranC  = 0        nv_summps     = 0
           nv_sumsurve  = 0        nv_sumbtr     = 0
           nv_sumfacri  = 0        nv_sumotr     = 0
           nv_sum1st    = 0        nv_sumftr     = 0
           nv_sum2nd    = 0        nv_summar     = 0
           nv_sumqs5    = 0        nv_sumret     = 0
           nv_sumtfp    = 0        nv_sumgros    = 0
           nv_sumeng    = 0        nv_sumxol     = 0


           nv_etxt       = ""      nv_esumfo1    = 0
           nv_esumtot    = 0       nv_esumfo2    = 0
           nv_esumnet    = 0       nv_esumfo3    = 0
           nv_esumvat    = 0       nv_esumfo4    = 0
           nv_esumtax    = 0       nv_esumrq     = 0
           nv_esumamt    = 0       nv_esummps    = 0
           nv_esumtranC  = 0       nv_esumbtr    = 0
           nv_esumfacri  = 0       nv_esumotr    = 0
           nv_esum1st    = 0       nv_esumftr    = 0
           nv_esum2nd    = 0       nv_esummar    = 0
           nv_esumqs5    = 0       nv_esumret    = 0
           nv_esumtfp    = 0       nv_esumgros   = 0
           nv_esumeng    = 0       nv_esumxol    = 0


           nv_sum1stl    = 0       nv_esum1stl   = 0
           nv_sum1stf    = 0       nv_esum1stf   = 0
           nv_sum1sta    = 0       nv_esum1sta   = 0

           nv_sum2ndl    = 0       nv_esum2ndl   = 0
           nv_sum2ndf    = 0       nv_esum2ndf   = 0
           nv_sum2nda    = 0       nv_esum2nda   = 0

           nv_sumengl    = 0       nv_esumengl   = 0
           nv_sumengf    = 0       nv_esumengf   = 0
           nv_sumenga    = 0       nv_esumenga   = 0 .

           /*---- เพิ่มเข้าไปเพื่อเช็ค Fac Ri ------*/
       ASSIGN
           nv_sumfacl    = 0       nv_esumfacl   = 0
           nv_sumfaca    = 0       nv_esumfaca   = 0
           nv_sumfacf    = 0       nv_esumfacf   = 0
           nv_sumerr     = 0       nv_esumerr    = 0 .

   END. /* LAST-OF(WCLM130.POLTYP) */


   IF  LAST-OF(WCLM130.BRANCH)  THEN DO:
       /*---jeab total
       nv_txt = "TOTAL :  " + n_dir_ri +
                "  " + ",BRANCH = " + n_branch.
       PUT STREAM ns1
           SKIP(1)
           ";" ";" ";" nv_txt ";"
           ";" ";" ";" ";" ";" ";" ";" ";" ";" ";"
           nb_sumtot       ";"
           nb_sumsurve     ";"
           nb_sumnet       ";"
           nb_sumvat       ";"
           nb_sumtax       ";"
           nb_sumamt       ";"
           nb_sum1st       ";"
           nb_sum2nd       ";"
           nb_sumfacri     ";"
           nb_sumqs5       ";"
           nb_sumtfp       ";"
           nb_summps       ";"
           nb_sumeng       ";"
           nb_summar       ";"
           nb_sumrq        ";"
           nb_sumbtr       ";"
           nb_sumotr       ";"
           nb_sumftr       ";"
           nb_sumfo1       ";"
           nb_sumfo2       ";"
           nb_sumfo3       ";"
           nb_sumfo4       ";"
           nb_sumret       ";"
           nb_sumgros      ";"
           nb_sumxol       SKIP.
       --------------------------------*/
       nv_row = nv_row + 1.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K"   '"' "TOTAL : "     '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X2;K"   '"' n_dir_ri       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X3;K"   '"' "BRANCH : "    '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X4;K"   '"' n_branch       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X10;K"  '"' nb_sumtot      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X11;K"  '"' nb_sumsurve    '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X12;K"  '"' nb_sumnet      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X13;K"  '"' nb_sumvat      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X14;K"  '"' nb_sumtax      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X15;K"  '"' nb_sumamt      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X10;K"  '"' nb_sum1st      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X11;K"  '"' nb_sum2nd      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X12;K"  '"' nb_sumfacri    '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X13;K"  '"' nb_sumqs5      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X14;K"  '"' nb_sumtfp      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X15;K"  '"' nb_summps      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X16;K"  '"' nb_sumeng       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X17;K"  '"' nb_summar       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X18;K"  '"' nb_sumrq        '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X19;K"  '"' nb_sumbtr       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X20;K"  '"' nb_sumotr       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X21;K"  '"' nb_sumftr       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X22;K"  '"' nb_sumfo1       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X23;K"  '"' nb_sumfo2       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X24;K"  '"' nb_sumfo3       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X25;K"  '"' nb_sumfo4       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X26;K"  '"' nb_sumret       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X27;K"  '"' nb_sumgros      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X28;K"  '"' nb_sumxol       '"'   SKIP.
       
       ASSIGN
           nv_txt       = ""
           nb_sumtot    = 0       nb_sumfo1    = 0
           nb_sumnet    = 0       nb_sumfo2    = 0
           nb_sumvat    = 0       nb_sumfo3    = 0
           nb_sumtax    = 0       nb_sumfo4    = 0
           nb_sumamt    = 0       nb_sumrq     = 0
           nb_sumtranC  = 0       nb_summps    = 0
           nb_sumsurve  = 0       nb_sumbtr    = 0
           nb_sumfacri  = 0       nb_sumotr    = 0
           nb_sum1st    = 0       nb_sumftr    = 0
           nb_sum2nd    = 0       nb_summar    = 0
           nb_sumqs5    = 0       nb_sumret    = 0
           nb_sumtfp    = 0       nb_sumgros   = 0
           nb_sumeng    = 0       nb_sumxol    = 0 .

   END. /* LAST-OF(WCLM130.BRANCH) */


   IF  LAST-OF(WCLM130.DIR_RI) THEN DO:
      /*---jeab total
       nv_txt = "TOTAL :  " + n_dir_ri.
       PUT STREAM ns1
           SKIP(1)
           ";" ";" ";" nv_txt ";"
           ";" ";" ";" ";" ";" ";" ";" ";" ";" ";"
           nd_sumtot       ";"
           nd_sumsurve     ";"
           nd_sumnet       ";"
           nd_sumvat       ";"
           nd_sumtax       ";"
           nd_sumamt       ";"
           nd_sum1st       ";"
           nd_sum2nd       ";"
           nd_sumfacri     ";"
           nd_sumqs5       ";"
           nd_sumtfp       ";"
           nd_summps       ";"
           nd_sumeng       ";"
           nd_summar       ";"
           nd_sumrq        ";"
           nd_sumbtr       ";"
           nd_sumotr       ";"
           nd_sumftr       ";"
           nd_sumfo1       ";"
           nd_sumfo2       ";"
           nd_sumfo3       ";"
           nd_sumfo4       ";"
           nd_sumret       ";"
           nd_sumgros      ";"
           nd_sumxol       SKIP.
         -----------------------*/
           nv_row = nv_row + 1.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K"   '"' "TOTAL : "     '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X2;K"   '"' n_dir_ri       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X10;K"  '"' nd_sumtot     '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X11;K"  '"' nd_sumsurve   '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X12;K"  '"' nd_sumnet     '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X13;K"  '"' nd_sumvat     '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X14;K"  '"' nd_sumtax     '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X15;K"  '"' nd_sumamt     '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X10;K"  '"' nd_sum1st     '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X11;K"  '"' nd_sum2nd     '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X12;K"  '"' nd_sumfacri   '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X13;K"  '"' nd_sumqs5     '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X14;K"  '"' nd_sumtfp     '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X15;K"  '"' nd_summps     '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X16;K"  '"' nd_sumeng      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X17;K"  '"' nd_summar      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X18;K"  '"' nd_sumrq       '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X19;K"  '"' nd_sumbtr      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X20;K"  '"' nd_sumotr      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X21;K"  '"' nd_sumftr      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X22;K"  '"' nd_sumfo1      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X23;K"  '"' nd_sumfo2      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X24;K"  '"' nd_sumfo3      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X25;K"  '"' nd_sumfo4      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X26;K"  '"' nd_sumret      '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X27;K"  '"' nd_sumgros     '"'   SKIP.
        PUT STREAM ns1 "C;Y" STRING(nv_row) ";X28;K"  '"' nd_sumxol      '"'   SKIP.
    
       ASSIGN
           nv_txt       = ""
           nd_sumtot    = 0        nd_sumfo1    = 0
           nd_sumnet    = 0        nd_sumfo2    = 0
           nd_sumvat    = 0        nd_sumfo3    = 0
           nd_sumtax    = 0        nd_sumfo4    = 0
           nd_sumamt    = 0        nd_sumrq     = 0
           nd_sumtranC  = 0        nd_summps    = 0
           nd_sumsurve  = 0        nd_sumbtr    = 0
           nd_sumfacri  = 0        nd_sumotr    = 0
           nd_sum1st    = 0        nd_sumftr    = 0
           nd_sum2nd    = 0        nd_summar    = 0
           nd_sumqs5    = 0        nd_sumgros   = 0
           nd_sumtfp    = 0        nd_sumret    = 0
           nd_sumeng    = 0        nd_sumxol    = 0 .

   END. /* LAST-OF(WCLM130.DIR_RI) */

END.  /* EACH  WCLM130  */

PUT STREAM  ns1  "E"  SKIP.
OUTPUT STREAM ns1 CLOSE.
/*--
CLEAR ALL NO-PAUSE.
HIDE  FRAME aa NO-PAUSE.
HIDE  FRAME bb NO-PAUSE.
---*/

/*-------------------- END OF : WACSTATE.P ---------------------*/
