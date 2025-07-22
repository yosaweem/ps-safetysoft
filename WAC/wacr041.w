&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
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

  Modify By: Lukkana M. A51-0082 17/11/2008
          - เปลี่ยน format batch no. จาก BBXXXXXX มาเป็น BBYYMMXXXX
          
  Modify By : Sayamol N. A53-0221  27/07/2553
          - ขยาย Format PV No. จากเดิม 10 หลักเป็น 13 หลัก    
  
  Modify By Nattanicha N. A57-0148  29/04/2014
   - แก้ไขการบันทึกบัญชีด้านเดบิต และ เครดิต จะไม่เท่ากัน   
  
  Modify By Nattanicha N. A57-0333 18/09/2014
   - Default Doc Type ตาม Branch User
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */
/*----------------------------------------------------------------------
     Modify By: Saharat S.  A62-0279  03/12/2019
      -เปลี่ยนหัว เป็น TMSTH
----------------------------------------------------------------------*/
CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */
DEF SHARED VAR n_User   AS CHAR.
DEF SHARED VAR n_Passwd AS CHAR.
DEF VAR   nv_User       AS CHAR NO-UNDO.
/*DEF VAR   nv_pwd        LIKE _password NO-UNDO. lukkana M. A51-0082 19/11/2008*/
DEF VAR   nv_pwd        AS CHAR NO-UNDO . /*Lukkana M. A51-0082 19/11/2008*/

ASSIGN
    nv_User = n_user
    nv_pwd  = n_passwd.

DEF VAR n_compy       LIKE  gl_bran.CHM015.COMPY.    
DEF VAR n_bthno       LIKE  gl_bran.CHM015.BCHNO.
DEF VAR n_bthty       LIKE  gl_bran.CHM015.BCHTYP.
DEF VAR n_bthdesc     LIKE  gl_bran.CHM100.ITMDES.
DEF VAR n_docno       LIKE  gl_bran.GLT000.DOCNO FORMAT "X(13)".    /*A53-0221*/
DEF VAR n_accyr       AS    CHAR   FORMAT "X(4)".
DEF VAR n_accmth      AS    CHAR   FORMAT "X(2)".
DEF VAR n_trntyp      LIKE  gl_bran.CHM015.TRNTYP.

DEF VAR n_print       AS LOGIC.
DEF VAR n_outtyp      AS INTEGER  FORMAT "9".
DEF VAR n_output      AS CHAR.
DEF STREAM ns1.
DEF VAR nv_output     AS CHAR.
DEF VAR nv_output2    AS CHAR.

DEF VAR n_safety      AS  CHAR     FORMAT "X(50)".
DEF VAR n_jv          AS  CHAR     FORMAT "X(25)".
DEF VAR n_date        AS  DATE     FORMAT "99/99/9999".
DEF VAR n_gltxt       AS  CHAR     FORMAT "X(50)".
DEF VAR n_macc        AS  CHAR     FORMAT "X(16)".
DEF VAR n_sub1        AS  CHAR     FORMAT "X(6)".
DEF VAR n_sub2        AS  CHAR     FORMAT "X(6)".
DEF VAR n_txt         AS  CHAR     FORMAT "X(130)".
DEF VAR n_ln1         AS  CHAR     FORMAT "X(115)".
DEF VAR n_ln2         AS  CHAR     FORMAT "X(115)".
DEF VAR n_doc         AS  CHAR     FORMAT "X(25)".         
DEF VAR n_username    AS  CHAR     FORMAT "X(40)".

DEF VAR nt_dramt      LIKE gl_bran.GLT001.LOCAMT.
DEF VAR nt_cramt      LIKE gl_bran.GLT001.LOCAMT.

DEF VAR txtprn         AS CHAR.
DEF VAR n_filename     AS CHAR INIT "".
DEF VAR n_copy         AS INT  INIT 1.
DEF VAR n_destination  AS CHAR INIT "".
DEF VAR n_printer      AS CHAR INIT "".

DEF VAR nv_usesta     AS CHAR INIT "P7".   /* Print Status */
DEF VAR nv_userName   AS CHAR.
DEF VAR datasta       AS LOGICAL.
DEF VAR nv_entdat     AS DATE.
DEF VAR nv_enttim     AS CHAR INIT "".

/* Report -------------------------------------------------------*/
DEF  VAR report-library AS CHAR. /*INIT "wFN/wprl/reports.prl".*/
DEF  VAR report-name    AS CHAR.   /*INIT "reminder".*/

DEF  VAR RB-DB-CONNECTION     AS CHAR INIT "".
DEF  VAR RB-INCLUDE-RECORDS   AS CHAR INIT "O".   /*Can Override Filter*/
DEF  VAR RB-FILTER            AS CHAR INIT "".
DEF  VAR RB-MEMO-FILE         AS CHAR INIT "".
DEF  VAR RB-PRINT-DESTINATION AS CHAR INIT "?". /*Direct to Screen*/
DEF  VAR RB-PRINTER-NAME      AS CHAR INIT "".
DEF  VAR RB-PRINTER-PORT      AS CHAR INIT "".
DEF  VAR RB-OUTPUT-FILE       AS CHAR INIT "".
DEF  VAR RB-NUMBER-COPIES     AS INTE INIT 1.
DEF  VAR RB-BEGIN-PAGE        AS INTE INIT 0.
DEF  VAR RB-END-PAGE          AS INTE INIT 0.
DEF  VAR RB-TEST-PATTERN      AS LOG INIT no.
DEF  VAR RB-WINDOW-TITLE      AS CHAR INIT "".
DEF  VAR RB-DISPLAY-ERRORS    AS LOG INIT yes.
DEF  VAR RB-DISPLAY-STATUS    AS LOG INIT yes.
DEF  VAR RB-NO-WAIT           AS LOG INIT no.
DEF  VAR RB-OTHER-PARAMETERS  AS CHAR INIT "".

