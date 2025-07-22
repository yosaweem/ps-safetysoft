/* WUSTR132.p  /*USTR132.P*/       */
/* TRANSFER POLICY TO UWM130 INSURED ITEM PER CAR */
/* Copyright  # Safety Insurance Public Company Limited        */
/*              บริษัท ประกันคุ้มภัย จำกัด (มหาชน)             */
/* CREATE BY  B.PHATTRANIT    ON  10/11/03                     */
/* Modify By : Porntiwa T.  A59-0297  A59-0297                 
             : ปรับให้รองรับงาน 2+ 3+                          */

/*---Note A490166---*/
DEFINE SHARED VAR  nv_batchyr   AS INT FORMAT "9999"            INIT 0.
DEFINE SHARED VAR  nv_batcnt    AS INT FORMAT "99"              INIT 0.
DEFINE SHARED VAR  nv_batchno   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.

Def  Input  parameter  s_recid3   As  Recid.
Def  Input  parameter  s_recid4   As  Recid.

DEFINE VAR             n_policy    AS CHARACTER         NO-UNDO.
DEFINE VAR             n_rencnt    AS INTEGER           NO-UNDO.
DEFINE VAR             n_endcnt    AS INTEGER           NO-UNDO.
DEFINE VAR             nv_riskno   AS INTEGER           NO-UNDO.
DEFINE VAR             nv_itemno   AS INTEGER           NO-UNDO.
DEFINE VAR             nv_message  AS CHARACTER         NO-UNDO.
 
DEFINE SHARED VAR      nv_polday   AS INTE FORMAT ">>9".
DEFINE SHARED VAR      nv_gapprm   AS DECI FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.
DEFINE SHARED VAR      nv_pdprm    AS DECI FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.

DEFINE        VAR      nt_gapprm   AS DECI FORMAT ">>,>>>,>>9.99-"  INITIAL 0.
DEFINE        VAR      nt_pdprm    AS DECI FORMAT ">>,>>>,>>9.99-"  INITIAL 0.
DEFINE        VAR      nv_adjgap   AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE        VAR      nv_adjpd    AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE        VAR      nv_adjvar   AS CHAR FORMAT "X(60)".


DEFINE VAR nv_gap    AS INTEGER   INITIAL 0  NO-UNDO.
DEFINE VAR nv_prem_c AS INTEGER   INITIAL 0  NO-UNDO.
DEFINE VAR nv_prem   AS INTEGER   INITIAL 0  NO-UNDO.
DEFINE VAR nv_bencod AS CHARACTER INITIAL "" NO-UNDO.
DEFINE VAR nv_line   AS INTEGER   INITIAL 0  NO-UNDO.

DEFINE VAR nv_lgar   AS INTEGER   INITIAL 0  NO-UNDO.
DEFINE VAR nv_lgar_c AS INTEGER   INITIAL 0  NO-UNDO.

DEFINE      SHARED VAR   nv_compcod AS CHAR  FORMAT "X(4)".
DEFINE      SHARED VAR   nv_compprm AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE      SHARED VAR   nv_compvar AS CHAR  FORMAT "X(60)".
DEFINE      SHARED VAR   nv_basecod AS CHAR  FORMAT "X(4)".
DEFINE      SHARED VAR   nv_baseprm AS DECI   FORMAT ">,>>>,>>9.99". /*NOTE MODI*/
DEFINE      SHARED VAR   nv_basevar AS CHAR  FORMAT "X(60)".

DEFINE      SHARED VAR   nv_usecod   AS CHARACTER FORMAT "X(4)".
DEFINE      SHARED VAR   nv_useprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE      SHARED VAR   nv_usevar   AS CHAR  FORMAT "X(60)".
DEFINE      SHARED VAR   nv_grpcod  AS CHARACTER FORMAT "X(4)".
DEFINE      SHARED VAR   nv_grprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE      SHARED VAR   nv_grpvar  AS CHAR  FORMAT "X(60)".

DEFINE      SHARED VAR   nv_yrcod   AS CHARACTER FORMAT "X(4)".
DEFINE      SHARED VAR   nv_yrprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE      SHARED VAR   nv_yrvar   AS CHAR  FORMAT "X(60)".

DEFINE      SHARED VAR   nv_sicod   AS CHARACTER FORMAT "X(4)".
DEFINE      SHARED VAR   nv_siprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE      SHARED VAR   nv_sivar   AS CHAR  FORMAT "X(60)".
DEFINE      SHARED VAR   nv_othcod  AS CHARACTER  FORMAT "X(4)".
DEFINE      SHARED VAR   nv_othprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE      SHARED VAR   nv_othvar  AS CHAR  FORMAT "X(60)".
DEFINE      SHARED VAR   nv_engcod  AS CHARACTER FORMAT "X(4)".
DEFINE      SHARED VAR   nv_engprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE      SHARED VAR   nv_engvar  AS CHAR  FORMAT "X(60)".
DEFINE      SHARED VAR   nv_drivcod AS CHARACTER FORMAT "X(4)".
DEFINE      SHARED VAR   nv_drivprm AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE      SHARED VAR   nv_drivvar AS CHAR  FORMAT "X(60)".
DEFINE      SHARED VAR   nv_bipcod  AS CHARACTER FORMAT "X(4)".
DEFINE      SHARED VAR   nv_bipprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE      SHARED VAR   nv_bipvar  AS CHAR  FORMAT "X(60)".

