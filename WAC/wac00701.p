/* WACPMDE.P  :  uzx00701.p  Premium for profit center report (Summary) */
/* create by  :  B.Phattranit  on 25/05/05  A48-0268                */
/* connect    :  stat, sic_test, sicfn                              */
/*------------------------------------------------------------------
 Modify By : TANTAWAN C.   09/01/2008   [A500178]
             ปรับ FORMAT branch เพื่อรองรับการขยายสาขา
--------------------------------------------------------------------*/
/**************************************************************/
{wac\wac00700.i}

/*--jeab
DEF INPUT PARAMETER      n_JV        AS  LOGICAL.
DEF INPUT PARAMETER      n_source    AS  CHAR         FORMAT   "X(2)".
DEF INPUT PARAMETER      nv_dir2     AS  LOGICAL      FORMAT   "D/R".
----*/

DEF INPUT PARAMETER fr_trndat AS DATE FORMAT "99/99/9999".
DEF INPUT parameter to_trndat AS DATE FORMAT "99/99/9999".
DEF INPUT PARAMETER nv_output AS CHAR FORMAT "X(25)".
DEF INPUT parameter nv_typ    AS INT  FORMAT "9"  .


DEF NEW SHARED VAR  n_poltyp  AS CHAR FORMAT "X(2)".
DEF NEW SHARED VAR  nv_JV     AS LOGICAL.

DEF VAR nv_row       AS INT  INIT 0.
DEF VAR nv_poldesc   AS CHAR INIT "".
DEF VAR nv_grptyp    AS CHAR INIT "".
DEF VAR nv_policytyp AS CHAR INIT "".

DEF    STREAM ns1.
/*--- A500178 ---*/
DEF VAR nv_dir    AS CHAR FORMAT "X(1)".
DEF VAR nv_branch LIKE uwm100.branch.
DEF VAR nv_line   AS CHAR FORMAT "X(2)".
/*--- A500178 ---*/

DEF WORKFILE   work_fil
    /*--- A500178 ---*/
    FIELD  wdir      AS CHAR FORMAT "X(1)"  COLUMN-LABEL "DIR"
    FIELD  wline     AS CHAR FORMAT "X(2)"  COLUMN-LABEL "poltyp"
    FIELD  wbranch   LIKE  uwm100.branch    COLUMN-LABEL "Branch"
    /*--- A500178 ---*/
    FIELD  wbrn_line as char format "x(10)" COLUMN-LABEL "Line"
    FIELD  poltyp    LIKE  uwm100.poltyp    COLUMN-LABEL "poltyp"
    FIELD  wsigr     like  uwm100.sigr_p    COLUMN-LABEL "SumInsured"
    FIELD  wprem     like  uwm100.prem_t    COLUMN-LABEL "PremTotal"
    FIELD  wstat     like  uwd200.ripr  COLUMN-LABEL "Qbaht"
    FIELD  wret      like  uwd200.ripr  COLUMN-LABEL "PR_RETEN"
    FIELD  w0q       like  uwd200.ripr  COLUMN-LABEL "PR_TFP"
    FIELD  w0t       like  uwd200.ripr  COLUMN-LABEL "PR_1st"
    FIELD  w0s       like  uwd200.ripr  COLUMN-LABEL "PR_2nd"
    FIELD  wf1       like  uwd200.ripr  COLUMN-LABEL "PR_F1"
    FIELD  wf2       like  uwd200.ripr  COLUMN-LABEL "PR_F2"
    FIELD  wf3       like  uwd200.ripr  COLUMN-LABEL "PR_F3"
    FIELD  wf4       like  uwd200.ripr  COLUMN-LABEL "PR_F4" 
    FIELD  w0rq      like  uwd200.ripr  COLUMN-LABEL "PR_Q/S"
    FIELD  w0ps      like  uwd200.ripr  COLUMN-LABEL "PR_MPS"
    FIELD  wbtr      like  uwd200.ripr  COLUMN-LABEL "PR_BTR"
    FIELD  wotr      like  uwd200.ripr  COLUMN-LABEL "PR_OTR"
    FIELD  wftr      like  uwd200.ripr  COLUMN-LABEL "PR_FTR"
    FIELD  ws8       like  uwd200.ripr  COLUMN-LABEL "PR_S8"
    FIELD  wother    like  uwd200.ripr  COLUMN-LABEL "PR_OTHER"

    FIELD  wpstat    like  uwm200.rip1  COLUMN-LABEL "%Qbath"
    FIELD  wpret     like  uwm200.rip1  COLUMN-LABEL "%RETEN"
    FIELD  wp0q      like  uwm200.rip1  COLUMN-LABEL "%TFP"
    FIELD  wp0t      like  uwm200.rip1  COLUMN-LABEL "%1st"
    FIELD  wp0s      like  uwm200.rip1  COLUMN-LABEL "%2nd"
    FIELD  wpf1      like  uwm200.rip1  COLUMN-LABEL "%F1"
    FIELD  wpf2      like  uwm200.rip1  COLUMN-LABEL "%F2"
    FIELD  wpf3      like  uwm200.rip1  COLUMN-LABEL "%F3"
    FIELD  wpf4      like  uwm200.rip1  COLUMN-LABEL "%F4"
    FIELD  wp0rq     like  uwm200.rip1  COLUMN-LABEL "%Q/S"
    FIELD  wp0ps     like  uwm200.rip1  COLUMN-LABEL "%MPS"
    FIELD  wpbtr     like  uwm200.rip1  COLUMN-LABEL "%BTR"
    FIELD  wpotr     like  uwm200.rip1  COLUMN-LABEL "%OTR"
    FIELD  wpftr     like  uwm200.rip1  COLUMN-LABEL "%FTR"
    FIELD  wps8      like  uwm200.rip1  COLUMN-LABEL "%S8"
    FIELD  wpother   like  uwm200.rip1  COLUMN-LABEL "%OTHER"

    FIELD  wccom     like  uwm100.coty_t   COLUMN-LABEL "ComTotat"
    FIELD  wcstat    like  uwd200.ric1  COLUMN-LABEL "COM_Qbaht"
    FIELD  wcret     like  uwd200.ric1  COLUMN-LABEL "COM_RETEN"
    FIELD  wc0q      like  uwd200.ric1  COLUMN-LABEL "COM_TFP"
    FIELD  wc0t      like  uwd200.ric1  COLUMN-LABEL "COM_1st"
    FIELD  wc0s      like  uwd200.ric1  COLUMN-LABEL "COM_2nd"
    FIELD  wcf1      like  uwd200.ric1  COLUMN-LABEL "COM_F1"
    FIELD  wcf2      like  uwd200.ric1  COLUMN-LABEL "COM_F2"
    FIELD  wcf3      like  uwd200.ric1  COLUMN-LABEL "COM_F3"
    FIELD  wcf4      like  uwd200.ric1  COLUMN-LABEL "COM_F4" 
    FIELD  wc0rq     like  uwd200.ric1  COLUMN-LABEL "COM_Q/S"
    FIELD  wc0ps     like  uwd200.ric1  COLUMN-LABEL "COM_MPS"
    FIELD  wcbtr     like  uwd200.ric1  COLUMN-LABEL "COM_BTR"
    FIELD  wcotr     like  uwd200.ric1  COLUMN-LABEL "COM_OTR"
    FIELD  wcftr     like  uwd200.ric1  COLUMN-LABEL "COM_FTR"
    FIELD  wcs8      like  uwd200.ric1  COLUMN-LABEL "COM_S8"
    FIELD  wcother   like  uwd200.ric1  COLUMN-LABEL "COM_OTHER".

