&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic_bran         PROGRESS
*/
&Scoped-define WINDOW-NAME Win-wgwqmenu
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Win-wgwqmenu 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 
/*----------------------------------------------------*/
/* Modify By : Kanchana Chai.  ปรับ format  branch เพื่อรองรับการขยายสาขา A50-0178 */
/* Modify By : Munchumas V.  เพิ่มข้อการค้นหาโดย Chassis No. (A51-0061) */
/* Modify By : Porntiwa P.  A53-0039  24/01/2011
             : ปรับ Running Endorse จาก 5 เป็น 6 หลัก                   */
/*----------------------------------------------------*/

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
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

/* Create By Chutikarn.S Date. 13/01/2010 Assign No.: A53-0015
             : Query Receipt Date (วันที่รับเงินจากลูกค้า)             */

Def  WorkFile  Temp1
          Field     bptr         As       Char
          Field     fptr         As       Char
          Field     text1        As       Char.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_uwm100

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES uwm100

/* Definitions for BROWSE br_uwm100                                     */
&Scoped-define FIELDS-IN-QUERY-br_uwm100 uwm100.policy uwm100.rencnt ~
uwm100.endcnt uwm100.insref uwm100.name1 uwm100.acno1 uwm100.agent ~
uwm100.endern uwm100.comdat uwm100.expdat uwm100.enddat uwm100.trndat ~
uwm100.endno uwm100.trty11 uwm100.docno1 uwm100.opnpol uwm100.releas ~
uwm100.usrid uwm100.bchyr uwm100.bchno uwm100.bchcnt 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_uwm100 
&Scoped-define QUERY-STRING-br_uwm100 FOR EACH uwm100 NO-LOCK
&Scoped-define OPEN-QUERY-br_uwm100 OPEN QUERY br_uwm100 FOR EACH uwm100 NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_uwm100 uwm100
&Scoped-define FIRST-TABLE-IN-QUERY-br_uwm100 uwm100


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-188 RECT-46 RECT1 RECT11 RECT-279 bu_ok ~
co_select fi_select br_uwm100 BU_exit-2 fi_textselect 
&Scoped-Define DISPLAYED-OBJECTS co_select fi_select fi_select2 fi_select3 ~
fi_select4 fi_select5 fi_textselect 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR Win-wgwqmenu AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BU_exit-2 
     LABEL "<< Back" 
     SIZE 12 BY 1.14
     FONT 6.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 8 BY 1.14
     FONT 6.

DEFINE VARIABLE co_select AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 9
     LIST-ITEMS "Policy ","Insured Code","Name ","Producer Code","Agent Code","Expdat","Contact No","Receipt Date","Batch No" 
     DROP-DOWN-LIST
     SIZE 24.5 BY 1
     BGCOLOR 15 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_select AS CHARACTER FORMAT "x(50)":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_select2 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_select3 AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_select4 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 30.5 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_select5 AS INTEGER FORMAT "99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_textselect AS CHARACTER FORMAT "X(256)":U INITIAL "Select Policy" 
      VIEW-AS TEXT 
     SIZE 24 BY 1.05
     BGCOLOR 3 FGCOLOR 15 FONT 36 NO-UNDO.

DEFINE RECTANGLE RECT-188
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 131 BY 18.76
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-279
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 10 BY 1.67
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-46
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 131 BY 2.14
     BGCOLOR 3 .

DEFINE RECTANGLE RECT1
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 131 BY 2.62
     BGCOLOR 3 .

