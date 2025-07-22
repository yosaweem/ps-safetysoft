&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */


DEF VAR nv_jvdat    AS DATE FORMAT "99/99/9999".
DEF VAR nv_source   AS CHAR FORMAT "x(2)".
DEF VAR nv_branfr   AS CHAR FORMAT "x(2)".
DEF VAR nv_branto   AS CHAR FORMAT "x(2)".
DEF VAR nv_output   AS CHAR FORMAT "x(35)".

/*-- Prn JV --*/
DEF VAR  n_txt      AS CHAR     FORMAT "X(130)".
DEF VAR  n_branchT  AS CHAR     FORMAT "X(30)".
DEF VAR  n_prdes    AS CHAR     FORMAT "X(60)".
DEF VAR  n_txt2     AS CHAR     FORMAT "X(60)".

DEF VAR  n_date     AS DATE     FORMAT "99/99/9999".
DEF VAR  n_monthT   AS CHAR     FORMAT "X(30)".
DEF VAR  n_yearT    AS INTE     FORMAT "9999".

DEF VAR  n_gltxt    AS CHAR     FORMAT "X(50)".
DEF VAR  n_prnmacc  AS CHAR     FORMAT "X(16)".

DEF VAR  NT_DR      AS DECIMAL  FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR  NT_CR      AS DECIMAL  FORMAT "->>>,>>>,>>>,>>9.99".

DEF VAR  n_safety   AS  CHAR    FORMAT "X(50)".
DEF VAR  n_prnjv    AS  CHAR    FORMAT "X(25)".

DEF VAR  n_ln1      AS  CHAR    FORMAT "X(75)".
DEF VAR  n_ln2      AS  CHAR    FORMAT "X(75)".
DEF VAR  n_ln3      AS  CHAR    FORMAT "X(75)".

DEF VAR  n_HSln1    AS  CHAR    FORMAT "X(110)".
DEF VAR  n_HSln2    AS  CHAR    FORMAT "X(110)".
DEF VAR  n_HSln3    AS  CHAR    FORMAT "X(110)".

DEF VAR n_policy LIKE acm001.policy.
DEF VAR n_rencnt   AS INT   FORMAT ">9" .                 
DEF VAR n_endcnt   AS INT   FORMAT "999".
DEF VAR n_endno    AS CHAR  FORMAT "X(9)".
DEF VAR n_trndat LIKE acm001.trndat FORMAT "99/99/9999" .
DEF VAR n_com2p  LIKE uwm120.com2p  FORMAT ">9".
DEF VAR n_prnvat   AS CHAR  FORMAT "X(1)".
DEF VAR n_comdat   AS DATE  FORMAT "99/99/9999".

DEF VAR n_ri       AS LOGICAL. /*--Yes = InwTreaty, No = InwFAC.--A51-0078--*/

DEF VAR n_name1    AS CHAR  FORMAT "X(70)". 

DEF VAR JV_output  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_write AS CHAR FORMAT "X(20)".    
DEF NEW SHARED VAR n_gldat  AS DATE.
DEF VAR frm_bran   LIKE uwm100.branch LABEL " From Branch        :  ".
DEF VAR to_bran    LIKE uwm100.branch LABEL "To                            :  ".
DEF NEW SHARED VAR n_source AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR n_jv     AS LOGICAL.
DEF VAR nv_reccnt  AS INT.
DEF VAR nv_next    AS INT.
DEF VAR cntop      AS INT.


DEF VAR nv_amount AS DECIMAL  FORMAT "->>>,>>>,>>>,>>9.99".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME frmain

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS recOutput-5 recOutput-6 recOutput-7 ~
recOutput-8 RecOK-3 RecOK-4 fi_branfr fi_branto fi_jvdat fi_source ~
fi_output bu_ok bu_cancel 
&Scoped-Define DISPLAYED-OBJECTS fi_branfr fi_branto fi_jvdat fi_source ~
fi_output 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_cancel 
     LABEL "CANCEL" 
     SIZE 15.33 BY 1.52
     FONT 2.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 15.33 BY 1.52
     FONT 2.

DEFINE VARIABLE fi_branfr AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_branto AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_jvdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 38.5 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_source AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE RECTANGLE RecOK-3
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16.5 BY 1.91
     BGCOLOR 1 .

DEFINE RECTANGLE RecOK-4
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16.5 BY 1.91
     BGCOLOR 1 .

DEFINE RECTANGLE recOutput-5
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 48.5 BY 3.52
     BGCOLOR 8 .

DEFINE RECTANGLE recOutput-6
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 48.5 BY 1.81
     BGCOLOR 8 .