/*
ASSIGN
    nv_JV       = n_JV 
    n_gldat     = to_trndat.
 */   

/* nv_time = STRING (TIME,"HH:MM"). */

OUTPUT STREAM ns1  TO VALUE(nv_output).
PUT    STREAM ns1  "ID;PND"  SKIP.
  
nv_row = nv_row + 1.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K"   '"' "Branch"        '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X2;K"   '"' "Policy Type"   '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X3;K"   '"' "Policy Desc."  '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X4;K"   '"' "Group Type"    '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X5;K"   '"' "Inward/Direct" '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X6;K"   '"' "Sum Insured"   '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X7;K"   '"' "เบี้ยประกันภัยรวม"      '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X8;K"   '"' "ค่านายหน้าประกันภัยรวม" '"'   SKIP.

PUT STREAM ns1 "C;Y" STRING(nv_row) ";X10;K"   '"' "เบี้ย RET"   '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X11;K"   '"' "%RET"        '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X12;K"   '"' "คอม RET"     '"'   SKIP.

PUT STREAM ns1 "C;Y" STRING(nv_row) ";X14;K"   '"' "เบี้ย Qbaht" '"'   SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X15;K"   '"' "%Qbaht"      '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X16;K"  '"' "คอม Qbaht"    '"'   SKIP.

PUT STREAM ns1 "C;Y" STRING(nv_row) ";X18;K"  '"' "เบี้ย 1ST"    '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X19;K"  '"' "%1ST"         '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X20;K"  '"' "คอม 1ST"      '"'   SKIP.

PUT STREAM ns1 "C;Y" STRING(nv_row) ";X22;K"  '"' "เบี้ย 2ND"    '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X23;K"  '"' "%2ND"         '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X24;K"  '"' "คอม 2ND"      '"'   SKIP. 

PUT STREAM ns1 "C;Y" STRING(nv_row) ";X26;K"  '"' "เบี้ย TFP"    '"'   SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X27;K"  '"' "%TFP"         '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X28;K"  '"' "คอม TFP"      '"'   SKIP.

PUT STREAM ns1 "C;Y" STRING(nv_row) ";X30;K"  '"' "เบี้ย FO1"    '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X31;K"  '"' "%FO1"         '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X32;K"  '"' "คอม FO1"      '"'   SKIP.

PUT STREAM ns1 "C;Y" STRING(nv_row) ";X34;K"  '"' "เบี้ย FO2"    '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X35;K"  '"' "%FO2"         '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X36;K"  '"' "คอม FO2"      '"'   SKIP.

PUT STREAM ns1 "C;Y" STRING(nv_row) ";X38;K"   '"'"เบี้ย FO3"    '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X39;K"   '"'"%FO3"         '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X40;K"   '"'"คอม FO3"      '"'   SKIP.

PUT STREAM ns1 "C;Y" STRING(nv_row) ";X42;K"   '"'"เบี้ย FO4"    '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X43;K"   '"'"%FO4"         '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X44;K"   '"'"คอม FO4"      '"'   SKIP.

PUT STREAM ns1 "C;Y" STRING(nv_row) ";X46;K"   '"'"เบี้ย Q/S"    '"'   SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X47;K"   '"'"%Q/S"         '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X48;K"   '"'"คอม Q/S"      '"'   SKIP.

PUT STREAM ns1 "C;Y" STRING(nv_row) ";X50;K"  '"' "เบี้ย MPS"    '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X51;K"  '"' "%MPS"         '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X52;K"  '"' "คอม MPS"      '"'   SKIP.

PUT STREAM ns1 "C;Y" STRING(nv_row) ";X54;K"  '"' "เบี้ย BTR"    '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X55;K"  '"' "%BTR"         '"'   SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X56;K"  '"' "คอม BTR"      '"'   SKIP. 

PUT STREAM ns1 "C;Y" STRING(nv_row) ";X58;K"  '"' "เบี้ย OTR"    '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X59;K"  '"' "%OTR"         '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X60;K"  '"' "คอม OTR"      '"'   SKIP.

PUT STREAM ns1 "C;Y" STRING(nv_row) ";X62;K"  '"' "เบี้ย FTR"    '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X63;K"  '"' "%FTR"         '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X64;K"  '"' "คอม FTR"      '"'   SKIP.

PUT STREAM ns1 "C;Y" STRING(nv_row) ";X66;K"  '"' "เบี้ย S8"     '"'   SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X67;K"  '"' "%S8"          '"'   SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X68;K"  '"' "คอม S8"       '"'   SKIP.

PUT STREAM ns1 "C;Y" STRING(nv_row) ";X70;K"  '"' "เบี้ย OTHER"  '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X71;K"  '"' "%OTHER"       '"'   SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row) ";X72;K"  '"' "คอม OTHER"    '"'   SKIP.

