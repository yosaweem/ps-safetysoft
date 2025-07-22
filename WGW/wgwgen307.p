/*=================================================================*/
/* Program Name :  Transfer Data   GW to Premium                   */
/* CREATE  By   : Chaiyong W. A58-0123 24/04/2015                  */
/*                Transfer Data   GW to Premium                    */
/* Dup Program Transfer                                            */ 
/*Modify by : Chaiyong W. A64-0228 28/05/2021                      */
/*            Add table uwmbenn                                    */      
/*Modify by : Songkran P. & Tontawan S. A65-0141 28/11/2022
              Add field                                            */      
/*Modify by : Chaiyong W. A66-0221 06/10/2023 06/10/2023 add field */                                               
/*=================================================================*/

DEF INPUT PARAMETER nv_bchyr  AS INT.
DEF INPUT PARAMETER nv_bchno  AS CHAR.
DEF INPUT PARAMETER nv_bchcnt AS INT.
DEF INPUT PARAMETER nv_policy AS CHAR.
DEF INPUT PARAMETER nv_rencnt AS INT.
DEF INPUT PARAMETER nv_endcnt AS INT.

/*---Begin by Chaiyong W. A64-0228 27/05/2021*/
DEF VAR nv_tbenna AS CHAR INIT "". 
DEF VAR nv_ex     AS INT  INIT 0.
DEF TEMP-TABLE ttext               
    FIELD lnumber  AS INT   INIT 0
    FIELD nline    AS INT   INIT 0
    FIELD ttext    AS CHAR  INIT ""
    FIELD tsta     AS CHAR  INIT ""
    FIELD riskno   AS INT   INIT 0
    FIELD itemno   AS INT   INIT 0
    FIELD tname    AS CHAR  INIT ""
    FIELD treship  AS CHAR  INIT "".
DEF VAR nv_count   AS INT   INIT 0.
DEF VAR nv_poline  AS CHAR  INIT "".
DEF VAR nv_Fptr    AS RECID INIT ?.
DEF VAR nv_jou     AS CHAR  INIT "".
DEF VAR nv_risk    AS INT   INIT 0.
DEF VAR nv_item    AS INT   INIT 0.
DEF VAR nv_sta     AS CHAR  INIT "".
DEF VAR nv_ridx    AS INT   INIT 0.
DEF VAR nv_txt     AS CHAR  INIT "".
DEF VAR nv_st1     AS CHAR  INIT "".
DEF VAR nv_st2     AS CHAR  INIT "".
DEF VAR nv_st3     AS CHAR  INIT "".
DEF VAR nv_st4     AS CHAR  INIT "".
DEF VAR nv_st5     AS CHAR  INIT "".
DEF VAR nv_Cst5    AS INT   INIT 0.
def var nv_day     as int   init 0.
def var nv_devide  as int   init 0.


PROCEDURE pd_ben:
    DEF INPUT PARAMETER nv_bname AS CHAR INIT "".
    DEF VAR nv_cben AS INT INIT 0.
    nv_ex = NUM-ENTRIES(nv_bname,",") NO-ERROR.
    loop_ben:
    REPEAT:
        CREATE ttext.
        ASSIGN
            nv_cben       = nv_cben  + 1
            nv_count      = nv_count + 1
            ttext.lnumber = nv_count
            ttext.tname   = trim(entry(nv_cben,nv_bname,",")) NO-ERROR.
        IF nv_cben  = nv_Ex THEN LEAVE loop_ben.
    END.
END PROCEDURE.
PROCEDURE pd_reship:
    nv_ex = NUM-ENTRIES(sic_bran.uwm307.reship,",") NO-ERROR.
    DEF VAR nv_cben AS INT INIT 0.
    loop_reship:
    REPEAT:
        nv_cben       = nv_cben  + 1.
        FIND FIRST ttext WHERE ttext.lnumber = nv_cben NO-ERROR NO-WAIT.
        IF AVAIL ttext THEN ttext.treship = trim(entry(nv_cben,sic_bran.uwm307.reship,",")).

        IF nv_cben  = nv_Ex THEN LEAVE loop_reship.
    END.