DEFINE      SHARED VAR   nv_biacod   AS CHARACTER FORMAT "X(4)".
DEFINE      SHARED VAR   nv_biaprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE      SHARED VAR   nv_biavar   AS CHAR  FORMAT "X(60)".
DEFINE      SHARED VAR   nv_pdacod   AS CHARACTER FORMAT "X(4)".
DEFINE      SHARED VAR   nv_pdaprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE      SHARED VAR   nv_pdavar   AS CHAR  FORMAT "X(60)".
DEFINE      SHARED VAR   nv_41cod1   AS CHARACTER FORMAT "X(4)".
DEFINE      SHARED VAR   nv_41cod2   AS CHARACTER FORMAT "X(4)".
DEFINE      SHARED VAR   nv_41       AS INTEGER   FORMAT ">>>,>>>,>>9".
DEFINE      SHARED VAR   nv_seat41   AS INTEGER   FORMAT ">>9".
DEFINE      SHARED VAR   nv_411prm   AS DECI      FORMAT ">,>>>,>>9.99".
DEFINE      SHARED VAR   nv_412prm   AS DECI      FORMAT ">,>>>,>>9.99".
DEFINE      SHARED VAR   nv_411var   AS CHAR  FORMAT "X(60)".
DEFINE      SHARED VAR   nv_412var   AS CHAR  FORMAT "X(60)".
DEFINE      SHARED VAR   nv_42cod    AS CHARACTER FORMAT "X(4)".
DEFINE      SHARED VAR   nv_42       AS INTEGER   FORMAT ">>>,>>>,>>9".
DEFINE      SHARED VAR   nv_42prm    AS DECI      FORMAT ">,>>>,>>9.99".
DEFINE      SHARED VAR   nv_42var    AS CHAR      FORMAT "X(60)".

DEFINE      SHARED VAR   nv_43cod    AS CHARACTER FORMAT "X(4)".
DEFINE      SHARED VAR   nv_43       AS INTEGER   FORMAT ">>>,>>>,>>9".
DEFINE      SHARED VAR   nv_43prm    AS DECI      FORMAT ">,>>>,>>9.99".
DEFINE      SHARED VAR   nv_43var    AS CHAR      FORMAT "X(60)".
DEFINE      SHARED VAR nv_dedod1_cod AS CHAR  FORMAT "X(4)".
DEFINE      SHARED VAR nv_dedod1_prm AS DECI  FORMAT ">,>>>,>>9.99-".
DEFINE      SHARED VAR nv_dedod1var  AS CHAR  FORMAT "X(60)".
DEFINE      SHARED VAR nv_dedod2_cod AS CHAR  FORMAT "X(4)".
DEFINE      SHARED VAR nv_dedod2_prm AS DECI  FORMAT ">,>>>,>>9.99-".
DEFINE      SHARED VAR nv_dedod2var  AS CHAR  FORMAT "X(60)".
DEFINE      SHARED VAR nv_dedpd_cod  AS CHAR  FORMAT "X(4)".
DEFINE      SHARED VAR nv_dedpd_prm  AS DECI  FORMAT ">,>>>,>>9.99-".
DEFINE      SHARED VAR nv_dedpdvar   AS CHAR  FORMAT "X(60)".
DEFINE      SHARED VAR   nv_flet_per AS DECIMAL FORMAT ">>9".
DEFINE      SHARED VAR   nv_flet     AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE      SHARED VAR   nv_fletvar  AS CHAR  FORMAT "X(60)".
DEFINE      SHARED VAR   nv_ncbper   LIKE sic_bran.uwm301.ncbper.
DEFINE      SHARED VAR   nv_ncb      AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE      SHARED VAR   nv_ncbvar   AS CHAR  FORMAT "X(60)".


DEFINE      SHARED VAR   nv_dss_per  AS DECIMAL   FORMAT ">9.99".
DEFINE      SHARED VAR   nv_dsspc    AS INTEGER   FORMAT ">>>,>>9.99-".
DEFINE      SHARED VAR   nv_dsspcvar AS CHAR      FORMAT "X(60)".
DEFINE      SHARED VAR   nv_stf_per  AS DECIMAL   FORMAT ">9.99".
DEFINE      SHARED VAR   nv_stf_amt  AS INTEGER   FORMAT ">>>,>>9.99-".
DEFINE      SHARED VAR   nv_stfvar   AS CHAR      FORMAT "X(60)".
DEFINE      SHARED VAR   nv_cl_per   AS DECIMAL   FORMAT ">9.99".
DEFINE      SHARED VAR   nv_lodclm   AS INTEGER   FORMAT ">>>,>>9.99-".
DEFINE      SHARED VAR   nv_clmvar   AS CHAR      FORMAT "X(60)".
DEFINE      SHARED VAR   nv_campcod AS CHAR  FORMAT "X(4)".
DEFINE      SHARED VAR   nv_camprem AS DECI  FORMAT ">>>9".
DEFINE      SHARED VAR   nv_campvar AS CHAR  FORMAT "X(60)".

DEFINE NEW  SHARED WORKFILE  wk_uwd132  LIKE brstat.wkuwd132.

DEFINE VAR nv_bptr   AS RECID.
DEFINE BUFFER wf_uwd132 FOR sic_bran.uwd132.

/*-- Add A59-0297 --*/
DEFINE      SHARED VAR   nv_baseprm3 AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE      SHARED VAR   nv_basecod3 AS CHAR FORMAT "X(4)".
DEFINE      SHARED VAR   nv_basevar3 AS CHAR FORMAT "X(60)".
DEFINE      SHARED VAR   nv_usecod3  AS CHAR FORMAT "X(4)".
DEFINE      SHARED VAR   nv_usevar3  AS CHAR FORMAT "X(60)".
DEFINE      SHARED VAR   nv_sicod3   AS CHAR FORMAT "X(4)".
DEFINE      SHARED VAR   nv_sivar3   AS CHAR FORMAT "X(4)".
DEFINE      SHARED VAR   nv_siprm3   AS DECI FORMAT ">>,>>>,>>9.99-".

DEFINE      SHARED VAR nv_supecod  AS CHAR  FORMAT "X(4)".
DEFINE      SHARED VAR nv_supeprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE      SHARED VAR nv_supevar1 AS CHAR  FORMAT "X(30)".
DEFINE      SHARED VAR nv_supevar2 AS CHAR  FORMAT "X(30)".
DEFINE      SHARED VAR nv_supevar  AS CHAR  FORMAT "X(60)".
/*-- End Add A59-0297 --*/

