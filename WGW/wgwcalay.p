 /************************************************************************/
/* WGWCALAY.p    : Co. Program Connect DB  formtmp                        */
/* Copyright	: Safety Insurance Public Company Limited 				 */
/*			      บริษัท ประกันคุ้มภัย จำกัด (มหาชน)					 */
/* CREATE BY	: Nipawadee R. 02/09/2010  Assign no. A53-0239           */
/************************************************************************/

DEF  SHARED VAR  n_User    AS CHAR.
DEF  SHARED VAR  n_Passwd  AS CHAR.

RUN wuw\wuwconfm.
RUN wgw\wgwaycl1.

DISCONNECT formtmp.