DEF VAR NAME_1   AS  CHAR     FORMAT "X(70)".    /*A51-0261*/
/*ADD Saharat S. A62-0279*/
{wuw\wuwppic00.i NEW}. 
{wuw\wuwppic01.i}
{wuw\wuwppic02.i}
/*END Saharat S. A62-0279*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME F-main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_remark fi_compy fi_trntypdes fi_accyr ~
fi_accmth fi_trntyp fi_docnofr fi_docnoto BU_Print BU_Cancel BU_exit ~
RECT-89 RECT-90 RECT-91 RECT-93 RECT-94 RECT-95 
&Scoped-Define DISPLAYED-OBJECTS fi_remark fi_compy fi_trntypdes fi_accyr ~
fi_accmth fi_trntyp fi_docnofr fi_docnoto fi_codesc fi_status 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BU_Cancel 
     LABEL "Cancel" 
     SIZE 15 BY 1.14
     FONT 6.

DEFINE BUTTON BU_exit 
     LABEL "Exit" 
     SIZE 15 BY 1.14
     FONT 6.

DEFINE BUTTON BU_Print 
     LABEL "Print" 
     SIZE 15 BY 1.14
     FONT 6.

DEFINE VARIABLE fi_accmth AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_accyr AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_codesc AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 53 BY 1
     BGCOLOR 15 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_compy AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_docnofr AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_docnoto AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 9 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_remark AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 69.5 BY .95
     BGCOLOR 8 FGCOLOR 6  NO-UNDO.

DEFINE VARIABLE fi_status AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     BGCOLOR 3 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trntyp AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_trntypdes AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 53.67 BY .95
     BGCOLOR 8 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-89
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 95.5 BY 15.38
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-90
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 89.5 BY 7.57
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-91
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 89.5 BY 1.81
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-93
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17 BY 1.57
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-94
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17 BY 1.57
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-95
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17 BY 1.57
     BGCOLOR 3 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-main
     fi_remark AT ROW 15.67 COL 3.17 COLON-ALIGNED NO-LABEL
     fi_compy AT ROW 5.43 COL 27 COLON-ALIGNED NO-LABEL
     fi_trntypdes AT ROW 8.71 COL 36.33 COLON-ALIGNED NO-LABEL
     fi_accyr AT ROW 7.05 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_accmth AT ROW 7.05 COL 45.5 COLON-ALIGNED NO-LABEL
     fi_trntyp AT ROW 8.62 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_docnofr AT ROW 10.48 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_docnoto AT ROW 10.52 COL 53.5 COLON-ALIGNED NO-LABEL
     BU_Print AT ROW 12.71 COL 7
     BU_Cancel AT ROW 12.71 COL 27.5
     BU_exit AT ROW 14.81 COL 79.5
     fi_codesc AT ROW 5.43 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_status AT ROW 12.76 COL 94 RIGHT-ALIGNED NO-LABEL
     "Doc Type :" VIEW-AS TEXT
          SIZE 11.5 BY .62 AT ROW 8.86 COL 16.5
          BGCOLOR 8 FONT 6
     "To :" VIEW-AS TEXT
          SIZE 4.83 BY .62 AT ROW 10.76 COL 50.5
          BGCOLOR 8 FONT 6
     "Year :" VIEW-AS TEXT
          SIZE 6.17 BY .62 AT ROW 7.29 COL 21.83
          BGCOLOR 8 FONT 6
     "Month:" VIEW-AS TEXT
          SIZE 7.5 BY .95 AT ROW 7.19 COL 39.5
          BGCOLOR 8 FONT 6
     " Status :" VIEW-AS TEXT
          SIZE 9 BY 1 AT ROW 12.76 COL 69.5
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "RC No. From :" VIEW-AS TEXT
          SIZE 14.33 BY .62 AT ROW 10.81 COL 13.67
          BGCOLOR 8 FONT 6
     "Company :" VIEW-AS TEXT
          SIZE 10.5 BY .76 AT ROW 5.71 COL 18
          BGCOLOR 8 FONT 6
     "  Print RV Transaction Entry List                               ใบสำคัญทั่วไป" VIEW-AS TEXT
          SIZE 87 BY 1.14 AT ROW 2.67 COL 8
          BGCOLOR 3 FGCOLOR 7 FONT 40
     RECT-89 AT ROW 1.52 COL 3
     RECT-90 AT ROW 4.67 COL 6
     RECT-91 AT ROW 2.29 COL 6
     RECT-93 AT ROW 12.48 COL 26.5
     RECT-94 AT ROW 12.48 COL 6
     RECT-95 AT ROW 14.57 COL 78.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 100 BY 16.48
         BGCOLOR 3 .


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
         TITLE              = "Print RV Transaction Entry List  - Wacr041.w"
         HEIGHT             = 16.48
         WIDTH              = 100
         MAX-HEIGHT         = 45.76
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.76
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

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT C-Win:LOAD-ICON("Wimage\safety":U) THEN
    MESSAGE "Unable to load icon: Wimage\safety"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-main
   FRAME-NAME Custom                                                    */
/* SETTINGS FOR FILL-IN fi_codesc IN FRAME F-main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_status IN FRAME F-main
   NO-ENABLE ALIGN-R                                                    */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Print RV Transaction Entry List  - Wacr041.w */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Print RV Transaction Entry List  - Wacr041.w */