DEFINE RECTANGLE recOutput-7
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 48.5 BY 3
     BGCOLOR 8 .

DEFINE RECTANGLE recOutput-8
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 67 BY 1.81
     BGCOLOR 8 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frmain
     fi_branfr AT ROW 4.43 COL 42.83 COLON-ALIGNED NO-LABEL 
     fi_branto AT ROW 5.81 COL 42.83 COLON-ALIGNED NO-LABEL 
     fi_jvdat AT ROW 7.81 COL 42.83 COLON-ALIGNED NO-LABEL 
     fi_source AT ROW 9.62 COL 58 RIGHT-ALIGNED NO-LABEL 
     fi_output AT ROW 12.62 COL 28.5 COLON-ALIGNED NO-LABEL 
     bu_ok AT ROW 14.81 COL 22 
     bu_cancel AT ROW 14.81 COL 47 
     "Output To :" VIEW-AS TEXT
          SIZE 16.17 BY .62 AT ROW 12.81 COL 12.5 
          BGCOLOR 8 FONT 2
     "Source       :" VIEW-AS TEXT
          SIZE 20 BY .62 AT ROW 9.81 COL 21.83 
          BGCOLOR 8 FONT 2
     "JV Date      :" VIEW-AS TEXT
          SIZE 19.5 BY .62 AT ROW 8 COL 21.83 
          BGCOLOR 8 FONT 2
     "Branch From  :" VIEW-AS TEXT
          SIZE 21 BY .62 AT ROW 4.62 COL 21.83 
          BGCOLOR 8 FONT 2
     "C6 = direct , C7 = RI" VIEW-AS TEXT
          SIZE 29.5 BY .62 AT ROW 11.05 COL 34.83 
          BGCOLOR 8 FGCOLOR 1 FONT 2
     "Branch To    :" VIEW-AS TEXT
          SIZE 21.5 BY .62 AT ROW 6.05 COL 21.83 
          BGCOLOR 8 FONT 2
     "                     PRINT JV O/S CLAIM" VIEW-AS TEXT
          SIZE 79.83 BY 1.52 AT ROW 1.71 COL 1.17 
          BGCOLOR 1 FGCOLOR 7 FONT 2
     recOutput-5 AT ROW 3.86 COL 16.83 
     recOutput-6 AT ROW 7.38 COL 16.83 
     recOutput-7 AT ROW 9.19 COL 16.83 
     recOutput-8 AT ROW 12.19 COL 7.5 
     RecOK-3 AT ROW 14.62 COL 21.33 
     RecOK-4 AT ROW 14.62 COL 46.33 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 16
         BGCOLOR 3  .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "<insert window title>"
         HEIGHT             = 16
         WIDTH              = 80
         MAX-HEIGHT         = 47.71
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 47.71
         VIRTUAL-WIDTH      = 213.33
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME frmain
   FRAME-NAME                                                           */
/* SETTINGS FOR FILL-IN fi_source IN FRAME frmain
   ALIGN-R                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* <insert window title> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* <insert window title> */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_cancel C-Win
