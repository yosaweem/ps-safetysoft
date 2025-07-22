/*************************************************************************
 WGWDigit.p : Check key Digit date time systems
            : ยังไม่เป็นระบบ ต้องหาวิธีครั้งต่อไป
 Copyright  : Safety Insurance Public Company Limited
                                                 บริษัท ประกันคุ้มภัย จำกัด (มหาชน)
 duplicate  : D:\WebWSKFK\WRS\WRSDigit.p                                                  
 CREATE BY  : Kridtiya i. A58-0356  Date: 02/11/2015  
 Database   : -
*************************************************************************/

DEFINE output parameter nv_octets AS CHARACTER NO-UNDO.

/* ---
DEFINE VARIABLE nv_octets    AS CHARACTER NO-UNDO.
--- */
/*
DEFINE VARIABLE hour       AS INTEGER NO-UNDO.
DEFINE VARIABLE minute     AS INTEGER NO-UNDO.
DEFINE VARIABLE sec        AS INTEGER NO-UNDO.
DEFINE VARIABLE timeleft   AS INTEGER NO-UNDO.
*/
/* */
DEFINE VARIABLE nv_cTime   AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_c1      AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_c2      AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_c3      AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_c4      AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_c5      AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_c6      AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_c7      AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_c8      AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_c9      AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_c10     AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_c11     AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_c12     AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_c13     AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_c14     AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_c15     AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_c16     AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_cCHAR   AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_cCHAR2  AS CHARACTER NO-UNDO.
/* */
/*

DEFINE VARIABLE nv_Low       AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Mid       AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hi        AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_ClockLow  AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_ClockHi   AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_node      AS CHARACTER NO-UNDO.
*/

DEFINE VARIABLE nv_Hdigit1   AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit2   AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit3   AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit4   AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit5   AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit6   AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit7   AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit8   AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit9   AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit10  AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit11  AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit12  AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit13  AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit14  AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit15  AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit16  AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit17  AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit18  AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit19  AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit20  AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit21  AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit22  AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit23  AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit24  AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit25  AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit26  AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit27  AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit28  AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit29  AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit30  AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit31  AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Hdigit32  AS CHARACTER NO-UNDO.
/* */
DEFINE VARIABLE nv_Idigit1   AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit2   AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit3   AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit4   AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit5   AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit6   AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit7   AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit8   AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit9   AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit10  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit11  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit12  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit13  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit14  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit15  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit16  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit17  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit18  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit19  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit20  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit21  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit22  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit23  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit24  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit25  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit26  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit27  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit28  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit29  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit30  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit31  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Idigit32  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_timedeci AS INTEGER NO-UNDO.

DEFINE VARIABLE nv_Int1   AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Int2   AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Int3   AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Int4   AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Int5   AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Int6   AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Int7   AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Int8   AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Int9   AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Int10  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Int11  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Int12  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Int13  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Int14  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Int15  AS INTEGER NO-UNDO.
DEFINE VARIABLE nv_Int16  AS INTEGER NO-UNDO.

DEFINE VARIABLE nv_Inprm    AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_Outprm   AS CHARACTER NO-UNDO.

DEFINE VARIABLE nv_loop     AS INTEGER NO-UNDO.
/* */

/* ใช้หลักการแรก ร่วมกับ  MTIME*/

nv_cTime = STRING( (TODAY - 10/15/1582) * (60 * 60 * 24) * (1000 * 100) + MTIME ).
/* */


nv_Inprm  = STRING( (INTEGER(SUBSTR(nv_cTime,1,1))  * 4 * 64 * 1) + MTIME ).

RUN PD_ReturnC (input nv_InPrm, output nv_Outprm).
nv_c1    = nv_Outprm + "000000".
/**/
nv_Inprm  = STRING( (INTEGER(SUBSTR(nv_cTime,2,1))  * 4 * 64 * 2) + MTIME ).

RUN PD_ReturnC (input nv_InPrm, output nv_Outprm).
nv_c2    = nv_Outprm + "000000".
/**/
nv_Inprm  = STRING( (INTEGER(SUBSTR(nv_cTime,3,1))  * 4 * 64 * 3) + MTIME ).

