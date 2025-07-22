/*----------------- Transfer to DWH and Summary to G/L for UPR NON MOTOR ---------------------------------*/
DEF VAR nv_countmotor    AS INTEGER.
DEF VAR nv_countnonmotor AS INTEGER.
DEF VAR nv_count         AS INTEGER.
DEF STREAM nfile.
DEF STREAM nfile1.
DEF STREAM ns1.
DEF NEW SHARED VAR sh_impdat   AS DATE FORMAT "99/99/9999".
DEF NEW SHARED VAR sh_imptim   AS CHAR FORMAT "X(9)".
DEF VAR  nv_inputmotor      AS CHAR FORMAT "X(80)" INIT "".     // "D:\Temp\UPR\M2022-03\upr_m_032022bi".   
DEF VAR  nv_inputmotor1     AS CHAR FORMAT "X(80)" INIT "".     // "D:\Temp\UPR\M2022-03\upr_m_032022_1_bi".
DEF VAR  nv_inputmotor2     AS CHAR FORMAT "X(80)" INIT "".     // "D:\Temp\UPR\M2022-03\upr_m_032022_2_bi".
DEF VAR  nv_inputnonmotor   AS CHAR FORMAT "X(80)" INIT "".     //INIT "".
DEF VAR  nv_inputmotor_success      AS CHAR FORMAT "X(80)" INIT "".
DEF VAR  nv_inputmotor1_success     AS CHAR FORMAT "X(80)" INIT "".
DEF VAR  nv_inputnonmotor_success   AS CHAR FORMAT "X(80)" INIT "".
DEF VAR  nv_outputfilesum       AS CHAR FORMAT "X(80)" INIT "".
DEF VAR  nv_outputfilesumgrp       AS CHAR FORMAT "X(80)" INIT "".

DEF VAR  nv_gpclass       AS CHAR FORMAT "X(4)" INIT "".

DEF VAR nv_start       AS CHAR FORMAT "X(8)" INIT "".
DEF VAR nv_end         AS CHAR FORMAT "X(8)" INIT "".
DEF VAR nv_total       AS CHAR FORMAT "X(8)" INIT "".
DEF VAR nv_timestart   AS INTEGER.
DEF VAR nv_timeend     AS INTEGER.

DEF VAR lv_monthend AS DATE.
DEF VAR nv_filesuccess   AS CHAR FORMAT "X(50)" INIT "" .


DEF INPUT PARAMETER innon_asdat AS DATE FORMAT "99/99/9999".
DEF INPUT PARAMETER innon_trndat AS DATE FORMAT "99/99/9999".
DEF INPUT PARAMETER innon_trndatto AS DATE FORMAT "99/99/9999".
DEF OUTPUT PARAMETER imnon_sta AS CHAR FORMAT "X(6)".

DEF VAR n_chkfile AS CHAR FORMAT "X(255)" INIT "".
DEF VAR nv_logfile AS CHAR FORMAT "X(255)" INIT "".

DEFINE TEMP-TABLE  wgetemp NO-UNDO
       FIELD  temp1     AS Char     FORMAT "X(100)" .