FOR EACH uwm100  NO-LOCK  USE-INDEX uwm10008  WHERE
         uwm100.trndat >= fr_trndat   and
         uwm100.trndat <= to_trndat   and
         /*--jeab
         uwm100.poltyp <> "V70"       and
         uwm100.poltyp <> "V72"       and
         uwm100.poltyp <> "V73"       and
         uwm100.poltyp <> "V74"       and
          ----*/
         uwm100.releas  = YES         .

         /*  jeab
         uwm100.dir_ri  = nv_dir2     and
         (SUBSTR(uwm100.policy,1,1) = "D" OR SUBSTR(uwm100.policy,1,1) = "I") AND
         uwm100.endcnt  = 000.
         */
         
        IF nv_typ = 2 THEN DO: /* non-motor all not 30,01 */
           IF (uwm100.poltyp  = "V70"  OR   /* Check Policy Type */
               uwm100.poltyp  = "V72"  OR
               uwm100.poltyp  = "V73"  OR  /* CMIP  */
               uwm100.poltyp  = "V74"  OR  /* CMIP  */
               uwm100.poltyp  = "M30"  OR  /* CMIP  */
               uwm100.poltyp  = "M01"  OR  /* CMIP  */
               uwm100.poltyp  = "   ") THEN NEXT.
        END.
        ELSE IF nv_typ = 3 THEN DO:  /* 30,01 */
            IF (uwm100.poltyp <>  "M01"  AND
                uwm100.poltyp <>  "M30") THEN NEXT.
        END.
        ELSE DO:   /* motor */
            IF (uwm100.poltyp <> "V70"  and  /* Check Policy Type */
               uwm100.poltyp  <> "V72"  and
               uwm100.poltyp  <> "V73"  and  /* CMIP  */
               uwm100.poltyp  <> "V74" )  /* CMIP  */  THEN NEXT.
        END.

         /*--- A500178 ---
         nv_brn_line    = substr(uwm100.policy,1,1) + "-" +
                          substr(uwm100.policy,2,1) + "-" +
                          substr(uwm100.policy,3,2).
        ------*/
        /* D-00-70 */
        IF SUBSTRING(uwm100.policy,1,1) = "D" OR /* branch 2 หลัก */
           SUBSTRING(uwm100.policy,1,1) = "I" THEN DO:

            ASSIGN
               nv_dir    = CAPS(SUBSTRING(uwm100.policy,1,1))
               nv_branch = "0" + SUBSTRING(uwm100.policy,2,1)
               nv_line   = SUBSTRING(uwm100.policy,3,2).

        END.
        /* D-10-70 */
        ELSE  /* branch 2 หลัก */
            ASSIGN
               nv_dir    = "D"
               nv_branch = SUBSTRING(uwm100.policy,1,2)
               nv_line   = SUBSTRING(uwm100.policy,3,2).


         nv_brn_line = nv_dir + "-" +
                       CAPS(nv_branch) + "-" +
                       nv_line.
        /*---- A500178 ---*/

        nv_policytyp   = uwm100.poltyp.
        

        ASSIGN
          nt_sigr = nt_sigr + uwm100.sigr_p
          nt_prem = nt_prem + uwm100.prem_t
          nt_com  = nt_com  + uwm100.com1_t.
        
        FOR EACH uwd200 USE-INDEX uwd20001 WHERE
                 uwd200.policy = uwm100.policy AND
                 uwd200.rencnt = uwm100.rencnt AND
                 uwd200.endcnt = uwm100.endcnt AND
                 uwd200.csftq  <> "C" 
        NO-LOCK.

            /*
            DISP  uwm100.trndat uwm100.policy substr(uwm100.policy,3,2)
            substr(uwm100.policy,2,1)  uwd200.rico with frame a CENTERED.
            PAUSE 0.
            */
            DISP "Process policy : " uwm100.policy WITH COLOR BLACK/WHITE NO-LABEL  
            TITLE "PROCESS..." WIDTH 50 FRAME BMain VIEW-AS DIALOG-BOX.

            IF uwd200.rico  = "STAT"  THEN  DO:  /* Qbaht */
                 ASSIGN
                    nt_stat_pr = nt_stat_pr + uwd200.ripr
                    nt_stat_co = nt_stat_co + uwd200.ric1.
                 
                 FIND FIRST uwm200 USE-INDEX uwm20001 WHERE  /*----------find % Comm จากTable uwm200-------*/
                            uwm200.policy = uwd200.policy AND
                            uwm200.rencnt = uwd200.rencnt AND
                            uwm200.endcnt = uwd200.endcnt AND
                            uwm200.csftq  = uwd200.csftq  AND
                            uwm200.rico   = uwd200.rico   AND
                            uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                 IF  AVAIL uwm200  THEN
                     nt_stat_per  = uwm200.rip1.
                /*------------------Gen JV----------------jeab
                 IF nv_JV = YES THEN DO:
                 n_poltyp = SUBSTR(uwm100.poltyp,2,2).  /*บันทึก AZR516-*/
                 
                 RUN uz/uzx00702 (INPUT n_poltyp, nt_stat_pr, nt_stat_co, nv_JV,
                                  nv_dir2, n_source, n_gldat).

                END.
                 ----------------------------------------*/     
             END.

             ELSE IF    uwd200.rico  = "0RET"  THEN DO:       /*-----------ไม่ต้อง Gen JV----------*/
                 ASSIGN
                    nt_ret_pr = nt_ret_pr + uwd200.ripr
                    nt_ret_co = nt_ret_co + uwd200.ric1.

                 FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                            uwm200.policy = uwd200.policy AND
                            uwm200.rencnt = uwd200.rencnt AND
                            uwm200.endcnt = uwd200.endcnt AND
                            uwm200.csftq  = uwd200.csftq  AND
                            uwm200.rico   = uwd200.rico   AND
                            uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                 IF  AVAIL uwm200  THEN
                     nt_ret_per  = uwm200.rip1.
             END.

             ELSE IF    SUBSTRING(uwd200.rico,1,2) = "0Q"  THEN DO: /* TFP */
                  ASSIGN
                    nt_0q_pr = nt_0q_pr  + uwd200.ripr
                    nt_0q_co = nt_0q_co  + uwd200.ric1.

                  FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                             uwm200.policy = uwd200.policy AND
                             uwm200.rencnt = uwd200.rencnt AND
                             uwm200.endcnt = uwd200.endcnt AND
                             uwm200.csftq  = uwd200.csftq  AND
                             uwm200.rico   = uwd200.rico   AND
                             uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                  IF  AVAIL uwm200  THEN
                      nt_0q_per  = uwm200.rip1.
                 /*------------------Gen JV----------------jeab
                  ASSIGN
                  n_poltyp = SUBSTR(uwm100.poltyp,2,2).  /*บันทึก AZR516-*/
                  
                  RUN uz/uzx00702 (INPUT n_poltyp, nt_0q_pr, nt_0q_co, nv_JV,
                                   nv_dir2, n_source, n_gldat).

                  ----------------------------------------*/     
             END.

             ELSE IF    SUBSTRING(uwd200.rico,1,2) = "0T"  AND          
                        SUBSTRING(uwd200.rico,6,2) = "01"  THEN DO:          /*--1ST--*/
                   ASSIGN
                      nt_0t_pr = nt_0t_pr + uwd200.ripr
                      nt_0t_co = nt_0t_co + uwd200.ric1.

                   FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                              uwm200.policy = uwd200.policy AND
                              uwm200.rencnt = uwd200.rencnt AND
                              uwm200.endcnt = uwd200.endcnt AND
                              uwm200.csftq  = uwd200.csftq  AND
                              uwm200.rico   = uwd200.rico   AND
                              uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                   IF  AVAIL uwm200  THEN
                       nt_0t_per  = uwm200.rip1.
                   /*------------------Gen JV----------------jeab
                   ASSIGN
                   n_poltyp = SUBSTR(uwm100.poltyp,2,2).  /*บันทึก AZR516-*/
                   
                   RUN uz/uzx00703 (INPUT n_poltyp, nt_0t_pr, nt_0t_co, nv_JV,
                                    nv_dir2, n_source, n_gldat).

                   ----------------------------------------*/          
             END.
           
             ELSE IF    SUBSTRING(uwd200.rico,1,2) = "0T"  AND
                        SUBSTRING(uwd200.rico,6,2) = "02"  THEN DO:         /*--2ND--*/
                  ASSIGN
                    nt_0s_pr = nt_0s_pr + uwd200.ripr
                    nt_0s_co = nt_0s_co + uwd200.ric1.

                  FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                             uwm200.policy = uwd200.policy AND
                             uwm200.rencnt = uwd200.rencnt AND
                             uwm200.endcnt = uwd200.endcnt AND
                             uwm200.csftq  = uwd200.csftq  AND
                             uwm200.rico   = uwd200.rico   AND
                             uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                  IF  AVAIL uwm200  THEN
                      nt_0s_per  = uwm200.rip1.
                  /*------------------Gen JV----------------jeab
                  ASSIGN
                  n_poltyp = SUBSTR(uwm100.poltyp,2,2).  /*บันทึก AZR516-*/
                  
                  RUN uz/uzx00704 (INPUT n_poltyp, nt_0s_pr, nt_0s_co, nv_JV,
                                   nv_dir2, n_source, n_gldat).

                  ----------------------------------------*/             
             END.

             ELSE IF    SUBSTRING(uwd200.rico,1,2) = "0T"  AND
                        SUBSTRING(uwd200.rico,6,2) = "F1"  THEN DO:
                  ASSIGN
                    nt_f1_pr = nt_f1_pr + uwd200.ripr
                    nt_f1_co = nt_f1_co + uwd200.ric1.

                  FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                             uwm200.policy = uwd200.policy AND
                             uwm200.rencnt = uwd200.rencnt AND
                             uwm200.endcnt = uwd200.endcnt AND
                             uwm200.csftq  = uwd200.csftq  AND
                             uwm200.rico   = uwd200.rico   AND
                             uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                  IF  AVAIL uwm200  THEN
                      nt_f1_per  = uwm200.rip1.
                  /*------------------Gen JV----------------jeab
                  n_poltyp = SUBSTR(uwm100.poltyp,2,2).  /*บันทึก AZR516-*/
                  
                  RUN uz/uzx00705 (INPUT n_poltyp, nt_f1_pr, nt_f1_co, nv_JV,
                                   nv_dir2, n_source, n_gldat).

                  ----------------------------------------*/        
             END.                              

             ELSE IF    SUBSTRING(uwd200.rico,1,2) = "0T"  AND
                        SUBSTRING(uwd200.rico,6,2) = "F2"  THEN DO:
                   ASSIGN
                     nt_f2_pr = nt_f2_pr + uwd200.ripr
                     nt_f2_co = nt_f2_co + uwd200.ric1.

                   FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                              uwm200.policy = uwd200.policy AND
                              uwm200.rencnt = uwd200.rencnt AND
                              uwm200.endcnt = uwd200.endcnt AND
                              uwm200.csftq  = uwd200.csftq  AND
                              uwm200.rico   = uwd200.rico   AND
                              uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                   IF  AVAIL uwm200  THEN
                       nt_f2_per  = uwm200.rip1.
                   /*------------------Gen JV----------------jeab
                   ASSIGN
                   n_poltyp = SUBSTR(uwm100.poltyp,2,2).  /*บันทึก AZR516-*/
                   
                   RUN uz/uzx00706 (INPUT n_poltyp, nt_f2_pr, nt_f2_co, nv_JV,
                                        nv_dir2, n_source, n_gldat).
                   
                   ----------------------------------------*/             
             END.

             ELSE IF    SUBSTRING(uwd200.rico,1,2) = "0T"  AND
                        SUBSTRING(uwd200.rico,6,2) = "F3"  THEN DO:
                   ASSIGN
                     nt_f3_pr = nt_f3_pr + uwd200.ripr
                     nt_f3_co = nt_f3_co + uwd200.ric1.

                   FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                              uwm200.policy = uwd200.policy AND
                              uwm200.rencnt = uwd200.rencnt AND
                              uwm200.endcnt = uwd200.endcnt AND
                              uwm200.csftq  = uwd200.csftq  AND
                              uwm200.rico   = uwd200.rico   AND
                              uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                   IF  AVAIL uwm200  THEN
                       nt_f3_per  = uwm200.rip1.
                   /*------------------Gen JV----------------jeab
                   ASSIGN
                   n_poltyp = SUBSTR(uwm100.poltyp,2,2).  /*บันทึก AZR516-*/
                   
                   RUN uz/uzx00706 (INPUT n_poltyp, nt_f3_pr, nt_f3_co, nv_JV,
                                        nv_dir2, n_source, n_gldat).
                   ----------------------------------------*/                    
             END.
                        
             ELSE IF    SUBSTRING(uwd200.rico,1,2) = "0T"  AND   /* A450055*/
                        SUBSTRING(uwd200.rico,6,2) = "F4"  THEN DO:
                    ASSIGN
                      nt_f4_pr = nt_f4_pr + uwd200.ripr
                      nt_f4_co = nt_f4_co + uwd200.ric1.

                    FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                               uwm200.policy = uwd200.policy AND
                               uwm200.rencnt = uwd200.rencnt AND
                               uwm200.endcnt = uwd200.endcnt AND
                               uwm200.csftq  = uwd200.csftq  AND
                               uwm200.rico   = uwd200.rico   AND
                               uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                    IF  AVAIL uwm200  THEN
                        nt_f4_per  = uwm200.rip1.
                   /*------------------Gen JV----------------jeab
                    ASSIGN
                    n_poltyp = SUBSTR(uwm100.poltyp,2,2).  /*บันทึก AZR516-*/
                    

                    RUN uz/uzx00706 (INPUT n_poltyp, nt_f4_pr, nt_f4_co, nv_JV,
                                         nv_dir2, n_source, n_gldat).
                    ----------------------------------------*/                 
             END.
         
             ELSE IF    SUBSTRING(uwd200.rico,1,3) = "0RQ" THEN DO:
                   ASSIGN
                     nt_0rq_pr = nt_0rq_pr + uwd200.ripr
                     nt_0rq_co = nt_0rq_co + uwd200.ric1.

                   FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                              uwm200.policy = uwd200.policy AND
                              uwm200.rencnt = uwd200.rencnt AND
                              uwm200.endcnt = uwd200.endcnt AND
                              uwm200.csftq  = uwd200.csftq  AND
                              uwm200.rico   = uwd200.rico   AND
                              uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                   IF  AVAIL uwm200  THEN
                       nt_0rq_per  = uwm200.rip1.
                  /*------------------Gen JV----------------jeab
                   ASSIGN
                   n_poltyp = SUBSTR(uwm100.poltyp,2,2).  /*บันทึก AZR516-*/
                   
                   RUN uz/uzx00704 (INPUT n_poltyp, nt_0rq_pr, nt_0rq_co, nv_JV,
                                        nv_dir2, n_source, n_gldat).
                   ----------------------------------------*/                     
             END.

             ELSE IF    SUBSTRING(uwd200.rico,1,3) = "0PS" THEN DO:            /*--MPS--*/
                  ASSIGN
                    nt_0ps_pr = nt_0ps_pr + uwd200.ripr
                    nt_0ps_co = nt_0ps_co + uwd200.ric1.

                  FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                             uwm200.policy = uwd200.policy AND
                             uwm200.rencnt = uwd200.rencnt AND
                             uwm200.endcnt = uwd200.endcnt AND
                             uwm200.csftq  = uwd200.csftq  AND
                             uwm200.rico   = uwd200.rico   AND
                             uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                  IF  AVAIL uwm200  THEN
                      nt_0ps_per  = uwm200.rip1.
                  /*------------------Gen JV----------------jeab
                  ASSIGN
                  n_poltyp = SUBSTR(uwm100.poltyp,2,2).  /*บันทึก AZR516-*/
                  
                  RUN uz/uzx00706 (INPUT n_poltyp, nt_0ps_pr, nt_0ps_co, nv_JV,
                                       nv_dir2, n_source, n_gldat).
                  ----------------------------------------*/        
             END.

             ELSE IF    SUBSTRING(uwd200.rico,1,3) = "0TF"  AND
                        SUBSTRING(uwd200.rico,6,2) = "FB"  THEN DO:
                   ASSIGN
                     nt_btr_pr = nt_btr_pr + uwd200.ripr
                     nt_btr_co = nt_btr_co + uwd200.ric1.

                   FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                              uwm200.policy = uwd200.policy AND
                              uwm200.rencnt = uwd200.rencnt AND
                              uwm200.endcnt = uwd200.endcnt AND
                              uwm200.csftq  = uwd200.csftq  AND
                              uwm200.rico   = uwd200.rico   AND
                              uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                   IF  AVAIL uwm200  THEN
                       nt_btr_per  = uwm200.rip1.
                  /*------------------Gen JV----------------jeab
                   ASSIGN
                   n_poltyp = SUBSTR(uwm100.poltyp,2,2).  /*บันทึก AZR516-*/

                   RUN uz/uzx00706 (INPUT n_poltyp, nt_btr_pr, nt_btr_co, nv_JV,
                                        nv_dir2, n_source, n_gldat).
                   ----------------------------------------*/        
             END.

             ELSE IF    SUBSTRING(uwd200.rico,1,3) = "0TF"  AND
                        SUBSTRING(uwd200.rico,6,2) = "FO"  THEN DO:
                  ASSIGN
                    nt_otr_pr = nt_otr_pr + uwd200.ripr
                    nt_otr_co = nt_otr_co + uwd200.ric1.

                  FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                             uwm200.policy = uwd200.policy AND
                             uwm200.rencnt = uwd200.rencnt AND
                             uwm200.endcnt = uwd200.endcnt AND
                             uwm200.csftq  = uwd200.csftq  AND
                             uwm200.rico   = uwd200.rico   AND
                             uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                  IF  AVAIL uwm200  THEN
                      nt_otr_per  = uwm200.rip1.
                  /*------------------Gen JV----------------jeab
                  ASSIGN
                  n_poltyp = SUBSTR(uwm100.poltyp,2,2).  /*บันทึก AZR516-*/

                  RUN uz/uzx00706 (INPUT n_poltyp, nt_otr_pr, nt_otr_co, nv_JV,
                                       nv_dir2, n_source, n_gldat).
                  ----------------------------------------*/     
             END.

             ELSE IF    SUBSTRING(uwd200.rico,1,3) = "0TF"  AND   /* A450055*/
                        SUBSTRING(uwd200.rico,6,2) = "FT"  THEN DO:
                  ASSIGN
                    nt_ftr_pr = nt_ftr_pr + uwd200.ripr
                    nt_ftr_co = nt_ftr_co + uwd200.ric1.

                  FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                             uwm200.policy = uwd200.policy AND
                             uwm200.rencnt = uwd200.rencnt AND
                             uwm200.endcnt = uwd200.endcnt AND
                             uwm200.csftq  = uwd200.csftq  AND
                             uwm200.rico   = uwd200.rico   AND
                             uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                  IF  AVAIL uwm200  THEN
                      nt_ftr_per  = uwm200.rip1.
                  /*------------------Gen JV----------------jeab
                  ASSIGN
                  n_poltyp = SUBSTR(uwm100.poltyp,2,2).  /*บันทึก AZR516-*/
                  
                  RUN uz/uzx00706 (INPUT n_poltyp, nt_ftr_pr, nt_ftr_co, nv_JV,
                                       nv_dir2, n_source, n_gldat).
                  ----------------------------------------*/      
             END.

             ELSE IF    SUBSTRING(uwd200.rico,1,4) = "0TA8"  AND               /*----ยกเลิก---*/                      
                        SUBSTRING(uwd200.rico,7,1) = "2"  THEN DO:
                  ASSIGN
                    nt_s8_pr = nt_s8_pr + uwd200.ripr
                    nt_s8_co = nt_s8_co + uwd200.ric1.

                  FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                             uwm200.policy = uwd200.policy AND
                             uwm200.rencnt = uwd200.rencnt AND
                             uwm200.endcnt = uwd200.endcnt AND
                             uwm200.csftq  = uwd200.csftq  AND
                             uwm200.rico   = uwd200.rico   AND
                             uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                  IF  AVAIL uwm200  THEN
                      nt_s8_per  = uwm200.rip1.
               /*   /*------------------Gen JV----------------jeab
                  ASSIGN
                  n_poltyp = SUBSTR(uwm100.poltyp,2,2).  /*บันทึก AZR516-*/
                  RUN uz/uzx00716 (INPUT n_poltyp, nt_s8_pr, nt_s8_co, nv_JV,
                                       nv_dir2, n_source, n_gldat).
                  ----------------------------------------*/         */
             END.

             ELSE  DO:
                 ASSIGN
                    nt_other_pr  = nt_other_pr + uwd200.ripr
                    nt_other_co  = nt_other_co + uwd200.ric1.

                 FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                            uwm200.policy = uwd200.policy AND
                            uwm200.rencnt = uwd200.rencnt AND
                            uwm200.endcnt = uwd200.endcnt AND
                            uwm200.csftq  = uwd200.csftq  AND
                            uwm200.rico   = uwd200.rico   AND
                            uwm200.c_enct = uwd200.c_enct  NO-LOCK  NO-ERROR.
                  IF  AVAIL uwm200  THEN
                      nt_other_per  = uwm200.rip1.
                 /*------------------Gen JV----------------
                  ASSIGN
                  n_poltyp = SUBSTR(uwm100.poltyp,2,2).  /*บันทึก AZR516-*/
                  RUN uz/uzx00705 (INPUT n_poltyp, nt_other_pr, nt_other_co, nv_JV,
                                         nv_dir2, n_source, n_gldat).
                 ---------------------------------------*/          
             END.
             
        END.   /*each uwd200 */

        FIND  FIRST work_fil  WHERE       /* D-00-70 , D-10-70 */
                   work_fil.wbrn_line   = nv_brn_line NO-ERROR.
        IF  NOT AVAIL work_fil  THEN
            CREATE  work_fil.
            ASSIGN  
                 work_fil.wbrn_line  = nv_brn_line
                 work_fil.poltyp     = nv_policytyp
                 /*--- A500178 ---*/
                 work_fil.wdir    = nv_dir
                 work_fil.wline   = nv_line
                 work_fil.wbranch = CAPS(uwm100.branch)
                 /*--- A500178 ---*/
              