RUN PD_ReturnC (input nv_InPrm, output nv_Outprm).
nv_c3    = nv_Outprm + "000000".
/**/
/*
RUN PD_loop(133). */

nv_Inprm  = STRING( (INTEGER(SUBSTR(nv_cTime,4,1))  * 4 * 64 * 4) + MTIME ).

RUN PD_ReturnC (input nv_InPrm, output nv_Outprm).
nv_c4    = nv_Outprm + "000000".
/**/
nv_Inprm  = STRING( (INTEGER(SUBSTR(nv_cTime,5,1))  * 4 * 64 * 5) + MTIME ).

RUN PD_ReturnC (input nv_InPrm, output nv_Outprm).
nv_c5    = nv_Outprm + "000000".
/**/
/*
RUN PD_loop(333). */
nv_Inprm  = STRING( (INTEGER(SUBSTR(nv_cTime,6,1))  * 4 * 64 * 6) + MTIME ).

RUN PD_ReturnC (input nv_InPrm, output nv_Outprm).
nv_c6    = nv_Outprm + "000000".
/**/
/*
RUN PD_loop(11). */
nv_Inprm  = STRING( (INTEGER(SUBSTR(nv_cTime,7,1))  * 4 * 64 * 7) + MTIME ).

RUN PD_ReturnC (input nv_InPrm, output nv_Outprm).
nv_c7    = nv_Outprm + "000000".
/**/
/*
RUN PD_loop(1087). */
nv_Inprm  = STRING( (INTEGER(SUBSTR(nv_cTime,8,1))  * 4 * 64 * 8) + MTIME ).

RUN PD_ReturnC (input nv_InPrm, output nv_Outprm).
nv_c8    = nv_Outprm + "000000".
/**/
/*
RUN PD_loop(77). */

nv_Inprm  = STRING( (INTEGER(SUBSTR(nv_cTime,9,1))  * 4 * 64 * 9) + MTIME ).

RUN PD_ReturnC (input nv_InPrm, output nv_Outprm).
nv_c9    = nv_Outprm + "000000".
/**/
/*
RUN PD_loop(33). */
nv_Inprm  = STRING( (INTEGER(SUBSTR(nv_cTime,10,1))  * 4 * 64 * 10) + MTIME ).

RUN PD_ReturnC (input nv_InPrm, output nv_Outprm).
nv_c10    = nv_Outprm + "000000".
/**/
/*
RUN PD_loop(111). */
nv_Inprm  = STRING( (INTEGER(SUBSTR(nv_cTime,11,1))  * 4 * 64 * 11) + MTIME ).

RUN PD_ReturnC (input nv_InPrm, output nv_Outprm).
nv_c11    = nv_Outprm + "000000".
/**/
/*
RUN PD_loop(177). */
nv_Inprm  = STRING( (INTEGER(SUBSTR(nv_cTime,12,1))  * 4 * 64 * 12) + MTIME ).

RUN PD_ReturnC (input nv_InPrm, output nv_Outprm).
nv_c12    = nv_Outprm + "000000".
/**/
nv_Inprm  = STRING( (INTEGER(SUBSTR(nv_cTime,13,1))  * 4 * 64 * 13) + MTIME ).

RUN PD_ReturnC (input nv_InPrm, output nv_Outprm).
nv_c13    = nv_Outprm + "000000".
/**/
nv_Inprm  = STRING( (INTEGER(SUBSTR(nv_cTime,14,1))  * 4 * 64 * 14) + MTIME ).

RUN PD_ReturnC (input nv_InPrm, output nv_Outprm).
nv_c14    = nv_Outprm + "000000".
/**/
nv_Inprm  = STRING( (INTEGER(SUBSTR(nv_cTime,15,1))  * 4 * 64 * 15) + MTIME ).

RUN PD_ReturnC (input nv_InPrm, output nv_Outprm).
nv_c15    = nv_Outprm + "000000".
/**/
nv_Inprm  = STRING( (INTEGER(SUBSTR(nv_cTime,16,1))  * 4 * 64 * 16) + MTIME ).

