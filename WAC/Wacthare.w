&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
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

  Modify By : TANTAWAN C.   15/01/2008   [A500178]
              ปรับ FORMAT branch เพื่อรองรับการขยายสาขา
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
DEF VAR poltp     AS CHAR FORMAT "x(3)" .
DEF VAR tranfr    AS DATE FORMAT "99/99/9999".
DEF VAR tranto    AS DATE FORMAT "99/99/9999".
DEF VAR nv_outPUT AS CHAR FORMAT "x(50)" .

DEFINE VAR   n_hptyp1    AS   CHAR.
DEFINE VAR   n_hpDestyp1 AS   CHAR.

DEF STREAM ns1.

/* Parameters Definitions ---                                           */
DEFINE NEW SHARED WORKFILE wdetail NO-UNDO
FIELD rects   AS CHAR FORMAT "X(1)"     INIT ""  /*1- record status*/
FIELD cedco   AS CHAR FORMAT "X(3)"     INIT ""  /*2- ceding company code*/
FIELD polnum  AS CHAR FORMAT "x(30)"    INIT ""  /*3- policy number*/
FIELD subpol  AS CHAR FORMAT "x(4)"     INIT ""  /*4- sub policy number*/ 
FIELD endor   AS CHAR FORMAT "x(6)"     INIT ""  /*5- endorsment number*/
FIELD trcode  AS CHAR FORMAT "x(2)"     INIT ""  /*6- transaction code*/
FIELD co-code AS CHAR FORMAT "x(1)"     INIT ""  /*7- co-insurance code*/
FIELD insname AS CHAR FORMAT "x(60)"    INIT ""  /*8- insured name and address*/
FIELD locate  AS CHAR FORMAT "x(60)"    INIT ""  /*9- Location of property*/
FIELD amp     AS CHAR FORMAT "x(2)"     INIT ""  /*10- amphoe code*/
FIELD cha     AS CHAR FORMAT "x(2)"     INIT ""  /*11- province code*/
FIELD blk     AS CHAR FORMAT "x(6)"     INIT ""  /*12- block number*/
FIELD ir      AS CHAR FORMAT "x(1)"     INIT ""  /*13- ir or non-ir*/
FIELD trdate  AS CHAR FORMAT "x(6)"     INIT ""  /*14- transaction date*/
/*----------- P1  ----------*/
FIELD effdate AS CHAR FORMAT "x(6)"     INIT ""  /*15- Effective date*/
FIELD expdat  AS CHAR FORMAT "x(6)"     INIT ""  /*16- expiry date*/
FIELD orgsi   AS CHAR FORMAT "x(11)"    INIT ""  /*17- original S/i*/
FIELD prate   AS CHAR FORMAT "x(9)"     INIT ""  /*18- premium rate*/
FIELD srate   AS CHAR FORMAT "x(3)"     INIT ""  /*19- surchage rate*/
FIELD disc    AS CHAR FORMAT "x(5)"     INIT ""  /*20- F.E. DISCOUNT*/
FIELD EXTPRM  AS CHAR FORMAT "X(9)"     INIT ""  /*21- PRM AMOUNT FOR EXTENDED PERILS*/
FIELD PRMAMT  AS CHAR FORMAT "X(11)"    INIT ""  /*22- NETT PREMIUM*/
FIELD SPRATE  AS CHAR FORMAT "X(5)"     INIT ""  /*23- SPCIAL DISCOUNT*/
FIELD FCAL    AS CHAR FORMAT "X(1)"     INIT ""  /*24- FLAG CALCULATE*/
/*--------- P2 ------------*/
FIELD TAX     AS CHAR FORMAT "X(1)"     INIT ""  /*25- TAXCODE*/
FIELD INTYPE  AS CHAR FORMAT "X(1)"     INIT ""  /*26- INISURANCE TYPE*/
FIELD BLDSI   AS CHAR FORMAT "X(11)"    INIT ""  /*27- S/I OF BUILDING*/
FIELD MACSI   AS CHAR FORMAT "X(11)"    INIT ""  /*28- S/I OF MACHINERY*/
FIELD FURSI   AS CHAR FORMAT "X(11)"    INIT ""  /*29- S/I OF FURNITURE*/
FIELD STKSI   AS CHAR FORMAT "X(11)"    INIT ""  /*30- S/I OF STOCK*/
FIELD OTHSI   AS CHAR FORMAT "X(11)"    INIT ""  /*31- S/I OF ORTHER*/
FIELD RIGHT   AS CHAR FORMAT "X(1)"     INIT ""  /*32-OWNER OR TENANT*/
FIELD STOREY  AS CHAR FORMAT "X(2)"     INIT ""  /*33- NO. OF STOREY*/
FIELD OCCU    AS CHAR FORMAT "X(4)"     INIT ""  /*34- OCCUPANCY CODE*/
FIELD RISK    AS CHAR FORMAT "X(4)"     INIT ""  /*35- EXTERNAL EXPOSE*/
FIELD CLASS   AS CHAR FORMAT "X(1)"     INIT ""  /*36- CLASS OF BUILDING*/
FIELD SICO      AS CHAR FORMAT "X(11)"  INIT ""  /*37- TOTAL S/I OF COINSURANCE POL*/
FIELD ATTAC     AS CHAR FORMAT "X(1)"   INIT ""  /*38- ATTACHMENT*/
FIELD MJRCLASS  AS CHAR FORMAT "X(1)"   INIT ""  /*39- CLASS OF BUSINESS*/ 
FIELD N_COLUMN  AS CHAR FORMAT "X(1)"   INIT ""  /*40- CLASS OF CLOUMN*/
FIELD BEAM    AS CHAR FORMAT "X(1)"     INIT ""  /*41- CLASSOF BEAM*/  
FIELD FLOOR   AS CHAR FORMAT "X(1)"     INIT ""  /*42- CLASS OF FLOOR*/
FIELD WALL    AS CHAR FORMAT "X(1)"     INIT ""  /*43- CLASS OF WALL*/
FIELD FILLER  AS CHAR FORMAT "X(2)"     INIT ""  /*44- FILLER*/ .
/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bu_hptyp fi_poltyp fi_tranfr fi_tranto ~
fi_output by_run bt_exit RECT-1 RECT-2 RECT-3 
&Scoped-Define DISPLAYED-OBJECTS fi_poltyp1 fi_poltyp fi_tranfr fi_tranto ~
fi_output 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bt_exit 
     LABEL "Exit" 
     SIZE 15 BY 1.14.

