/************************************************************************/
/* wgwtrno2.p   Transfer Gw to Premium   Release     				    */
/* Copyright	: Tokio Marine Safety Insurance (Thailand) PCL.         */
/*			  บริษัท คุ้มภัยโตเกียวมารีนประกันภัย (ประเทศไทย)			*/
/* CREATE BY	: Chaiyong W.  ASSIGN A64-0189  DATE 21/04/2021 		*/
/************************************************************************/
DEF VAR nv_srel  AS CHAR INIT "".
DEF VAR nv_oth1  AS CHAR INIT "".
DEF VAR nv_oth2  AS CHAR INIT "".
DEF VAR nv_oth3  AS CHAR INIT "".

nv_srel = "release".

RUN wgw\wgwtrnon(INPUT nv_srel,
                 INPUT nv_oth1 ,
                 INPUT nv_oth2 ,
                 INPUT nv_oth3).