DEFINE TEMP-TABLE  wgenmotor NO-UNDO
   /*FIELD  impdat     AS DATE     FORMAT "99/99/9999" */ 
          FIELD  asdate     AS Date     FORMAT "99/99/9999"
   /*1*/  FIELD  dir_ri     AS CHAR     FORMAT "X(4)"            
   /*2*/  FIELD  branch     AS Char     FORMAT "X(4)"               
   /*3*/  FIELD  poltyp     AS Char     FORMAT "X(4)"               
   /*4*/  FIELD  trndat     AS Date     FORMAT "99/99/9999"         
   /*5*/  FIELD  policy     AS Char     FORMAT "X(16)"              
   /*6*/  FIELD  endno      AS Char     FORMAT "X(10)"              
   /*7*/  FIELD  rencnt     AS Integer  FORMAT ">>9"                
   /*8*/  FIELD  endcnt     AS Integer  FORMAT ">>9"                
   /*9*/  FIELD  comdat     AS Date     FORMAT "99/99/9999"         
   /*10*/ FIELD  expdat     AS Date     FORMAT "99/99/9999"         
   /*11*/ FIELD  exdatcal   AS Integer  FORMAT ">>>>>>9"            
   /*12*/ FIELD  datecal    AS Integer  FORMAT ">>>>>>9"            
   /*13*/ FIELD  prmcom     AS Decimal  FORMAT "->>,>>>,>>>,>>>.99" 
   /*14*/ FIELD  sumprm     AS Decimal  FORMAT "->>,>>>,>>>,>>>.99" 
   /*15*/ FIELD  earn       AS Decimal  FORMAT "->>,>>>,>>>,>>>.99" 
   /*16*/ FIELD  uearn      AS Decimal  FORMAT "->>,>>>,>>>,>>>.99" 
   /*17*/ FIELD  earn1      AS Decimal  FORMAT "->>,>>>,>>>,>>>.99" 
   /*18*/ FIELD  uearn1     AS Decimal  FORMAT "->>,>>>,>>>,>>>.99" 
   /*19*/ FIELD  prmall     AS Decimal  FORMAT "->>,>>>,>>>,>>>.99" 
   /*20*/ FIELD  earnall    AS Decimal  FORMAT "->>,>>>,>>>,>>>.99" 
   /*21*/ FIELD  uearnall   AS Decimal  FORMAT "->>,>>>,>>>,>>>.99" 
   /*22*/ FIELD  prmtrt     AS Decimal  FORMAT "->>,>>>,>>>,>>>.99" 
   /*23*/ FIELD  earntrt    AS Decimal  FORMAT "->>,>>>,>>>,>>>.99" 
   /*24*/ FIELD  uearntrt   AS Decimal  FORMAT "->>,>>>,>>>,>>>.99" 
   /*25*/ FIELD  prmfac     AS Decimal  FORMAT "->>,>>>,>>>,>>>.99" 
   /*26*/ FIELD  earnfac    AS Decimal  FORMAT "->>,>>>,>>>,>>>.99" 
   /*27*/ FIELD  uearnfac   AS Decimal  FORMAT "->>,>>>,>>>,>>>.99" 
   /*28*/ FIELD  polsta     AS CHAR     FORMAT "X(4)"              
   /*29*/ FIELD  agent      AS Char     FORMAT "X(10)"              
   /*30*/ FIELD  agentname  AS Char     FORMAT "X(250)"             
   /*31*/ FIELD  acno       AS Char     FORMAT "X(10)"              
   /*32*/ FIELD  acnoname   AS Char     FORMAT "X(250)" .            
   /*FIELD  imptim     AS Char     FORMAT "X(8)".*/  

DEFINE TEMP-TABLE  wgennonmotor NO-UNDO
   /*FIELD  impdat     AS DATE     FORMAT "99/99/9999" */  
          FIELD  asdate     AS Date     FORMAT "99/99/9999"
   /*1*/  FIELD  dir_ri     AS CHAR     FORMAT "X(4)"             
   /*2*/  FIELD  branch     AS Char     FORMAT "X(4)"               
   /*3*/  FIELD  poltyp     AS Char     FORMAT "X(4)"               
   /*4*/  FIELD  trndat     AS Date     FORMAT "99/99/9999"         
   /*5*/  FIELD  policy     AS Char     FORMAT "X(16)"              
   /*6*/  FIELD  endno      AS Char     FORMAT "X(10)"              
   /*7*/  FIELD  rencnt     AS Integer  FORMAT ">>9"                
   /*8*/  FIELD  endcnt     AS Integer  FORMAT ">>9"                
   /*9*/  FIELD  comdat     AS Date     FORMAT "99/99/9999"         
   /*10*/ FIELD  expdat     AS Date     FORMAT "99/99/9999"         
   /*11*/ FIELD  exdatcal   AS Integer  FORMAT ">>>>>>9"            
   /*12*/ FIELD  datecal    AS Integer  FORMAT ">>>>>>9"            
   /*13*/ FIELD  prmall     AS Decimal  FORMAT "->>,>>>,>>>,>>>.99" 
   /*14*/ FIELD  earnall    AS Decimal  FORMAT "->>,>>>,>>>,>>>.99" 
   /*15*/ FIELD  uearnall   AS Decimal  FORMAT "->>,>>>,>>>,>>>.99" 
   /*16*/ FIELD  prmtrt     AS Decimal  FORMAT "->>,>>>,>>>,>>>.99" 
   /*17*/ FIELD  earntrt    AS Decimal  FORMAT "->>,>>>,>>>,>>>.99" 
   /*18*/ FIELD  uearntrt   AS Decimal  FORMAT "->>,>>>,>>>,>>>.99" 
   /*19*/ FIELD  prmfac     AS Decimal  FORMAT "->>,>>>,>>>,>>>.99" 
   /*20*/ FIELD  earnfac    AS Decimal  FORMAT "->>,>>>,>>>,>>>.99" 
   /*21*/ FIELD  uearnfac   AS Decimal  FORMAT "->>,>>>,>>>,>>>.99" 
   /*22*/ FIELD  polsta     AS CHAR     FORMAT "X(4)"               
   /*23*/ FIELD  agent      AS Char     FORMAT "X(10)"              
   /*24*/ FIELD  agentname  AS Char     FORMAT "X(250)"             
   /*25*/ FIELD  acno       AS Char     FORMAT "X(10)"              
   /*26*/ FIELD  acnoname   AS Char     FORMAT "X(250)" .            
   /*FIELD  imptim     AS Char     FORMAT "X(8)".*/ 