DEFINE BUTTON bu_hptyp 
     IMAGE-UP FILE "WIMAGE\help":U
     LABEL "Btn 2" 
     SIZE 3.5 BY 1.05.

DEFINE BUTTON by_run 
     LABEL "RUN" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 44.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_poltyp AS CHARACTER FORMAT "X(256)":U INITIAL "F10" 
     VIEW-AS FILL-IN 
     SIZE 9.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_poltyp1 AS CHARACTER FORMAT "X(256)":U INITIAL "FIRE INSURANCE" 
     VIEW-AS FILL-IN 
     SIZE 28.33 BY 1
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_tranfr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_tranto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 73 BY 1.81
     BGCOLOR 102 .

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 73 BY 1.29
     BGCOLOR 102 .

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 73 BY 7.29
     BGCOLOR 102 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     bu_hptyp AT ROW 4.38 COL 36.5
     fi_poltyp1 AT ROW 4.38 COL 43 COLON-ALIGNED NO-LABEL
     fi_poltyp AT ROW 4.43 COL 24.67 COLON-ALIGNED NO-LABEL
     fi_tranfr AT ROW 6.52 COL 24.67 COLON-ALIGNED NO-LABEL
     fi_tranto AT ROW 6.48 COL 55.5 COLON-ALIGNED NO-LABEL
     fi_output AT ROW 8.62 COL 24.67 COLON-ALIGNED NO-LABEL
     by_run AT ROW 10.91 COL 42
     bt_exit AT ROW 10.91 COL 59
     "Policy Type :" VIEW-AS TEXT
          SIZE 14 BY 1.05 AT ROW 4.38 COL 6.5
          BGCOLOR 102 
     "Trans Date From :" VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 6.48 COL 7
          BGCOLOR 102 
     "TO" VIEW-AS TEXT
          SIZE 5.5 BY 1.05 AT ROW 6.48 COL 46.5
          BGCOLOR 102 
     "Output File Name :" VIEW-AS TEXT
          SIZE 19 BY 1.05 AT ROW 8.57 COL 7
          BGCOLOR 102 
     "      TEXT FILE FIRE AND IAR TO THAIRE" VIEW-AS TEXT
          SIZE 43.5 BY .76 AT ROW 1.76 COL 17.5
          BGCOLOR 15 FGCOLOR 31 
     RECT-1 AT ROW 10.67 COL 2.5
     RECT-2 AT ROW 1.52 COL 2.5
     RECT-3 AT ROW 3.1 COL 2.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 75.5 BY 11.87
         BGCOLOR 19 FONT 6.


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
         HEIGHT             = 11.86
         WIDTH              = 75.5
         MAX-HEIGHT         = 11.86
         MAX-WIDTH          = 75.5
         VIRTUAL-HEIGHT     = 11.86
         VIRTUAL-WIDTH      = 75.5
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
IF NOT C-Win:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   Custom                                                               */
/* SETTINGS FOR FILL-IN fi_poltyp1 IN FRAME fr_main
   NO-ENABLE                                                            */
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