DO:
  /*--------- FON -------
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
  ---------------------*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BU_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BU_Cancel C-Win
ON CHOOSE OF BU_Cancel IN FRAME F-main /* Cancel */
DO:
  ASSIGN
     fi_compy    = ""
     fi_codesc   = ""
     fi_trntyp    = ""
     fi_docnofr  = ""
     fi_docnoto  = ""
     n_print     = NO.
  
  DISP fi_compy   fi_codesc
       fi_trntyp   fi_docnofr fi_docnoto
  WITH FRAME {&FRAME-NAME}. 
       
  APPLY "ENTRY" TO fi_compy.        
     
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BU_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BU_exit C-Win
ON CHOOSE OF BU_exit IN FRAME F-main /* Exit */
DO:

  FOR EACH artmp USE-INDEX artmp01 WHERE
                   artmp.usrid  = n_User   AND
                   artmp.entdat = nv_entdat AND
                   artmp.enttim = nv_enttim AND
                   artmp.usesta = "P7".   
                DELETE artmp.
  END.
  RELEASE artmp.
  
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BU_Print
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BU_Print C-Win
ON CHOOSE OF BU_Print IN FRAME F-main /* Print */
DO:

    
  /*----------------
  RUN Wgl\Wglprn01(OUTPUT n_print,
                   OUTPUT n_outtyp,
                   OUTPUT n_output) .
      
  IF n_print THEN DO:
     fi_status   =  "Printing".
     DISP fi_status WITH FRAME {&FRAME-NAME}.
     
     IF n_outtyp = 1 OR n_outtyp = 2 THEN DO: 
                        
        RUN PdPrintToPrinter_File.
        
        fi_status = "Complete". 
        DISP fi_status WITH FRAME {&FRAME-NAME}.    
     END.
     ELSE DO:
        RUN PdPrintToExcel.
    ------------------*/
       
   IF fi_docnofr = "" OR fi_docnoto = "" THEN DO:
      MESSAGE "RC No. is invalid! Please Enter RC No. " VIEW-AS ALERT-BOX.
      APPLY "ENTRY" TO fi_docnofr IN FRAME {&FRAME-NAME}.
      RETURN NO-APPLY.
   END.

   FOR EACH artmp USE-INDEX artmp01 WHERE
                         artmp.usrid  = n_User   AND
                         artmp.entdat = nv_entdat AND
                         artmp.enttim = nv_enttim AND
                         artmp.usesta = "P7":
        DELETE artmp.
    END.
    
           RUN pdCreateArtmp.
        
            /*------------- Fon:20/04/04 ---------------------------*/
            Report-library       =  "Wac\Wprl\wacr041.PRL". 
            Report-Name          =  "GLTrnLst1".
            
            /*---A58-0164---
            RUN Wgl\Wglprn02 (INPUT-OUTPUT n_copy,
                              INPUT-OUTPUT n_destination,
                              INPUT-OUTPUT n_printer,
                              INPUT-OUTPUT n_filename,
                              INPUT-OUTPUT n_print).
            --------------------*/

            /*---A58-0164---*/
            ASSIGN n_print = YES
                   n_copy = 1
                   n_printer = "PDFCreator".
        

            IF n_printer <> ? AND n_filename = "" THEN DO:
                          
                RB-NUMBER-COPIES     = n_copy.
                RB-PRINT-DESTINATION = n_destination.
                RB-PRINTER-NAME      = n_printer.
                RB-OUTPUT-FILE       = n_filename.

                FIND FIRST dbtable WHERE dbtable.phyname = "form" OR dbtable.phyname = "sicfn"
                    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL dbtable THEN DO:
                    IF dbtable.phyname = "form" THEN DO:
                        ASSIGN
                            nv_User = "?"
                            nv_pwd = "?".
                        RB-DB-CONNECTION = dbtable.unixpara.
                    END.
                    ELSE DO:
                        RB-DB-CONNECTION = dbtable.unixpara + " -U " + nv_user + " -P " + nv_pwd.
                    END.
                END.
                /*-end A51-0261*/
               

                 RB-FILTER  = "artmp.branch  = '" + fi_compy   + "' " + " AND " +
                              "artmp.rectyp   = '" + fi_trntyp   + "' " + " AND " +
                              "artmp.rvno   >= '" + fi_docnofr + "' " + " AND " +
                              "artmp.rvno   <= '" + fi_docnoto + "' " + " AND " +
                              "artmp.usrid   = '" + n_user    + "'"  + " AND " +    
                              "artmp.entdat  = "  +                              
                               STRING (MONTH (nv_entdat))      + "/"  +              
                               STRING (DAY (nv_entdat))  + "/" +                
                               STRING (YEAR (nv_entdat)) + "  AND "   +           
                              "artmp.enttim  = '" + nv_enttim  + "'" + " AND " + 
                              "artmp.usesta  = '" + nv_usesta  + "'" .

                 RB-OTHER-PARAMETERS = /*"rb_name_1 =" + name_1 .*/     /*kridtiya i. A51-0261*/
                                       "rb_name_1 =" + nv_a4_34 + " " + nv_a4_03 . /*ADD Saharat S. A62-0279*/ 
                 
                
                 RUN aderb\_printrb(report-library, 
                                report-name,
                                RB-DB-CONNECTION,
                                RB-INCLUDE-RECORDS,
                                RB-FILTER,
                                RB-MEMO-FILE,
                                RB-PRINT-DESTINATION,
                                RB-PRINTER-NAME,
                                RB-PRINTER-PORT,
                                RB-OUTPUT-FILE,
                                RB-NUMBER-COPIES,
                                RB-BEGIN-PAGE,
                                RB-END-PAGE,
                                RB-TEST-PATTERN,
                                RB-WINDOW-TITLE,
                                RB-DISPLAY-ERRORS,
                                RB-DISPLAY-STATUS,
                                RB-NO-WAIT,
                                RB-OTHER-PARAMETERS).
                
                /*------------------- End of Fon ----------------------*/ 
              /*************************************/
            
                
                fi_status  =  "Printing Complete".
                DISP fi_status WITH FRAME {&FRAME-NAME}.
            
            END. /*END IF n_printer*/

            ELSE IF n_filename <> ? THEN DO:
                RUN pdPrintToExcel.
            END.

          /*END.    /* first-of */

        END.   /*for each artmp*/*/


        fi_status = "Complete". 
        DISP fi_status WITH FRAME {&FRAME-NAME}.

        IF fi_status = "Complete" THEN MESSAGE "Print Complete!" VIEW-AS ALERT-BOX INFORMATION.

        FOR  EACH  artmp USE-INDEX artmp01 WHERE
                   artmp.usrid  = n_User   AND
                   artmp.entdat = nv_entdat AND
                   artmp.enttim = nv_enttim AND
                   artmp.usesta = "P7".   
                DELETE artmp.
        END.

        RELEASE artmp.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accmth
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accmth C-Win
ON LEAVE OF fi_accmth IN FRAME F-main
DO:
  ASSIGN fi_accmth = INPUT fi_accmth.
  DISP fi_accmth WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accyr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accyr C-Win