/*--Premium--*/  work_fil.wsigr  = work_fil.wsigr + nt_sigr
                 work_fil.wprem  = work_fil.wprem + nt_prem
                 work_fil.wstat  = work_fil.wstat + nt_stat_pr
                 work_fil.wret   = work_fil.wret  + nt_ret_pr
                 work_fil.w0q    = work_fil.w0q   + nt_0q_pr
                 work_fil.w0t    = work_fil.w0t   + nt_0t_pr
                 work_fil.w0s    = work_fil.w0s   + nt_0s_pr
                 work_fil.wf1    = work_fil.wf1   + nt_f1_pr
                 work_fil.wf2    = work_fil.wf2   + nt_f2_pr
                 work_fil.wf3    = work_fil.wf3   + nt_f3_pr
                 work_fil.wf4    = work_fil.wf4   + nt_f4_pr 
                 work_fil.w0rq   = work_fil.w0rq  + nt_0rq_pr
                 work_fil.w0ps   = work_fil.w0ps  + nt_0ps_pr
                 work_fil.wbtr   = work_fil.wbtr  + nt_btr_pr
                 work_fil.wotr   = work_fil.wotr  + nt_otr_pr
                 work_fil.wftr   = work_fil.wftr  + nt_ftr_pr
                 work_fil.ws8    = work_fil.ws8   + nt_s8_pr   
                 work_fil.wother = work_fil.wother + nt_other_pr