/*------
Message "s_recid3"   s_recid3   skip
        " s_recid4 " s_recid4    skip
        "nv_polday " nv_polday   skip
        " nv_gapprm" nv_gapprm   skip
        " nv_pdprm " nv_pdprm    skip  View-as alert-box.
Message "nv_compcod " nv_compcod skip
        "nv_compprm " nv_compprm skip
        "nv_compvar " nv_compvar skip
        "nv_basecod " nv_basecod skip
        "nv_baseprm " nv_baseprm skip
        "nv_basevar " nv_basevar skip
        " nv_usecod "  nv_usecod skip
        " nv_useprm "  nv_useprm skip
        " nv_usevar "  nv_usevar skip
        " nv_grpcod "  nv_grpcod skip
        " nv_grprm  "  nv_grprm  skip
        " nv_grpvar "  nv_grpvar skip
        " nv_yrcod  "  nv_yrcod  skip
        " nv_yrprm  "  nv_yrprm  skip
        " nv_yrvar  "  nv_yrvar  skip  View-as alert-box.
Message "  nv_sicod    "  nv_sicod    skip
        "  nv_siprm    "  nv_siprm    skip
        "  nv_sivar    "  nv_sivar    skip
        "  nv_othcod   "  nv_othcod   skip
        "  nv_othprm   "  nv_othprm   skip
        "  nv_othvar   "  nv_othvar   skip
        "  nv_engcod   "  nv_engcod   skip
        "  nv_engprm   "  nv_engprm   skip
        "  nv_engvar   "  nv_engvar   skip
        "  nv_drivcod  "  nv_drivcod  skip
        "  nv_drivprm  "  nv_drivprm  skip
        "  nv_drivvar  "  nv_drivvar  skip
        " nv_bipcod    "  nv_bipcod   skip
        " nv_bipprm    "  nv_bipprm   skip
        " nv_bipvar   "   nv_bipvar   skip  View-as alert-box.
Message "  nv_biacod  "  nv_biacod skip
        "  nv_biaprm  "  nv_biaprm skip
        "  nv_biavar  "  nv_biavar skip
        "  nv_pdacod  "  nv_pdacod skip
        "  nv_pdaprm  "  nv_pdaprm skip
        "  nv_pdavar  "  nv_pdavar skip
        "  nv_41cod1  "  nv_41cod1 skip
        "  nv_41cod2  "  nv_41cod2 skip
        "  nv_41      "  nv_41     skip
        "  nv_seat41  "  nv_seat41 skip
        "  nv_411prm  "  nv_411prm skip
        "  nv_412prm  "  nv_412prm skip
        "  nv_411var  "  nv_411var skip
        "  nv_412var  "  nv_412var skip
        "  nv_42cod   "  nv_42cod  skip
        "  nv_42      "  nv_42     skip
        "  nv_42prm   "  nv_42prm  skip
        "  nv_42var   "  nv_42var  skip  View-as alert-box.
Message "    nv_43cod    "   nv_43cod    skip
        "    nv_43       "   nv_43       skip
        "    nv_43prm    "   nv_43prm    skip
        "    nv_43var    "   nv_43var    skip
        "  nv_dedod1_cod " nv_dedod1_cod skip
        "  nv_dedod1_prm " nv_dedod1_prm skip
        "  nv_dedod1var  " nv_dedod1var  skip
        "  nv_dedod2_cod " nv_dedod2_cod skip
        "  nv_dedod2_prm " nv_dedod2_prm skip
        "  nv_dedod2var  " nv_dedod2var  skip
        "  nv_dedpd_cod  " nv_dedpd_cod  skip
        "  nv_dedpd_prm  " nv_dedpd_prm  skip
        "  nv_dedpdvar   " nv_dedpdvar   skip
        "    nv_flet_per "   nv_flet_per skip
        "    nv_flet     "   nv_flet     skip
        "    nv_fletvar  "   nv_fletvar  skip
        "    nv_ncbper   "   nv_ncbper   skip
        "    nv_ncb      "   nv_ncb      skip
        "    nv_ncbvar   "   nv_ncbvar   skip View-as alert-box.
Message " nv_dss_per  " nv_dss_per   skip
        " nv_dsspc    " nv_dsspc    skip
        " nv_dsspcvar " nv_dsspcvar skip
        " nv_stf_per  " nv_stf_per  skip
        " nv_stf_amt  " nv_stf_amt  skip
        " nv_stfvar   " nv_stfvar   skip
        " nv_cl_per   " nv_cl_per   skip
        " nv_lodclm   " nv_lodclm   skip
        " nv_clmvar   " nv_clmvar   skip
        " nv_campcod  " nv_campcod  skip
        " nv_camprem  " nv_camprem  skip
        " nv_campvar  " nv_campvar  View-as alert-box.
----------------*/

FIND FIRST sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-ERROR.

FIND FIRST sic_bran.uwm130 WHERE RECID(uwm130) = s_recid3 NO-ERROR.

ASSIGN   n_policy  = sic_bran.uwm130.policy
         n_rencnt  = sic_bran.uwm130.rencnt
         n_endcnt  = sic_bran.uwm130.endcnt
         nv_riskno = sic_bran.uwm130.riskno
         nv_itemno = sic_bran.uwm130.itemno.

                          /* DELETE RECORD UWD132 IS OLD */