RUN PD_ReturnC (input nv_InPrm, output nv_Outprm).
nv_c16    = nv_Outprm + "000000".
/**/

/*---
DISPLAY
nv_c1  nv_c2  nv_c3  nv_c4  nv_c5  nv_c6  nv_c7 nv_c8 nv_c9 nv_c10
nv_c11 nv_c12 nv_c13 nv_c14 nv_c15 nv_c16 WITH FRAME AA 1 COLUMN.
pause.
--- */

/* ***************
nv_c1    = "000000" + STRING( INTEGER(SUBSTR(nv_cTime,1,1))  * 4 * 64 * 1).
nv_c2    = "000000" + STRING( INTEGER(SUBSTR(nv_cTime,2,1))  * 4 * 64 * 2).
nv_c3    = "000000" + STRING( INTEGER(SUBSTR(nv_cTime,3,1))  * 4 * 64 * 3).
nv_c4    = "000000" + STRING( INTEGER(SUBSTR(nv_cTime,4,1))  * 4 * 64 * 4).
nv_c5    = "000000" + STRING( INTEGER(SUBSTR(nv_cTime,5,1))  * 4 * 64 * 5).
nv_c6    = "000000" + STRING( INTEGER(SUBSTR(nv_cTime,6,1))  * 4 * 64 * 6).
nv_c7    = "000000" + STRING( INTEGER(SUBSTR(nv_cTime,7,1))  * 4 * 64 * 7).
nv_c8    = "000000" + STRING( INTEGER(SUBSTR(nv_cTime,8,1))  * 4 * 64 * 8).
nv_c9    = "000000" + STRING( INTEGER(SUBSTR(nv_cTime,9,1))  * 4 * 64 * 9).
nv_c10   = "000000" + STRING( INTEGER(SUBSTR(nv_cTime,10,1)) * 4 * 64 * 10).
nv_c11   = "000000" + STRING( INTEGER(SUBSTR(nv_cTime,11,1)) * 4 * 64 * 11).
nv_c12   = "000000" + STRING( INTEGER(SUBSTR(nv_cTime,12,1)) * 4 * 64 * 12).
nv_c13   = "000000" + STRING( INTEGER(SUBSTR(nv_cTime,13,1)) * 4 * 64 * 13).
nv_c14   = "000000" + STRING( INTEGER(SUBSTR(nv_cTime,14,1)) * 4 * 64 * 14).
nv_c15   = "000000" + STRING( INTEGER(SUBSTR(nv_cTime,15,1)) * 4 * 64 * 15).
nv_c16   = "000000" + STRING( INTEGER(SUBSTR(nv_cTime,16,1)) * 4 * 64 * 16).
/***/
nv_c1  = SUBSTR(nv_c1, LENGTH(nv_c1)  - 4, 5).
nv_c2  = SUBSTR(nv_c2, LENGTH(nv_c2)  - 4, 5).
nv_c3  = SUBSTR(nv_c3, LENGTH(nv_c3)  - 4, 5).
nv_c4  = SUBSTR(nv_c4, LENGTH(nv_c4)  - 4, 5).
nv_c5  = SUBSTR(nv_c5, LENGTH(nv_c5)  - 4, 5).
nv_c6  = SUBSTR(nv_c6, LENGTH(nv_c6)  - 4, 5).
nv_c7  = SUBSTR(nv_c7, LENGTH(nv_c7)  - 4, 5).
nv_c8  = SUBSTR(nv_c8, LENGTH(nv_c8)  - 4, 5).
nv_c9  = SUBSTR(nv_c9, LENGTH(nv_c9)  - 4, 5).
nv_c10 = SUBSTR(nv_c10,LENGTH(nv_c10) - 4, 5).
nv_c11 = SUBSTR(nv_c11,LENGTH(nv_c11) - 4, 5).
nv_c12 = SUBSTR(nv_c12,LENGTH(nv_c12) - 4, 5).
nv_c13 = SUBSTR(nv_c13,LENGTH(nv_c13) - 4, 5).
nv_c14 = SUBSTR(nv_c14,LENGTH(nv_c14) - 4, 5).
nv_c15 = SUBSTR(nv_c15,LENGTH(nv_c15) - 4, 5).
nv_c16 = SUBSTR(nv_c16,LENGTH(nv_c16) - 4, 5).
*************** */
/* */