ON LEAVE OF fi_accyr IN FRAME F-main
DO:
  
 ASSIGN fi_accyr = INPUT fi_accyr.
  DISP fi_accyr WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_compy
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_compy C-Win
ON LEAVE OF fi_compy IN FRAME F-main
DO:
   ASSIGN 
      fi_compy   =  INPUT fi_compy
      fi_codesc  = "".
  
   IF fi_compy <> "" THEN DO:
     
     FIND gl_bran.CHM020 USE-INDEX CHM02001 WHERE
          gl_bran.CHM020.COMPY = fi_compy   NO-LOCK NO-ERROR.
     IF NOT AVAILABLE CHM020 THEN DO:
        BELL.
        MESSAGE " Company record is not available in CHM020."
        VIEW-AS ALERT-BOX ERROR.
        APPLY "ENTRY" TO fi_compy.
        RETURN NO-APPLY.
     END.   
     ASSIGN
        fi_compy     =  CAPS(INPUT fi_compy)
        fi_codesc    =  gl_bran.CHM020.CONAM.
   END.
  
   DISP  fi_compy fi_codesc WITH FRAME f-main.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_docnofr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_docnofr C-Win
ON LEAVE OF fi_docnofr IN FRAME F-main
DO:
  ASSIGN fi_docnofr =  INPUT fi_docnofr
         fi_docnoto =  fi_docnofr.
  
  DISP fi_docnofr  fi_docnoto WITH FRAME {&FRAME-NAME}. 
      
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_docnoto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_docnoto C-Win
ON LEAVE OF fi_docnoto IN FRAME F-main
DO:
  ASSIGN
     fi_docnoto   =  INPUT fi_docnoto.
  
  IF fi_docnoto < fi_docnofr THEN DO:
     BELL.
     MESSAGE "Document No. To... must be greater than Document No. From...!"
     VIEW-AS ALERT-BOX Error.
     APPLY "ENTRY" TO fi_docnoto.
     RETURN NO-APPLY.
     
  END. 
 
  DISP fi_docnoto WITH FRAME {&FRAME-NAME}. 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trntyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trntyp C-Win
ON ENTRY OF fi_trntyp IN FRAME F-main
DO:

  /*---A57-0333---*/
  fi_remark = "กรุณาระบุ R แล้วตามด้วยสาขาที่ต้องการ เช่น RV, R1, R2, R12, R36,...".
  DISP fi_remark WITH FRAME F-main.
  /*-------------*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trntyp C-Win
ON LEAVE OF fi_trntyp IN FRAME F-main
DO:
 ASSIGN fi_trntyp = CAPS (INPUT fi_trntyp)
        fi_trntypdes = ""
        fi_remark = "".  /*A57-0333*/

 /*---- A57-0148----*/
 IF LENGTH(fi_trntyp) = 2 THEN DO:
    FIND FIRST gl_bran.CHM100 WHERE gl_bran.chm100.tabcod = "D001" AND 
                             SUBSTR(gl_bran.CHM100.ITMCOD,1,2) = fi_trntyp 
    NO-LOCK NO-ERROR.
    IF AVAILABLE gl_bran.CHM100 THEN DO:
      ASSIGN  fi_trntypdes  = gl_bran.CHM100.ITMDES.
    END.
    ELSE DO:
      ASSIGN  fi_trntypdes  = "Doc Type has not found! ".
    END.
 END.   /* if length(trntyp) = 2    ---Branch 1 หลัก---*/
 ELSE DO:
    FIND FIRST gl_bran.CHM100 WHERE gl_bran.chm100.tabcod = "D001" AND 
                             SUBSTR(gl_bran.CHM100.ITMCOD,1,3) = fi_trntyp  
    NO-LOCK NO-ERROR.
    IF AVAILABLE gl_bran.CHM100 THEN DO:
      ASSIGN  fi_trntypdes  = gl_bran.CHM100.ITMDES.
    END.
    ELSE DO:
      ASSIGN  fi_trntypdes  = "Doc Type has not found!".
    END.
 END.

 /*-------end A57-0148---*/


 DISP fi_trntyp fi_trntypdes fi_remark /*A57-0333*/ WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
/********************  T I T L E   F O R  C - W I N  ****************/
   DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
   DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(50)" NO-UNDO.
  
   gv_prgid = "Wacr041".
   gv_prog  = "Print RV Transaction Entry List".
   RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).
   RUN  WUT\WUTWICEN (c-win:handle).  
/*********************************************************************/

SESSION:DATA-ENTRY-RETURN = YES.
 
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
  RUN enable_UI.
    
  ASSIGN  /*nv_user       = USERID(LDBNAME("GL"))
          n_user        = nv_user*/
          nv_entdat     = TODAY
          nv_enttim     = STRING(TIME, "HH:MM:SS")
          fi_compy      = "3"
          fi_accyr      = STRING(YEAR(TODAY),"9999").
          /*fi_accmth     = STRING(MONTH(TODAY),"99")  ---- A57-0148---*/
          /*---A57-0333---
          fi_trntyp     = "RV".
          ----------*/
          IF LENGTH (nv_user) = 6 THEN DO: 
             IF SUBSTR(nv_user,6,1) = "0" THEN fi_trntyp = "RV".
             ELSE fi_trntyp = "R" + SUBSTR(nv_user,6,1).
          END.
          ELSE DO:
             fi_trntyp = "R" + SUBSTR(nv_user,6,2).
          END.

  DISP fi_compy fi_accyr /*---fi_accmth ----A57-0148---*/ 
       fi_trntyp  WITH FRAME f-main.

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
  DISPLAY fi_remark fi_compy fi_trntypdes fi_accyr fi_accmth fi_trntyp 
          fi_docnofr fi_docnoto fi_codesc fi_status 
      WITH FRAME F-main IN WINDOW C-Win.
  ENABLE fi_remark fi_compy fi_trntypdes fi_accyr fi_accmth fi_trntyp 
         fi_docnofr fi_docnoto BU_Print BU_Cancel BU_exit RECT-89 RECT-90 
         RECT-91 RECT-93 RECT-94 RECT-95 
      WITH FRAME F-main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-F-main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdCreateArtmp C-Win 