DEFINE RECTANGLE RECT11
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 13.83 BY 1.57
     BGCOLOR 1 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_uwm100 FOR 
      uwm100 SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_uwm100
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_uwm100 Win-wgwqmenu _STRUCTURED
  QUERY br_uwm100 DISPLAY
      uwm100.policy COLUMN-LABEL "Policy" FORMAT "x(15)":U COLUMN-FGCOLOR 0 COLUMN-BGCOLOR 15
      uwm100.rencnt COLUMN-LABEL "Ren" FORMAT ">9":U
      uwm100.endcnt COLUMN-LABEL "End" FORMAT "999":U
      uwm100.insref COLUMN-LABEL "Insured" FORMAT "x(11)":U COLUMN-FGCOLOR 0
      uwm100.name1 COLUMN-LABEL "Name" FORMAT "x(25)":U COLUMN-FGCOLOR 0
      uwm100.acno1 COLUMN-LABEL "Producer" FORMAT "x(11)":U
      uwm100.agent COLUMN-LABEL "Agent" FORMAT "x(11)":U
      uwm100.endern COLUMN-LABEL "ReceiptDate" FORMAT "99/99/9999":U
            WIDTH 12
      uwm100.comdat COLUMN-LABEL "Comdate" FORMAT "99/99/9999":U
            WIDTH 12
      uwm100.expdat COLUMN-LABEL "Expdat" FORMAT "99/99/9999":U
            WIDTH 12 COLUMN-FGCOLOR 0
      uwm100.enddat COLUMN-LABEL "Enddate" FORMAT "99/99/9999":U
            WIDTH 12
      uwm100.trndat COLUMN-LABEL "Trndat" FORMAT "99/99/9999":U
            WIDTH 12
      /*uwm100.endno COLUMN-LABEL "EndNo." FORMAT "x(8)":U*//*Comment A53-0039*/
      uwm100.endno COLUMN-LABEL "EndNo." FORMAT "x(10)":U /*Add A53-0039*/
      uwm100.trty11 COLUMN-LABEL "Tran.Type" FORMAT "x":U WIDTH 2
      uwm100.docno1 COLUMN-LABEL "Doc No." FORMAT "x(7)":U WIDTH 10
      uwm100.opnpol COLUMN-LABEL "เลขที่สัญญา" FORMAT "x(16)":U
      uwm100.releas COLUMN-LABEL "Rel" FORMAT "yes/no":U
      uwm100.usrid COLUMN-LABEL "User" FORMAT "x(10)":U
      uwm100.bchyr FORMAT "9999":U
      uwm100.bchno FORMAT "X(17)":U WIDTH 20
      uwm100.bchcnt FORMAT "99":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 128.5 BY 18.05
         BGCOLOR 15 FGCOLOR 0 FONT 6.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     bu_ok AT ROW 2 COL 121.67
     co_select AT ROW 2.05 COL 15.17 COLON-ALIGNED NO-LABEL
     fi_select AT ROW 2.05 COL 70.33 COLON-ALIGNED NO-LABEL
     fi_select2 AT ROW 2.05 COL 70.33 COLON-ALIGNED NO-LABEL
     fi_select3 AT ROW 2.05 COL 70.5 COLON-ALIGNED NO-LABEL
     fi_select4 AT ROW 2.05 COL 79 COLON-ALIGNED NO-LABEL
     fi_select5 AT ROW 2.05 COL 110 COLON-ALIGNED NO-LABEL
     br_uwm100 AT ROW 4.48 COL 3.17
     BU_exit-2 AT ROW 23.19 COL 119
     fi_textselect AT ROW 2.05 COL 42.67 COLON-ALIGNED NO-LABEL
     "Query By" VIEW-AS TEXT
          SIZE 10.5 BY 1.05 AT ROW 2.05 COL 3.67
          BGCOLOR 3 FGCOLOR 15 FONT 36
     RECT-188 AT ROW 3.86 COL 2
     RECT-46 AT ROW 22.67 COL 2
     RECT1 AT ROW 1.24 COL 2
     RECT11 AT ROW 22.91 COL 118
     RECT-279 AT ROW 1.71 COL 120.67
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.33 BY 24.04
         BGCOLOR 8 FONT 6.


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
  CREATE WINDOW Win-wgwqmenu ASSIGN
         HIDDEN             = YES
         TITLE              = ""
         HEIGHT             = 23.76
         WIDTH              = 133.33
         MAX-HEIGHT         = 24.52
         MAX-WIDTH          = 133.33
         VIRTUAL-HEIGHT     = 24.52
         VIRTUAL-WIDTH      = 133.33
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
IF NOT Win-wgwqmenu:LOAD-ICON("WIMAGE\safety":U) THEN
    MESSAGE "Unable to load icon: WIMAGE\safety"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW Win-wgwqmenu
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
                                                                        */