FIND FIRST sic_bran.uwd132 USE-INDEX uwd13201     WHERE  /*a490166 note modi Index from uwd13290 To uwd13201 */
           sic_bran.uwd132.policy = sic_bran.uwm130.policy AND
           sic_bran.uwd132.rencnt = sic_bran.uwm130.rencnt AND
           sic_bran.uwd132.endcnt = sic_bran.uwm130.endcnt AND
           sic_bran.uwd132.riskgp = sic_bran.uwm130.riskgp AND
           sic_bran.uwd132.riskno = sic_bran.uwm130.riskno AND
           sic_bran.uwd132.itemno = sic_bran.uwm130.itemno AND
           /*a490166*/                                             
           sic_bran.uwd132.bchyr = nv_batchyr            AND 
           sic_bran.uwd132.bchno = nv_batchno            AND 
           sic_bran.uwd132.bchcnt  = nv_batcnt                     
NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_bran.uwd132 THEN DO:
  FOR EACH sic_bran.uwd132 USE-INDEX uwd13201     WHERE  /*a490166 note modi Index from uwd13290 To uwd13201 */
           sic_bran.uwd132.policy = sic_bran.uwm130.policy AND
           sic_bran.uwd132.rencnt = sic_bran.uwm130.rencnt AND
           sic_bran.uwd132.endcnt = sic_bran.uwm130.endcnt AND
           sic_bran.uwd132.riskgp = sic_bran.uwm130.riskgp AND
           sic_bran.uwd132.riskno = sic_bran.uwm130.riskno AND
           sic_bran.uwd132.itemno = sic_bran.uwm130.itemno AND
           /*a490166*/
           sic_bran.uwd132.bchyr = nv_batchyr            AND   
           sic_bran.uwd132.bchno = nv_batchno            AND   
           sic_bran.uwd132.bchcnt  = nv_batcnt             :
    DELETE sic_bran.uwd132.
  END.

  sic_bran.uwm130.fptr03 = 0.
  sic_bran.uwm130.bptr03 = 0.
END.

/*DELETE FROM wkuwd132. */

nv_line = 0.
nt_gapprm  = 0.    nt_pdprm  = 0.
nv_adjgap  = 0.    nv_adjpd  = 0.

                                              /* SET DATA ADD WORKFILE UWD132 */

/* COMPULSORY  Premium   */

   IF   nv_compprm      <> 0  THEN DO:
        ASSIGN nv_gap     = 0
               nv_prem_c  = 0.
      nv_gap    = nv_compprm.
      nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

      RUN WGS/WGSTK132 (INPUT  n_policy, /*a490166 note modi */
                               n_rencnt,
                               n_endcnt,
                               nv_riskno,
                               nv_itemno,
                               sic_bran.uwm301.tariff,    /* nv_tariff */
                               nv_compcod,                /* nv_bencod */
                               nv_compvar,
                               nv_gap,
                               nv_prem_c,
                  INPUT-OUTPUT nv_line).

   END.  /* comp <> 0 */

/* BASE  : Basic Premium   */
      ASSIGN nv_gap     = 0
             nv_prem_c  = 0.

      nv_gap    = nv_baseprm.
      nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

      RUN WGS/WGSTK132 (INPUT  n_policy,                  /*a490166 note modi*/
                               n_rencnt,
                               n_endcnt,
                               nv_riskno,
                               nv_itemno,
                               sic_bran.uwm301.tariff,    /* nv_tariff */
                               nv_basecod,                /* nv_bencod */
                               nv_basevar,
                               nv_gap,
                               nv_prem_c,
                  INPUT-OUTPUT nv_line).

/* BASE : Premium 3 */
      IF nv_basecod3 <> "" THEN DO:
          ASSIGN nv_gap     = 0
                 nv_prem_c  = 0.

          nv_gap    = nv_baseprm3.
          nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

          RUN WGS/WGSTK132 (INPUT  n_policy, /*a490166 note modi */
                              n_rencnt,
                              n_endcnt,
                              nv_riskno,
                              nv_itemno,
                              sic_bran.uwm301.tariff,    /* nv_tariff */
                              nv_basecod3,                /* nv_bencod */
                              nv_basevar3,
                              nv_gap,
                              nv_prem_c,
                 INPUT-OUTPUT nv_line).
      END.


/* Vehicle use */
      ASSIGN nv_gap    = 0
             nv_prem_c = 0.

      nv_gap    = nv_useprm.
      nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

      RUN WGS/WGSTK132 (INPUT   n_policy,                /*a490166 note modi*/
                                n_rencnt,
                                n_endcnt,
                                nv_riskno,
                                nv_itemno,
                                sic_bran.uwm301.tariff,            /* nv_tariff */
                                nv_usecod,                         /* nv_bencod */
                                nv_usevar,
                                nv_gap,
                                nv_prem_c,
                  INPUT-OUTPUT  nv_line).

/* Vehicle use 3 */
      /*-- Add A59-0297 --*/
      IF nv_usecod3  <> "" THEN DO:
          ASSIGN nv_gap    = 0
                 nv_prem_c = 0.
    
          nv_gap    = nv_useprm.
          nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

          RUN WGS/WGSTK132 (INPUT   n_policy,                /*a490166 note modi*/
                                n_rencnt,
                                n_endcnt,
                                nv_riskno,
                                nv_itemno,
                                sic_bran.uwm301.tariff,            /* nv_tariff */
                                nv_usecod3,                         /* nv_bencod */
                                nv_usevar3,
                                nv_gap,
                                nv_prem_c,
                  INPUT-OUTPUT  nv_line).  
      END.
      /*-- End Add A59-0297 --*/

/* Engine   */

     ASSIGN nv_gap    = 0
            nv_prem_c = 0.

     nv_gap    = nv_engprm.
     nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

     RUN WGS/WGSTK132 (INPUT      n_policy,                         /*a490166 note modi*/
                                  n_rencnt,
                                  n_endcnt,
                                  nv_riskno,
                                  nv_itemno,
                                  sic_bran.uwm301.tariff,           /* nv_tarif~ f */
                                  nv_engcod,                        /* nv_bencod */
                                  nv_engvar,
                                  nv_gap,
                                  nv_prem_c,
                     INPUT-OUTPUT nv_line).