PROCEDURE PdCreateArtmp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR compy AS CHAR.
DEF VAR sacc1 AS CHAR.
DEF VAR entdat AS INTEGER.
DEF VAR trntyp AS CHAR.

ASSIGN compy = fi_compy.

FOR EACH gl_bran.GLT001 USE-INDEX GLT00101 WHERE 
            glt001.compy    = fi_compy   AND       
            glt001.accyr    = fi_accyr   AND       
            glt001.accmth   = fi_accmth  AND 
            glt001.trntyp   = fi_trntyp  AND       
            (glt001.docno  >= fi_docnofr AND
             glt001.docno  <= fi_docnoto) NO-LOCK
   BREAK BY gl_bran.GLT001.BTHNO
         BY gl_bran.GLT001.DOCNO 
         BY gl_bran.GLT001.DRCR   DESCENDING
         BY gl_bran.GLT001.MACC   :  

      CREATE artmp.
      ASSIGN artmp.usrid       = n_User
             artmp.entdat      = nv_entdat
             artmp.enttim      = nv_enttim
             artmp.usesta      = nv_usesta
             artmp.branch      = gl_bran.GLT001.COMPY 
             artmp.prjtyp      = gl_bran.GLT001.BTHTY
             artmp.prjno       = gl_bran.GLT001.BTHNO 
             artmp.rectyp      = gl_bran.GLT001.TRNTYP
             artmp.rvno        = gl_bran.GLT001.DOCNO 
             artmp.prjcode     = gl_bran.GLT001.MACC  
             artmp.text1       = gl_bran.GLT001.SACC1 
             artmp.text2       = gl_bran.GLT001.SACC2
             artmp.detail1     = TRIM(gl_bran.GLT001.DESC1)
             /*artmp.detail2     = TRIM(gl_bran.GLT001.DEsc2).*/
             artmp.text3        = TRIM(gl_bran.GLT001.DEsc2). 

       /*----- A56-0193
       FIND FIRST gl_bran.glt000 USE-INDEX glt00001 
                             WHERE gl_bran.glt000.compy = gl_bran.glt001.compy 
                               AND gl_bran.glt000.bthno = gl_bran.glt001.bthno
                               AND gl_bran.glt000.accyr = gl_bran.glt001.accyr
                               AND gl_bran.glt000.accmth = gl_bran.glt001.accmth
                               AND gl_bran.glt000.trntyp = gl_bran.glt001.trntyp
                               AND gl_bran.glt000.docno = gl_bran.glt001.docno NO-LOCK NO-ERROR.
       IF AVAIL gl_bran.glt000 THEN DO:
          ASSIGN artmp.DATE1       =  gl_bran.glt000.docdat.
       END.
       ---end A56-0193---*/

      ASSIGN artmp.DATE1       =  gl_bran.glt001.curdat.

       IF gl_bran.GLT001.DRCR = TRUE THEN DO:
          ASSIGN
            artmp.amt1        =  gl_bran.GLT001.LOCAMT
            artmp.settleflg   =  TRUE.
       END.
       ELSE DO:
          ASSIGN
            artmp.amt2        =  gl_bran.GLT001.LOCAMT
            artmp.settleflg   =  FALSE.
       END. 

       /* Lukkana M. A51-0082 19/11/2008*/
       FIND xzm600 WHERE
            xzm600.acno  =  artmp.usrid  NO-LOCK NO-ERROR.
       IF AVAILABLE xzm600 THEN
          artmp.detail2    =  xzm600.tname.
       /* Lukkana M. A51-0082 19/11/2008*/

       /*Add kridtiya i. A51-0261*/
       FOR EACH xtm101 NO-LOCK.
           ASSIGN NAME_1 = xtm101.left70.
       END.
       /*end kridtiya i. A51-0261*/



            FIND gl_bran.GLM001 USE-INDEX GLM00101       WHERE 
                gl_bran.GLM001.YR      = gl_bran.GLT001.ACCYR   AND 
                gl_bran.GLM001.COMPY   = gl_bran.GLT001.COMPY   AND 
                gl_bran.GLM001.MACC    = gl_bran.GLT001.MACC    AND
                gl_bran.GLM001.SACC1   = gl_bran.GLT001.SACC1   AND
                gl_bran.GLM001.SACC2   = gl_bran.GLT001.SACC2   NO-LOCK NO-ERROR.
            IF AVAILABLE GLM001 THEN 
              ASSIGN
                artmp.prjdes     = gl_bran.GLM001.DESC1.
            ELSE DO:
              ASSIGN
                artmp.prjdes     = "".
            END.
            
            ASSIGN trntyp = gl_bran.GLT001.TRNTYP.
            IF LENGTH(trntyp) = 2 THEN DO:
                FIND FIRST gl_bran.CHM100 WHERE gl_bran.chm100.tabcod = "D001" AND 
                                         SUBSTR(gl_bran.CHM100.ITMCOD,1,2) = trntyp 
                NO-LOCK NO-ERROR.
                IF AVAILABLE gl_bran.CHM100 THEN DO:
                  ASSIGN  artmp.ref1  = gl_bran.CHM100.ITMDES.
                END.
                ELSE DO:
                  ASSIGN  artmp.ref1  = "".
                END.
            END.   /* if length(trntyp) = 2    ---Branch 1 หลัก---*/
            ELSE DO:
                FIND FIRST gl_bran.CHM100 WHERE gl_bran.chm100.tabcod = "D001" AND 
                                         SUBSTR(gl_bran.CHM100.ITMCOD,1,3) = trntyp  
                NO-LOCK NO-ERROR.
                IF AVAILABLE gl_bran.CHM100 THEN DO:
                  ASSIGN  artmp.ref1  = gl_bran.CHM100.ITMDES.
                END.
                ELSE DO:
                  ASSIGN  artmp.ref1  = "".
                END.
            END.
            
            ASSIGN
                entdat = MONTH(nv_entdat)
                sacc1  = gl_bran.GLT001.sacc1.
            
            FIND FIRST gl_bran.CHM993  WHERE  gl_bran.CHM993.COMPY =  compy AND 
                                   gl_bran.CHM993.BRANCH  = sacc1    NO-LOCK NO-ERROR.
            IF AVAILABLE gl_bran.CHM993 THEN DO:
              ASSIGN artmp.ref2   = gl_bran.CHM993.DESCR.
            END.
            ELSE DO:
              ASSIGN artmp.ref2   = "".
            END.
     END.  /* for each glt001 */  

     
     
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdPrintToExcel C-Win 
PROCEDURE PdPrintToExcel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  
  /*-----------
  n_doc     =  fi_docno.
  n_date    =  fi_docdat. 
  ------------*/
   
   