END PROCEDURE.
nv_poline = SUBSTR(nv_policy,3,2) NO-ERROR.
IF nv_poline = "68" OR  nv_poline = "69" THEN DO:
 
    FIND FIRST sic_bran.uwmbenn USE-INDEX uwmbenn01 WHERE
               sic_bran.uwmbenn.policy = nv_policy AND   
               sic_bran.uwmbenn.rencnt = nv_rencnt AND   
               sic_bran.uwmbenn.endcnt = nv_endcnt NO-LOCK NO-ERROR . 
    IF AVAIL sic_bran.uwmbenn THEN DO:
     /*Found have data not cuttext*/

    END.
    ELSE DO:

    
    
        FIND FIRST sic_bran.uwm120 WHERE
               sic_bran.uwm120.policy = nv_policy AND
               sic_bran.uwm120.rencnt = nv_rencnt AND
               sic_bran.uwm120.endcnt = nv_endcnt AND
               sic_bran.uwm120.bchyr  = nv_bchyr  AND
               sic_bran.uwm120.bchno  = nv_bchno  AND
               sic_bran.uwm120.bchcnt = nv_bchcnt NO-LOCK NO-ERROR.
        IF AVAIL sic_bran.uwm120 THEN DO:
            nv_fptr = sic_bran.uwm120.fptr01.
            loop_ftxt:
            REPEAT:
                IF nv_fptr = 0 OR nv_fptr = ? THEN LEAVE loop_ftxt.
                FIND sic_bran.uwd120 WHERE RECID(sic_bran.uwd120) = nv_fptr NO-LOCK NO-ERROR.
                IF AVAIL sic_bran.uwd120 THEN DO:
                    
                    IF sic_bran.uwd120.policy <> sic_bran.uwm120.policy OR
                       sic_bran.uwd120.rencnt <> sic_bran.uwm120.rencnt OR
                       sic_bran.uwd120.endcnt <> sic_bran.uwm120.endcnt OR 
                       sic_bran.uwd120.riskgp <> sic_bran.uwm120.riskgp OR
                       sic_bran.uwd120.riskno <> sic_bran.uwm120.riskno THEN DO:
                        nv_fptr = 0.
                    END.
                    ELSE IF nv_fptr = sic_bran.uwd120.fptr THEN DO:
                        nv_fptr = 0.
                    END.
                    ELSE DO:
                        ASSIGN
                            nv_fptr  = sic_bran.uwd120.fptr
                            nv_txt   = trim(sic_bran.uwd120.ltext)
                            .
        
        
                        IF nv_txt <> "" THEN DO:
                            IF nv_st5 = "F" AND nv_cst5 <> 0 THEN DO:
                                IF INDEX(nv_txt,"Risk") = 1 AND INDEX(nv_txt,"item") > 7  AND INDEX(nv_txt,"item") < 20 THEN DO:
                                    ASSIGN
                                        nv_st5 = ""
                                        nv_Cst5 = 0.
                                END.
                                ELSE LEAVE loop_Ftxt.
                            END.
                            CREATE ttext.
                            ASSIGN
                                 nv_count    = nv_Count + 1
                                 ttext.nline = nv_Count 
                                 ttext.ttext = nv_txt .
                            
        
        
        
                            IF nv_st1 = "" AND INDEX(nv_txt,":") = 5 AND nv_count = 1 THEN DO:
                                ASSIGN nv_st1 = "F" ttext.tsta = "From".
                                nv_ridx     = R-INDEX(nv_txt,":") .
                                IF R-INDEX(nv_txt,",") <> 0 THEN DO:
                                    RUN pd_entry(INPUT-OUTPUT ttext.ttext).
                                END.
                                ELSE ttext.ttext = trim(SUBSTR(ttext.ttext, R-INDEX(nv_txt,":") + 1)).
        
    
                                
                            END.
                            ELSE IF nv_st2 = "" AND INDEX(nv_txt,":") = 5 AND nv_count = 2 THEN do:
                                ASSIGN nv_st2 = "F" ttext.tsta = "To".
                                nv_ridx     = R-INDEX(nv_txt,":") .
                                
                                IF R-INDEX(nv_txt,",") <> 0 THEN DO:
                                    RUN pd_entry(INPUT-OUTPUT ttext.ttext).
                                END.
                                ELSE ttext.ttext = trim(SUBSTR(ttext.ttext, R-INDEX(nv_txt,":") + 1)).
                            END.
                            ELSE IF nv_st3 = "" AND index(nv_txt,"Membercode:") = 1 THEN  nv_st3 = "F".
                            ELSE IF nv_st4 = "" AND index(nv_txt,"RISK 1 ITEM 1") = 1 THEN  nv_st4 = "F".
                           IF INDEX(nv_txt,"Risk") = 1 AND INDEX(nv_txt,"item") > 7  AND INDEX(nv_txt,"item") < 20  THEN DO:
                                nv_risk = int(trim(SUBSTR(nv_txt,5,INDEX(nv_txt,"item") - 5 ))) NO-ERROR  .
                                
                                nv_txt = trim(SUBSTR(nv_txt,R-INDEX(nv_txt,"item") + 4 )) NO-ERROR  .
                                 
                                IF INDEX(nv_Txt," ") <> 0 THEN nv_txt = SUBSTR(nv_txt,1, INDEX(nv_Txt," ")).
                                nv_Txt = TRIM(nv_txt).
                                nv_item = INT(nv_txt) NO-ERROR.
                                nv_sta  = "".
        
                            END.
                            ELSE DO:
                                 
                                 IF nv_risk <> 0  AND nv_item <> 0 AND nv_sta = "" THEN nv_sta = "Insure Name" .
                                 ELSE IF INDEX(nv_txt,"IC NO.  :") = 1       THEN ASSIGN nv_sta = "ICNO"  ttext.ttext = trim(SUBSTR(ttext.ttext,10)) NO-ERROR.
                                 ELSE IF INDEX(nv_txt,"Passport No. :") = 1  THEN ASSIGN nv_sta = "passport" ttext.ttext = trim(SUBSTR(ttext.ttext,15)) NO-ERROR.
                                 ELSE IF INDEX(nv_txt,"ID Card :") = 1  THEN ASSIGN nv_sta = "Id card" ttext.ttext = trim(SUBSTR(ttext.ttext,10)) NO-ERROR.
                                 ELSE IF INDEX(nv_txt,"Mobile :") = 1  THEN ASSIGN nv_sta = "mobile"  ttext.ttext = trim(SUBSTR(ttext.ttext,9)) NO-ERROR.
                                 ELSE IF INDEX(nv_txt,"Beneficiary :") = 1  THEN nv_sta = "Benficiary".     
                                 
                            END.
                            IF nv_sta <> "" AND ttext.tsta = "" AND INDEX(nv_txt,"Beneficiary :") <> 1 THEN ttext.tsta = nv_sta.
                             ASSIGN
                                    ttext.riskno =  nv_risk
                                    ttext.itemno =  nv_item.
        
        
                            IF index(nv_txt,"Beneficiary :") = 1  THEN ASSIGN nv_st5  = "F" nv_Cst5 = 0.
                            IF ttext.tsta = "Benficiary" THEN DO:
                                nv_txt = "".
                                IF INDEX(ttext.ttext,"/") > 1  THEN nv_txt = "/".
                                ELSE IF INDEX(ttext.ttext,"\") > 1 THEN nv_txt = "\".
                                IF nv_txt <> "" THEN DO:
                                    
                                    ttext.treship = trim(substr(ttext.ttext,INDEX(ttext.ttext,nv_txt) + 1)  ) no-error.
                                    ttext.ttext   = trim(substr(ttext.ttext,1,INDEX(ttext.ttext,nv_txt) - 1)) no-error. 
                                END.
                            END.
                            IF nv_count >= 15 THEN DO:
                                IF nv_St1 <> "" AND
                                   nv_St2 <> "" AND
                                   nv_St3 <> "" AND
                                   nv_St4 <> "" THEN DO:
                                END.
                                ELSE LEAVE loop_ftxt.
                            END.
                        END.
                        ELSE DO:
                            IF  nv_st5  = "F"  THEN nv_Cst5 = nv_Cst5 + 1.
                        END.
                    END.
        
                END.
            END.
            IF nv_St1 <> "" AND
               nv_St2 <> "" AND
               nv_St3 <> "" AND
               nv_St4 <> "" THEN DO:
                FOR EACH ttext NO-LOCK BY ttext.nline:
                    IF ttext.tsta = "From" THEN nv_jou = ttext.ttext .
                    ELSE IF ttext.tsta = "To" THEN nv_jou = nv_jou + " - " + ttext.ttext .
                END.
            END.    
        END.
    END.
END.
PROCEDURE pd_entry:
    DEF INPUT-OUTPUT PARAMETER nv_tentry AS CHAR INIT "".
    DEF VAR nv_ientry AS INT INIT 0.
    DEF VAR nv_icou   AS INT INIT 0.
    DEF VAR nv_itext  AS CHAR INIT "".
    DEF VAR nv_itext2 AS CHAR INIT "".
    
    nv_ientry = NUM-ENTRIES(nv_tentry,",") NO-ERROR.
    IF nv_ientry <> 0 THEN DO:
        loop_entry:
         REPEAT:
             nv_icou = nv_icou + 1.
             nv_itext = "".
             nv_itext = ENTRY(nv_icou,nv_tentry,",") NO-ERROR.
             IF nv_itext <> "" THEN DO:
                 IF INDEX(nv_itext,":") <> 0 THEN nv_itext = TRIM(SUBSTR(nv_itext,INDEX(nv_itext,":") + 1)).
                 IF nv_itext2 = "" THEN nv_itext2 = nv_itext.
                 ELSE nv_itext2 = nv_itext2 + "," + nv_itext.
             END.

             IF nv_icou = nv_ientry THEN LEAVE loop_entry.
         END.
    END.
    ELSE nv_tentry = trim(SUBSTR(nv_tentry, R-INDEX(nv_txt,":") + 1)).
    IF nv_itext2  <> "" THEN nv_tentry = nv_itext2 .
END PROCEDURE.
/*End by Chaiyong W. A64-0228 27/05/2021-----*/
FOR EACH sic_bran.uwm307 WHERE
         sic_bran.uwm307.policy = nv_policy AND
         sic_bran.uwm307.rencnt = nv_rencnt AND
         sic_bran.uwm307.endcnt = nv_endcnt AND
         sic_bran.uwm307.bchyr  = nv_bchyr  AND
         sic_bran.uwm307.bchno  = nv_bchno  AND
         sic_bran.uwm307.bchcnt = nv_bchcnt NO-LOCK:
  FIND FIRST sicuw.uwm307 WHERE 
       sicuw.uwm307.policy = sic_bran.uwm307.policy AND
       sicuw.uwm307.rencnt = sic_bran.uwm307.rencnt AND
       sicuw.uwm307.endcnt = sic_bran.uwm307.endcnt AND
       sicuw.uwm307.riskgp = sic_bran.uwm307.riskgp AND
       sicuw.uwm307.riskno = sic_bran.uwm307.riskno AND
       sicuw.uwm307.itemno = sic_bran.uwm307.itemno
  NO-ERROR.

  IF NOT AVAILABLE sicuw.uwm307 THEN DO:
    CREATE sicuw.uwm307.
  END.

  ASSIGN
    sicuw.uwm307.policy = sic_bran.uwm307.policy       
    sicuw.uwm307.rencnt = sic_bran.uwm307.rencnt       
    sicuw.uwm307.endcnt = sic_bran.uwm307.endcnt       
    sicuw.uwm307.riskgp = sic_bran.uwm307.riskgp       
    sicuw.uwm307.riskno = sic_bran.uwm307.riskno       
    sicuw.uwm307.itemno = sic_bran.uwm307.itemno       
    sicuw.uwm307.iref   = sic_bran.uwm307.iref         
    sicuw.uwm307.ifirst = sic_bran.uwm307.ifirst       
    sicuw.uwm307.iname  = sic_bran.uwm307.iname        
    sicuw.uwm307.iyob   = sic_bran.uwm307.iyob         
    sicuw.uwm307.idob   = sic_bran.uwm307.idob         
    sicuw.uwm307.iocc   = sic_bran.uwm307.iocc         
    sicuw.uwm307.iocct  = sic_bran.uwm307.iocct        
    sicuw.uwm307.ioccs  = sic_bran.uwm307.ioccs        
    sicuw.uwm307.bname1 = sic_bran.uwm307.bname1       
    sicuw.uwm307.bname2 = sic_bran.uwm307.bname2       
    sicuw.uwm307.badd1  = sic_bran.uwm307.badd1        
    sicuw.uwm307.badd2  = sic_bran.uwm307.badd2        
    sicuw.uwm307.reship = sic_bran.uwm307.reship       
    sicuw.uwm307.endatt = sic_bran.uwm307.endatt.

  ASSIGN
    sicuw.uwm307.ldcd[1]   = sic_bran.uwm307.ldcd[1]
    sicuw.uwm307.ldcd[2]   = sic_bran.uwm307.ldcd[2]
    sicuw.uwm307.ldcd[3]   = sic_bran.uwm307.ldcd[3]
    sicuw.uwm307.ldae[1]   = sic_bran.uwm307.ldae[1]
    sicuw.uwm307.ldae[2]   = sic_bran.uwm307.ldae[2]
    sicuw.uwm307.ldae[3]   = sic_bran.uwm307.ldae[3]
    sicuw.uwm307.ldrate[1] = sic_bran.uwm307.ldrate[1]
    sicuw.uwm307.ldrate[2] = sic_bran.uwm307.ldrate[2]
    sicuw.uwm307.ldrate[3] = sic_bran.uwm307.ldrate[3]
    sicuw.uwm307.mb4wks = sic_bran.uwm307.mb4wks       
    sicuw.uwm307.mb5wks = sic_bran.uwm307.mb5wks       
    sicuw.uwm307.mb4ded = sic_bran.uwm307.mb4ded       
    sicuw.uwm307.mb5ded = sic_bran.uwm307.mb5ded
    sicuw.uwm307.mb6ded = sic_bran.uwm307.mb6ded.

  ASSIGN
    sicuw.uwm307.abcd[1]   = sic_bran.uwm307.abcd[1]
    sicuw.uwm307.abcd[2]   = sic_bran.uwm307.abcd[2]
    sicuw.uwm307.abcd[3]   = sic_bran.uwm307.abcd[3]
    sicuw.uwm307.abcd[4]   = sic_bran.uwm307.abcd[4]
    sicuw.uwm307.abrtae[1] = sic_bran.uwm307.abrtae[1]
    sicuw.uwm307.abrtae[2] = sic_bran.uwm307.abrtae[2]
    sicuw.uwm307.abrtae[3] = sic_bran.uwm307.abrtae[3]
    sicuw.uwm307.abrtae[4] = sic_bran.uwm307.abrtae[4]
    sicuw.uwm307.abrt[1]   = sic_bran.uwm307.abrt[1]
    sicuw.uwm307.abrt[2]   = sic_bran.uwm307.abrt[2]
    sicuw.uwm307.abrt[3]   = sic_bran.uwm307.abrt[3]
    sicuw.uwm307.abrt[4]   = sic_bran.uwm307.abrt[4]
    sicuw.uwm307.abapae[1] = sic_bran.uwm307.abapae[1]
    sicuw.uwm307.abapae[2] = sic_bran.uwm307.abapae[2]
    sicuw.uwm307.abapae[3] = sic_bran.uwm307.abapae[3]
    sicuw.uwm307.abapae[4] = sic_bran.uwm307.abapae[4]
    sicuw.uwm307.abap[1]   = sic_bran.uwm307.abap[1]
    sicuw.uwm307.abap[2]   = sic_bran.uwm307.abap[2]
    sicuw.uwm307.abap[3]   = sic_bran.uwm307.abap[3]
    sicuw.uwm307.abap[4]   = sic_bran.uwm307.abap[4]
    sicuw.uwm307.abpdae[1] = sic_bran.uwm307.abpdae[1]
    sicuw.uwm307.abpdae[2] = sic_bran.uwm307.abpdae[2]
    sicuw.uwm307.abpdae[3] = sic_bran.uwm307.abpdae[3]
    sicuw.uwm307.abpdae[4] = sic_bran.uwm307.abpdae[4]
    sicuw.uwm307.abpd[1]   = sic_bran.uwm307.abpd[1]
    sicuw.uwm307.abpd[2]   = sic_bran.uwm307.abpd[2]
    sicuw.uwm307.abpd[3]   = sic_bran.uwm307.abpd[3]
    sicuw.uwm307.abpd[4]   = sic_bran.uwm307.abpd[4].

    sicuw.uwm307.tariff = sic_bran.uwm307.tariff     .
    sicuw.uwm307.icno   = sic_bran.uwm307.icno       .
    sicuw.uwm307.bname3 = sic_bran.uwm307.bname3     .
    sicuw.uwm307.mbsi[1] = sic_bran.uwm307.mbsi[1]   .
    sicuw.uwm307.mbsi[2] = sic_bran.uwm307.mbsi[2]   .
    sicuw.uwm307.mbsi[3] = sic_bran.uwm307.mbsi[3]   .
    sicuw.uwm307.mbsi[4] = sic_bran.uwm307.mbsi[4]   .
    sicuw.uwm307.mbsi[5] = sic_bran.uwm307.mbsi[5]   .
    sicuw.uwm307.mbsi[6] = sic_bran.uwm307.mbsi[6]   .
    /* ----------------
    sicuw.uwm307.mbsi[7] = sic_bran.uwm307.mbsi[7]   .
    sicuw.uwm307.mbsi[8] = sic_bran.uwm307.mbsi[8]   .
    sicuw.uwm307.mbsi[9] = sic_bran.uwm307.mbsi[9]   .
    sicuw.uwm307.mbsi[10] = sic_bran.uwm307.mbsi[10] .
    sicuw.uwm307.mbsi[11] = sic_bran.uwm307.mbsi[11] .
    sicuw.uwm307.mbsi[12] = sic_bran.uwm307.mbsi[12] .
    ----------------- */
    sicuw.uwm307.mbr_ae[1] = sic_bran.uwm307.mbr_ae[1].
    sicuw.uwm307.mbr_ae[2] = sic_bran.uwm307.mbr_ae[2].
    sicuw.uwm307.mbr_ae[3] = sic_bran.uwm307.mbr_ae[3].
    sicuw.uwm307.mbr_ae[4] = sic_bran.uwm307.mbr_ae[4].
    sicuw.uwm307.mbr_ae[5] = sic_bran.uwm307.mbr_ae[5].
    sicuw.uwm307.mbr_ae[6] = sic_bran.uwm307.mbr_ae[6].
    /* -----------------
    sicuw.uwm307.mbr_ae[7] = sic_bran.uwm307.mbr_ae[7].
    sicuw.uwm307.mbr_ae[8] = sic_bran.uwm307.mbr_ae[8].
    sicuw.uwm307.mbr_ae[9] = sic_bran.uwm307.mbr_ae[9].
    sicuw.uwm307.mbr_ae[10] = sic_bran.uwm307.mbr_ae[10].
    sicuw.uwm307.mbr_ae[11] = sic_bran.uwm307.mbr_ae[11].
    sicuw.uwm307.mbr_ae[12] = sic_bran.uwm307.mbr_ae[12].
    ----------------- */
    sicuw.uwm307.mbrate[1] = sic_bran.uwm307.mbrate[1]   .
    sicuw.uwm307.mbrate[2] = sic_bran.uwm307.mbrate[2]   .
    sicuw.uwm307.mbrate[3] = sic_bran.uwm307.mbrate[3]   .
    sicuw.uwm307.mbrate[4] = sic_bran.uwm307.mbrate[4]   .
    sicuw.uwm307.mbrate[5] = sic_bran.uwm307.mbrate[5]   .
    sicuw.uwm307.mbrate[6] = sic_bran.uwm307.mbrate[6]   .
    /* ------------------
    sicuw.uwm307.mbrate[7] = sic_bran.uwm307.mbrate[7]   .
    sicuw.uwm307.mbrate[8] = sic_bran.uwm307.mbrate[8]   .
    sicuw.uwm307.mbrate[9] = sic_bran.uwm307.mbrate[9]   .
    sicuw.uwm307.mbrate[10] = sic_bran.uwm307.mbrate[10] .
    sicuw.uwm307.mbrate[11] = sic_bran.uwm307.mbrate[11] .
    sicuw.uwm307.mbrate[12] = sic_bran.uwm307.mbrate[12] .
    ----------------- */
    sicuw.uwm307.mbapae[1] = sic_bran.uwm307.mbapae[1]   .
    sicuw.uwm307.mbapae[2] = sic_bran.uwm307.mbapae[2]   .
    sicuw.uwm307.mbapae[3] = sic_bran.uwm307.mbapae[3]   .
    sicuw.uwm307.mbapae[4] = sic_bran.uwm307.mbapae[4]   .
    sicuw.uwm307.mbapae[5] = sic_bran.uwm307.mbapae[5]   .
    sicuw.uwm307.mbapae[6] = sic_bran.uwm307.mbapae[6]   .
    /* -----------------
    sicuw.uwm307.mbapae[7] = sic_bran.uwm307.mbapae[7]   .
    sicuw.uwm307.mbapae[8] = sic_bran.uwm307.mbapae[8]   .
    sicuw.uwm307.mbapae[9] = sic_bran.uwm307.mbapae[9]   .
    sicuw.uwm307.mbapae[10] = sic_bran.uwm307.mbapae[10] .
    sicuw.uwm307.mbapae[11] = sic_bran.uwm307.mbapae[11] .
    sicuw.uwm307.mbapae[12] = sic_bran.uwm307.mbapae[12].
    ------------------ */
    sicuw.uwm307.mbap[1]   = sic_bran.uwm307.mbap[1]  .
    sicuw.uwm307.mbap[2]   = sic_bran.uwm307.mbap[2]  .
    sicuw.uwm307.mbap[3]   = sic_bran.uwm307.mbap[3]   .
    sicuw.uwm307.mbap[4]   = sic_bran.uwm307.mbap[4]   .
    sicuw.uwm307.mbap[5]   = sic_bran.uwm307.mbap[5]    .
    sicuw.uwm307.mbap[6]   = sic_bran.uwm307.mbap[6]    .
    /* -----------------
    sicuw.uwm307.mbap[7]   = sic_bran.uwm307.mbap[7]    .
    sicuw.uwm307.mbap[8]   = sic_bran.uwm307.mbap[8]    .
    sicuw.uwm307.mbap[9]   = sic_bran.uwm307.mbap[9]    .
    sicuw.uwm307.mbap[10]   = sic_bran.uwm307.mbap[10]  .
    sicuw.uwm307.mbap[11]   = sic_bran.uwm307.mbap[11]  .
    sicuw.uwm307.mbap[12]   = sic_bran.uwm307.mbap[12]  .
    ------------------ */
    sicuw.uwm307.mbpdae[1] = sic_bran.uwm307.mbpdae[1]  .
    sicuw.uwm307.mbpdae[2] = sic_bran.uwm307.mbpdae[2]  .
    sicuw.uwm307.mbpdae[3] = sic_bran.uwm307.mbpdae[3]  .
    sicuw.uwm307.mbpdae[4] = sic_bran.uwm307.mbpdae[4]  .
    sicuw.uwm307.mbpdae[5] = sic_bran.uwm307.mbpdae[5]  .
    sicuw.uwm307.mbpdae[6] = sic_bran.uwm307.mbpdae[6]  .
    /* -----------------
    sicuw.uwm307.mbpdae[7] = sic_bran.uwm307.mbpdae[7]  .
    sicuw.uwm307.mbpdae[8] = sic_bran.uwm307.mbpdae[8]  .
    sicuw.uwm307.mbpdae[9] = sic_bran.uwm307.mbpdae[9]  .
    sicuw.uwm307.mbpdae[10] = sic_bran.uwm307.mbpdae[10].
    sicuw.uwm307.mbpdae[11] = sic_bran.uwm307.mbpdae[11].
    sicuw.uwm307.mbpdae[12] = sic_bran.uwm307.mbpdae[12].
    ----------------- */
       
  ASSIGN
    sicuw.uwm307.mbpd[1] = sic_bran.uwm307.mbpd[1]
    sicuw.uwm307.mbpd[2] = sic_bran.uwm307.mbpd[2]
    sicuw.uwm307.mbpd[3] = sic_bran.uwm307.mbpd[3]
    sicuw.uwm307.mbpd[4] = sic_bran.uwm307.mbpd[4]
    sicuw.uwm307.mbpd[5] = sic_bran.uwm307.mbpd[5]
    sicuw.uwm307.mbpd[6] = sic_bran.uwm307.mbpd[6]
    /* ----------------
    sicuw.uwm307.mbpd[7] = sic_bran.uwm307.mbpd[7]
    sicuw.uwm307.mbpd[8] = sic_bran.uwm307.mbpd[8]
    sicuw.uwm307.mbpd[9] = sic_bran.uwm307.mbpd[9]
    sicuw.uwm307.mbpd[10] = sic_bran.uwm307.mbpd[10]
    sicuw.uwm307.mbpd[11] = sic_bran.uwm307.mbpd[11]
    sicuw.uwm307.mbpd[12] = sic_bran.uwm307.mbpd[12]
    ----------------- */
    sicuw.uwm307.mb1day = sic_bran.uwm307.mb1day       
    sicuw.uwm307.mb6day = sic_bran.uwm307.mb6day       
    sicuw.uwm307.mb7day = sic_bran.uwm307.mb7day       
    sicuw.uwm307.mb8day = sic_bran.uwm307.mb8day.
  /*---Begin by Chaiyong W. A64-0228 28/05/2021*/
  ASSIGN
      sicuw.uwm307.iday        = sic_bran.uwm307.iday     
      sicuw.uwm307.iprd_fr     = sic_bran.uwm307.iprd_fr  
      sicuw.uwm307.iprd_to     = sic_bran.uwm307.iprd_to  
      sicuw.uwm307.i_jrny      = sic_bran.uwm307.i_jrny   
      sicuw.uwm307.isex        = sic_bran.uwm307.isex     
      sicuw.uwm307.passport    = sic_bran.uwm307.passport 
      sicuw.uwm307.codeocc     = sic_bran.uwm307.codeocc  
      sicuw.uwm307.chr1        = sic_bran.uwm307.chr1     
      sicuw.uwm307.chr2        = sic_bran.uwm307.chr2     
      sicuw.uwm307.chr3        = sic_bran.uwm307.chr3     
      sicuw.uwm307.chr4        = sic_bran.uwm307.chr4     
      sicuw.uwm307.chr5        = sic_bran.uwm307.chr5     
      sicuw.uwm307.date1       = sic_bran.uwm307.date1    
      sicuw.uwm307.date2       = sic_bran.uwm307.date2    
      sicuw.uwm307.dec1        = sic_bran.uwm307.dec1     
      sicuw.uwm307.dec2        = sic_bran.uwm307.dec2     
      sicuw.uwm307.int1        = sic_bran.uwm307.int1     
      sicuw.uwm307.int2        = sic_bran.uwm307.int2     
      sicuw.uwm307.titleid     = sic_bran.uwm307.titleid  
      sicuw.uwm307.firstname   = sic_bran.uwm307.firstname
      sicuw.uwm307.lastname    = sic_bran.uwm307.lastname 
      sicuw.uwm307.ititle      = sic_bran.uwm307.ititle       
      sicuw.uwm307.ipassport   = sic_bran.uwm307.ipassport    
      sicuw.uwm307.icodeocc    = sic_bran.uwm307.icodeocc     
      sicuw.uwm307.iaddr1      = sic_bran.uwm307.iaddr1       
      sicuw.uwm307.iaddr2      = sic_bran.uwm307.iaddr2       
      sicuw.uwm307.icodeaddr1  = sic_bran.uwm307.icodeaddr1   
      sicuw.uwm307.icodeaddr2  = sic_bran.uwm307.icodeaddr2
      /*---Begin Songkarn A65-0141 28/11/2022*/
      sicuw.uwm307.icodeaddr3  = sic_bran.uwm307.icodeaddr3      
      sicuw.uwm307.iheight     = sic_bran.uwm307.iheight         
      sicuw.uwm307.iweight     = sic_bran.uwm307.iweight         
      sicuw.uwm307.iaddr3      = sic_bran.uwm307.iaddr3          
      sicuw.uwm307.iaddr4      = sic_bran.uwm307.iaddr4          
      sicuw.uwm307.ipostcd     = sic_bran.uwm307.ipostcd         
      sicuw.uwm307.imob1       = sic_bran.uwm307.imob1           
      sicuw.uwm307.imob2       = sic_bran.uwm307.imob2           
      sicuw.uwm307.iphone1     = sic_bran.uwm307.iphone1         
      sicuw.uwm307.iphone2     = sic_bran.uwm307.iphone2         
      sicuw.uwm307.iemail1     = sic_bran.uwm307.iemail1         
      sicuw.uwm307.iemail2     = sic_bran.uwm307.iemail2         
      sicuw.uwm307.iacnotyp    = sic_bran.uwm307.iacnotyp        
      sicuw.uwm307.iempid      = sic_bran.uwm307.iempid          
      sicuw.uwm307.iplan       = sic_bran.uwm307.iplan   
      /*--- Add By Tontawan S. A65-0141 26/07/2023 ---*/
      //sicuw.uwm307.itconsent   = sic_bran.uwm307.itconsent -- Awaiting update
      sicuw.uwm307.itdamt      = sic_bran.uwm307.itdamt    
      sicuw.uwm307.ipdpacon1   = sic_bran.uwm307.ipdpacon1 
      sicuw.uwm307.ipdpacon2   = sic_bran.uwm307.ipdpacon2 
      sicuw.uwm307.icondat     = sic_bran.uwm307.icondat   
      sicuw.uwm307.irace       = sic_bran.uwm307.irace     
      sicuw.uwm307.ircod       = sic_bran.uwm307.ircod     
      sicuw.uwm307.imicrochip  = sic_bran.uwm307.imicrochip
      sicuw.uwm307.icerrace    = sic_bran.uwm307.icerrace  
      sicuw.uwm307.ipurpose    = sic_bran.uwm307.ipurpose  
      sicuw.uwm307.inote1      = sic_bran.uwm307.inote1    
      sicuw.uwm307.inote2      = sic_bran.uwm307.inote2    
      sicuw.uwm307.itypdes     = sic_bran.uwm307.itypdes   
      sicuw.uwm307.imonth      = sic_bran.uwm307.imonth    
      sicuw.uwm307.ireship     = sic_bran.uwm307.ireship   
      /*--- End By Tontawan S. A65-0141 26/07/2023 ---*/
      sicuw.uwm307.icno1       = sic_bran.uwm307.icno1  
      
      /*--- End A65-0141 28/11/2022-----*/
      sicuw.uwm307.iterdat     = sic_bran.uwm307.iterdat  /*---add by Chaiyong W. A66-0228 06/10/2023*/
      sicuw.uwm307.print_att   = sic_bran.uwm307.print_att  /*---add by Chaiyong W. A66-0228 06/10/2023*/

      nv_tbenna                = "".  
  /*---Begin by Chaiyong W. A66-0221 20/10/2023*/
  IF sicuw.uwm307.icodeocc  = "" THEN DO:
      IF sicuw.uwm307.iocc <> "" AND LENGTH(TRIM(sicuw.uwm307.iocc)) > 1 THEN DO:
         FIND FIRST stat.occupdet USE-INDEX occupdet01 WHERE
                    stat.occupdet.desocce = sicuw.uwm307.iocc NO-LOCK NO-ERROR NO-WAIT.
         IF AVAILABLE stat.occupdet THEN DO:
             sicuw.uwm307.icodeocc = stat.occupdet.codeocc.
         END.
         ELSE DO:
             FIND FIRST stat.occupdet USE-INDEX occupdet01 WHERE
                        stat.occupdet.desocct = sicuw.uwm307.iocc NO-LOCK NO-ERROR NO-WAIT.
             IF AVAILABLE occupdet THEN DO:
                 sicuw.uwm307.icodeocc = stat.occupdet.codeocc.
             END.
         END.
         IF TRIM(sicuw.uwm307.icodeocc) = "" THEN sicuw.uwm307.icodeocc = "9999".

      END.
      ELSE DO:
          ASSIGN
              sicuw.uwm307.icodeocc = "9999"
              sicuw.uwm307.iocc     = "-".
      END.

  END.
  /*End by Chaiyong W. A66-0221 20/10/2023-----*/


  IF sicuw.uwm307.i_jrny = "" AND nv_jou <> "" THEN DO: 
      sicuw.uwm307.i_jrny = nv_jou.
      if sicuw.uwm307.iprd_fr = ? AND sicuw.uwm307.iprd_to = ? then DO:
          FIND sicuw.uwm100 WHERE sicuw.uwm100.policy = sicuw.uwm307.policy AND
              sicuw.uwm100.rencnt = sicuw.uwm307.rencnt AND
              sicuw.uwm100.endcnt = sicuw.uwm307.endcnt NO-LOCK NO-ERROR.
          IF AVAIL sicuw.uwm100 THEN DO:
              ASSIGN
                  nv_day                 = 0
                  nv_devide              = 0
                  sicuw.uwm307.iprd_fr   = sicuw.uwm100.comdat
                  sicuw.uwm307.iprd_to   = sicuw.uwm100.expdat.
               RUN WUW\WUWDATE1(INPUT sicuw.uwm100.poltyp,
                                      sicuw.uwm307.iprd_fr,
                                      sicuw.uwm307.iprd_to,
                                INPUT-OUTPUT nv_day,
                                INPUT-OUTPUT nv_devide).
               IF nv_day <> 0 AND sicuw.uwm307.iday = "" THEN sicuw.uwm307.iday = STRING(nv_day).
          END.
      END.


  END.

  FOR EACH sic_bran.uwmbenn USE-INDEX uwmbenn01 WHERE sic_bran.uwmbenn.policy = sic_bran.uwm307.policy AND
                                                      sic_bran.uwmbenn.rencnt = sic_bran.uwm307.rencnt AND
                                                      sic_bran.uwmbenn.endcnt = sic_bran.uwm307.endcnt AND
                                                      sic_bran.uwmbenn.riskgp = sic_bran.uwm307.riskgp AND
                                                      sic_bran.uwmbenn.riskno = sic_bran.uwm307.riskno AND
                                                      sic_bran.uwmbenn.itemno = sic_bran.uwm307.itemno NO-LOCK BY sic_bran.uwmbenn.lnumber:

      nv_tbenna = "Trn".

      FIND FIRST sicuw.uwmbenn USE-INDEX uwmbenn01 WHERE
            sicuw.uwmbenn.policy      = sic_bran.uwmbenn.policy   and
            sicuw.uwmbenn.rencnt      = sic_bran.uwmbenn.rencnt   and
            sicuw.uwmbenn.endcnt      = sic_bran.uwmbenn.endcnt   and
            sicuw.uwmbenn.riskgp      = sic_bran.uwmbenn.riskgp   and
            sicuw.uwmbenn.riskno      = sic_bran.uwmbenn.riskno   and
            sicuw.uwmbenn.itemno      = sic_bran.uwmbenn.itemno   and
            sicuw.uwmbenn.lnumber     = sic_bran.uwmbenn.lnumber  NO-ERROR NO-WAIT.
      IF NOT AVAIL sicuw.uwmbenn THEN CREATE sicuw.uwmbenn.           
        ASSIGN                    
            sicuw.uwmbenn.policy      = sic_bran.uwmbenn.policy
            sicuw.uwmbenn.rencnt      = sic_bran.uwmbenn.rencnt
            sicuw.uwmbenn.endcnt      = sic_bran.uwmbenn.endcnt
            sicuw.uwmbenn.riskgp      = sic_bran.uwmbenn.riskgp
            sicuw.uwmbenn.riskno      = sic_bran.uwmbenn.riskno
            sicuw.uwmbenn.itemno      = sic_bran.uwmbenn.itemno
            sicuw.uwmbenn.lnumber     = sic_bran.uwmbenn.lnumber  
            sicuw.uwmbenn.ntitle      = sic_bran.uwmbenn.ntitle   
            sicuw.uwmbenn.firstname   = sic_bran.uwmbenn.firstname
            sicuw.uwmbenn.lastname    = sic_bran.uwmbenn.lastname 
            sicuw.uwmbenn.addr1       = sic_bran.uwmbenn.addr1    
            sicuw.uwmbenn.addr2       = sic_bran.uwmbenn.addr2    
            sicuw.uwmbenn.addr3       = sic_bran.uwmbenn.addr3    
            sicuw.uwmbenn.addr4       = sic_bran.uwmbenn.addr4    
            sicuw.uwmbenn.codeaddr1   = sic_bran.uwmbenn.codeaddr1
            sicuw.uwmbenn.codeaddr2   = sic_bran.uwmbenn.codeaddr2
            sicuw.uwmbenn.codeaddr3   = sic_bran.uwmbenn.codeaddr3
            sicuw.uwmbenn.postcode    = sic_bran.uwmbenn.postcode 
            sicuw.uwmbenn.Tel1        = sic_bran.uwmbenn.Tel1     
            sicuw.uwmbenn.Tel2        = sic_bran.uwmbenn.Tel2     
            sicuw.uwmbenn.lineid      = sic_bran.uwmbenn.lineid   
            sicuw.uwmbenn.passport    = sic_bran.uwmbenn.passport 
            sicuw.uwmbenn.shareper    = sic_bran.uwmbenn.shareper 
            sicuw.uwmbenn.sex         = sic_bran.uwmbenn.sex      
            sicuw.uwmbenn.icno        = sic_bran.uwmbenn.icno     
            sicuw.uwmbenn.reship      = sic_bran.uwmbenn.reship   
            sicuw.uwmbenn.coderef     = sic_bran.uwmbenn.coderef .
  END.
  IF nv_tbenna = "" THEN DO:
      nv_Cst5   = 0.
      FOR EACH ttext WHERE ttext.tsta   = "Benficiary" AND 
                           ttext.riskno = sic_bran.uwm307.riskno AND
                           ttext.itemno = sic_bran.uwm307.itemno BY ttext.nline:
          ASSIGN
              nv_tbenna    = "Trn"
              nv_Cst5      = nv_Cst5 + 1
              ttext.tsta   = "Benficiarys".
          
          FIND FIRST  sicuw.uwmbenn USE-INDEX uwmbenn01 WHERE sicuw.uwmbenn.policy  = sic_bran.uwm307.policy  AND
                                                    sicuw.uwmbenn.rencnt  = sic_bran.uwm307.rencnt  AND
                                                    sicuw.uwmbenn.endcnt  = sic_bran.uwm307.endcnt  AND
                                                    sicuw.uwmbenn.riskgp  = sic_bran.uwm307.riskgp  AND
                                                    sicuw.uwmbenn.riskno  = sic_bran.uwm307.riskno  AND
                                                    sicuw.uwmbenn.itemno  = sic_bran.uwm307.itemno  AND
                                                    sicuw.uwmbenn.lnumber = nv_Cst5                 NO-ERROR NO-WAIT.
          IF NOT AVAIL sicuw.uwmbenn THEN CREATE sicuw.uwmbenn.
          ASSIGN
              sicuw.uwmbenn.policy     = sic_bran.uwm307.policy
              sicuw.uwmbenn.rencnt     = sic_bran.uwm307.rencnt
              sicuw.uwmbenn.endcnt     = sic_bran.uwm307.endcnt
              sicuw.uwmbenn.riskgp     = sic_bran.uwm307.riskgp
              sicuw.uwmbenn.riskno     = sic_bran.uwm307.riskno
              sicuw.uwmbenn.itemno     = sic_bran.uwm307.itemno
              sicuw.uwmbenn.lnumber    = nv_Cst5   
              sicuw.uwmbenn.firstname  = ttext.ttext    
              sicuw.uwmbenn.reship     = ttext.treship.
          IF nv_Cst5 = 1 THEN DO:
              ASSIGN
                  sicuw.uwmbenn.addr1      = sic_bran.uwm307.badd1 
                  sicuw.uwmbenn.addr2      = sic_bran.uwm307.badd2 .
          END.
      END.
      /*69*/
  END.
  IF nv_tbenna = "" THEN DO:
      FOR EACH ttext :
          DELETE ttext .
      END.
      RELEASE ttext NO-ERROR.
      nv_count   = 0.
      IF sic_bran.uwm307.bname1 <> "" THEN DO:
          IF INDEX(sic_bran.uwm307.bname1,",") <> 0 THEN DO:
              RUN pd_ben(INPUT sic_Bran.uwm307.bname1).
          END.
          ELSE DO:
              CREATE ttext.
              ASSIGN
                  nv_count      = nv_count + 1
                  ttext.lnumber = nv_count
                  ttext.tname   = trim(sic_bran.uwm307.bname1).
          END.
      END.
      IF sic_bran.uwm307.bname2 <> "" THEN DO:
          IF INDEX(sic_bran.uwm307.bname2,",") <> 0 THEN DO:
              RUN pd_ben(INPUT sic_bran.uwm307.bname2).
          END.
          ELSE DO:
              CREATE ttext.
              ASSIGN
                  nv_count      = nv_count + 1
                  ttext.lnumber = nv_count
                  ttext.tname   = trim(sic_bran.uwm307.bname2).
          END.
      END.
      IF index(sic_bran.uwm307.reship,",") <> 0 AND nv_count > 1 THEN DO:
          RUN pd_reship.
      END.
      ELSE DO:
          FIND FIRST ttext NO-ERROR NO-WAIT.
          IF AVAIL ttext THEN ttext.treship = sic_bran.uwm307.reship.
          
      END.
      FOR EACH ttext BY ttext.lnumber:
          FIND FIRST  sicuw.uwmbenn USE-INDEX uwmbenn01 WHERE sicuw.uwmbenn.policy  = sic_bran.uwm307.policy  AND
                                                    sicuw.uwmbenn.rencnt  = sic_bran.uwm307.rencnt  AND
                                                    sicuw.uwmbenn.endcnt  = sic_bran.uwm307.endcnt  AND
                                                    sicuw.uwmbenn.riskgp  = sic_bran.uwm307.riskgp  AND
                                                    sicuw.uwmbenn.riskno  = sic_bran.uwm307.riskno  AND
                                                    sicuw.uwmbenn.itemno  = sic_bran.uwm307.itemno  AND
                                                    sicuw.uwmbenn.lnumber = ttext.lnumber           NO-ERROR NO-WAIT.
          IF NOT AVAIL sicuw.uwmbenn THEN CREATE sicuw.uwmbenn.
          ASSIGN
              sicuw.uwmbenn.policy     = sic_bran.uwm307.policy
              sicuw.uwmbenn.rencnt     = sic_bran.uwm307.rencnt
              sicuw.uwmbenn.endcnt     = sic_bran.uwm307.endcnt
              sicuw.uwmbenn.riskgp     = sic_bran.uwm307.riskgp
              sicuw.uwmbenn.riskno     = sic_bran.uwm307.riskno
              sicuw.uwmbenn.itemno     = sic_bran.uwm307.itemno
              sicuw.uwmbenn.lnumber    = ttext.lnumber 
              sicuw.uwmbenn.firstname  = ttext.tname    
              sicuw.uwmbenn.reship     = ttext.treship.
          IF ttext.lnumber = 1 THEN DO:
              ASSIGN
                  sicuw.uwmbenn.addr1      = sic_bran.uwm307.badd1 
                  sicuw.uwmbenn.addr2      = sic_bran.uwm307.badd2 .
          END.

      
      END.
  END.
  
  /*End by Chaiyong W. A64-0228 28/05/2021-----*/
END.
RELEASE sicuw.uwmbenn NO-ERROR. /*--add by Chaiyong W. A64-0228 18/05/2021*/
RELEASE sicuw.uwm307  NO-ERROR. /*--add by Chaiyong W. A64-0228 18/05/2021*/

HIDE MESSAGE NO-PAUSE.