/* Driver Age    */
       ASSIGN nv_gap    = 0
              nv_prem_c = 0.

     nv_gap    = nv_drivprm.
     nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

  RUN WGS/WGSTK132 (INPUT      n_policy,                      /*a490166 note modi*/
                               n_rencnt,
                               n_endcnt,
                               nv_riskno,
                               nv_itemno,
                               sic_bran.uwm301.tariff,        /* nv_tariff */
                               nv_drivcod,                    /* nv_bencod */
                               nv_drivvar,
                               nv_gap,
                               nv_prem_c,
                  INPUT-OUTPUT nv_line).

/* Vehicle Year    */
     ASSIGN nv_gap    = 0
            nv_prem_c = 0.

     nv_gap    = nv_yrprm.
     nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

     RUN WGS/WGSTK132 (INPUT      n_policy,                      /*a490166 note modi*/
                                  n_rencnt,
                                  n_endcnt,
                                  nv_riskno,
                                  nv_itemno,
                                  sic_bran.uwm301.tariff,          /* nv_tarif~ f */
                                  nv_yrcod,                        /* nv_bencod */
                                  nv_yrvar,
                                  nv_gap,
                                  nv_prem_c,
                     INPUT-OUTPUT nv_line).

/* Sum Insured    */

     ASSIGN nv_gap    = 0
            nv_prem_c = 0.

     nv_gap    = nv_siprm.
     nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

     RUN WGS/WGSTK132 (INPUT      n_policy,                        /*a490166 note modi*/ 
                                  n_rencnt,
                                  n_endcnt,
                                  nv_riskno,
                                  nv_itemno,
                                  sic_bran.uwm301.tariff,          /* nv_tarif~ f */
                                  nv_sicod,                        /* nv_bencod */
                                  nv_sivar,
                                  nv_gap,
                                  nv_prem_c,
                     INPUT-OUTPUT nv_line).

/* Sum Insured 3 */
     /*-- Add A59-0297 --*/
     IF nv_sicod3 <> "" THEN DO: 
         ASSIGN nv_gap    = 0
                nv_prem_c = 0.
    
         nv_gap    = nv_siprm3.
         nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

         RUN WGS/WGSTK132 (INPUT  n_policy,                        /*a490166 note modi*/ 
                                  n_rencnt,
                                  n_endcnt,
                                  nv_riskno,
                                  nv_itemno,
                                  sic_bran.uwm301.tariff,          /* nv_tarif~ f */
                                  nv_sicod3,                       /* nv_bencod */
                                  nv_sivar3,
                                  nv_gap,
                                  nv_prem_c,
                     INPUT-OUTPUT nv_line).


     END.

     /*-- Super Car --*/
     IF nv_supecod <> "" THEN DO:
         ASSIGN nv_gap    = 0
                nv_prem_c = 0.
    
         nv_gap = nv_supeprm.
         nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

         RUN WGS/WGSTK132 (INPUT  n_policy,                        /*a490166 note modi*/ 
                                  n_rencnt,
                                  n_endcnt,
                                  nv_riskno,
                                  nv_itemno,
                                  sic_bran.uwm301.tariff,          /* nv_tarif~ f */
                                  nv_supecod,                      /* nv_bencod */
                                  nv_supevar,
                                  nv_gap,
                                  nv_prem_c,
                     INPUT-OUTPUT nv_line).
     END.
     /*-- End Add A59-0297 --*/

/* Accessory       */

     ASSIGN nv_gap    = 0
            nv_prem_c = 0.

     nv_gap    = nv_othprm.
     nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

     RUN WGS/WGSTK132 (INPUT      n_policy,                         /*a490166 note modi*/
                                  n_rencnt,
                                  n_endcnt,
                                  nv_riskno,
                                  nv_itemno,
                                  sic_bran.uwm301.tariff,           /* nv_tarif~ f */
                                  nv_othcod,                        /* nv_bencod */
                                  nv_othvar,
                                  nv_gap,
                                  nv_prem_c,
                     INPUT-OUTPUT nv_line).

/* Vehicle Group     */

     ASSIGN nv_gap    = 0
            nv_prem_c = 0.

     nv_gap    = nv_grprm.
     nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

     RUN WGS/WGSTK132 (INPUT      n_policy,                        /*a490166 note modi*/
                                  n_rencnt,
                                  n_endcnt,
                                  nv_riskno,
                                  nv_itemno,
                                  sic_bran.uwm301.tariff,            /* nv_tarif~ f */
                                  nv_grpcod,                        /* nv_bencod~  */
                                  nv_grpvar,
                                  nv_gap,
                                  nv_prem_c,
                     INPUT-OUTPUT nv_line).

/* BI per Person   */

     ASSIGN nv_gap    = 0
            nv_prem_c = 0.

     nv_gap    = nv_bipprm.
     nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

     RUN WGS/WGSTK132 (INPUT      n_policy,                         /*a490166 note modi*/
                                  n_rencnt,
                                  n_endcnt,
                                  nv_riskno,
                                  nv_itemno,
                                  sic_bran.uwm301.tariff,           /* nv_tarif~ f */
                                  nv_bipcod,                        /* nv_bencod */
                                  nv_bipvar,
                                  nv_gap,
                                  nv_prem_c,
                     INPUT-OUTPUT nv_line).

/* BI per Accident     */

     ASSIGN nv_gap    = 0
            nv_prem_c = 0.

     nv_gap    = nv_biaprm.
     nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

     RUN WGS/WGSTK132 (INPUT      n_policy,                        /*a490166 note modi*/  
                                  n_rencnt,
                                  n_endcnt,
                                  nv_riskno,
                                  nv_itemno,
                                  sic_bran.uwm301.tariff,           /* nv_tarif~ f */
                                  nv_biacod,                        /* nv_bencod */
                                  nv_biavar,
                                  nv_gap,
                                  nv_prem_c,
                     INPUT-OUTPUT nv_line).