/*   n_safety  = "บริษัท ประกันคุ้มภัย จำกัด (มหาชน)". */   /*A51-0261*/
  n_safety  = NAME_1.                                       /*A51-0261*/
  n_jv      = txtprn.
    
  /*nv_outpu = TRIM(n_output) + ".TXT" .*/                 /*A51-0261*/  
  nv_output = TRIM(n_filename) + ".TXT".                   /*A51-0261*/ 

 
                                                          
  OUTPUT STREAM  ns1  TO VALUE(nv_output).
  
  
FOR EACH gl_bran.GLT001 USE-INDEX GLT00102 WHERE 
            glt001.compy    = fi_compy   AND       
            glt001.accyr    = fi_accyr   AND       
            /*--- glt001.accmth   = fi_accmth  AND   ---A57-0148---*/
            glt001.trntyp   = fi_trntyp  AND       
            (glt001.docno  >= fi_docnofr AND
             glt001.docno  <= fi_docnoto) NO-LOCK       
             
  BREAK BY GLT001.BTHNO
        BY GLT001.DOCNO 
        BY GLT001.DRCR   DESCENDING
        BY GLT001.MACC   :  
             
     
     IF FIRST-OF(GLT001.DOCNO) THEN DO:
        ASSIGN
           n_date     = ?
           n_doc      = ""
           n_txt      = ""
           n_username = "".
       /*---aom---    
        FIND gl_bran.GLT000 USE-INDEX GLT00001    WHERE 
             gl_bran.GLT000.COMPY  = GLT001.COMPY   AND
             gl_bran.GLT000.BTHNO  = GLT001.BTHNO   AND
             gl_bran.GLT000.ACCYR  = GLT001.ACCYR   AND
             gl_bran.GLT000.ACCMTH = GLT001.ACCMTH  AND
             gl_bran.GLT000.TRNTYP = GLT001.TRNTYP  AND
             gl_bran.GLT000.DOCNO  = GLT001.DOCNO   NO-LOCK NO-ERROR.
        IF NOT AVAILABLE GLT000 THEN NEXT.     

        n_date  = GLT000.DOCDAT.
      --------end aom--------*/
        n_date  = gl_bran.glt001.curdat.
        n_doc   = GLT001.DOCNO.
        n_txt   = "คำอธิบาย  :  " + TRIM(GLT001.DESC1).
     
        FIND xzm600 WHERE
             xzm600.acno  =  glt001.useid  NO-LOCK NO-ERROR.
        IF AVAILABLE xzm600 THEN 
           n_username    =  xzm600.tname.
        /* Lukkana M. A51-0082 19/11/2008*/


        
        /*------------------- H E A D E R ----------------------*/
        PUT STREAM ns1 SPACE(60) n_safety  SPACE(60) SKIP.
        PUT STREAM ns1 SPACE(70) n_jv SPACE(70) SKIP.
        PUT STREAM ns1 "เลขที่" SPACE(3) n_doc  SPACE(60)
                       "วันที่" SPACE(3) n_date SKIP.       
                          
        PUT STREAM ns1 "ประเภทบัญชี" ";"
                       "บัญชีเลขที่" ";"
                       "SUB1" ";"
                       "SUB2" ";"
                       "เดบิต" ";"
                       "เครดิต" SKIP.
       /*---------------------  H E A D E R --------------------*/
        
     END.
                
     FIND  gl_bran.GLM001 USE-INDEX GLM00101    WHERE  /*USE-INDEX GLM00107*/
           gl_bran.GLM001.YR    = GLT001.ACCYR  AND
           gl_bran.GLM001.COMPY = GLT001.COMPY  AND
           gl_bran.GLM001.MACC  = GLT001.MACC   AND
           gl_bran.GLM001.SACC1 = GLT001.SACC1  AND
           gl_bran.GLM001.SACC2 = GLT001.SACC2  NO-LOCK NO-ERROR.
     IF AVAILABLE GLM001 THEN DO:
        ASSIGN
            n_gltxt  =  TRIM(GLM001.DESC1)
            n_macc   =  GLM001.MACC
            n_sub1   =  GLM001.SACC1
            n_sub2   =  GLM001.SACC2.
     END.          
     ELSE DO:
        ASSIGN
           n_gltxt  =  ""
           n_macc   =  GLT001.MACC
           n_sub1   =  GLT001.SACC1
           n_sub2   =  GLT001.SACC2.
     END.
     
     IF GLT001.DRCR  THEN DO:
        n_gltxt  = TRIM(n_gltxt).
        PUT STREAM ns1
            n_gltxt  ";"    
            n_macc          FORMAT "X(8)"  ";"          
            + "'" + n_sub1  FORMAT "X(6)"  ";"    
            + "'" + n_sub2  FORMAT "X(6)"  ";"     
            GLT001.LOCAMT   FORMAT ">>>,>>>,>>>,>>9.99" SKIP. 
  
        nt_dramt    = nt_dramt + GLT001.LOCAMT.

     END.
     ELSE DO:
        n_gltxt  = TRIM(n_gltxt).
        PUT STREAM ns1
            n_gltxt  ";"    
            n_macc          FORMAT "X(8)"  ";"          
            + "'" + n_sub1  FORMAT "X(6)"  ";"    
            + "'" + n_sub2  FORMAT "X(6)"  ";" ";"     
            GLT001.LOCAMT   FORMAT ">>>,>>>,>>>,>>9.99" SKIP. 

        nt_cramt   = nt_cramt + GLT001.LOCAMT.

     END.
               
     IF LAST-OF(GLT001.DOCNO) THEN DO:
        PUT STREAM ns1
            SKIP(1)
            "รวมยอด "   ";" ";" ";" ";"      
            nt_dramt    ";"       
            nt_cramt    SKIP(1) 
            n_txt       FORMAT "X(116)"  SKIP(1)
            
            SPACE(2) n_username  FORMAT "X(25)"  SKIP 
            "_________________________"  ";"
            "_________________________"  ";"
            "_________________________"  SKIP
            "     ผู้บันทึกบัญชี "  ";"
            "      สมุห์บัญชี"      ";"
            "    ผู้ตรวจฝ่ายบัญชี "      SKIP.

         nt_dramt   = 0.
         nt_cramt   = 0.

     END.
     
  END. /* for each */

  OUTPUT STREAM ns1  CLOSE.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdPrintToPrinter_File C-Win 