/*-------------*/                   

/*--% Comm --*/  work_fil.wpstat = nt_stat_per
                 work_fil.wpret  = nt_ret_per
                 work_fil.wp0q   = nt_0q_per
                 work_fil.wp0t   = nt_0t_per
                 work_fil.w0s    = nt_0s_per
                 work_fil.wpf1   = nt_f1_per
                 work_fil.wpf2   = nt_f2_per
                 work_fil.wpf3   = nt_f3_per
                 work_fil.wpf4   = nt_f4_per
                 work_fil.wp0rq  = nt_0rq_per
                 work_fil.wp0ps  = nt_0ps_per
                 work_fil.wpbtr  = nt_btr_per
                 work_fil.wpotr  = nt_otr_per
                 work_fil.wpftr  = nt_ftr_per
                 work_fil.wps8   = nt_s8_per  
                 work_fil.wpother = nt_other_per

                 work_fil.wccom   = work_fil.wccom  + nt_com
                 work_fil.wcstat  = work_fil.wcstat + nt_stat_co
                 work_fil.wcret   = work_fil.wcret  + nt_ret_co
                 work_fil.wc0q    = work_fil.wc0q   + nt_0q_co
                 work_fil.wc0t    = work_fil.wc0t   + nt_0t_co
                 work_fil.wc0s    = work_fil.wc0s   + nt_0s_co
                 work_fil.wcf1    = work_fil.wcf1   + nt_f1_co
                 work_fil.wcf2    = work_fil.wcf2   + nt_f2_co
                 work_fil.wcf3    = work_fil.wcf3   + nt_f3_co
                 work_fil.wcf4    = work_fil.wcf4   + nt_f4_co  
                 work_fil.wc0rq   = work_fil.wc0rq  + nt_0rq_co
                 work_fil.wc0ps   = work_fil.wc0ps  + nt_0ps_co
                 work_fil.wcbtr   = work_fil.wcbtr  + nt_btr_co
                 work_fil.wcotr   = work_fil.wcotr  + nt_otr_co
                 work_fil.wcftr   = work_fil.wcftr  + nt_ftr_co 
                 work_fil.wcs8    = work_fil.wcs8   + nt_s8_co   
                 work_fil.wcother = work_fil.wcother + nt_other_co.

                ASSIGN

                   nt_sigr      = 0
                   nt_prem      = 0
                   nt_stat_pr   = 0
                   nt_ret_pr    = 0
                   nt_0q_pr     = 0
                   nt_0t_pr     = 0
                   nt_0s_pr     = 0
                   nt_f1_pr     = 0
                   nt_f2_pr     = 0
                   nt_f3_pr     = 0
                   nt_f4_pr     = 0   /* a450055 */
                   nt_0rq_pr    = 0
                   nt_0ps_pr    = 0
                   nt_btr_pr    = 0
                   nt_otr_pr    = 0
                   nt_ftr_pr    = 0  /* a450055 */
                   nt_s8_pr     = 0  
                   nt_other_pr  = 0

                   nt_com       = 0
                   nt_stat_co   = 0
                   nt_ret_co    = 0
                   nt_0q_co     = 0
                   nt_0t_co     = 0
                   nt_0s_co     = 0
                   nt_f1_co     = 0
                   nt_f2_co     = 0
                   nt_f3_co     = 0
                   nt_f4_co     = 0
                   nt_0rq_co    = 0
                   nt_0ps_co    = 0
                   nt_btr_co    = 0
                   nt_otr_co    = 0
                   nt_ftr_co    = 0
                   nt_s8_co     = 0   
                   nt_other_co  = 0.


