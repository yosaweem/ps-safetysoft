/*************************************************************************
 WGWHDExt.p : ใช้เฉพาะ ระบบงานนำเข้าข้อมูล พรบ. จาก Broker ผ่าน Web Service 
 Copyright  : Safety Insurance Public Company Limited
              บริษัท ประกันคุ้มภัย จำกัด (มหาชน)
 CREATE BY  : Watsana K.   ASSIGN: A56-0299        DATE: 25/09/2013
 Database   : Not Connect DB
*************************************************************************/

DEF   INPUT  PARAMETER  win_title AS  HANDLE                NO-UNDO.
DEF   INPUT  PARAMETER  gv_prgid  AS  CHAR   FORMAT "X(8)"  NO-UNDO.
DEF   INPUT  PARAMETER  gv_prog   AS  CHAR   FORMAT "X(40)" NO-UNDO.

DEF VAR gv_text   AS CHAR FORMAT "X(133)" INITIAL "" NO-UNDO.
DEF VAR gv_prdid  AS CHAR FORMAT "X(40)"  INITIAL "" NO-UNDO .
DEF VAR gv_des    AS CHAR FORMAT "X(40)"  INITIAL "" NO-UNDO.
DEF VAR gv_title  AS CHAR FORMAT "X(40)"  INITIAL "" NO-UNDO.
def var a         as char format "x(90)".

/*
FIND sym003 WHERE sym003.co = "00" NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sym003 THEN gv_prdid = sym003.scrhdr.
*/
/* Use External call Web Services */
gv_prdid = "Safety Insurance Co.,Ltd.".


ASSIGN 
gv_des   = SUBSTRING(gv_prog,1,35).
gv_title = SUBSTRING(gv_prdid,1,37).

SUBSTRING(gv_text,1,8)    =  gv_prgid.       
SUBSTRING(gv_text,18,40)  =  gv_title.
SUBSTRING(gv_text,64,42)  =  gv_des.
SUBSTRING(gv_text,117,10) =  STRING(TODAY,"99/99/9999").
SUBSTRING(gv_text,130,8)  =  STRING(TIME,"HH:MM:SS")  .


ASSIGN 
      win_title:title = gv_text.

/*****************************************************************************
 win_title:title =  SUBSTRING(gv_prgid,1,8)    + FILL(" ",6)  +
                    SUBSTRING(gv_text,1,40)    + FILL(" ",10) +
                    SUBSTRING(gv_prog,1,34)    + FILL(" ",15) +
                    STRING(TODAY,"99/99/9999") + FILL(" ",4)  +
                    STRING(TIME,"HH:MM:SS").
*******************************************************************************/

   
/* END OF FILE : WSUHDEXT.P */