/* BROWSE-TAB br_uwm100 fi_select5 fr_main */
/* SETTINGS FOR FILL-IN fi_select2 IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_select2:HIDDEN IN FRAME fr_main           = TRUE.

/* SETTINGS FOR FILL-IN fi_select3 IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_select3:HIDDEN IN FRAME fr_main           = TRUE.

/* SETTINGS FOR FILL-IN fi_select4 IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_select4:HIDDEN IN FRAME fr_main           = TRUE.

/* SETTINGS FOR FILL-IN fi_select5 IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_select5:HIDDEN IN FRAME fr_main           = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(Win-wgwqmenu)
THEN Win-wgwqmenu:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_uwm100
/* Query rebuild information for BROWSE br_uwm100
     _TblList          = "sic_bran.uwm100"
     _FldNameList[1]   > sic_bran.uwm100.policy
"uwm100.policy" "Policy" "x(15)" "character" 15 0 ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   > sic_bran.uwm100.rencnt
"uwm100.rencnt" "Ren" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[3]   > sic_bran.uwm100.endcnt
"uwm100.endcnt" "End" ? "integer" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[4]   > sic_bran.uwm100.insref
"uwm100.insref" "Insured" "x(11)" "character" ? 0 ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[5]   > sic_bran.uwm100.name1
"uwm100.name1" "Name" "x(25)" "character" ? 0 ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[6]   > sic_bran.uwm100.acno1
"uwm100.acno1" "Producer" "x(11)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[7]   > sic_bran.uwm100.agent
"uwm100.agent" "Agent" "x(11)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[8]   > sic_bran.uwm100.endern
"uwm100.endern" "ReceiptDate" ? "date" ? ? ? ? ? ? no ? no no "12" yes no no "U" "" ""
     _FldNameList[9]   > sic_bran.uwm100.comdat
"uwm100.comdat" "Comdate" ? "date" ? ? ? ? ? ? no ? no no "12" yes no no "U" "" ""
     _FldNameList[10]   > sic_bran.uwm100.expdat
"uwm100.expdat" "Expdat" ? "date" ? 0 ? ? ? ? no ? no no "12" yes no no "U" "" ""
     _FldNameList[11]   > sic_bran.uwm100.enddat
"uwm100.enddat" "Enddate" ? "date" ? ? ? ? ? ? no ? no no "12" yes no no "U" "" ""
     _FldNameList[12]   > sic_bran.uwm100.trndat
"uwm100.trndat" "Trndat" ? "date" ? ? ? ? ? ? no ? no no "12" yes no no "U" "" ""
     _FldNameList[13]   > sic_bran.uwm100.endno
"uwm100.endno" "EndNo." ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[14]   > sic_bran.uwm100.trty11
"uwm100.trty11" "Tran.Type" ? "character" ? ? ? ? ? ? no ? no no "2" yes no no "U" "" ""
     _FldNameList[15]   > sic_bran.uwm100.docno1
"uwm100.docno1" "Doc No." ? "character" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" ""
     _FldNameList[16]   > sic_bran.uwm100.opnpol
"uwm100.opnpol" "เลขที่สัญญา" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[17]   > sic_bran.uwm100.releas
"uwm100.releas" "Rel" ? "logical" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[18]   > sic_bran.uwm100.usrid
"uwm100.usrid" "User" "x(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[19]   = sic_bran.uwm100.bchyr
     _FldNameList[20]   > sic_bran.uwm100.bchno
"uwm100.bchno" ? "X(17)" "character" ? ? ? ? ? ? no ? no no "20" yes no no "U" "" ""
     _FldNameList[21]   = sic_bran.uwm100.bchcnt
     _Query            is NOT OPENED
*/  /* BROWSE br_uwm100 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Win-wgwqmenu
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Win-wgwqmenu Win-wgwqmenu
ON END-ERROR OF Win-wgwqmenu
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Win-wgwqmenu Win-wgwqmenu
ON WINDOW-CLOSE OF Win-wgwqmenu
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BU_exit-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BU_exit-2 Win-wgwqmenu
ON CHOOSE OF BU_exit-2 IN FRAME fr_main /* << Back */
DO:
  Apply "Close" To This-Procedure.
  Return No-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok Win-wgwqmenu
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:

   If Input co_select = "Policy" Then Do :
        OPEN QUERY br_uwm100 FOR EACH uwm100 use-index uwm10001 
                     WHERE uwm100.policy >= Input fi_select   NO-LOCK .
  End.
  Else If Input co_select = "Insured Code" Then Do :
        OPEN QUERY br_uwm100 FOR EACH uwm100 use-index uwm10005
                     WHERE uwm100.insref >= Input fi_select   NO-LOCK .
  End.
  Else If Input co_select = "Name" Then Do :
        OPEN QUERY br_uwm100 FOR EACH uwm100  use-index uwm10006
                     WHERE uwm100.name1 >= Input fi_select   NO-LOCK .
  End.
  Else If Input co_select = "Producer Code" Then Do :
        OPEN QUERY br_uwm100 FOR EACH uwm100 use-index uwm10094
                     WHERE uwm100.acno1 >= Input fi_select   NO-LOCK .
  End. 
  Else If Input co_select = "Expdat" Then Do :
        OPEN QUERY br_uwm100 FOR EACH uwm100 use-index uwm10092 
                     WHERE uwm100.expdat >=  Input fi_select2   NO-LOCK .
  End.
  Else If Input co_select = "Vehicle Reg. No" Then Do :
        OPEN QUERY br_uwm301 FOR EACH uwm301 use-index uwm30102 
                     WHERE uwm301.vehreg  >=  Input fi_select   NO-LOCK .
  End. 
  Else If Input co_select = "Contact No" Then Do :
        OPEN QUERY br_uwm100 FOR EACH uwm100 use-index uwm10009
                     WHERE uwm100.opnpol >= Input fi_select   NO-LOCK .
  End. 
  Else If Input co_select = "Agent Code" Then Do :
        OPEN QUERY br_uwm100 FOR EACH uwm100 use-index uwm10004
                     WHERE uwm100.agent >= Input fi_select   NO-LOCK .
  End. 
  Else If Input co_select = "Chassis No" Then Do :
        OPEN QUERY br_uwm301 FOR EACH uwm301 use-index uwm30103 
                     WHERE uwm301.trareg  >=  Input fi_select   NO-LOCK .
  End. 
  Else If Input co_select = "Receipt Date" Then Do :
        OPEN QUERY br_uwm100 FOR EACH uwm100 use-index uwm10010 
                     WHERE uwm100.endern >=  Input fi_select2   NO-LOCK .
  End.
  Else If Input co_select = "Batch No" Then Do :
        OPEN QUERY br_uwm100 FOR EACH uwm100 use-index uwm10020 
                     WHERE uwm100.bchyr   =  Input fi_select3   AND 
                           uwm100.bchno  >=  Input fi_select4   AND 
                           uwm100.bchcnt >=  Input fi_select5   NO-LOCK .
  End.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME co_select
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_select Win-wgwqmenu
ON VALUE-CHANGED OF co_select IN FRAME fr_main
DO:
     uwm100.policy:COLUMN-BGCOLOR    IN BROWSE br_uwm100   = 15.
     uwm100.insref:COLUMN-BGCOLOR    IN BROWSE br_uwm100   = 15.    
     uwm100.name1:COLUMN-BGCOLOR     IN BROWSE br_uwm100   = 15.
     uwm100.acno1:COLUMN-BGCOLOR     IN BROWSE br_uwm100   = 15.
     uwm100.expdat:COLUMN-BGCOLOR    IN BROWSE br_uwm100   = 15.
     uwm100.opnpol:COLUMN-BGCOLOR    IN BROWSE br_uwm100   = 15.
     uwm100.agent:COLUMN-BGCOLOR     IN BROWSE br_uwm100   = 15.
     uwm100.endern:COLUMN-BGCOLOR    IN BROWSE br_uwm100   = 15.
     uwm100.bchyr:COLUMN-BGCOLOR     IN BROWSE br_uwm100   = 15.  
     uwm100.bchno:COLUMN-BGCOLOR     IN BROWSE br_uwm100   = 15.  
     uwm100.bchcnt:COLUMN-BGCOLOR    IN BROWSE br_uwm100   = 15. 


 If Input co_select = "Policy" Then Do :
       View br_uwm100. 
       fi_select2:Hidden = Yes.
       fi_select3:Hidden = Yes.
       fi_select4:Hidden = Yes.
       fi_select5:Hidden = Yes.
       View fi_select.         
       fi_textselect  =  "Select Policy".   
       uwm100.policy:COLUMN-BGCOLOR   IN BROWSE br_uwm100   = 10.
       OPEN QUERY br_uwm100 FOR EACH uwm100 use-index uwm10001 .                  
  End.
  Else If Input co_select = "Insured Code" Then Do :
       View br_uwm100.   
       fi_select2:Hidden = Yes.  
       fi_select3:Hidden = Yes.
       fi_select4:Hidden = Yes.
       fi_select5:Hidden = Yes.
       View fi_select.         
       fi_textselect  =  "Select Insured Code".
       uwm100.Insref:COLUMN-BGCOLOR   IN BROWSE br_uwm100   = 10.
       OPEN QUERY br_uwm100 FOR EACH uwm100 use-index uwm10005.           
  End.
  Else If Input co_select = "Name" Then Do :
       View br_uwm100.   
       fi_select2:Hidden = Yes.  
       fi_select3:Hidden = Yes.
       fi_select4:Hidden = Yes.
       fi_select5:Hidden = Yes.
       View fi_select.         
       fi_textselect  =  "Select Name".    
       uwm100.name1:COLUMN-BGCOLOR   IN BROWSE br_uwm100   = 10.
       OPEN QUERY br_uwm100 FOR EACH uwm100  use-index uwm10006.
  End.
  Else If Input co_select = "Producer Code" Then Do :
       View br_uwm100.   
       fi_select2:Hidden = Yes.  
       fi_select3:Hidden = Yes.
       fi_select4:Hidden = Yes.
       fi_select5:Hidden = Yes.
       View fi_select.       
       fi_textselect  =  "Select Producer Code". 
       uwm100.acno1:COLUMN-BGCOLOR   IN BROWSE br_uwm100   = 10.
       OPEN QUERY br_uwm100 FOR EACH uwm100 use-index uwm10094.   
  End. 
  Else If Input co_select = "Agent Code" Then Do :
       View br_uwm100.   
       fi_select2:Hidden = Yes.  
       fi_select3:Hidden = Yes.
       fi_select4:Hidden = Yes.
       fi_select5:Hidden = Yes.
       View fi_select.       
       fi_textselect  =  "Select Agent Code". 
       uwm100.agent:COLUMN-BGCOLOR   IN BROWSE br_uwm100   = 10.
       OPEN QUERY br_uwm100 FOR EACH uwm100 use-index uwm10094.   
  End. 
  Else If Input co_select = "Expdat" Then Do :
       View br_uwm100.   
       fi_select:Hidden = Yes.
       fi_select3:Hidden = Yes.
       fi_select4:Hidden = Yes.
       fi_select5:Hidden = Yes.
       fi_select2:Sensitive = Yes.       
       View fi_select2.  
       fi_textselect  =  "Select Expiry Date".
       uwm100.expdat:COLUMN-BGCOLOR   IN BROWSE br_uwm100   = 10.
       OPEN QUERY br_uwm100 FOR EACH uwm100 use-index uwm10092.    
  End.   
  Else If Input co_select = "Contact No" Then Do :
       View br_uwm100.   
       fi_select2:Hidden = Yes.  
       fi_select3:Hidden = Yes.
       fi_select4:Hidden = Yes.
       fi_select5:Hidden = Yes.
       View fi_select.       
       fi_textselect  =  "Select Contact  No". 
       uwm100.opnpol:COLUMN-BGCOLOR   IN BROWSE br_uwm100   = 10.
       OPEN QUERY br_uwm100 FOR EACH uwm100 use-index uwm10009.   
  End.  
  Else If Input co_select = "Receipt Date" Then Do :
       View br_uwm100.   
       fi_select:Hidden = Yes.
       fi_select3:Hidden = Yes.
       fi_select4:Hidden = Yes.
       fi_select5:Hidden = Yes.
       fi_select2:Sensitive = Yes.       
       View fi_select2.  
       fi_textselect  =  "Select Receipt Date".
       uwm100.endern:COLUMN-BGCOLOR   IN BROWSE br_uwm100   = 10.
       OPEN QUERY br_uwm100 FOR EACH uwm100 use-index uwm10010.    
  End. 
  Else If Input co_select = "Batch No" Then Do :
       View br_uwm100.   
       fi_select:Hidden = Yes.  
       fi_select2:Hidden = Yes. 
       fi_select3:Sensitive = Yes.  
       fi_select4:Sensitive = Yes.  
       fi_select5:Sensitive = Yes.  
       View fi_select3 fi_select4 fi_select5.       
       fi_textselect  =  "Select Batch No.". 
       uwm100.bchyr:COLUMN-BGCOLOR   IN BROWSE br_uwm100   = 10.
       uwm100.bchno:COLUMN-BGCOLOR   IN BROWSE br_uwm100   = 10.
       uwm100.bchcnt:COLUMN-BGCOLOR  IN BROWSE br_uwm100   = 10.
       OPEN QUERY br_uwm100 FOR EACH uwm100 use-index uwm10020.   
  End. 

  Disp fi_textselect With Frame fr_main.

  Apply "Entry" To fi_select.
  Apply "Entry" To fi_select2.
  Apply "Entry" To fi_select3.
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_select
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_select Win-wgwqmenu
ON RETURN OF fi_select IN FRAME fr_main
DO:
    Apply "Choose" To bu_ok.
  Return No-Apply.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_select2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_select2 Win-wgwqmenu