nv_c1  = SUBSTR(nv_c1, 1, 5).
nv_c2  = SUBSTR(nv_c2, 1, 5).
nv_c3  = SUBSTR(nv_c3, 1, 5).
nv_c4  = SUBSTR(nv_c4, 1, 5).
nv_c5  = SUBSTR(nv_c5, 1, 5).
nv_c6  = SUBSTR(nv_c6, 1, 5).
nv_c7  = SUBSTR(nv_c7, 1, 5).
nv_c8  = SUBSTR(nv_c8, 1, 5).
nv_c9  = SUBSTR(nv_c9, 1, 5).
nv_c10 = SUBSTR(nv_c10,1, 5).
nv_c11 = SUBSTR(nv_c11,1, 5).
nv_c12 = SUBSTR(nv_c12,1, 5).
nv_c13 = SUBSTR(nv_c13,1, 5).
nv_c14 = SUBSTR(nv_c14,1, 5).
nv_c15 = SUBSTR(nv_c15,1, 5).
nv_c16 = SUBSTR(nv_c16,1, 5).
/* ---------------------------------------------------- */
/* --------
nv_cCHAR  = nv_c1  + nv_c2  + nv_c3  + nv_c4  + nv_c5  + nv_c6 + nv_c7 + nv_c8 + nv_c9 + nv_c10
          + nv_c11 + nv_c12 + nv_c13 + nv_c14 + nv_c15 + nv_c16 .
nv_cCHAR2 = "1234567890123456789012345678901234567890123456789012345678901234".
-------- */

/* ใช้เสี่ยว วินาที รวมกับอักษรชุดแรก แต่ละรายการ */

nv_timedeci = INTEGER(string(MTIME))- INTEGER(string(TIME) + "000").

/* Time Low */
nv_Idigit1  = (nv_timedeci +  INTEGER( SUBSTR(nv_c1,1,3) )) MODULO 16.
nv_Idigit2  = (nv_timedeci +  INTEGER( SUBSTR(nv_c1,4,2) )) MODULO 16.
nv_Idigit3  = (nv_timedeci +  INTEGER( SUBSTR(nv_c2,1,3) )) MODULO 16.
nv_Idigit4  = (nv_timedeci +  INTEGER( SUBSTR(nv_c2,4,2) )) MODULO 16.
nv_Idigit5  = (nv_timedeci +  INTEGER( SUBSTR(nv_c3,1,3) )) MODULO 16.
nv_Idigit6  = (nv_timedeci +  INTEGER( SUBSTR(nv_c3,4,2) )) MODULO 16.
nv_Idigit7  = (nv_timedeci +  INTEGER( SUBSTR(nv_c4,1,3) )) MODULO 16.
nv_Idigit8  = (nv_timedeci +  INTEGER( SUBSTR(nv_c4,4,2) )) MODULO 16.

/* Time Mid */
nv_Idigit9  = (nv_timedeci +  INTEGER( SUBSTR(nv_c5,1,3) )) MODULO 16.
nv_Idigit10 = (nv_timedeci +  INTEGER( SUBSTR(nv_c5,4,2) )) MODULO 16.
nv_Idigit11 = (nv_timedeci +  INTEGER( SUBSTR(nv_c6,1,3) )) MODULO 16.
nv_Idigit12 = (nv_timedeci +  INTEGER( SUBSTR(nv_c6,4,2) )) MODULO 16.