ON CHOOSE OF bu_cancel IN FRAME frmain /* CANCEL */
DO:

  APPLY "CLOSE" TO THIS-PROCEDURE.
  
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME frmain /* OK */
DO:
  
  IF nv_branfr = "" THEN DO:
     MESSAGE " ** Please Enter Branch From ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_branfr IN FRAM frmain.
     RETURN NO-APPLY.
  END.

  IF nv_branto = "" THEN DO:
     MESSAGE "** Please Enter Branch To ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_branto IN FRAM frmain.
     RETURN NO-APPLY.
  END.
 
  IF nv_jvdat = ? THEN DO:
     MESSAGE "** Please Enter JV Date ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_jvdat IN FRAM frmain.
     RETURN NO-APPLY.
  END.

  IF nv_source  = ""  THEN DO:
     MESSAGE "** Please Enter Source ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_source IN FRAM frmain.
     RETURN NO-APPLY.
  END. 

  IF nv_source <> "C6"  AND
     nv_source <> "C7"  THEN DO:
     MESSAGE "** Please Check Source **" VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_source IN FRAM frmain.
     RETURN NO-APPLY.
  END.

  IF nv_output = "" THEN DO:
     MESSAGE "** Please Enter Output **" VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_output IN FRAM frmain.
     RETURN NO-APPLY.
  END.

  /* ------------- end check data ------------------*/
 
    FOR EACH xtm101 NO-LOCK.
        ASSIGN n_name1 = xtm101.left70.  
    END.

     ASSIGN

        jv_output = nv_output + "JV.SLK" 
        n_ln1     = FILL("=",75)
        n_ln2     = n_ln1
        n_ln3     = n_ln1
        n_safety  = CHR(27) + CHR(69) + CHR(14) + n_name1 +                                    /*A51-0261*/
                    CHR(27) + CHR(70) + CHR(20)
        n_prnjv   = CHR(27) + CHR(69) + CHR(14) + "ใบสำคัญทั่วไป" +
                    CHR(27) + CHR(70) + CHR(20).
        
      
    OUTPUT TO VALUE (jv_output) NO-ECHO.
    EXPORT DELIMITER ";" 
      "" "ใบสำคัญทั่วไป".
    EXPORT DELIMITER ";" "".
    OUTPUT CLOSE.

    FOR EACH azr516 WHERE azr516.gldat   = nv_jvdat   AND
                          azr516.branch >= nv_branfr  AND
                          azr516.branch <= nv_branto  AND
                          azr516.amount <> 0          AND
                          azr516.source  = nv_source  AND
                          azr516.prgrp  <= 2          NO-LOCK
                    BREAK BY azr516.branch
                          BY azr516.prgrp
                         /* BY azr516.drcr  DESCENDING*/
                          BY azr516.macc
                          BY azr516.sacc1
                          BY azr516.sacc2:  
        ASSIGN nv_amount = azr516.amount.

        IF FIRST-OF (azr516.bran) THEN DO:
           OUTPUT TO VALUE (jv_output) APPEND NO-ECHO. 
           EXPORT DELIMITER ";"
      "" "" "" "เลขที่ __________".
    EXPORT DELIMITER ";" "".
    EXPORT DELIMITER ";"
      "" n_safety.
    EXPORT DELIMITER ";"
      ""  .   
    EXPORT DELIMITER ";"
      "" "   วันที่" 
      nv_jvdat FORMAT "99/99/9999".
    EXPORT DELIMITER ";"
      n_ln1.                           
    EXPORT DELIMITER ";"
      "ประเภทบัญชี"                      
      "  บัญชีเลขที่"  
      " SUB1"
      " SUB2"
      "       เดบิต"                    
      "       เครดิต".
    EXPORT DELIMITER ";"
      n_ln2.
           OUTPUT CLOSE. 
        END.

            IF  FIRST-OF(azr516.prgrp)  THEN DO:
            ASSIGN  n_branchT  = ""
                    n_txt      = ""
                    n_prdes    = ""
                    n_txt2     = "".
            FIND FIRST xmd179 WHERE xmd179.docno  = "710"  AND
                          SUBSTRING(xmd179.headno,1,1) = azr516.branch 
                          NO-LOCK NO-ERROR.
            IF AVAILABLE xmd179 THEN n_branchT  = xmd179.head.

            IF azr516.prgrp <> 4 THEN DO:
               ASSIGN   n_date   = azr516.gldat
                        n_monthT = ""
                        n_yearT  = YEAR(azr516.gldat) + 543.

               IF MONTH(azr516.gldat) = 1  THEN  n_monthT = "มกราคม".
               IF MONTH(azr516.gldat) = 2  THEN  n_monthT = "กุมภาพันธ์".
               IF MONTH(azr516.gldat) = 3  THEN  n_monthT = "มีนาคม".
               IF MONTH(azr516.gldat) = 4  THEN  n_monthT = "เมษายน".
               IF MONTH(azr516.gldat) = 5  THEN  n_monthT = "พฤษภาคม".
               IF MONTH(azr516.gldat) = 6  THEN  n_monthT = "มิถุนายน".
               IF MONTH(azr516.gldat) = 7  THEN  n_monthT = "กรกฎาคม".
               IF MONTH(azr516.gldat) = 8  THEN  n_monthT = "สิงหาคม".
               IF MONTH(azr516.gldat) = 9  THEN  n_monthT = "กันยายน".
               IF MONTH(azr516.gldat) = 10 THEN  n_monthT = "ตุลาคม".
               IF MONTH(azr516.gldat) = 11 THEN  n_monthT = "พฤศจิกายน".
               IF MONTH(azr516.gldat) = 12 THEN  n_monthT = "ธันวาคม".

               IF azr516.prgrp = 1 THEN  n_prdes = "ค่านายหน้า".
               IF azr516.prgrp = 2 THEN  n_prdes = "ค่าเบี้ยประกัน".
               IF azr516.prgrp = 3 THEN  n_prdes = "ค่าภาษีมูลค่าเพิ่มค่านายหน้า".
            END.
            ELSE ASSIGN  n_prdes = "ยกเลิกการตั้งค่าภาษีมูลค่าเพิ่มค่านายหน้า"
                         n_date  = ?.

            n_txt = "คำอธิบาย  : บันทึก" + TRIM(n_prdes) + "  " +
                    TRIM(n_branchT) + "(" + AZR516.BRANCH + ")" +
                    "  ประจำเดือน " + TRIM(n_monthT) + " "  +
                    STRING(n_yearT).

            n_txt2 = "(GL Date  : " + STRING(azr516.gldat,"99/99/9999") + 
                     "   Source : " + azr516.source + ")".
        END. /* End FIRST-OF (prgp) */

        FIND gl.glm001  USE-INDEX glm00101 WHERE
             gl.glm001.yr    = STRING(YEAR(azr516.gldat)) AND
             gl.glm001.compy = "0"                        AND
             gl.glm001.macc  = azr516.macc                AND
             gl.glm001.sacc1 = azr516.sacc1               AND
             gl.glm001.sacc2 = azr516.sacc2               NO-LOCK NO-ERROR.
        IF AVAILABLE  gl.glm001    THEN DO:
           ASSIGN  n_gltxt    =  TRIM(gl.glm001.desc1)
                   n_prnmacc  =  gl.glm001.macc.
        END.
        ELSE DO:
           FIND FIRST gl.glm001  USE-INDEX glm00101  WHERE
                      gl.glm001.yr    = STRING(YEAR(azr516.gldat)) AND
                      gl.glm001.compy = "0"                        AND
                      gl.glm001.macc  = azr516.macc                AND
                      gl.glm001.sacc1 = azr516.sacc1 NO-LOCK NO-ERROR.
           IF AVAILABLE gl.glm001 THEN DO:
              ASSIGN  n_gltxt    =  TRIM(gl.glm001.desc1)
                      n_prnmacc  =  gl.glm001.macc.
           END.
           ELSE DO:
               FIND FIRST  gl.glm001  USE-INDEX glm00101 WHERE
                    gl.glm001.yr    = STRING(YEAR(azr516.gldat)) AND
                    gl.glm001.compy = "0"                        AND
                    gl.glm001.macc  = azr516.macc   NO-LOCK NO-ERROR.
               IF AVAILABLE gl.glm001 THEN DO:
                  ASSIGN  n_gltxt   = TRIM(gl.glm001.desc1)
                          n_prnmacc = gl.glm001.macc.
               END.
               ELSE ASSIGN  n_gltxt    = ""
                            n_prnmacc  = azr516.macc.
           END.
        END.

        IF  azr516.drcr  THEN DO:
            n_gltxt  = TRIM(n_gltxt).
            OUTPUT TO VALUE (jv_output) APPEND NO-ECHO. 
            EXPORT DELIMITER ";" 
              n_gltxt 
              n_prnmacc
              "'" + azr516.sacc1 FORMAT "X(3)"
              "'" + azr516.sacc2 FORMAT "X(3)"
               /*azr516.amount. */
                nv_amount.
            OUTPUT CLOSE.
            NT_DR   = NT_DR + AZR516.AMOUNT.
        END.
        ELSE DO:
            n_gltxt  = TRIM(n_gltxt).
            OUTPUT TO VALUE (jv_output) APPEND NO-ECHO.   


    IF nv_reccnt > 65500 THEN  DO:
        ASSIGN
          cntop     = LENGTH(jv_output) - 5  /*-- ตัดชื่อ ==> XXXX1.SLK --*/
          nv_next   = nv_next + 1
          nv_output = SUBSTR(jv_output,1,cntop) + STRING(nv_next) + ".SLK"
          nv_reccnt = 0.
        OUTPUT TO VALUE (jv_output) NO-ECHO.
        EXPORT DELIMITER ";"
        "BRANCH "          
        "POL.LINE "        
        "POLICY "          
        "RENCNT "          
        "ENDCNT "          
        "ENDT.NO. " 
        "COM.DATE"
        "TRANS.DATE "      
        "PREMIUM "         
        "COMPULSORY "      
        "PA "              
        "TOT.PREMIUM "     
        "STAMP "           
        "STAMP COMPULSORY "
        "STAMP PA "        
        "TOT.STAMP "       
        "VAT "             
        "VAT COMPULSORY "  
        "VAT PA "          
        "TOT.VAT  "        
        "TOT.PREM VAT  "   
        "SBT "             
        "TOT.PREM SBT "    
        "COMM. "           
        "COMM. COMPULSORY "
        "COMM. PA  " 
        "TOT.COMM.  "
        "R/I Disc."
        "TOT.COMM.DISC."
        "PRNVAT ".
        OUTPUT CLOSE.
        nv_reccnt = nv_reccnt + 1.
    END.  

            EXPORT DELIMITER ";" 
              n_gltxt           
              n_prnmacc  
              "'" + azr516.sacc1 FORMAT "X(3)"
              "'" + azr516.sacc2 FORMAT "X(3)"
              ""
              /*azr516.amount . */
                nv_amount.
            OUTPUT CLOSE.
   
            NT_CR   = NT_CR + AZR516.AMOUNT.
        END.

        IF LAST-OF(azr516.prgrp) THEN DO:
            OUTPUT TO VALUE (jv_output) APPEND NO-ECHO.
            EXPORT DELIMITER ";"
              FILL("-",120).
            EXPORT DELIMITER ";"
              n_txt.
            EXPORT DELIMITER ";"
              n_txt2.
            EXPORT DELIMITER ";" "".
            OUTPUT CLOSE.

            IF LAST-OF(azr516.branch) THEN DO:
               OUTPUT TO VALUE (jv_output) APPEND NO-ECHO.   
               EXPORT DELIMITER ";"
                 "" "" "" "  Total DR/CR  "   NT_DR   NT_CR .
               OUTPUT CLOSE.
               ASSIGN nt_dr  = 0  nt_cr  = 0    nv_amount = 0 .

               OUTPUT TO VALUE (jv_output) APPEND NO-ECHO.  
               EXPORT DELIMITER ";" "".
               EXPORT DELIMITER ";"
                 "____________________"          
                 "____________________"           
                 "____________________"           
                 "____________________"  .
               EXPORT DELIMITER ";"
                  "     ผู้จัดเตรียม   "           
                  "    ผู้ตรวจฝ่ายบัญชี "          
                  "      สมุห์บัญชี"               
                  "     ผู้บันทึกบัญชี " .
               EXPORT DELIMITER ";"
                  n_ln3.
               EXPORT DELIMITER ";" "".
               EXPORT DELIMITER ";" "".
               OUTPUT CLOSE. 
            END. /*END if Last-of (branch)*/
        END. /*END if Last-of (prgrp)*/
    END.   /* END FOR EACH */

    MESSAGE " .. Print Complete .. " VIEW-AS ALERT-BOX.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branfr C-Win