ON RETURN OF fi_select2 IN FRAME fr_main
DO:
  Apply "Choose" To bu_ok.
  Return No-Apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_select5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_select5 Win-wgwqmenu
ON RETURN OF fi_select5 IN FRAME fr_main
DO:
  Apply "Choose" To bu_ok.
  Return No-Apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_uwm100
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Win-wgwqmenu 


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
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  
  gv_prgid = "wfnqmenu".
  gv_prog  = "Query  Policy For Receipt".
  RUN  WUT\WUTHEAD (Win-wgwqmenu:handle,gv_prgid,gv_prog).

/*********************************************************************/  

  RUN  WUT\WUTWICEN (Win-wgwqmenu:handle).  
  SESSION:data-Entry-Return = Yes.

  
  co_select = "Policy".
  Disp co_select With Frame fr_main.
    
  Open Query  br_uwm100
      For each uwm100 No-Lock By uwm100.policy .
    
 fi_select:Move-To-Top().   
 Rect11:Move-To-Top().
 Apply "Value-Changed" to co_select.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI Win-wgwqmenu  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(Win-wgwqmenu)
  THEN DELETE WIDGET Win-wgwqmenu.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI Win-wgwqmenu  _DEFAULT-ENABLE
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
  DISPLAY co_select fi_select fi_select2 fi_select3 fi_select4 fi_select5 
          fi_textselect 
      WITH FRAME fr_main IN WINDOW Win-wgwqmenu.
  ENABLE RECT-188 RECT-46 RECT1 RECT11 RECT-279 bu_ok co_select fi_select 
         br_uwm100 BU_exit-2 fi_textselect 
      WITH FRAME fr_main IN WINDOW Win-wgwqmenu.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW Win-wgwqmenu.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