/* Time Hi*/
nv_Idigit13 = (nv_timedeci +  INTEGER( SUBSTR(nv_c7,1,3) )) MODULO 16.
nv_Idigit14 = (nv_timedeci +  INTEGER( SUBSTR(nv_c7,4,2) )) MODULO 16.
nv_Idigit15 = (nv_timedeci +  INTEGER( SUBSTR(nv_c8,1,3) )) MODULO 16.
nv_Idigit16 = (nv_timedeci +  INTEGER( SUBSTR(nv_c8,4,2) )) MODULO 16.

/* Check Seq Low */
nv_Idigit17 = (nv_timedeci +  INTEGER( SUBSTR(nv_c9,1,3) )) MODULO 16.
nv_Idigit18 = (nv_timedeci +  INTEGER( SUBSTR(nv_c9,4,2) )) MODULO 16.

/* Check seq hi and reserved */
nv_Idigit19 = (nv_timedeci +  INTEGER( SUBSTR(nv_c10,1,3) )) MODULO 16.
nv_Idigit20 = (nv_timedeci +  INTEGER( SUBSTR(nv_c10,4,2) )) MODULO 16.

/* Node */
nv_Idigit21 = (nv_timedeci +  INTEGER( SUBSTR(nv_c11,1,3) )) MODULO 16.
nv_Idigit22 = (nv_timedeci +  INTEGER( SUBSTR(nv_c11,4,2) )) MODULO 16.
nv_Idigit23 = (nv_timedeci +  INTEGER( SUBSTR(nv_c12,1,3) )) MODULO 16.
nv_Idigit24 = (nv_timedeci +  INTEGER( SUBSTR(nv_c12,4,2) )) MODULO 16.
nv_Idigit25 = (nv_timedeci +  INTEGER( SUBSTR(nv_c13,1,3) )) MODULO 16.
nv_Idigit26 = (nv_timedeci +  INTEGER( SUBSTR(nv_c13,4,2) )) MODULO 16.
nv_Idigit27 = (nv_timedeci +  INTEGER( SUBSTR(nv_c14,1,3) )) MODULO 16.
nv_Idigit28 = (nv_timedeci +  INTEGER( SUBSTR(nv_c14,4,2) )) MODULO 16.
nv_Idigit29 = (nv_timedeci +  INTEGER( SUBSTR(nv_c15,1,3) )) MODULO 16.
nv_Idigit30 = (nv_timedeci +  INTEGER( SUBSTR(nv_c15,4,2) )) MODULO 16.
nv_Idigit31 = (nv_timedeci +  INTEGER( SUBSTR(nv_c16,1,3) )) MODULO 16.
nv_Idigit32 = (nv_timedeci +  INTEGER( SUBSTR(nv_c16,4,2) )) MODULO 16.
/* ----------------------------------------------------------------- */

ASSIGN
  nv_Hdigit1    = ""  nv_Hdigit2    = ""  nv_Hdigit3    = ""  nv_Hdigit4    = ""
  nv_Hdigit5    = ""  nv_Hdigit6    = ""  nv_Hdigit7    = ""  nv_Hdigit8    = ""
  nv_Hdigit9    = ""  nv_Hdigit10   = ""
  nv_Hdigit11   = ""  nv_Hdigit12   = ""  nv_Hdigit13   = ""  nv_Hdigit14   = ""
  nv_Hdigit15   = ""  nv_Hdigit16   = ""  nv_Hdigit17   = ""  nv_Hdigit18   = ""
  nv_Hdigit19   = ""  nv_Hdigit20   = ""
  nv_Hdigit21   = ""  nv_Hdigit22   = ""  nv_Hdigit23   = ""  nv_Hdigit24   = ""
  nv_Hdigit25   = ""  nv_Hdigit26   = ""  nv_Hdigit27   = ""  nv_Hdigit28   = ""
  nv_Hdigit29   = ""  nv_Hdigit30   = ""
  nv_Hdigit31   = ""  nv_Hdigit32   = "".
/* */