/*
FORM
 " " SKIP
 nv_inputmotor     LABEL "MOTOR1>     Import File: " SKIP
 /*nv_inputmotor1    LABEL "MOTOR2>     Import File: " SKIP
 nv_inputmotor2    LABEL "MOTOR2>     Import File: " SKIP */
 nv_inputnonmotor  LABEL "NON-MOTOR>  Import File: " 
WITH FRAME login CENTERED ROW 1 SIDE-LABELS OVERLAY WIDTH 80  
TITLE " Import Unearn".

UPDATE nv_inputmotor 
       //nv_inputmotor1
       //nv_inputmotor2
       nv_inputnonmotor 
WITH FRAME login.
*/
/*
RUN getEndofMonth (INPUT nv_today - 1, OUTPUT lv_monthend).

FIND FIRST gldat_fil WHERE gldat_fil.reportid = "glora001" AND gldat_fil.reporttype = "2" NO-LOCK NO-ERROR.
IF  AVAIL gldat_fil THEN DO:
    ASSIGN  /*nv_inputmotor    = gldat_fil.npath1 + gldat_fil.output1 + STRING(YEAR(lv_monthend),"9999") 
                             + STRING(MONTH(lv_monthend),"99") 
                             + STRING(DAY(lv_monthend),"99") + "bi"
            nv_inputmotor1   = gldat_fil.npath1 + gldat_fil.output1 + STRING(YEAR(lv_monthend),"9999") 
                             + STRING(MONTH(lv_monthend),"99") 
                             + STRING(DAY(lv_monthend),"99") + "_1_bi"*/
            nv_inputnonmotor = gldat_fil.npath1 + gldat_fil.output1 + STRING(YEAR(lv_monthend),"9999") 
                             + STRING(MONTH(lv_monthend),"99") 
                             + STRING(DAY(lv_monthend),"99") + "bi"
            /*nv_inputmotor_success  = gldat_fil.npath2 + gldat_fil.output1 + STRING(YEAR(lv_monthend),"9999") 
                          + STRING(MONTH(lv_monthend),"99") 
                          + STRING(DAY(lv_monthend),"99") + "bi"  
            nv_inputmotor1_success  = gldat_fil.npath2 + gldat_fil.output1 + STRING(YEAR(lv_monthend),"9999") 
                          + STRING(MONTH(lv_monthend),"99") 
                          + STRING(DAY(lv_monthend),"99") + "_1_bi" */
            nv_inputnonmotor_success = gldat_fil.npath2 + gldat_fil.output1 + STRING(YEAR(lv_monthend),"9999") 
                          + STRING(MONTH(lv_monthend),"99") 
                          + STRING(DAY(lv_monthend),"99") + "bi"
            nv_outputfilesum = gldat_fil.npath1 + "uprsumforgl" + STRING(YEAR(lv_monthend),"9999") 
                             + STRING(MONTH(lv_monthend),"99") 
                             + STRING(DAY(lv_monthend),"99").
END.
*/

nv_start     = STRING(TIME,"HH:MM:SS").
nv_timestart = TIME.
nv_timeend   = TIME.
nv_total     = "".

//RUN pd_getendofMonth (INPUT TODAY - 1, OUTPUT lv_monthend).
ASSIGN lv_monthend  =    innon_asdat. 
nv_inputnonmotor = "D:\temp\uprexp\Non\UPNON" + STRING(YEAR(lv_monthend),"9999") 
                      + STRING(MONTH(lv_monthend),"99") 
                      + STRING(DAY(lv_monthend),"99") + "bi".

// nv_inputnonmotor = "D:\Temp\upNON20220331bi".
 nv_outputfilesum = "D:\temp\uprexp\Non\SUM_NONMotor.txt". 
 nv_outputfilesumgrp = "D:\temp\uprexp\Non\SUM_NONMotor_gpclass.txt".