PROCEDURE PdPrintToPrinter_File :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
   /*----------
   n_doc     = CHR(27) + CHR(69) + CHR(14) + fi_docno +
               CHR(27) + CHR(70) + CHR(20).
   
   n_date    =  fi_docdat. 
   -----------*/
   
  
   
   n_ln1     = FILL("=",116).
   n_ln2     = n_ln1.
/*    n_safety  = CHR(27) + CHR(69) + CHR(14) + "บริษัท ประกันคุ้มภัย จำกัด (มหาชน)" +  */ /*A51-0261*/
   n_safety  = CHR(27) + CHR(69) + CHR(14) + NAME_1 +           /*A51-0261*/
               CHR(27) + CHR(70) + CHR(20).
   n_jv      = CHR(27) + CHR(69) + CHR(14) + txtprn +
               CHR(27) + CHR(70) + CHR(20).
         
   IF n_output = "PRINTER" THEN nv_output = "PRINTER".
   ELSE nv_output = TRIM(n_output) + ".PRN".

     
   /*--------------- Cthai3l.exe -----------------*/
   IF SEARCH("CTHAI3L.EXE")  <> ?  THEN DO:
      IF   nv_output= "PRINTER"  THEN DO:
           nv_output2   = "C:\3L" +
                          SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) +
                          SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) +
                          SUBSTRING(STRING(TIME,"HH:MM:SS"),7,2) +
                          ".TMP".
          OUTPUT STREAM  ns1  TO VALUE(nv_output2)  PAGED  PAGE-SIZE 40.
     END.
     ELSE
          OUTPUT STREAM  ns1  TO VALUE(nv_output)   PAGED  PAGE-SIZE 40.
   END.
   ELSE DO:
     IF  SEARCH("CTHAI3L.TXT")  <> ?  THEN DO:
         DOS SILENT  DEL CTHAI3L.TXT.
     END.
         OUTPUT STREAM   ns1  TO VALUE(nv_output)   PAGED  PAGE-SIZE 40.
      
   END.
   /*------------------ Cthai3l.exe -------------------*/
    
   PUT STREAM ns1 CONTROL  CHR(27) + CHR(64) + CHR(18).
   PUT STREAM ns1 CONTROL  CHR(27) + CHR(67) + CHR(0) + CHR(11).
   PUT STREAM ns1 CONTROL  CHR(27) + CHR(48).
   PUT STREAM ns1 CONTROL  CHR(27) + CHR(103).
   PUT STREAM ns1 CONTROL  NULL.
   