&Scoped-define SELF-NAME bt_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt_exit C-Win
ON CHOOSE OF bt_exit IN FRAME fr_main /* Exit */
DO:
  APPLY "close" TO this-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hptyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hptyp C-Win
ON CHOOSE OF bu_hptyp IN FRAME fr_main /* Btn 2 */
DO:   
  CURRENT-WINDOW:SENSITIVE = NO.   
  RUN Whp\WhpPtyp1(INPUT-OUTPUT n_hptyp1,INPUT-OUTPUT n_hpdestyp1).
  CURRENT-WINDOW:SENSITIVE = Yes. 
  ASSIGN  
    fi_poltyp = n_hptyp1 
    fi_poltyp1 = n_hpDestyp1.
  DISP fi_poltyp fi_poltyp1 WITH FRAME {&FRAME-NAME}.
       Apply "Entry" To fi_poltyp.
       Return No-Apply.    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME by_run
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL by_run C-Win
ON CHOOSE OF by_run IN FRAME fr_main /* RUN */
DO:
  /*------ chk Line    -----*/
    IF INPUT fi_poltyp = "F10" OR INPUT fi_poltyp = "M11"  THEN DO:
    END.
    ELSE DO:
        MESSAGE "Policy Type Must Be Only F10 or M11 " VIEW-AS ALERT-BOX.
        APPLY "Entry" TO fi_poltyp .
        RETURN NO-APPLY.
    END.
  /*----- end chk line -----*/
    DEF VAR mlrchk  AS CHAR FORMAT "x" INIT "".
    DEF VAR n_end   AS CHAR FORMAT "x" INIT "".
    DEF VAR cocod   AS CHAR FORMAT "x" INIT "".
    DEF VAR n_sitot1 AS DECIMAL FORMAT "->>>>>>>>>>>>>>9.99".
    DEF VAR n_cotot1 AS DECIMAL FORMAT "->>>>>>>>>>>>>>9.99".
    DEF VAR n_d11c1  AS DECIMAL FORMAT "->>>>>>>>>>>>>>9.99".
    DEF VAR n_digit1 AS DECIMAL FORMAT "->>>>>>>>>>>>>>9.99".
    DEF VAR n_sitot2 AS DECIMAL FORMAT "->>>>>>>>>>>>>>9.99".
    DEF VAR n_cotot2 AS DECIMAL FORMAT "->>>>>>>>>>>>>>9.99".
    DEF VAR n_d11c2  AS DECIMAL FORMAT "->>>>>>>>>>>>>>9.99".
    DEF VAR n_digit2 AS DECIMAL FORMAT "->>>>>>>>>>>>>>9.99".
    DEF VAR n_prm1   AS DECIMAL FORMAT "->>>>>>>>>>>>>>9.99".
    DEF VAR n_prm2   AS DECIMAL FORMAT "->>>>>>>>>>>>>>9.99".
    DEF VAR n_prm3   AS DECIMAL FORMAT "->>>>>>>>>>>>>>9.99".
    DEF VAR prem_amount  AS DECIMAL FORMAT "->>>>>>>>>>>>>>9.99".
    DEF VAR ATTAC AS CHAR FORMAT "x".

    DEF VAR n_wall AS CHAR FORMAT "X".
    DEF VAR n_beam AS CHAR FORMAT "X".
    DEF VAR n_flor AS CHAR FORMAT "X".
    DEF VAR n_colu AS CHAR FORMAT "X". /*ไม่มีเสาอ่ะ */
    DEF VAR mjr    AS CHAR FORMAT "x".

    DEF VAR n_occu AS CHAR FORMAT "x(4)".
    DEF VAR n_risk AS CHAR FORMAT "x(4)".
    DEF VAR n_cons AS CHAR FORMAT "x(4)".
    DEF VAR n_STOR AS CHAR FORMAT "x(2)".

    DEF VAR n_prate AS DECI FORMAT ">9.99999-". /*fire*/
    DEF VAR n_srate AS DECI FORMAT ">9.99999-". /*surc*/
    DEF VAR n_disc  AS DECI FORMAT ">9.99999-". /*fedi*/
    DEF VAR n_extp  AS DECI FORMAT " >>,>>>,>>>,>>9.99". /*fadd*/

    DEF VAR loc      AS CHAR.
    DEF VAR ownten   AS CHAR FORMAT "x".
    DEF VAR district AS CHAR FORMAT "x(2)".
    DEF VAR province AS CHAR FORMAT "x(2)".
    DEF VAR block1   AS CHAR FORMAT "x(6)".
    DEF VAR LB       AS INTEGER.
    DEF VAR CHKIR    AS CHAR.
    DEF VAR tdat     AS DATE FORMAT "99/99/99".
    DEF VAR tdat1    AS CHAR.
    DEF VAR efdat    AS DATE FORMAT "99/99/99".
    DEF VAR efdat1   AS CHAR.
    DEF VAR exdat    AS DATE FORMAT "99/99/99".
    DEF VAR exdat1   AS CHAR.
    
    
    DEF VAR osi     AS INTEGER  FORMAT "-9,999,999,999,999,999".
    DEF VAR diffper AS DECIMAL  FORMAT "-999.99".
    DEF VAR money   AS DECIMAL  FORMAT "-9,999,999,999,999,999".
    DEF VAR SUBP    AS CHAR     FORMAT "x(4)".
    DEF VAR T1      AS CHAR     FORMAT "X".
    DEF VAR T2      AS CHAR     FORMAT "X".
    
    DEF VAR a1 AS CHAR FORMAT "x(2)".
    DEF VAR a2 AS CHAR FORMAT "x(2)".
    DEF VAR a3 AS CHAR FORMAT "x(2)".
    DEF VAR c1 AS CHAR FORMAT "x(2)".
    DEF VAR c2 AS CHAR FORMAT "x(2)".
    DEF VAR c3 AS CHAR FORMAT "x(2)".
    DEF VAR b1 AS CHAR FORMAT "x(2)".
    DEF VAR b2 AS CHAR FORMAT "x(2)".
    DEF VAR b3 AS CHAR FORMAT "x(2)".

    DEF VAR n_col AS CHAR FORMAT "x".
    DEF VAR n_bea AS CHAR FORMAT "x".  
    DEF VAR n_flo AS CHAR FORMAT "x".
    DEF VAR n_wal AS CHAR FORMAT "x".  

    ASSIGN
        poltp     = SUBSTR(INPUT fi_poltyp,2,2 )
        tranfr    = INPUT fi_tranfr
        tranto    = INPUT fi_tranto
        nv_output = INPUT fi_output.
    
    OUTPUT STREAM ns1 TO VALUE(nv_output).