/* PD per Accident     */

     ASSIGN nv_gap    = 0
            nv_prem_c = 0.

     nv_gap    = nv_pdaprm.
     nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

     RUN WGS/WGSTK132 (INPUT      n_policy,                         /*a490166 note modi*/
                                  n_rencnt,
                                  n_endcnt,
                                  nv_riskno,
                                  nv_itemno,
                                  sic_bran.uwm301.tariff,           /* nv_tarif~ f */
                                  nv_pdacod,                        /* nv_bencod */
                                  nv_pdavar,
                                  nv_gap,
                                  nv_prem_c,
                     INPUT-OUTPUT nv_line).

/* PA. 411  Driver Person    */
  ASSIGN nv_gap    = 0
         nv_prem_c = 0.

  nv_gap    = nv_411prm.
  nv_prem_c = TRUNCATE((nv_gap  * nv_polday) / 365,0).

  nv_bencod = "".
  nv_bencod = nv_41cod1.


  RUN WGS/WGSTK132 (INPUT      n_policy,                            /*a490166 note modi*/
                               n_rencnt,
                               n_endcnt,
                               nv_riskno,
                               nv_itemno,
                               sic_bran.uwm301.tariff,                /* nv_tariff */
                               nv_bencod,
                               nv_411var,
                               nv_gap,
                               nv_prem_c,
                  INPUT-OUTPUT nv_line).

/* PA. 412 : PASSENGER   */
  ASSIGN nv_gap    = 0
         nv_prem_c = 0.

  nv_gap    = nv_412prm.
  nv_prem_c = TRUNCATE((nv_gap  * nv_polday) / 365,0).
  nv_bencod = "".
  nv_bencod = nv_41cod2.


  RUN WGS/WGSTK132 (INPUT        n_policy,
                               n_rencnt,
                               n_endcnt,
                               nv_riskno,
                               nv_itemno,
                               sic_bran.uwm301.tariff,                /* nv_tariff */
                               nv_bencod,
                               nv_412var,
                               nv_gap,
                               nv_prem_c,
                  INPUT-OUTPUT nv_line).

/* PA. 42 : Medical Expense */
  ASSIGN nv_gap    = 0
         nv_prem_c = 0.

  nv_gap    = nv_42prm.
  nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
  nv_bencod = "".
  nv_bencod = nv_42cod.


  RUN WGS/WGSTK132 (INPUT        n_policy,
                               n_rencnt,
                               n_endcnt,
                               nv_riskno,
                               nv_itemno,
                               sic_bran.uwm301.tariff,                /* nv_tariff */
                               nv_bencod,
                               nv_42var,
                               nv_gap,
                               nv_prem_c,
                  INPUT-OUTPUT nv_line).


/* PA. 43 : Airfrieght */
  ASSIGN nv_gap    = 0
         nv_prem_c = 0.

  nv_gap    = nv_43prm.
  nv_prem_c = TRUNCATE((nv_gap *  nv_polday) / 365,0).
  nv_bencod = "".
  nv_bencod = nv_43cod.

  RUN WGS/WGSTK132 (INPUT        n_policy,
                               n_rencnt,
                               n_endcnt,
                               nv_riskno,
                               nv_itemno,
                               sic_bran.uwm301.tariff,                /* nv_tariff */
                               nv_bencod,
                               nv_43var,
                               nv_gap,
                               nv_prem_c,
                  INPUT-OUTPUT nv_line).

/* Deductible Benefit   : Deduct  OD  */
/*--- Comment A59-0297 --
IF  nv_dedod1_prm  <> 0  THEN DO:
    ASSIGN nv_gap    = 0
           nv_prem_c = 0.

    nv_gap    = nv_dedod1_prm.
    nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
    nv_bencod = "".
    nv_bencod = nv_dedod1_cod.

    RUN WGS/WGSTK132 (INPUT        n_policy,
                                 n_rencnt,
                                 n_endcnt,
                                 nv_riskno,
                                 nv_itemno,
                                 sic_bran.uwm301.tariff,                /* nv_tariff */
                                 nv_bencod,
                                 nv_dedod1var,
                                 nv_gap,                /* nv_gap    */
                                 nv_prem_c,              /* nv_prem_c */
                    INPUT-OUTPUT nv_line).

END.
-- End Add A59-0297 --*/
/*-- Add A59-0297 --*/
IF uwm301.covcod = "2.1" OR uwm301.covcod = "3.1" THEN DO:
    ASSIGN nv_gap    = 0
           nv_prem_c = 0.

    nv_gap    = nv_dedod1_prm.
    nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
    nv_bencod = "".
    nv_bencod = nv_dedod1_cod.

    RUN WGS/WGSTK132 (INPUT n_policy,
                            n_rencnt,
                            n_endcnt,
                            nv_riskno,
                            nv_itemno,
                            sic_bran.uwm301.tariff,                /* nv_tariff */
                            nv_bencod,
                            nv_dedod1var,
                            nv_gap,                /* nv_gap    */
                            nv_prem_c,              /* nv_prem_c */
               INPUT-OUTPUT nv_line).

    ASSIGN nv_gap    = 0
           nv_prem_c = 0.
    
    nv_gap    = nv_dedod2_prm.
    nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
    nv_bencod = "".
    nv_bencod = nv_dedod2_cod.

    RUN WGS/WGSTK132 (INPUT n_policy,
                            n_rencnt,
                            n_endcnt,
                            nv_riskno,
                            nv_itemno,
                            sic_bran.uwm301.tariff,                /* nv_tariff */
                            nv_bencod,
                            nv_dedod2var,
                            nv_gap,                /* nv_gap    */
                            nv_prem_c,              /* nv_prem_c */
               INPUT-OUTPUT nv_line).

