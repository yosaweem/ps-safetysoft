/*HO: GW_SAFE -LD SIC_BRAN,GW_STAT -LD BRSTAT,EXPIRY -LD SIC_EXP, SICSYAC, SICCL, STAT*/
/************************************************************************/
/* wgwrw100.p   Transfer Expiry to Gw_safe ,Gw_stat                     */
/* Dup Program  : uwr70130.p                                            */
/* Copyright	: Safety Insurance Public Company Limited 				*/
/*			  บริษัท ประกันคุ้มภัย จำกัด (มหาชน)					    */
/* CREATE BY	: Chaiyong W.   ASSIGN A61-0016 21/05/2018              */
/************************************************************************/
/*-----Expiry policy--------*/
DEF INPUT PARAMETER sh_policy AS CHARACTER FORMAT "X(12)" NO-UNDO.
DEF INPUT PARAMETER sh_rencnt AS INTEGER FORMAT "999".
DEF INPUT PARAMETER sh_endcnt AS INTEGER FORMAT "999".
/*-----Premium policy-------*/
DEF INPUT PARAMETER nw_policy AS CHARACTER FORMAT "X(12)" NO-UNDO.
DEF INPUT PARAMETER nw_rencnt AS INTEGER FORMAT "999".
DEF INPUT PARAMETER nw_endcnt AS INTEGER FORMAT "999".
DEF SHARED var sh_bchyr   AS INT INIT 0.    
DEF SHARED VAR sh_bchno   AS CHAR INIT "".  
DEF SHARED VAR sh_bchcnt  AS INT INIT 0. 
/*
DEF VAR sh_policy AS CHARACTER FORMAT "X(12)" NO-UNDO.
DEF VAR sh_rencnt AS INTEGER FORMAT "999".
DEF VAR sh_endcnt AS INTEGER FORMAT "999".
DEF VAR nw_policy AS CHARACTER FORMAT "X(12)" NO-UNDO.
DEF VAR nw_rencnt AS INTEGER FORMAT "999".
DEF VAR nw_endcnt AS INTEGER FORMAT "999".
*/
/*----*/
DEF VAR nv_driver AS CHARACTER FORMAT "X(23)" INITIAL "" NO-UNDO.
DEF VAR nw_driver AS CHARACTER FORMAT "X(23)" INITIAL "" NO-UNDO.

HIDE MESSAGE NO-PAUSE.
/*MESSAGE "Update mailtext_fil". */
/*
sh_policy = "DW7099002961".
sh_rencnt = 3.
sh_endcnt = 2.
nw_policy = "DW7044p00023".
nw_rencnt = 4.
nw_endcnt = 0.

find first sic_bran.uwm130 where 
           sic_bran.uwm130.policy = nw_policy AND
           sic_bran.uwm130.rencnt = nw_rencnt AND
           sic_bran.uwm130.endcnt = nw_endcnt no-lock no-error.
if avail sic_bran.uwm130 then do:
  disp nw_policy nw_rencnt nw_endcnt .
  pause 5 no-message.
end.
==*/

FOR EACH sic_bran.uwm130 WHERE
         sic_bran.uwm130.policy = nw_policy AND
         sic_bran.uwm130.rencnt = nw_rencnt AND
         sic_bran.uwm130.endcnt = nw_endcnt AND
         sic_bran.uwm130.bchyr  = sh_bchyr              AND
         sic_bran.uwm130.bchno  = sh_bchno              AND
         sic_bran.uwm130.bchcnt = sh_bchcnt           