loop_note:
REPEAT:
FOR EACH uwm100 USE-INDEX uwm10008  WHERE uwm100.trndat >= tranfr   AND 
         uwm100.trndat     <= tranto AND
         uwm100.releas      = YES    AND
  substr(uwm100.poltyp,2,2) = poltp  AND
  substr(uwm100.policy,1,1) = "D"    OR 
    /*--- A500178 ---*/
 (SUBSTR(uwm100.policy,1,2) >= "10" AND  /* รหัสสาขา  10 ถึง 99 */
  SUBSTR(uwm100.policy,1,2) <= "99" )
    /*--- ฤ500178 ---*/
  :
      
      DISP  "POLICY  :"UWM100.POLICY SKIP
            "REN/ENDCNT  :"UWM100.RENCNT " / " UWM100.ENDCNT SKIP
            "INSNAME  :" UWM100.NAME1
            WITH COLOR white/green NO-LABEL FRAME frProcess VIEW-AS DIALOG-BOX
            TITLE  "  Processing ...".
      
      ASSIGN
      
      mlrchk = "" /*check multi risk */
      cocod  = "" /*cocode*/
      n_sitot1 = 0              prem_amount = 0 
      n_cotot1 = 0              n_prm1      = 0    
      n_d11c1  = 0              n_prm2      = 0    
      n_digit1 = 0              SUBP        = ""          
      n_sitot2 = 0              loc         = ""          
      n_cotot2 = 0              district    = ""         
      n_d11c2  = 0              province    = ""            
      n_digit2 = 0              block1      = ""              
      CHKIR    = ""             TDAT1       = ""  
      efdat1   = ""             exdat1      = ""                        
      ownten   = ""             attac       = ""
      mjr      = ""             n_wall      = ""
      n_flor   = ""             n_beam      = ""
      n_colu   = "".
          
      /*-------- BEFORE ASSIGN VALUE ---------*/
      /*--- SUBPOL ---*/
      FIND LAST UWM120 WHERE UWM120.POLICY = UWM100.POLICY AND 
                             UWM120.RENCNT = UWM100.RENCNT AND
                             UWM120.ENDCNT = UWM100.ENDCNT NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL UWM120 THEN DO:
            IF UWM120.RISKNO > 1  THEN DO: /*CHK MULTIRISK*/
                    /*subp   = "0" +  string(uwm120.riskno).*/
                    IF LENGTH(string(uwm120.riskno)) = 1 THEN subp = "000" + string(uwm120.riskno).
                    ELSE IF LENGTH(string(uwm120.riskno)) = 2 THEN subp = "00"  + string(uwm120.riskno).
                    ELSE IF LENGTH(string(uwm120.riskno)) = 3 THEN subp = "0"   + string(uwm120.riskno).
                    ELSE IF LENGTH(string(uwm120.riskno)) = 4 THEN subp = string(uwm120.riskno).
                    mlrchk = "y".
            END.
            ELSE DO:
                    subp   = "".               
                    mlrchk = "n". 
            END.
      END. /*if avail*/
      /*--- n_end ---*/
      IF LENGTH(string(UWM100.ENDCNT)) = 3 THEN n_end = "000" + string(UWM100.ENDCNT).
      ELSE IF LENGTH(string(UWM100.ENDCNT)) = 2 THEN n_end = "0000" + string(UWM100.ENDCNT).
      ELSE IF LENGTH(string(UWM100.ENDCNT)) = 1 THEN n_end = "00000" + string(UWM100.ENDCNT).
      /*--- trcode t1 ---*/
       IF uwm100.coins = YES THEN DO: /* chk co-insure */
                ASSIGN    
                    t1 =  "3"
                    
                    cocod  = "1".  /*coinsure = 1*/
       END. 
       IF mlrchk = "y"  THEN DO:  /*CHK MULTIRISK*/
               t1 =  "2".
       END.
       ELSE DO:
                ASSIGN    
                    t1 =  "1"
                    
                    cocod  = "". /*normal = blank*/
       END.
       /*--- trcode t2 ---*/
       IF uwm100.tranty = "N"      THEN     t2 = "N".  /*new policy*/
       ELSE IF uwm100.tranty = "R" THEN     t2 = "R".  /*renew*/
       ELSE IF uwm100.tranty = "E" THEN     t2 = "1".  /*endos*/ /*CASE SUB POLICY*/
       /*--- tdat ---*/
      tdat  = uwm100.trndat .
      a1    = string(INTEGER(SUBSTR(STRING(TDAT),7,2))  + 43). /*ทำให้เป็นปี พศ.*/
      a2    = SUBSTR(STRING(TDAT),4,2).
      a3    = SUBSTR(STRING(TDAT),1,2).
      TDAT1  = A1 + A2 + A3.
      /*--- efdat ---*/
      efdat  = uwm100.comdat .
      b1    = string(INTEGER(SUBSTR(STRING(efDAT),7,2)) + 43). /*ทำให้เป็นปี พศ.*/
      b2    = SUBSTR(STRING(efdAT),4,2).
      b3    = SUBSTR(STRING(efDAT),1,2).
      efDAT1  = b1 + b2 + b3.
      /*--- expdat ---*/
      exdat  = uwm100.expdat .
      c1    = string(INTEGER(SUBSTR(STRING(exDAT),7,2)) + 43). /*ทำให้เป็นปี พศ.*/
      c2    = SUBSTR(STRING(exDAT),4,2).
      c3    = SUBSTR(STRING(exDAT),1,2).
      exDAT1  = c1 + c2 + c3.
      /*--- mjrclass ---*/
      IF SUBSTR(uwm100.policy,3,2) = "10" THEN mjr = "F".
      ELSE mjr = "I".
      /*--- locate ---*/
     
     FIND uwm304 USE-INDEX uwm30401   WHERE uwm304.policy = uwm120.policy AND
          uwm304.rencnt = uwm120.rencnt AND uwm304.endcnt = uwm120.endcnt AND
          uwm304.riskgp = uwm120.riskgp AND uwm304.riskno = 0001
     NO-WAIT NO-ERROR.
      IF AVAIL uwm304 THEN DO:
            loc = uwm304.locn1 + " " + uwm304.locn2 + " " + uwm304.locn3.
            IF LENGTH(uwm304.storey) = 2 THEN N_STOR = uwm304.storey.
            ELSE N_STOR = "0" + uwm304.storey.
            
            ownten = uwm304.ownten.
            n_occu = uwm304.occupn. /*occu*/
            n_risk = uwm304.distct. /*risk*/
            IF uwm304.constr = "A" OR uwm304.constr ="B" THEN           /*class เอา 123 ถ้าเป็น a , b เป็น 1 ค่ะ*/ 
             n_cons = "1".
            ELSE IF uwm304.constr = "1"   THEN n_cons = "1".
            ELSE IF uwm304.constr = "2"   THEN n_cons = "2".
            ELSE IF uwm304.constr = "3"   THEN n_cons = "3".
            ELSE n_cons = "".
            /*--- wall beam floor wall*/
              
              IF INDEX(uwm304.wall,"คอนกรีต") <> 0  OR INDEX(uwm304.wall,"concrete") <> 0 THEN n_wall = "1".
              ELSE IF INDEX(uwm304.wall,"ไม้") <> 0 OR INDEX(uwm304.wall,"wood") <> 0 THEN n_wall = "2".
              ELSE n_wall = "3".

              IF INDEX(uwm304.floor,"คอนกรีต") <> 0 OR INDEX(uwm304.floor,"concrete") <> 0 THEN n_flor = "1".
              ELSE IF INDEX(uwm304.floor,"เหล็ก") <> 0 OR INDEX(uwm304.floor,"iron") <> 0 THEN n_flor = "2".
              ELSE n_flor = "3".

              
              IF INDEX(uwm304.beam,"คอนกรีต") <> 0 OR INDEX(uwm304.beam,"concrete") <> 0 THEN n_beam = "1".
              ELSE IF INDEX(uwm304.beam,"เหล็ก") <> 0 OR INDEX(uwm304.beam,"iron") <> 0 THEN n_beam = "2".
              ELSE n_beam = "3".
              
              
      END. /*then do*/
      ELSE DO: 
          ASSIGN
          loc     = ""
          n_occu  = ""
          n_risk  = ""
          n_cons  = "".
      END.
      /*--- amp ----*/
      FIND uwd141 USE-INDEX uwd14101 WHERE
           uwd141.policy  = uwm304.policy AND
           uwd141.rencnt  = uwm304.rencnt AND
           uwd141.riskgp  = uwm304.riskgp AND
           uwd141.riskno  = uwm304.riskno AND
           uwd141.endcnt  = uwm304.endcnt NO-WAIT NO-ERROR.
      IF AVAIL uwd141 THEN DO:
          ASSIGN
               district = uwd141.dist_n 
               province = uwd141.prov_n.
              IF uwd141.blok_n <> " " THEN DO:
              block1   = substr(uwd141.blok_n,1,4) + uwd141.sblok_n .
              LB = LENGTH(uwd141.blok_n).
                  IF SUBSTR(uwd141.blok_n,LB,1) = "I" THEN     CHKIR = "I".
                  ELSE CHKIR = "".
              END.

      END.
      ELSE DO: 
          ASSIGN
          province = ""
          district = ""
          block1   = ""    .

      END.
      /*--- rate ---*/
      
      ASSIGN
      n_prate = 0
      n_srate = 0
      n_disc  = 0
      n_extp  = 0.

      FIND FIRST   UWD132 WHERE UWD132.POLICY = UWM100.POLICY AND 
                                UWD132.RENCNT = UWM100.RENCNT AND
                                UWD132.ENDCNT = UWM100.ENDCNT AND 
                                uwd132.bencod = "FIRE"        NO-LOCK  NO-WAIT NO-ERROR.
      IF AVAIL uwd132 THEN n_prate =  uwd132.rate.
      ELSE     n_prate = 0.

      FIND FIRST   UWD132 WHERE UWD132.POLICY = UWM100.POLICY AND 
                                UWD132.RENCNT = UWM100.RENCNT AND
                                UWD132.ENDCNT = UWM100.ENDCNT AND 
                                uwd132.bencod = "SURC"        NO-LOCK  NO-WAIT NO-ERROR.
      IF AVAIL uwd132 THEN n_srate =  uwd132.rate.
      ELSE     n_srate = 0.

      FIND FIRST   UWD132 WHERE UWD132.POLICY = UWM100.POLICY AND 
                                UWD132.RENCNT = UWM100.RENCNT AND
                                UWD132.ENDCNT = UWM100.ENDCNT AND 
                                uwd132.bencod = "FEDI"        NO-LOCK  NO-WAIT NO-ERROR.
      IF AVAIL uwd132 THEN n_DISC =  uwd132.rate.
      ELSE     n_DISC = 0.
           
      FIND FIRST   UWD132 WHERE UWD132.POLICY = UWM100.POLICY AND 
                                UWD132.RENCNT = UWM100.RENCNT AND
                                UWD132.ENDCNT = UWM100.ENDCNT AND 
                                uwd132.bencod = "BENCOD"        NO-LOCK  NO-WAIT NO-ERROR.
      IF AVAIL uwd132 THEN n_EXTP =  uwd132.PREM_C.
      ELSE     n_EXTP = 0.

          
          
      
      /*** don't move or add part ***/
      
      /*---- prmant ----*/
      
      FOR EACH   uwm120 USE-INDEX uwm12001 WHERE
                     uwm120.policy = uwm100.policy  AND
                     uwm120.rencnt = uwm100.rencnt  AND
                     uwm120.endcnt = uwm100.endcnt  NO-LOCK.
                 n_prm2 = n_prm2 + uwm120.prem_r.
      END.
      n_prm1 = uwm100.prem_t.
      IF  n_prm2 <> n_prm1 THEN prem_amount = n_prm2.
      ELSE prem_amount = n_prm1.       
      /*--- attachment ---*/

      
      FOR EACH uwm120 WHERE uwm120.policy = uwm100.policy AND
                            uwm120.rencnt = uwm100.rencnt AND
                            uwm120.endcnt = uwm100.Endcnt NO-LOCK .
          IF uwm120.fptr01 NE 0 OR uwm120.fptr02 NE 0
          OR uwm120.fptr03 NE 0 OR uwm120.fptr08 NE 0
          THEN DO:
            attac = "A".
            LEAVE.
          END. /*then do*/
          ELSE DO:
            attac = "".
          END. /*else do*/
      END.

      /*---------------------------------------*/
      /*---- Orgsi  ----*/
      /*---- normal case ----*/
      IF uwm100.coins = YES THEN DO: /*check ว่า เป็น  Coinsure ไหม*/
          /*MESSAGE "LOOP1".*/
          FOR EACH   uwm120 USE-INDEX uwm12001 WHERE
                     uwm120.policy = uwm100.policy  AND
                     uwm120.rencnt = uwm100.rencnt  AND
                     uwm120.endcnt = uwm100.endcnt  NO-LOCK.
               n_sitot2 = n_sitot2 + uwm120.sigr.
               n_cotot2 = n_cotot2 + uwm120.sico. 
          END.
          IF uwm100.billco = "Y" THEN DO: n_d11c2 = n_sitot2. /*bill co = yes*/
          END.
          ELSE DO: n_d11c2 = n_sitot2 - n_cotot2.
          END.
          n_digit2 = n_d11c2.
      END.
      ELSE DO:
          FOR EACH   uwm120 USE-INDEX uwm12001 WHERE
                     uwm120.policy = uwm100.policy  AND
                     uwm120.rencnt = uwm100.rencnt  AND
                     uwm120.endcnt = uwm100.endcnt  NO-LOCK.
               n_sitot2 = n_sitot2 + uwm120.sigr.
               n_cotot2 = n_cotot2 + uwm120.sico. 
          END.
          n_digit2 = n_sitot2.
      END.
      /*--- กรณีสลักหลัง ---*/
      IF uwm100.endcnt > 0 THEN DO:
          FOR EACH   uwm120 USE-INDEX uwm12001 WHERE
                     uwm120.policy = uwm100.policy  AND
                     uwm120.rencnt = uwm100.rencnt  AND
                     uwm120.endcnt = 0  NO-LOCK.
               n_sitot1 = n_sitot1 + uwm120.sigr.
               n_cotot1 = n_cotot1 + uwm120.sico. 
               n_prm3 = n_prm3 + uwm120.prem_r.
          END.
          IF uwm100.billco = "Y" THEN DO: n_d11c1 = n_sitot1. /*bill co = yes*/
          END.
          ELSE DO: n_d11c1 = n_sitot1 - n_cotot1.
          END.
          n_digit1    = n_d11c1.        
          n_digit2    = n_digit2 - n_digit1 .        
          prem_amount = n_prm3 - prem_amount. /*prem amount*/
      END.
    /*------------------------------------------------------------*/
      /*----------- assign to workfile --------------*/
      CREATE wdetail.
      ASSIGN
          WDETaIL.RECTS      = ""
          WDETAIL.CEDCO      = "STY"
          WDETAIL.POLNUM     = UWM100.POLICY
          WDETAIL.SUBPOL     = SUBP 
          WDETAIL.ENDOR      = n_end
          WDETAIL.TRCODE     = t1 + t2 
          WDETAIL.CO-CODE    = cocod
          WDETAIL.INSNAME    = TRIM(UWM100.NTITLE) + " " + UWM100.NAME1
          wdetail.locate     = loc
          WDETAIL.amp        = district
          WDETAIL.cha        = province
          WDETAIL.blk        = block1 
          WDETAIL.IR         = CHKIR
          WDETAIL.trdate     = TDAT1
        /*----- END PAGE1 -----*/
          wdetail.effdat     = efdat1
          wdetail.expdat     = exdat1
          wdetail.orgsi      = STRING(n_digit2) 
          wdetail.prate      = STRING(n_prate)
          wdetail.srate      = STRING(n_srate)
          wdetail.disc       = STRING(n_disc) 
          WDETAIL.EXTPRM     = STRING(n_extp) 
          wdetail.PRMAMT     = string(prem_amount)
          wdetail.sprate     = "" /*ไม่ส่งข้อมูลก็ได้*/
          wdetail.fcal       = "" /*ไม่ส่งข้อมูลก็ได้*/
        /*--- end page2 ---*/
          wdetail.tax        = "" /*ไม่ส่งข้อมูลก็ได้*/
          wdetail.intype     = "" /*ไม่ส่งข้อมูลก็ได้*/
          wdetail.bldsi      = "" /*ไม่ส่งข้อมูลก็ได้*/
          wdetail.macsi      = "" /*ไม่ส่งข้อมูลก็ได้*/
          wdetail.fursi      = "" /*ไม่ส่งข้อมูลก็ได้*/
          wdetail.stksi      = "" /*ไม่ส่งข้อมูลก็ได้*/
          wdetail.othsi      = "" /*ไม่ส่งข้อมูลก็ได้*/
          wdetail.RIGHT      = ownten
          wdetail.storey     = N_STOR
          wdetail.occu       = n_occu 
          wdetail.risk       = n_risk
          wdetail.class      = n_cons
          wdetail.sico       = "" /*ไม่ส่งข้อมูลก็ได้*/
          wdetail.attac      = ATTAC 
          /*--- end page3 ---*/
          wdetail.mjrclass   = mjr
          wdetail.n_COLUMN   = "3" /*อื่นๆ เพราะทางเราไม่มีเสา*/
          wdetail.beam       = n_beam 
          wdetail.floor      = n_flor 
          wdetail.wall       = n_wall 
          wdetail.filler     = "" . 
      


      
      PUT STREAM ns1
          WDETaIL.RECTS   
          WDETAIL.CEDCO   
          WDETAIL.POLNUM  
          WDETAIL.SUBPOL  
          WDETAIL.ENDOR   
          WDETAIL.TRCODE  
          WDETAIL.CO-CODE 
          WDETAIL.INSNAME 
          wdetail.locate  
          WDETAIL.amp     
          WDETAIL.cha     
          WDETAIL.blk     
          WDETAIL.IR      
          WDETAIL.trdate  
          /*end p1*/
          wdetail.effdat  
          wdetail.expdat  
          wdetail.orgsi   
          wdetail.prate
          wdetail.srate
          wdetail.disc
          WDETAIL.EXTPRM
          wdetail.prmamt
          wdetail.sprate
          wdetail.fcal  
          /*end p2*/
          wdetail.tax     
          wdetail.intype  
          wdetail.bldsi   
          wdetail.macsi   
          wdetail.fursi   
          wdetail.stksi   
          wdetail.othsi   
          wdetail.RIGHT   
          wdetail.storey  
          wdetail.occu    
          wdetail.risk    
          wdetail.class   
          wdetail.sico    
          wdetail.attac   
          /*end p3*/
          wdetail.mjrclass
          wdetail.n_COLUMN
          wdetail.beam    
          wdetail.floor   
          wdetail.wall    
          wdetail.filler  
          /*end p4*/

          SKIP.
      