/*DELETE

FOR EACH upr001_fil.
    DISP "DELETE DWH (upr001_fil)" upr001_fil.policy FORMAT "X(12)" NO-LABEL 
                   upr001_fil.rencnt NO-LABEL 
                   upr001_fil.endcnt NO-LABEL.
    PAUSE 0.

    DELETE upr001_fil.
END.

FOR EACH uem100 WHERE uem100.asdat = 03/31/2022.     //lv_monthend.
    DISP "DELETE GLOC - Master (uem100)" uem100.DIR_ri NO-LABEL 
                  uem100.branch NO-LABEL 
                  uem100.gpclass NO-LABEL
                  uem100.poltyp NO-LABEL.
    PAUSE 0.
    DELETE uem100.
END.

FOR EACH uem200 WHERE uem200.asdat = 03/31/2022.     //lv_monthend.
    DISP "DELETE GLOC - Group Master (uem200)" uem200.DIR_ri NO-LABEL 
                  uem200.branch NO-LABEL 
                  uem200.gpclass NO-LABEL.
    PAUSE 0.
    DELETE uem200.
END.

FOR EACH ued001 WHERE ued001.asdat =  03/31/2022.    //lv_monthend.
    DISP "DELETE GLOC - Detail (ued001)" ued001.policy FORMAT "X(12)" NO-LABEL 
                   ued001.rencnt NO-LABEL 
                   ued001.endcnt NO-LABEL.
    PAUSE 0.
    DELETE ued001.
END.
*/

sh_impdat   = TODAY.
sh_imptim   = STRING(TIME,"HH:MM:SS").
sh_imptim   = "10:00:00".

/*NON-MOTOR*/
FOR EACH wgennonmotor.
    DELETE wgennonmotor.
END.

FOR EACH wgetemp.
    DELETE wgetemp.
END.

/*DELIMITER*/  
ASSIGN n_chkfile = ""
       n_chkfile = SEARCH(nv_inputnonmotor).
IF n_chkfile <> ? THEN DO:
    nv_count = 0.
    INPUT STREAM nfile1 FROM value(nv_inputnonmotor). 
    REPEAT :
        nv_count = nv_count + 1. 
        IF nv_count > 5 THEN DO: /*Head Column Line 1-5*/
            CREATE wgennonmotor.
            IMPORT STREAM nfile1 DELIMITER "|" wgennonmotor.
        END.
        ELSE DO:
            CREATE wgetemp.
            IMPORT STREAM nfile1 wgetemp.
        END.
    END.     
    INPUT STREAM nfile1 CLOSE.
END.

nv_countnonmotor =0.