END.
ELSE DO:
    IF  nv_dedod1_prm  <> 0  THEN DO:
        ASSIGN nv_gap    = 0
               nv_prem_c = 0.
    
        nv_gap    = nv_dedod1_prm.
        nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
        nv_bencod = "".
        nv_bencod = nv_dedod1_cod.
    
        RUN WGS/WGSTK132 (INPUT n_policy,
                                n_rencnt,
                                n_endcnt,
                                nv_riskno,
                                nv_itemno,
                                sic_bran.uwm301.tariff,                /* nv_tariff */
                                nv_bencod,
                                nv_dedod1var,
                                nv_gap,                /* nv_gap    */
                                nv_prem_c,              /* nv_prem_c */
                   INPUT-OUTPUT nv_line).
    
    END.

    /* Deductible ADD OD  */

    IF  nv_dedod2_prm  <> 0  THEN DO:
        ASSIGN nv_gap    = 0
               nv_prem_c = 0.
    
        nv_gap    = nv_dedod2_prm.
        nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
        nv_bencod = "".
        nv_bencod = nv_dedod2_cod.
    
        RUN WGS/WGSTK132 (INPUT n_policy,
                                n_rencnt,
                                n_endcnt,
                                nv_riskno,
                                nv_itemno,
                                sic_bran.uwm301.tariff,                /* nv_tariff */
                                nv_bencod,
                                nv_dedod2var,
                                nv_gap,                /* nv_gap    */
                                nv_prem_c,              /* nv_prem_c */
                   INPUT-OUTPUT nv_line).
    
    END.
END.
/*-- End Add A59-0297 --*/

/* Deductible PD   */

IF  nv_dedpd_prm  <> 0  THEN DO:
    ASSIGN nv_gap    = 0
           nv_prem_c = 0.

    nv_gap    = nv_dedpd_prm.
    nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).
    nv_bencod = "".
    nv_bencod = nv_dedpd_cod.

    RUN WGS/WGSTK132 (INPUT        n_policy,
                                 n_rencnt,
                                 n_endcnt,
                                 nv_riskno,
                                 nv_itemno,
                                 sic_bran.uwm301.tariff,                /* nv_tariff */
                                 nv_bencod,
                                 nv_dedpdvar,
                                 nv_gap,                /* nv_gap    */
                                 nv_prem_c,              /* nv_prem_c */
                    INPUT-OUTPUT nv_line).

END.


/* FLEET */
IF nv_flet  <> 0 THEN DO:
  ASSIGN nv_gap    = 0
         nv_prem_c = 0.

  nv_gap     = nv_flet.
  nv_prem_c  = TRUNCATE((nv_gap  * nv_polday) / 365,0).

  RUN WGS/WGSTK132 (INPUT        n_policy,
                               n_rencnt,
                               n_endcnt,
                               nv_riskno,
                               nv_itemno,
                               sic_bran.uwm301.tariff,                /* nv_tariff */
                               "FLET",                     /* nv_benc~ od */
                               nv_fletvar,
                               nv_gap,                  /* nv_gap    */
                               nv_prem_c,                /* nv_prem_c */
                  INPUT-OUTPUT nv_line).

END.

/* NCB : Experience Discount */
IF nv_ncb   <> 0 THEN DO:
  ASSIGN nv_gap    = 0
         nv_prem_c = 0.

  nv_gap     = nv_ncb.
  nv_prem_c  = TRUNCATE((nv_gap   * nv_polday) / 365,0).

  RUN  WGS/WGSTK132 (INPUT        n_policy,
                               n_rencnt,
                               n_endcnt,
                               nv_riskno,
                               nv_itemno,
                               sic_bran.uwm301.tariff,                /* nv_tariff */
                               "NCB",                            /* nv_benc~ od */
                               nv_ncbvar,
                               nv_gap,                   /* nv_gap    */
                               nv_prem_c,                 /* nv_prem_c */
                  INPUT-OUTPUT nv_line).

END.


/* Discount Special Percent */
IF nv_dsspc <> 0 THEN DO:

   ASSIGN nv_gap    = 0
          nv_prem_c = 0.

   nv_gap     = nv_dsspc.
   nv_prem_c  = TRUNCATE((nv_gap * nv_polday) / 365,0).

   RUN WGS/WGSTK132 (INPUT       n_policy,
                               n_rencnt,
                               n_endcnt,
                               nv_riskno,
                               nv_itemno,
                               sic_bran.uwm301.tariff,                /* nv_tariff */
                               "DSPC",                       /* nv_bencod */
                               nv_dsspcvar,
                               nv_gap,                 /* nv_gap    */
                               nv_prem_c,               /* nv_gap    */
                  INPUT-OUTPUT nv_line).

END.


/* Discount Staff */
IF nv_stf_amt   <> 0 THEN DO:

  ASSIGN nv_gap    = 0
         nv_prem_c = 0.

   nv_gap     = nv_stf_amt.
   nv_prem_c  = TRUNCATE((nv_gap  * nv_polday) / 365,0).

  RUN WGS/WGSTK132 (INPUT        n_policy,
                               n_rencnt,
                               n_endcnt,
                               nv_riskno,
                               nv_itemno,
                               sic_bran.uwm301.tariff,                  /* nv_tariff */
                               "DSTF",                           /* nv_bencod */
                               nv_stfvar,
                               nv_gap,                          /* nv_gap    */
                               nv_prem_c,                       /* nv_gap    */
                  INPUT-OUTPUT nv_line).

END.


/* Load Claim */
IF nv_cl_per     <> 0 THEN DO:
  ASSIGN nv_gap    = 0
         nv_prem_c = 0.


   nv_gap     = nv_lodclm.
   nv_prem_c  = TRUNCATE((nv_gap  * nv_polday) / 365,0).

   nv_bencod = "".

   nv_bencod   = "CL" + STRING(nv_cl_per).

  RUN WGS/WGSTK132 (INPUT        n_policy,
                               n_rencnt,
                               n_endcnt,
                               nv_riskno,
                               nv_itemno,
                               sic_bran.uwm301.tariff,                /* nv_tariff */
                               nv_bencod,
                               nv_clmvar,
                               nv_gap,                 /* nv_gap    */
                               nv_prem_c,               /* nv_gap    */
                  INPUT-OUTPUT nv_line).