FOR EACH gl_bran.GLT001 USE-INDEX GLT00102 WHERE 
            glt001.compy    = fi_compy   AND       
            glt001.accyr    = fi_accyr   AND       
            /*---- glt001.accmth   = fi_accmth  AND       --- A57-0148---*/
            glt001.trntyp   = fi_trntyp  AND       
            (glt001.docno  >= fi_docnofr AND
             glt001.docno  <= fi_docnoto) NO-LOCK

     BREAK BY GLT001.BTHNO
        BY GLT001.DOCNO 
        BY GLT001.DRCR   DESCENDING
        BY GLT001.MACC   : 
   
               
     IF FIRST-OF(GLT001.DOCNO) THEN DO:
        ASSIGN
           n_date      = ?
           n_doc       = ""
           n_txt       = ""
           n_username  = "".
         /*---------------------------           
        FIND gl_bran.GLT000 USE-INDEX GLT00001    WHERE 
             gl_bran.GLT000.COMPY  = GLT001.COMPY   AND
             gl_bran.GLT000.BTHNO  = GLT001.BTHNO   AND
             gl_bran.GLT000.ACCYR  = GLT001.ACCYR   AND
             gl_bran.GLT000.ACCMTH = GLT001.ACCMTH  AND
             gl_bran.GLT000.TRNTYP = GLT001.TRNTYP  AND
             gl_bran.GLT000.DOCNO  = GLT001.DOCNO   NO-LOCK NO-ERROR.
        IF NOT AVAILABLE GLT000 THEN NEXT.     
        
        n_date  = GLT000.DOCDAT.
        -----------end aom---------*/
        n_date  = gl_bran.glt001.curdat.
        n_doc   = CHR(27) + CHR(69) + CHR(14) + GLT001.DOCNO +
                  CHR(27) + CHR(70) + CHR(20).
        n_txt   = "คำอธิบาย  :  " + TRIM(GLT001.DESC1).
         
        
        FIND xzm600 WHERE
             xzm600.acno  =  glt001.useid  NO-LOCK NO-ERROR.
        IF AVAILABLE xzm600 THEN 
           n_username    =  xzm600.tname.
        
        
        PUT STREAM ns1
               "เลขที่"                         AT 92       SPACE(1)
               n_doc                                        SKIP(1)    
               n_safety                         AT 40       SKIP
               n_jv                             AT 49       SKIP
               "วันที่"                         AT 92       SPACE(1)
               n_date     FORMAT "99/99/9999"               SKIP
               n_ln1      FORMAT "X(116)"       AT 1        SKIP
               "|"                              AT 1
               "ประเภทบัญชี"                    AT 20
               "|  บัญชีเลขที่"                 AT 53
               "| SUB1"                         AT 68
               "| SUB2"                         AT 75
               "|   เดบิต"                      AT 82
               "|       เครดิต"                 AT 97
               "|"                              AT 116      SKIP
               n_ln2      FORMAT "X(116)"       AT 1        SKIP .

     END.
                       
     FIND  gl_bran.GLM001 USE-INDEX GLM00101    WHERE  /*USE-INDEX GLM00107*/
           gl_bran.GLM001.YR    = GLT001.ACCYR  AND
           gl_bran.GLM001.COMPY = GLT001.COMPY  AND
           gl_bran.GLM001.MACC  = GLT001.MACC   AND
           gl_bran.GLM001.SACC1 = GLT001.SACC1  AND
           gl_bran.GLM001.SACC2 = GLT001.SACC2  NO-LOCK NO-ERROR.
     IF AVAILABLE GLM001 THEN DO:
        ASSIGN
            n_gltxt  =  TRIM(GLM001.DESC1)
            n_macc   =  GLM001.MACC
            n_sub1   =  GLM001.SACC1
            n_sub2   =  GLM001.SACC2.
     END.          
     ELSE DO:
        ASSIGN
           n_gltxt  =  ""
           n_macc   =  GLT001.MACC
           n_sub1   =  GLT001.SACC1
           n_sub2   =  GLT001.SACC2.
     END.
                    
     IF GLT001.DRCR  THEN DO:
        n_gltxt  = "| " + TRIM(n_gltxt).
        PUT STREAM ns1
            n_gltxt                                    AT 1
            "|"                                        AT 53
            n_macc         FORMAT "X(8)"               AT 55
            "|"                                        AT 64 
            n_sub1         FORMAT "X(3)"               AT 66
            "|"                                        AT 71
            n_sub2         FORMAT "X(3)"               AT 73
            "|"                                        AT 78
            GLT001.LOCAMT  FORMAT ">>>,>>>,>>>,>>9.99" AT 79 
            "|"                                        AT 97 
            "|"                                        AT 116 SKIP. 

        nt_dramt    = nt_dramt + GLT001.LOCAMT.

     END.
     ELSE DO:
        n_gltxt  = "|      " + TRIM(n_gltxt).
        PUT STREAM ns1
            n_gltxt                                     AT 1
            "|"                                         AT 53
            n_macc          FORMAT "X(8)"               AT 55
            "|"                                         AT 64 
            n_sub1          FORMAT "X(3)"               AT 66
            "|"                                         AT 71
            n_sub2          FORMAT "X(3)"               AT 73
            "|"                                         AT 78
            "|"                                         AT 97 
            GLT001.LOCAMT   FORMAT ">>>,>>>,>>>,>>9.99" AT 98 
            "|"                                         AT 116 SKIP. 

        nt_cramt   = nt_cramt + GLT001.LOCAMT.

     END.
      
     IF LINE-COUNTER(ns1) > 40 THEN DO:
        PAGE STREAM ns1.
        PUT STREAM ns1
            "เลขที่"                         AT 92       SPACE(1)
            n_doc                                        SKIP(1)    
            n_safety                         AT 40       SKIP
            n_jv                             AT 49       SKIP
            "วันที่"                         AT 92       SPACE(1)
            n_date     FORMAT "99/99/9999"               SKIP
            n_ln1      FORMAT "X(116)"       AT 1        SKIP
            "|"                              AT 1
            "ประเภทบัญชี"                    AT 20
            "|  บัญชีเลขที่"                 AT 53
            "| SUB1"                         AT 68
            "| SUB2"                         AT 75
            "|   เดบิต"                      AT 82
            "|       เครดิต"                 AT 97
            "|"                              AT 116      SKIP
            n_ln2      FORMAT "X(116)"       AT 1        SKIP .

     END.
     

     IF LAST-OF (GLT001.DOCNO) THEN DO:
        PUT STREAM ns1
            FILL("-",116)   FORMAT "X(116)"  AT 1        SKIP(1)
            "รวมยอด  "                       AT 35
            nt_dramt                         AT 72
            nt_cramt                         AT 94       SKIP(2)
            n_txt           FORMAT "X(116)"  AT 1        SKIP(2)

            n_username      FORMAT "X(25)"   AT 5        SKIP
                      
            "________________________"       AT 3
            "________________________"       AT 43
            "________________________"       AT 83       SKIP

            "        ผู้บันทึกบัญชี "        AT 3
            "       ผู้ตรวจฝ่ายบัญชี "       AT 43
            "         สมุห์บัญชี"            AT 83       SKIP.

         nt_dramt   = 0.
         nt_cramt   = 0.


         IF LINE-COUNTER(ns1) < 41 THEN
            PUT STREAM ns1
                SKIP(41 - LINE-COUNTER(ns1)).
     END.
     
  
  END. /* for each */
  
  /*PUT STREAM ns1 CONTROL  CHR(27) + CHR(64).*/
  OUTPUT STREAM ns1  CLOSE.
 
  /*---------- End of Cthai3l ------------*/ 
  IF  nv_output  = "PRINTER"  THEN DO:
     IF SEARCH("CTHAI3L.EXE")  <> ?  THEN DO:
        DOS SILENT  cthai3l  -c2  -s1  VALUE(nv_output2)  > VALUE("LPT1:").
        DOS SILENT  DEL VALUE(nv_output2).
     END.
  END. 
  /*---------- End of Cthai3l ----------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