FOR EACH  wgennonmotor NO-LOCK.

    IF wgennonmotor.policy = "" THEN NEXT.
    IF SUBSTRING(wgennonmotor.policy,1,1) = "C" OR 
       SUBSTRING(wgennonmotor.policy,1,1) = "Q" OR
       SUBSTRING(wgennonmotor.policy,1,1) = "U" OR
       SUBSTRING(wgennonmotor.policy,1,1) = "R" THEN NEXT.

    nv_countnonmotor = nv_countnonmotor + 1.

    
   /* DISP wgennonmotor.asdat  NO-LABEL
         wgennonmotor.policy NO-LABEL 
         wgennonmotor.rencnt NO-LABEL 
         wgennonmotor.endcnt NO-LABEL
         nv_countnonmotor    NO-LABEL.
    PAUSE 0.
    */
    

    FIND FIRST upr001_fil WHERE upr001_fil.asdat  = wgennonmotor.asdat  AND
                                upr001_fil.impdat = sh_impdat           AND
                                upr001_fil.policy = wgennonmotor.policy AND
                                upr001_fil.rencnt = wgennonmotor.rencnt AND
                                upr001_fil.endcnt = wgennonmotor.endcnt 
    NO-LOCK NO-ERROR.
    IF NOT AVAIL upr001_fil THEN DO:

    CREATE upr001_fil.
    ASSIGN upr001_fil.impdat    =  sh_impdat
           upr001_fil.asdat     =  wgennonmotor.asdat
           upr001_fil.dir_ri    =  TRIM(wgennonmotor.dir_ri)   
           upr001_fil.branch    =  TRIM(wgennonmotor.branch)  
           upr001_fil.poltyp    =  TRIM(wgennonmotor.poltyp)  
           upr001_fil.trndat    =  wgennonmotor.trndat  
           upr001_fil.policy    =  TRIM(wgennonmotor.policy)  
           upr001_fil.endno     =  TRIM(wgennonmotor.endno)   
           upr001_fil.rencnt    =  wgennonmotor.rencnt  
           upr001_fil.endcnt    =  wgennonmotor.endcnt  
           upr001_fil.comdat    =  wgennonmotor.comdat  
           upr001_fil.expdat    =  wgennonmotor.expdat  
           upr001_fil.exdatcal  =  wgennonmotor.exdatcal
           upr001_fil.datecal   =  wgennonmotor.datecal 
           upr001_fil.prmall    =  wgennonmotor.prmall  
           upr001_fil.earnall   =  wgennonmotor.earnall 
           upr001_fil.uearnall  =  wgennonmotor.uearnall
           upr001_fil.prmtrt    =  wgennonmotor.prmtrt  
           upr001_fil.earntrt   =  wgennonmotor.earntrt 
           upr001_fil.uearntrt  =  wgennonmotor.uearntrt
           upr001_fil.prmfac    =  wgennonmotor.prmfac  
           upr001_fil.earnfac   =  wgennonmotor.earnfac 
           upr001_fil.uearnfac  =  wgennonmotor.uearnfac
           upr001_fil.polsta    =  TRIM(wgennonmotor.polsta)  
           upr001_fil.agent     =  TRIM(wgennonmotor.agent)   
           upr001_fil.agentnam  =  TRIM(wgennonmotor.agentnam)
           upr001_fil.acno      =  TRIM(wgennonmotor.acno)    
           upr001_fil.acnoname  =  TRIM(wgennonmotor.acnoname)
           upr001_fil.imptim    =  sh_imptim  .
    END.
    RELEASE upr001_fil.
    
END.


nv_end       = STRING(TIME,"HH:MM:SS"). 
nv_timeend   = TIME.                                           
nv_total     = STRING((nv_timeend - nv_timestart),"HH:MM:SS"). 

imnon_sta = "Yes".

ASSIGN n_chkfile = ""
       n_chkfile = SEARCH(nv_inputnonmotor).
IF n_chkfile <> ? THEN DO:
    OS-COPY VALUE(nv_inputnonmotor) VALUE(nv_inputnonmotor_success).
    IF OS-ERROR <> 0 THEN DO:
       MESSAGE "An error occured" OS-ERROR VIEW-AS ALERT-BOX ERROR.
    END.
END.
/*
ELSE DO:
    OS-DELETE VALUE (nv_inputnonmotor).
END.
*/


nv_logfile = "D:\temp\uprexp\log_uprimportnon.txt".
OUTPUT TO VALUE(nv_logfile) APPEND NO-ECHO.
EXPORT DELIMITER "|"
        "Complete (UNEARN)" 
        "As Date=" 
        innon_asdat
        "Import Date="
        TODAY
        "Motor= "   
        nv_countmotor 
        " Non-Motor= " 
        nv_countnonmotor 
        nv_start 
        nv_end   
        nv_total .
OUTPUT CLOSE.

APPLY "CLOSE" TO THIS-PROCEDURE.
    RETURN NO-APPLY.
/*
DISPLAY "Complete (UNEARN)" SKIP
        "Motor= " nv_countmotor NO-LABEL " Non-Motor= " nv_countnonmotor NO-LABEL SKIP(1)
        nv_start NO-LABEL
        nv_end   NO-LABEL
        nv_total NO-LABEL.
PAUSE.
*/

/*--------------------P R O C E D U R E-------------------------------------*/

PROCEDURE pd_getEndofMonth:
    DEF INPUT PARAMETER lv_date AS DATE.
    DEF OUTPUT PARAMETER lv_monthend AS DATE.

    lv_monthend = DATE(MONTH(lv_date),31,YEAR(lv_date)) NO-ERROR.
    IF lv_monthend = ? THEN DO:
        lv_monthend = DATE(MONTH(lv_date),30,YEAR(lv_date)) NO-ERROR.
        IF lv_monthend = ? THEN DO:
           lv_monthend = DATE(MONTH(lv_date),29,YEAR(lv_date)) NO-ERROR.
           IF lv_monthend = ? THEN DO:
              lv_monthend = DATE(MONTH(lv_date),28,YEAR(lv_date)) NO-ERROR.
           END.
        END.
    END.
END PROCEDURE.