END.

/* MOTOR + PA   Premium   */

   IF   nv_camprem       <> 0  THEN DO:

        ASSIGN nv_gap     = 0
               nv_prem_c  = 0.

      nv_gap    = nv_camprem.
      nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

      RUN WGS/WGSTK132 (INPUT    n_policy,
                               n_rencnt,
                               n_endcnt,
                               nv_riskno,
                               nv_itemno,
                               sic_bran.uwm301.tariff,    /* nv_tariff */
                               nv_campcod,       /* nv_bencod */
                               nv_campvar,
                               nv_gap,
                               nv_prem_c,
                  INPUT-OUTPUT nv_line).

   END.  /* motor + pa  <> 0 */

/* Insured Item Benefit & Premium */

IF nv_line <> 0 THEN DO:
  nv_bptr = 0.
  FOR EACH wk_uwd132 NO-LOCK BREAK BY wk_uwd132.line
  :
    CREATE sic_bran.uwd132.

    ASSIGN  sic_bran.uwd132.policy        = wk_uwd132.policy
            sic_bran.uwd132.rencnt        = wk_uwd132.rencnt
            sic_bran.uwd132.endcnt        = wk_uwd132.endcnt
            sic_bran.uwd132.riskgp        = wk_uwd132.riskgp
            sic_bran.uwd132.riskno        = wk_uwd132.riskno
            sic_bran.uwd132.itemno        = wk_uwd132.itemno
            sic_bran.uwd132.rateae        = wk_uwd132.rateae
            sic_bran.uwd132.bencod        = wk_uwd132.bencod
            sic_bran.uwd132.benvar        = wk_uwd132.benvar
            sic_bran.uwd132.rate          = wk_uwd132.rate
            sic_bran.uwd132.gap_ae        = wk_uwd132.gap_ae
            sic_bran.uwd132.gap_c         = wk_uwd132.gap_c
            sic_bran.uwd132.pd_aep        = wk_uwd132.pd_aep
            sic_bran.uwd132.prem_c        = wk_uwd132.prem_c
            sic_bran.uwd132.bptr          = nv_bptr
            sic_bran.uwd132.dl1_c         = 0
            sic_bran.uwd132.dl2_c         = 0
            sic_bran.uwd132.dl3_c         = 0
            sic_bran.uwd132.fptr          = 0  .
     
    ASSIGN /*a490166*/
            sic_bran.uwd132.bchyr       = nv_batchyr         /* batch Year */
            sic_bran.uwd132.bchno       = nv_batchno         /* batchno    */
            sic_bran.uwd132.bchcnt        = nv_batcnt .        /* batcnt     */


    IF nv_bptr <> 0 THEN DO:
       FIND wf_uwd132 WHERE RECID(wf_uwd132) = nv_bptr.

       wf_uwd132.fptr = RECID(sic_bran.uwd132).
    END.

    IF nv_bptr = 0 THEN  uwm130.fptr03 = RECID(sic_bran.uwd132).

    nv_bptr = RECID(sic_bran.uwd132).
  END.                                               /* End FOR EACH wk_uwd132 */

  uwm130.bptr03 = nv_bptr.


/*---------Adjust premium ---------*/

nt_gapprm   = 0.
nt_pdprm    = 0.

FOR EACH sic_bran.uwd132   WHERE
         sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
         sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
         sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
         sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
         sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
         /*a490166*/ 
         sic_bran.uwd132.bchyr = nv_batchyr              AND   
         sic_bran.uwd132.bchno = nv_batchno              AND   
         sic_bran.uwd132.bchcnt  = nv_batcnt               NO-LOCK.

     nt_gapprm   = nt_gapprm + sic_bran.uwd132.gap_c.
     nt_pdprm    = nt_pdprm  + sic_bran.uwd132.prem_c.

END.


IF      nv_gapprm    <> nt_gapprm   THEN DO:
        nv_adjgap    = nv_gapprm - nt_gapprm.

        FIND FIRST sic_bran.uwd132  USE-INDEX uwd13201  WHERE /*a490116 note change index from uwd13290 to uwd13201*/
                   sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
                   sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                   sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                   sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                   sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
                   sic_bran.uwd132.bencod  = "PD"                    AND
                   /*a490166*/                                       
                   sic_bran.uwd132.bchyr = nv_batchyr              AND
                   sic_bran.uwd132.bchno = nv_batchno              AND
                   sic_bran.uwd132.bchcnt  = nv_batcnt               NO-ERROR.
       IF  AVAIL   sic_bran.uwd132  THEN  DO:
           ASSIGN  sic_bran.uwd132.gap_c   = sic_bran.uwd132.gap_c + nv_adjgap.
       END.
END.

IF      nv_pdprm     <> nt_pdprm    THEN DO:
        nv_adjpd     = nv_pdprm - nt_pdprm.

        FIND FIRST sic_bran.uwd132  USE-INDEX uwd13201  WHERE /*a490116 note change index from uwd13290 to uwd13201*/
                   sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
                   sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                   sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                   sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                   sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
                   sic_bran.uwd132.bencod  = "PD"                    AND
                   /*a490166*/                                       
                   sic_bran.uwd132.bchyr = nv_batchyr              AND
                   sic_bran.uwd132.bchno = nv_batchno              AND
                   sic_bran.uwd132.bchcnt  = nv_batcnt               NO-ERROR.
       IF  AVAIL   sic_bran.uwd132  THEN
           ASSIGN  sic_bran.uwd132.prem_c  = sic_bran.uwd132.prem_c + nv_adjpd.

END.

/*-------------------end adjust premium-----------*/


END.                                                      /* END nv_line <> 0 */

nv_message = "".

/* END OF : USTR132.P */