END.  /* each uwm100 */

FOR EACH  work_fil 
    /*--- A500178 ---
    break by  substr(work_fil.wbrn_line,1,1)  /*D*/
          by  substr(work_fil.wbrn_line,5,2)  /*70*/
          by  substr(work_fil.wbrn_line,3,1). /*0*/
    ------*/
    BREAK BY work_fil.wdir
          BY work_fil.wline
          BY work_fil.wbranch.
    /*--- A500178 ---*/

    IF  work_fil.wstat  < 0  THEN  
        work_fil.wstat  = work_fil.wstat * (-1).
    IF  work_fil.w0q    < 0 THEN
        work_fil.w0q    = work_fil.w0q  * (-1).
    IF  work_fil.w0t    < 0 THEN
        work_fil.w0t    = work_fil.w0t  * (-1).
    IF  work_fil.w0s    < 0 THEN
        work_fil.w0s    =  work_fil.w0s  * (-1).
    IF  work_fil.wf1    < 0 THEN
        work_fil.wf1    = work_fil.wf1  * (-1).
    IF  work_fil.wf2    < 0 THEN
        work_fil.wf2    = work_fil.wf2  * (-1).
    IF  work_fil.wf3    < 0 THEN
        work_fil.wf3    = work_fil.wf3  * (-1).
    IF  work_fil.wf4    < 0 THEN
        work_fil.wf4    = work_fil.wf4  * (-1). 
    IF  work_fil.w0rq   < 0 THEN
        work_fil.w0rq   = work_fil.w0rq  * (-1).
    IF  work_fil.w0ps   < 0 THEN
        work_fil.w0ps   = work_fil.w0ps  * (-1).
    IF  work_fil.wbtr   < 0 THEN
        work_fil.wbtr   = work_fil.wbtr  * (-1).
    IF  work_fil.wotr   < 0 THEN
        work_fil.wotr   = work_fil.wotr  * (-1).
    IF  work_fil.wftr   < 0 THEN                
        work_fil.wftr   = work_fil.wftr  * (-1).
    IF  work_fil.ws8    < 0 THEN
        work_fil.ws8    =  work_fil.ws8  * (-1).    
    IF  work_fil.wret   < 0 THEN
        work_fil.wret   = work_fil.wret  * (-1).
    IF  work_fil.wother  < 0 THEN
        work_fil.wother = work_fil.wother  * (-1).

   /*----jeab
   /*HIDE FRAME a NO-PAUSE.*/
    PUT STREAM ns1
        work_fil.wbrn_line   ";"
        work_fil.wsigr   FORMAT "->>>,>>>,>>>,>>9.99" ";"
        work_fil.wprem   FORMAT "->,>>>,>>>,>>9.99"   ";"
        work_fil.wccom   FORMAT "->,>>>,>>>,>>9.99"   ";"  ";"
        work_fil.wret    FORMAT "->,>>>,>>>,>>9.99"   ";"   
        work_fil.wpret   FORMAT ">>,>>>,>>>,>>9.99%"  ";"
        work_fil.wcret   FORMAT "->,>>>,>>>,>>9.99"   ";"  ";"
        work_fil.wstat   FORMAT "->,>>>,>>>,>>9.99"   ";"   
        work_fil.wpstat  FORMAT ">>,>>>,>>>,>>9.99%"  ";"   
        work_fil.wcstat  FORMAT "->,>>>,>>>,>>9.99"   ";"  ";"
        work_fil.w0t     FORMAT "->,>>>,>>>,>>9.99"   ";"   
        work_fil.wp0t    FORMAT ">>,>>>,>>>,>>9.99%"  ";"   
        work_fil.wc0t    FORMAT "->,>>>,>>>,>>9.99"   ";"  ";"
        work_fil.w0s     FORMAT "->,>>>,>>>,>>9.99"   ";"   
        work_fil.wp0s    FORMAT ">>,>>>,>>>,>>9.99%"  ";"    
        work_fil.wc0s    FORMAT "->,>>>,>>>,>>9.99"   ";"  ";"               
        work_fil.w0q     FORMAT "->,>>>,>>>,>>9.99"   ";"        
        work_fil.wp0q    FORMAT ">>,>>>,>>>,>>9.99%"  ";"    
        work_fil.wc0q    FORMAT "->,>>>,>>>,>>9.99"   ";"  ";"               
        work_fil.wf1     FORMAT "->,>>>,>>>,>>9.99"   ";"        
        work_fil.wpf1    FORMAT ">>,>>>,>>>,>>9.99%"  ";"    
        work_fil.wcf1    FORMAT "->,>>>,>>>,>>9.99"   ";"  ";"               
        work_fil.wf2     FORMAT "->,>>>,>>>,>>9.99"   ";"        
        work_fil.wpf2    FORMAT ">>,>>>,>>>,>>9.99%"  ";"    
        work_fil.wcf2    FORMAT "->,>>>,>>>,>>9.99"   ";"  ";"               
        work_fil.wf3     FORMAT "->,>>>,>>>,>>9.99"   ";"       
        work_fil.wpf3    FORMAT ">>,>>>,>>>,>>9.99%"  ";"    
        work_fil.wcf3    FORMAT "->,>>>,>>>,>>9.99"   ";"  ";"               
        work_fil.wf4     FORMAT "->,>>>,>>>,>>9.99"   ";"        
        work_fil.wpf4    FORMAT ">>,>>>,>>>,>>9.99%"  ";"    
        work_fil.wcf4    FORMAT "->,>>>,>>>,>>9.99"   ";"  ";"               
        work_fil.w0rq    FORMAT "->,>>>,>>>,>>9.99"   ";"       
        work_fil.wp0rq   FORMAT ">>,>>>,>>>,>>9.99%"  ";"    
        work_fil.wc0rq   FORMAT "->,>>>,>>>,>>9.99"   ";"  ";"               
        work_fil.w0ps    FORMAT "->,>>>,>>>,>>9.99"   ";"    
        work_fil.wp0ps   FORMAT ">>,>>>,>>>,>>9.99%"  ";"    
        work_fil.wc0ps   FORMAT "->,>>>,>>>,>>9.99"   ";"  ";"               
        work_fil.wbtr    FORMAT "->,>>>,>>>,>>9.99"   ";"        
        work_fil.wpbtr   FORMAT ">>,>>>,>>>,>>9.99%"  ";"    
        work_fil.wcbtr   FORMAT "->,>>>,>>>,>>9.99"   ";"  ";"               
        work_fil.wotr    FORMAT "->,>>>,>>>,>>9.99"   ";"        
        work_fil.wpotr   FORMAT ">>,>>>,>>>,>>9.99%"  ";"    
        work_fil.wcotr   FORMAT "->,>>>,>>>,>>9.99"   ";"  ";"               
        work_fil.wftr    FORMAT "->,>>>,>>>,>>9.99"   ";"        
        work_fil.wpftr   FORMAT ">>,>>>,>>>,>>9.99%"  ";"    
        work_fil.wcftr   FORMAT "->,>>>,>>>,>>9.99"   ";"  ";"               
        work_fil.ws8     FORMAT "->,>>>,>>>,>>9.99"   ";"    
        work_fil.wps8    FORMAT ">>,>>>,>>>,>>9.99%"  ";"      
        work_fil.wcs8    FORMAT "->,>>>,>>>,>>9.99"   ";"  ";"               
        work_fil.wother  FORMAT "->,>>>,>>>,>>9.99"   ";"    
        work_fil.wpother FORMAT ">>,>>>,>>>,>>9.99%"  ";"    
        work_fil.wcother FORMAT "->,>>>,>>>,>>9.99"   ";" 
        SKIP.
         ------*/
    nv_poldesc = "".
    nv_grptyp  = "".

    FIND Xmm031 USE-INDEX Xmm03101 WHERE Xmm031.poltyp = work_fil.poltyp  
    NO-LOCK NO-ERROR.
    nv_poldesc = IF AVAILABLE Xmm031 THEN Xmm031.poldes ELSE "".

    FIND FIRST s0m005 USE-INDEX s0m00501     WHERE
               s0m005.key2 = work_fil.poltyp
    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL s0m005 THEN nv_grptyp = s0m005.key1.

    nv_row = nv_row + 1.
    /*--- A500178 ---
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K"   '"' substr(work_fil.wbrn_line,3,1)               '"'   SKIP.
    ------*/
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K"   '"' work_fil.wbranch '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X2;K"   '"' work_fil.poltyp  '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X3;K"   '"' nv_poldesc       '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X4;K"   '"' nv_grptyp        '"'   SKIP.
    /*--- A500178 ---
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X5;K"   '"' substr(work_fil.wbrn_line,1,1) '"'   SKIP.
    ------*/
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X5;K"   '"' work_fil.wdir    '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X6;K"   '"' work_fil.wsigr   FORMAT "->>>,>>>,>>>,>>9.99" '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X7;K"   '"' work_fil.wprem   FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X8;K"   '"' work_fil.wccom   FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X10;K"  '"' work_fil.wret    FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X11;K"  '"' work_fil.wpret   FORMAT ">>,>>>,>>>,>>9.99%"  '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X12;K"  '"' work_fil.wcret   FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X14;K"  '"' work_fil.wstat   FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X15;K"  '"' work_fil.wpstat  FORMAT ">>,>>>,>>>,>>9.99%"  '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X16;K"  '"' work_fil.wcstat  FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X18;K"  '"' work_fil.w0t     FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X19;K"  '"' work_fil.wp0t    FORMAT ">>,>>>,>>>,>>9.99%"  '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X20;K"  '"' work_fil.wc0t    FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X22;K"  '"' work_fil.w0s     FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X23;K"  '"' work_fil.wp0s    FORMAT ">>,>>>,>>>,>>9.99%"  '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X24;K"  '"' work_fil.wc0s    FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X26;K"  '"' work_fil.w0q     FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X27;K"  '"' work_fil.wp0q    FORMAT ">>,>>>,>>>,>>9.99%"  '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X28;K"  '"' work_fil.wc0q    FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X30;K"  '"' work_fil.wf1     FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X31;K"  '"' work_fil.wpf1    FORMAT ">>,>>>,>>>,>>9.99%"  '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X32;K"  '"' work_fil.wcf1    FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X34;K"  '"' work_fil.wf2     FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X35;K"  '"' work_fil.wpf2    FORMAT ">>,>>>,>>>,>>9.99%"  '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X36;K"  '"' work_fil.wcf2    FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X38;K"  '"' work_fil.wf3     FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X39;K"  '"' work_fil.wpf3    FORMAT ">>,>>>,>>>,>>9.99%"  '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X40;K"  '"' work_fil.wcf3    FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X42;K"  '"' work_fil.wf4     FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X43;K"  '"' work_fil.wpf4    FORMAT ">>,>>>,>>>,>>9.99%"  '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X44;K"  '"' work_fil.wcf4    FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X46;K"  '"' work_fil.w0rq    FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X47;K"  '"' work_fil.wp0rq   FORMAT ">>,>>>,>>>,>>9.99%"  '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X48;K"  '"' work_fil.wc0rq   FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X50;K"  '"' work_fil.w0ps    FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X51;K"  '"' work_fil.wp0ps   FORMAT ">>,>>>,>>>,>>9.99%"  '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X52;K"  '"' work_fil.wc0ps   FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X54;K"  '"' work_fil.wbtr    FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X55;K"  '"' work_fil.wpbtr   FORMAT ">>,>>>,>>>,>>9.99%"  '"'   SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X56;K"  '"' work_fil.wcbtr   FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X58;K"  '"' work_fil.wotr    FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X59;K"  '"' work_fil.wpotr   FORMAT ">>,>>>,>>>,>>9.99%"  '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X60;K"  '"' work_fil.wcotr   FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X62;K"  '"' work_fil.wftr    FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X63;K"  '"' work_fil.wpftr   FORMAT ">>,>>>,>>>,>>9.99%"  '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X64;K"  '"' work_fil.wcftr   FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X66;K"  '"' work_fil.ws8     FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X67;K"  '"' work_fil.wps8    FORMAT ">>,>>>,>>>,>>9.99%"  '"'   SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X68;K"  '"' work_fil.wcs8    FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X70;K"  '"' work_fil.wother  FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X71;K"  '"' work_fil.wpother FORMAT ">>,>>>,>>>,>>9.99%"  '"'   SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X72;K"  '"' work_fil.wcother FORMAT "->,>>>,>>>,>>9.99"   '"'   SKIP.
 

   
END.  /* each work_fil */

PUT STREAM  ns1  "E"  SKIP.
OUTPUT STREAM ns1 CLOSE.

    /*
    OUTPUT STREAM ns1 CLOSE.
    HIDE FRAME a NO-PAUSE.
    HIDE ALL.
    */
   /*  RUN uz/uzhead("UZX00701").
    MESSAGE "!! JV Complete !!" VIEW-AS ALERT-BOX. */
    

/* end program */
