/* WGWTBMAI.P */
/* Transfer data from test to premium */
/* MAILTXT_FIL : ADD DRIVER NAME      */
/*

   Sombat Phu. : 26/04/2003
   Description : Transfer data from Brach to Branch
                 brsic_bran ->  sic_bran
                 brstat     ->  stat
   Modify  by  : sombat 12/09/2000
   Modify  by  : Narin  19/10/2010
   DEFINE INPUT-OUTPUT PARAMETER  sh_policy  , sh_rencnt  , sh_endcnt , 
                                  nv_batchyr , nv_batchno , nv_batcnt 
   สรุปหลักการ Connect Database GW  และ Database local 
   1. DATABASE GW  ที่ CONNECT ได้ ให้ทำการ DISCONNECT ออก SIC_BRAN  กับ  BRSTAT
      และ ทำการ Conncet database : gw_safe  &  gw_stat
          sic_bran  --->  
          brstat    --->  gw_stat
   2. DATABASE Local Connect ดังนี้ 
          bransafe --->  -ld  brsic_bran
          brstat   --->  -ld  brstat
*/

DEFINE INPUT-OUTPUT PARAMETER  sh_policy    AS CHAR FORMAT "X(16)" INIT 0.
DEFINE INPUT-OUTPUT PARAMETER  sh_rencnt    AS INT  FORMAT "999"   INIT 0.
DEFINE INPUT-OUTPUT PARAMETER  sh_endcnt    AS INT  FORMAT "999"   INIT 0. 
DEFINE INPUT-OUTPUT PARAMETER  nv_batchyr   AS INT  FORMAT "9999"  INIT 0.
DEFINE INPUT-OUTPUT PARAMETER  nv_batchno   AS CHAR FORMAT "X(13)" INIT ""  NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER  nv_batcnt    AS INT  FORMAT "99"    INIT 0.

def var nv_int as int.
def var nv_fptr as recid.
def var nv_bptr as recid.

def var putchr as char format "x(100)" init "" no-undo.

hide message no-pause.
/*message "Update mailtext_fil".*/

def  var nv_sic_bran   as inte init 0  no-undo.
def  var nv_host       as inte init 0  no-undo.

DEF VAR nv_driver AS CHARACTER FORMAT "X(23)" INITIAL "" NO-UNDO.

  FOR EACH brsic_bran.uwm130 WHERE
           brsic_bran.uwm130.policy = sh_policy AND
           brsic_bran.uwm130.rencnt = sh_rencnt AND
           brsic_bran.uwm130.endcnt = sh_endcnt
  NO-LOCK:

    nv_driver = TRIM(brsic_bran.uwm130.policy) +
                STRING(brsic_bran.uwm130.rencnt,"99" ) +
                STRING(brsic_bran.uwm130.endcnt,"999")  +
                STRING(brsic_bran.uwm130.riskno,"999") +
                STRING(brsic_bran.uwm130.itemno,"999").

    HIDE MESSAGE NO-PAUSE.
    /*MESSAGE "Search driver name" nv_driver.*/

    FIND FIRST brstat.mailtxt_fil USE-INDEX mailtxt01  WHERE
               brstat.mailtxt_fil.policy  = nv_driver  AND
               brstat.mailtxt_fil.lnumber = 1
    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE brstat.mailtxt_fil THEN DO:

      FIND FIRST gw_stat.mailtxt_fil USE-INDEX mailtxt01  WHERE
                 gw_stat.mailtxt_fil.policy  = nv_driver  AND
                 gw_stat.mailtxt_fil.lnumber = 1
      NO-LOCK NO-ERROR NO-WAIT.
      IF AVAILABLE gw_stat.mailtxt_fil THEN DO:

        FOR EACH gw_stat.mailtxt_fil USE-INDEX mailtxt01  WHERE
                 gw_stat.mailtxt_fil.policy  = nv_driver
        :
          DELETE gw_stat.mailtxt_fil.
        END.
      END.

      FOR EACH brstat.mailtxt_fil USE-INDEX mailtxt01 WHERE
               brstat.mailtxt_fil.policy = nv_driver  
      NO-LOCK:
         HIDE MESSAGE NO-PAUSE.
         /*MESSAGE "Create mailtxt_fil"
                 brstat.mailtxt_fil.policy. */

           FIND gw_stat.mailtxt_fil USE-INDEX mailtxt01 WHERE
                gw_stat.mailtxt_fil.policy  =  brstat.mailtxt_fil.policy  AND
                gw_stat.mailtxt_fil.lnumber =  brstat.mailtxt_fil.lnumber AND
                gw_stat.mailtxt_fil.ltext   =  brstat.mailtxt_fil.ltext   AND
                gw_stat.mailtxt_fil.ltext2  =  brstat.mailtxt_fil.ltext2  AND
                gw_stat.mailtxt_fil.bchyr   =  nv_batchyr                 AND
                gw_stat.mailtxt_fil.bchno   =  nv_batchno                 AND
                gw_stat.mailtxt_fil.bchcnt  =  nv_batcnt  
          NO-ERROR.
          IF NOT AVAILABLE gw_stat.mailtxt_fil THEN DO:
         
                 CREATE gw_stat.mailtxt_fil.
                 ASSIGN
                   gw_stat.mailtxt_fil.policy  =  brstat.mailtxt_fil.policy
                   gw_stat.mailtxt_fil.lnumber =  brstat.mailtxt_fil.lnumber
                   gw_stat.mailtxt_fil.ltext   =  brstat.mailtxt_fil.ltext
                   gw_stat.mailtxt_fil.ltext2  =  brstat.mailtxt_fil.ltext2
                   gw_stat.mailtxt_fil.bchyr   =  nv_batchyr 
                   gw_stat.mailtxt_fil.bchno   =  nv_batchno 
                   gw_stat.mailtxt_fil.bchcnt  =  nv_batcnt  .
          END. /*IF NOT AVAILABLE gw_stat.mailtxt_fil THEN DO:*/
      END.

    END.   /* AVAILABLE brstat.mailtxt_fil */
    ELSE DO:

      FOR EACH gw_stat.mailtxt_fil USE-INDEX mailtxt01  WHERE
               gw_stat.mailtxt_fil.policy  = nv_driver
      :
        DELETE gw_stat.mailtxt_fil.
      END.

    END.

  END.

/* END OF : WGWTBMAI.P */