END. /*FOR EACH*/
      OUTPUT STREAM ns1 CLOSE.
      
      LEAVE loop_note.
  END. /*LOOP NOTE*/
      MESSAGE "Mission  Complete".
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output C-Win
ON LEAVE OF fi_output IN FRAME fr_main
DO:
  fi_output = INPUT fi_outPUT.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_poltyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_poltyp C-Win
ON LEAVE OF fi_poltyp IN FRAME fr_main
DO:
   /*------ chk Line    -----*/

   IF INPUT fi_poltyp = "F10" OR INPUT fi_poltyp = "M11"  THEN DO:
       fi_poltyp = CAPS (INPUT fi_poltyp).
       DISP fi_poltyp WITH FRAME fr_main.
   END.
   ELSE DO:
       MESSAGE "Policy Type Must Be Only F10 or M11 " VIEW-AS ALERT-BOX.
       APPLY "Entry" TO fi_poltyp .
       RETURN NO-APPLY.
   END.

  /*----- end chk line -----*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tranfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tranfr C-Win
ON LEAVE OF fi_tranfr IN FRAME fr_main
DO:
    ASSIGN
    fi_tranfr = INPUT fi_Tranfr
    fi_tranto = INPUT fi_tranfr.
    DISP fi_tranfr fi_tranto WITH FRAME fr_main.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tranto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tranto C-Win
ON LEAVE OF fi_tranto IN FRAME fr_main
DO:
  IF INPUT FI_TRANFR > INPUT FI_TRANTO THEN DO:
      MESSAGE "Trans Date From Can't More Than Trans Date To".
      APPLY "entry" TO fi_tranto.
      RETURN NO-APPLY.
  END.
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
  RUN enable_UI.
  /********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR.
  DEF  VAR  gv_prog    AS   CHAR.
  
  gv_prgid = "wacthare".
  gv_prog  = "Send Text File Fire & IAR To Thaire ".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).
  /*********************************************************************/ 
   RUN Wut\WutwiCen (C-Win:HANDLE).  
  CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.
  SESSION:DATA-ENTRY-RETURN = YES.
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
  DISPLAY fi_poltyp1 fi_poltyp fi_tranfr fi_tranto fi_output 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE bu_hptyp fi_poltyp fi_tranfr fi_tranto fi_output by_run bt_exit RECT-1 
         RECT-2 RECT-3 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