RUN Proc_Chr (input nv_Idigit1,  output nv_Hdigit1).
RUN Proc_Chr (input nv_Idigit2,  output nv_Hdigit2).
RUN Proc_Chr (input nv_Idigit3,  output nv_Hdigit3).
RUN Proc_Chr (input nv_Idigit4,  output nv_Hdigit4).
RUN Proc_Chr (input nv_Idigit5,  output nv_Hdigit5).
RUN Proc_Chr (input nv_Idigit6,  output nv_Hdigit6).
RUN Proc_Chr (input nv_Idigit7,  output nv_Hdigit7).
RUN Proc_Chr (input nv_Idigit8,  output nv_Hdigit8).
RUN Proc_Chr (input nv_Idigit9,  output nv_Hdigit9).
RUN Proc_Chr (input nv_Idigit10, output nv_Hdigit10).
RUN Proc_Chr (input nv_Idigit11, output nv_Hdigit11).
RUN Proc_Chr (input nv_Idigit12, output nv_Hdigit12).
RUN Proc_Chr (input nv_Idigit13, output nv_Hdigit13).
RUN Proc_Chr (input nv_Idigit14, output nv_Hdigit14).
RUN Proc_Chr (input nv_Idigit15, output nv_Hdigit15).
RUN Proc_Chr (input nv_Idigit16, output nv_Hdigit16).
RUN Proc_Chr (input nv_Idigit17, output nv_Hdigit17).
RUN Proc_Chr (input nv_Idigit18, output nv_Hdigit18).
RUN Proc_Chr (input nv_Idigit19, output nv_Hdigit19).
RUN Proc_Chr (input nv_Idigit20, output nv_Hdigit20).
RUN Proc_Chr (input nv_Idigit21, output nv_Hdigit21).
RUN Proc_Chr (input nv_Idigit22, output nv_Hdigit22).
RUN Proc_Chr (input nv_Idigit23, output nv_Hdigit23).
RUN Proc_Chr (input nv_Idigit24, output nv_Hdigit24).
RUN Proc_Chr (input nv_Idigit25, output nv_Hdigit25).
RUN Proc_Chr (input nv_Idigit26, output nv_Hdigit26).
RUN Proc_Chr (input nv_Idigit27, output nv_Hdigit27).
RUN Proc_Chr (input nv_Idigit28, output nv_Hdigit28).
RUN Proc_Chr (input nv_Idigit29, output nv_Hdigit29).
RUN Proc_Chr (input nv_Idigit30, output nv_Hdigit30).
RUN Proc_Chr (input nv_Idigit31, output nv_Hdigit31).
RUN Proc_Chr (input nv_Idigit32, output nv_Hdigit32).

/* */
nv_octets = 
  nv_Hdigit1  + nv_Hdigit2  + nv_Hdigit3  + nv_Hdigit4  + 
  nv_Hdigit5  + nv_Hdigit6  + nv_Hdigit7  + nv_Hdigit8  + "-" +
  nv_Hdigit9  + nv_Hdigit10 + nv_Hdigit11 + nv_Hdigit12 + "-" +
  nv_Hdigit13 + nv_Hdigit14 + nv_Hdigit15 + nv_Hdigit16 + "-" +
  nv_Hdigit17 + nv_Hdigit18 + nv_Hdigit19 + nv_Hdigit20 + "-" +
  nv_Hdigit21 + nv_Hdigit22 + nv_Hdigit23 + nv_Hdigit24 + 
  nv_Hdigit25 + nv_Hdigit26 + nv_Hdigit27 + nv_Hdigit28 + 
  nv_Hdigit29 + nv_Hdigit30 + nv_Hdigit31 + nv_Hdigit32.
/* */

/* --------
DISPLAY
/*--- */
nv_c1  nv_c2  nv_c3  nv_c4  nv_c5  nv_c6  nv_c7 nv_c8 nv_c9 nv_c10
nv_c11 nv_c12 nv_c13 nv_c14 nv_c15 nv_c16
/*
nv_cCHAR FORMAT "X(74)"
nv_cCHAR2 FORMAT "X(64)"
*/

nv_octets FORMAT "X(40)"