ON LEAVE OF fi_branfr IN FRAME frmain
DO:
    ASSIGN

      fi_branfr = CAPS(INPUT fi_branfr)
      nv_branfr = CAPS(fi_branfr).

      DISP fi_branfr WITH FRAM frmain .


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branto C-Win
ON LEAVE OF fi_branto IN FRAME frmain
DO:
    ASSIGN

        fi_branto = CAPS(INPUT fi_branto)
        nv_branto = CAPS(fi_branto).

        DISP fi_branto WITH FRAM frmain .

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_jvdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_jvdat C-Win
ON LEAVE OF fi_jvdat IN FRAME frmain
DO:
    ASSIGN

        fi_jvdat   = INPUT fi_jvdat
        nv_jvdat   = fi_jvdat.

        DISP fi_jvdat WITH FRAM frmain .

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output C-Win
ON LEAVE OF fi_output IN FRAME frmain
DO:
      ASSIGN

        fi_output = INPUT fi_output
        nv_output = fi_output.

        DISP fi_output WITH FRAM frmain .


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_source
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_source C-Win
ON LEAVE OF fi_source IN FRAME frmain
DO:
    ASSIGN

    fi_source = CAPS(INPUT fi_source)
    nv_source = CAPS(fi_source).

    DISP fi_source WITH FRAM frmain .

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:

    DEF VAR gv_prog  AS CHAR FORMAT "x(30)".
  DEF VAR gv_prgid AS CHAR FORMAT "x(15)".

  gv_prgid = "WACROSC4".
  gv_prog  = "Print JV O/S Claim".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

   RUN wac\waccongl.
    SESSION:DATA-ENTRY-RETURN = YES.

  RUN enable_UI.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
  THEN DELETE WIDGET C-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  DISPLAY fi_branfr fi_branto fi_jvdat fi_source fi_output 
      WITH FRAME frmain IN WINDOW C-Win.
  ENABLE recOutput-5 recOutput-6 recOutput-7 recOutput-8 RecOK-3 RecOK-4 
         fi_branfr fi_branto fi_jvdat fi_source fi_output bu_ok bu_cancel 
      WITH FRAME frmain IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frmain}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