NO-LOCK:
  nw_driver = TRIM(sic_bran.uwm130.policy) +
              STRING(sic_bran.uwm130.rencnt,"99" ) +
              STRING(sic_bran.uwm130.endcnt,"999") +
              STRING(sic_bran.uwm130.riskno,"999") +
              STRING(sic_bran.uwm130.itemno,"999").

  /*chk
  message color green/black "nw_driver:" nw_driver.
  pause 5 no-message.
  chk*/

  FOR EACH sic_exp.uwm130 WHERE
           sic_exp.uwm130.policy = sh_policy AND
           sic_exp.uwm130.rencnt = sh_rencnt AND
           sic_exp.uwm130.endcnt = sh_endcnt
  NO-LOCK:
    nv_driver = TRIM(sic_exp.uwm130.policy) +
                STRING(sic_exp.uwm130.rencnt,"99" ) +
                STRING(sic_exp.uwm130.endcnt,"999") +
                STRING(sic_exp.uwm130.riskno,"999") +
                STRING(sic_exp.uwm130.itemno,"999").
    /*chk
    message color green/black "nv_driver:" nv_driver.
    pause 5 no-message.
    chk*/


    HIDE MESSAGE NO-PAUSE.
    /*MESSAGE "Search driver name" nv_driver. */

    FIND FIRST sic_exp.s0m009 WHERE
               sic_exp.s0m009.key1  = nv_driver  AND
               INTEGER(sic_exp.s0m009.noseq) = 1
    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE sic_exp.s0m009 THEN DO:
      FOR EACH brstat.mailtxt_fil WHERE
               brstat.mailtxt_fil.policy = nw_driver AND
               brstat.mailtxt_fil.bchyr  = sh_bchyr  AND
               brstat.mailtxt_fil.bchno  = sh_bchno  AND
               brstat.mailtxt_fil.bchcnt = sh_bchcnt           


      :
        DELETE brstat.mailtxt_fil.
      END.

      FOR EACH sic_exp.s0m009 /* USE-INDEX mailtxt01 */ WHERE
               sic_exp.s0m009.key1 = nv_driver
      NO-LOCK:
         HIDE MESSAGE NO-PAUSE.
    /*     MESSAGE "Create mailtxt_fil"
                 brstat.mailtxt_fil.policy.*/

         CREATE brstat.mailtxt_fil.
         /*
         message color yel/black "create brstat.mailtxt_fil".
         pause 5 no-message.
         */
         ASSIGN
            brstat.mailtxt_fil.policy  = nw_driver /* sic_exp.s0m009.key1 */
            brstat.mailtxt_fil.lnumber = INTEGER(sic_exp.s0m009.noseq)
            brstat.mailtxt_fil.ltext   = sic_exp.s0m009.fld1
            brstat.mailtxt_fil.ltext2  = sic_exp.s0m009.fld2
            brstat.mailtxt_fil.bchyr  = sh_bchyr    
            brstat.mailtxt_fil.bchno  = sh_bchno    
            brstat.mailtxt_fil.bchcnt = sh_bchcnt   
             .

         /*-- Add A67-0029 --*/
         ASSIGN
             brstat.mailtxt_fil.drivbirth = sic_exp.s0m009.drivbirth  
             brstat.mailtxt_fil.drivage   = sic_exp.s0m009.drivage    
             brstat.mailtxt_fil.occupcod  = sic_exp.s0m009.occupcod   
             brstat.mailtxt_fil.occupdes  = sic_exp.s0m009.occupdes   
             brstat.mailtxt_fil.cardflg   = sic_exp.s0m009.cardflg    
             brstat.mailtxt_fil.drividno  = sic_exp.s0m009.drividno   
             brstat.mailtxt_fil.licenno   = sic_exp.s0m009.licenno    
             brstat.mailtxt_fil.drivnam   = sic_exp.s0m009.drivnam    
             brstat.mailtxt_fil.gender    = sic_exp.s0m009.gender     
             brstat.mailtxt_fil.drivlevel = sic_exp.s0m009.drivlevel  
             brstat.mailtxt_fil.levelper  = sic_exp.s0m009.levelper   
             brstat.mailtxt_fil.titlenam  = sic_exp.s0m009.titlenam   
             brstat.mailtxt_fil.licenexp  = sic_exp.s0m009.licenexp   
             brstat.mailtxt_fil.firstnam  = sic_exp.s0m009.firstnam   
             brstat.mailtxt_fil.lastnam   = sic_exp.s0m009.lastnam 
             brstat.mailtxt_fil.dconsen   = sic_exp.s0m009.dconsen
             brstat.mailtxt_fil.drivtxt1  = sic_exp.s0m009.drivtxt1
             brstat.mailtxt_fil.drivtxt2  = sic_exp.s0m009.drivtxt2.
         /*-- End Add A67-0029 --*/
      END.
    END.   /* AVAILABLE s0m009 */
    /*
    else do:
      message color red/yel "not avail s0m009".
    end.
    */

  END.        /* sic_exp.uwm130 */

END.   /* sic_bran.uwm130 */
/* END OF : CVMAIL.P */
