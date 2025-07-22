/************************************************************************/
/* Wacc007.p    : Co. Program Connect DB sicfn & formtmp                */
/* Copyright	: Safety Insurance Public Company Limited 				*/
/*			      บริษัท ประกันคุ้มภัย จำกัด (มหาชน)					*/
/* CREATE BY	: Amparat C.   ASSIGN A53-0236  DATE 15/08/2010			*/
/************************************************************************/

DEF  SHARED VAR  n_User    AS CHAR.
DEF  SHARED VAR  n_Passwd  AS CHAR.

RUN wac\wacconfn.
RUN wuw\wuwconfm.

IF CONNECTED ("formtmp")  THEN RUN wac\wacr007.
ELSE MESSAGE "Can't connected to database  formtmp !  "  VIEW-AS ALERT-BOX.                

DISCONNECT formtmp.
DISCONNECT SicFn.