nv_Idigit1  nv_Idigit2  nv_Idigit3  nv_Idigit4  nv_Idigit5
nv_Idigit6  nv_Idigit7  nv_Idigit8  nv_Idigit9  nv_Idigit10
nv_Idigit11 nv_Idigit12 nv_Idigit13 nv_Idigit14 nv_Idigit15
nv_Idigit16 nv_Idigit17 nv_Idigit18 nv_Idigit19 nv_Idigit20
nv_Idigit21 nv_Idigit22 nv_Idigit23 nv_Idigit24 nv_Idigit25
nv_Idigit26 nv_Idigit27 nv_Idigit28 nv_Idigit29 nv_Idigit30
nv_Idigit31 nv_Idigit32 
WITH 1 COLUMN.
PAUSE.
-------- */

/* ------------------------------------------------------------------ */
/* END OF FILE : WRSDigit. */


PROCEDURE Proc_Chr:
  /* */
  DEFINE input  parameter nv_CheckNumber AS INTEGER   NO-UNDO.
  DEFINE output parameter nv_ReceiptChr  AS CHARACTER FORMAT "X" NO-UNDO.
  /* */
  DEFINE VARIABLE nv_seqno   AS INTEGER   NO-UNDO.
  DEFINE VARIABLE nv_lx      AS INTEGER   NO-UNDO.

  nv_seqno      = 0.
  nv_ReceiptChr = "".

  DO WHILE nv_lx <= nv_CheckNumber:

    CASE nv_seqno:
      WHEN 0   THEN nv_ReceiptChr = "0".
      WHEN 1   THEN nv_ReceiptChr = "1".
      WHEN 2   THEN nv_ReceiptChr = "2".
      WHEN 3   THEN nv_ReceiptChr = "3".
      WHEN 4   THEN nv_ReceiptChr = "4".
      WHEN 5   THEN nv_ReceiptChr = "5".
      WHEN 6   THEN nv_ReceiptChr = "6".
      WHEN 7   THEN nv_ReceiptChr = "7".
      WHEN 8   THEN nv_ReceiptChr = "8".
      WHEN 9   THEN nv_ReceiptChr = "9".
      WHEN 10  THEN nv_ReceiptChr = "a".
      WHEN 11  THEN nv_ReceiptChr = "b".
      WHEN 12  THEN nv_ReceiptChr = "c".
      WHEN 13  THEN nv_ReceiptChr = "d".
      WHEN 14  THEN nv_ReceiptChr = "e".
      WHEN 15  THEN nv_ReceiptChr = "f".
    END CASE.


    nv_lx    = nv_lx + 1.
    /* */

    nv_seqno = nv_seqno + 1.
    IF nv_seqno = 16 THEN nv_seqno = 0.

  END.
  /* */
END PROCEDURE.
/* -------- */


PROCEDURE PD_ReturnC:
  /* */
  DEFINE input  parameter nv_InputPrm   AS CHARACTER NO-UNDO.
  DEFINE output parameter nv_Outputprm  AS CHARACTER NO-UNDO.
/*
  DEFINE output parameter nv_ReceiptChr AS CHARACTER FORMAT "X" NO-UNDO.
*/
  DEFINE VARIABLE nv_c1      AS CHARACTER NO-UNDO.
  DEFINE VARIABLE nv_chkno   AS INTEGER   NO-UNDO.
  DEFINE VARIABLE nv_lno     AS INTEGER   NO-UNDO.

  nv_chkno = LENGTH(nv_InputPrm).
  nv_lno   = 1.

  DO WHILE nv_lno <= nv_chkno:

    nv_c1 = SUBSTRING(nv_InputPrm, nv_lno, 1).

    nv_Outputprm = TRIM(nv_c1) + TRIM(nv_Outputprm).

    nv_lno = nv_lno + 1.
  END.

END PROCEDURE.
/* -------- */

PROCEDURE PD_loop:
  /* */
  DEFINE input  parameter nv_loop  AS  INTEGER   NO-UNDO.

  DEFINE VARIABLE nv_line    AS INTEGER   NO-UNDO.

  nv_line  = 0.

  DO WHILE nv_line <= nv_loop:

    nv_line = nv_line + 1.
  END.

END PROCEDURE.
/* -------- */

/* END OF FILE : WRSDigit. */
