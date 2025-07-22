/*programid   : wgwtaygn.w                                                                 */ 
/*programname : load text file AYCL to GW                                                  */ 
/*Copyright   : Safety Insurance Public Company Limited บริษัท ประกันคุ้มภัย จำกัด (มหาชน) */ 
/*create by   : Kridtiya i. A56-0241  date . 02/08/2013                                    */ 
/*Modify By   : Porntiwa P. A58-0361  30/09/2015  ปรับเพิ่มตัวแปร                            */
/*Modify By Jiraphon P. A59-0451 26/10/2016 เพิ่มตัวแปร                                    */
/*Modify By Sarinya C A61-0349 05/11/2018 เพิ่มตัวแปร  */
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by   : Ranu i. A64-0138 เพิ่มเงื่อนไขการคำนวณเบี้ยจากโปรแกรมกลาง */
DEF VAR  np_recno       AS CHAR FORMAT "x(10)"  INIT "".  /* 1	ลำดับที่  	*/
DEF VAR  np_Notify_dat  AS CHAR FORMAT "X(10)"  INIT "".  /* 2	วันที่แจ้ง 	*/
DEF VAR  np_notifyno    AS CHAR FORMAT "X(10)"  INIT "".  /* 3	เลขรับแจ้ง 	*/
DEF VAR  np_branch      AS CHAR FORMAT "X(2)"   INIT "".  /* 4	Branch     	*/
DEF VAR  np_contract    AS CHAR FORMAT "X(20)"  INIT "".  /* 5	Contract   	*/
DEF VAR  np_title       AS CHAR FORMAT "X(25)"  INIT "".  /* 6	คำนำหน้าชื่อ	*/
DEF VAR  np_name        AS CHAR FORMAT "X(30)"  INIT "".  /* 7	ชื่อ  	    */
DEF VAR  np_name2       AS CHAR FORMAT "X(20)"  INIT "".  /* 8	นามสกุล  	*/
DEF VAR  np_addr1       AS CHAR FORMAT "X(60)"  INIT "".  /* 9	ที่อยู่ 1   	*/
DEF VAR  np_addr2       AS CHAR FORMAT "X(45)"  INIT "".  /* 10	ที่อยู่ 2     	*/
DEF VAR  np_addr3       AS CHAR FORMAT "X(45)"  INIT "".  /* 11	ที่อยู่ 3     	*/
DEF VAR  np_addr4       AS CHAR FORMAT "X(40)"  INIT "".  /* 12	ที่อยู่ 4     	*/
DEF VAR  np_brand       AS CHAR FORMAT "X(30)"  INIT "".  /* 13	ยี่ห้อรถ   	*/
DEF VAR  np_model       AS CHAR FORMAT "X(50)"  INIT "".  /* 14	รุ่นรถ     	*/
DEF VAR  np_vehreg      AS CHAR FORMAT "X(40)"  INIT "".  /* 15	เลขทะเบียน 	*/
DEF VAR  np_caryear     AS CHAR FORMAT "X(10)"  INIT "".  /* 16	ปีรถ       	*/
DEF VAR  np_ccweigth    AS CHAR FORMAT "X(10)"  INIT "".  /* 17	CC.        	*/
DEF VAR  np_cha_no      AS CHAR FORMAT "X(25)"  INIT "".  /* 18	เลขตัวถัง  	*/
DEF VAR  np_engno       AS CHAR FORMAT "X(25)"  INIT "".  /* 19	เลขเครื่อง 	*/
DEF VAR  np_codenotify  AS CHAR FORMAT "X(20)"  INIT "".  /* 20	Code ผู้แจ้ง      */
DEF VAR  np_cover       AS CHAR FORMAT "X(5)"   INIT "".  /* 21	ประเภท     	      */
DEF VAR  np_companycode AS CHAR FORMAT "X(20)"  INIT "".  /* 22	Code บ.ประกัน     */
DEF VAR  np_prepol      AS CHAR FORMAT "X(16)"  INIT "".  /* 23	เลขกรมธรรม์เดิม   */
DEF VAR  np_idno        AS CHAR FORMAT "x(15)"  INIT "". 
DEF VAR  np_comdate     AS CHAR FORMAT "X(10)"  INIT "".  /* 24	วันคุ้มครองประกัน */
DEF VAR  np_expdate     AS CHAR FORMAT "X(10)"  INIT "".  /* 25	วันหมดประกัน      */
DEF VAR  np_sumins      AS CHAR FORMAT "X(20)"  INIT "".  /* 26	ทุนประกัน  	      */
DEF VAR  np_premium     AS CHAR FORMAT "X(35)"  INIT "".  /* 27	ค่าเบี้ยสุทธิ์    */
DEF VAR  np_premiumnet  AS CHAR FORMAT "X(35)"  INIT "".  /* 28	ค่าเบี้ยรวมภาษีอากร           	*/
DEF VAR  np_deduct      AS CHAR FORMAT "X(35)"  INIT "".  /* 29	Deduct     	*/
DEF VAR  np_company72   AS CHAR FORMAT "X(20)"  INIT "".  /* 30	Code บ.ประกัน พรบ. 	*/
DEF VAR  np_comdate72   AS CHAR FORMAT "X(30)"  INIT "".  /* 31	วันคุ้มครองพรบ.    	*/
DEF VAR  np_expdate72   AS CHAR FORMAT "X(20)"  INIT "".  /* 32	วันหมดพรบ. 	*/
DEF VAR  np_prmcomp     AS CHAR FORMAT "X(50)"  INIT "".  /* 33	ค่าพรบ.    	*/
DEF VAR  np_drino       AS CHAR FORMAT "X(30)"  INIT "".  /* 34	ระบุผู้ขับขี่      	*/
DEF VAR  np_garage      AS CHAR FORMAT "X(20)"  INIT "".  /* 35	ซ่อมห้าง   	*/
DEF VAR  np_access      AS CHAR FORMAT "X(150)" INIT "".  /* 36	คุ้มครองอุปกรณ์เพิ่มเติม */
DEF VAR  np_editadd     AS CHAR FORMAT "X(150)" INIT "".  /* 37 แก้ไขที่อยู่       	 */ 
DEF VAR  np_benname     AS CHAR FORMAT "X(100)" INIT "".  /* 38	ผู้รับผลประโยชน์ 	 */ 
DEF VAR  np_remak       AS CHAR FORMAT "X(100)" INIT "".  /* 39	หมายเหตุ             */ 
DEF VAR  np_complete    AS CHAR FORMAT "X(20)"  INIT "".  /* 40	complete/not complete*/ 
DEF VAR  np_release     AS CHAR FORMAT "X(10)"  INIT "".   /* 41	Yes/No .  	     */
DEF VAR  np_prekpi      AS CHAR FORMAT "X(20)"  INIT "" .  /* 41   เบี้ยรวม    	     */
DEF VAR  np_payamount   AS CHAR FORMAT "X(10)"  INIT "" .  /* 41  ชำระล่าสุด  	     */ 
DEF VAR  np_producer    AS CHAR FORMAT "X(10)"  INIT "".   /* A58-0361 */
DEF VAR  np_agent       AS CHAR FORMAT "X(10)"  INIT "".   /* A58-0361 */
DEF VAR  np_ISPNo       AS CHAR FORMAT "X(20)"  INIT "".   /* Inspection No */

DEFINE WORKFILE wdetail
    FIELD poltyp      AS CHAR FORMAT "x(3)"   INIT ""  
    FIELD policy      AS CHAR FORMAT "x(16)"  INIT ""   
    FIELD compul      AS CHAR FORMAT "x"      INIT ""
    FIELD notifydat   AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD notifyno    AS CHAR FORMAT "x(20)"  INIT ""
    FIELD branch      AS CHAR FORMAT "x(2)"   INIT ""
    FIELD cedpol      AS CHAR FORMAT "x(25)"  INIT "" 
    FIELD insfer      AS CHAR FORMAT "x(10)"  INIT ""
    FIELD tiname      AS CHAR FORMAT "x(15)"  INIT ""   
    FIELD insnam      AS CHAR FORMAT "x(50)"  INIT ""  
    FIELD insnam2     AS CHAR FORMAT "x(50)"  INIT ""   
    FIELD insnam3     AS CHAR FORMAT "x(50)"  INIT ""   
    FIELD iadd1       AS CHAR FORMAT "x(150)" INIT ""    
    FIELD iadd2       AS CHAR FORMAT "x(35)"  INIT ""    
    FIELD iadd3       AS CHAR FORMAT "x(35)"  INIT ""    
    FIELD iadd4       AS CHAR FORMAT "x(35)"  INIT ""
    FIELD brand       AS CHAR FORMAT "x(30)"  INIT ""
    FIELD model       AS CHAR FORMAT "x(50)"  INIT ""
    FIELD vehreg      AS CHAR FORMAT "x(11)"  INIT ""
    FIELD caryear     AS CHAR FORMAT "x(4)"   INIT ""
    FIELD cc          AS CHAR FORMAT "x(10)"  INIT ""
    FIELD engno       AS CHAR FORMAT "x(25)"  INIT ""     
    FIELD chasno      AS CHAR FORMAT "x(25)"  INIT ""   
    FIELD notiuser    AS CHAR FORMAT "X(50)"  INIT ""   
    FIELD covcod      AS CHAR FORMAT "x"      INIT ""
    FIELD prepol      AS CHAR FORMAT "x(20)"  INIT ""
    FIELD comdat      AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD expdat      AS CHAR FORMAT "x(10)"  INIT ""  
    FIELD premt       AS CHAR FORMAT "x(20)"  INIT ""
    FIELD volprem     AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD garage      AS CHAR FORMAT "x"      INIT "" 
    FIELD textf6      AS CHAR FORMAT "X(100)" INIT "" 
    FIELD nmember     AS CHAR INIT "" FORMAT "x(255)" 
    FIELD nmember2    AS CHAR INIT "" FORMAT "x(255)"
    FIELD benname     AS CHAR FORMAT "x(100)" INIT ""  
    FIELD vatcode     AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD prempa      AS CHAR FORMAT "x"      INIT ""    
    FIELD subclass    AS CHAR FORMAT "x(3)"   INIT ""    
    FIELD weight      AS CHAR FORMAT "x(10)"  INIT ""
    FIELD seat        AS CHAR FORMAT "x(2)"   INIT ""
    FIELD body        AS CHAR FORMAT "x(20)"  INIT ""
    FIELD vehuse      AS CHAR FORMAT "x"      INIT ""     
    FIELD stk         AS CHAR FORMAT "x(15)"  INIT ""     
    FIELD access      AS CHAR FORMAT "x"      INIT "" 
    FIELD ncb         AS CHAR FORMAT "x(10)"  INIT ""   
    FIELD tpbiper     AS CHAR FORMAT "x(20)"  INIT ""  
    FIELD tpbiacc     AS CHAR FORMAT "x(20)"  INIT ""  
    FIELD tppdacc     AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD si          AS CHAR FORMAT "x(20)"  INIT ""   
    FIELD fi          AS CHAR FORMAT "x(20)"  INIT ""
    FIELD n_IMPORT    AS CHAR FORMAT "x(2)"   INIT ""     
    FIELD n_export    AS CHAR FORMAT "x(2)"   INIT ""     
    FIELD cancel      AS CHAR FORMAT "x(2)"   INIT ""   
    FIELD WARNING     AS CHAR FORMAT "X(30)"  INIT ""
    FIELD comment     AS CHAR FORMAT "x(512)" INIT ""   
    FIELD seat41      AS INTE FORMAT "99"     INIT 0         
    FIELD pass        AS CHAR FORMAT "x"      INIT "n"       
    FIELD OK_GEN      AS CHAR FORMAT "X"      INIT "Y"        
    FIELD comper      AS CHAR INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"                  
    FIELD comacc      AS CHAR INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"                  
    FIELD NO_41       AS CHAR INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"                  
    FIELD NO_42       AS CHAR INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"                   
    FIELD NO_43       AS CHAR INIT "200000"   FORMAT ">,>>>,>>>,>>>,>>9"                  
    FIELD baseprem    AS INTE FORMAT ">,>>>,>>>,>>>,>>9" INIT  0
    FIELD cargrp      AS CHAR FORMAT "x(2)"  INIT ""      
    FIELD producer    AS CHAR FORMAT "x(10)" INIT ""      
    FIELD agent       AS CHAR FORMAT "x(10)" INIT "" 
    FIELD redbook     AS CHAR INIT "" FORMAT "X(8)"     
    FIELD base        AS CHAR INIT "" FORMAT "x(8)"     
    FIELD accdat      AS CHAR INIT "" FORMAT "x(10)"    
    FIELD docno       AS CHAR INIT "" FORMAT "x(10)"    
    FIELD idno        AS CHAR FORMAT "X(15)"  INIT ""  
    FIELD prekpi      AS CHAR FORMAT "X(20)"  INIT ""  
    FIELD payamount   AS CHAR FORMAT "X(10)"  INIT ""  
    FIELD r_time      AS CHAR FORMAT "X(10)"  /*Add Jiraphon A59-0451*/
    FIELD r_date      AS CHAR FORMAT "X(10)"  /*Add Jiraphon A59-0451*/
    FIELD ISPNo       AS CHAR FORMAT "X(20)"  INIT ""   /* Inspection No */ /*A61-0349*/
    /*FIELD delerco     AS CHAR FORMAT "x(10)"  INIT ""  
    FIELD remak1      AS CHAR FORMAT "x(100)" INIT ""
    FIELD typecar     AS CHAR FORMAT "x(30)"  INIT ""
    FIELD ispno       AS CHAR FORMAT "X(30)"  INIT ""   
    FIELD birthday    AS CHAR FORMAT "X(100)"  INIT ""  
    FIELD occupins    AS CHAR FORMAT "X(100)" INIT ""   
    FIELD namedirect  AS CHAR FORMAT "X(100)" INIT ""  
    FIELD drivname1   AS CHAR FORMAT "X(100)" INIT "" 
    FIELD idnodri1    AS CHAR FORMAT "X(20)"  INIT ""  
    FIELD drivname2   AS CHAR FORMAT "X(100)" INIT ""  
    FIELD idnodri2    AS CHAR FORMAT "X(20)"  INIT ""   
    FIELD campaigno   AS CHAR FORMAT "X(20)"  INIT ""    */         
    FIELD financecd  AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD firstName   AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD lastName    AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD postcd      AS CHAR FORMAT "x(15)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeocc     AS CHAR FORMAT "x(4)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr1   AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr2   AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr3   AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD br_insured  AS CHAR FORMAT "x(5)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD campaign_ov AS CHAR FORMAT "x(30)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
    FIELD insnamtyp   AS CHAR FORMAT "x(60)" INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR nv_chkerror  AS CHAR FORMAT "x(250)" INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR nv_postcd    AS CHAR FORMAT "x(25)" INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR n_firstdat      AS CHAR FORMAT "x(10)"  INIT ""  .
def    NEW SHARED VAR   nv_message as   char.
DEF VAR nv_riskgp        LIKE sicuw.uwm120.riskgp         NO-UNDO.
DEFINE NEW SHARED VAR no_baseprm AS DECI  FORMAT ">>,>>>,>>9.99-".  /*note add test Base Premium 25/09/2006*/
DEFINE NEW SHARED VAR NO_basemsg AS CHAR  FORMAT "x(50)" .          /*Warning Error If Not in Range 25/09/2006 */
DEFINE            VAR nv_accdat  AS DATE  FORMAT "99/99/9999" INIT ?  .     
DEFINE            VAR nv_docno   AS CHAR  FORMAT "9999999"    INIT " ".
DEFINE NEW SHARED VAR  nv_batchyr   AS INT FORMAT "9999"            INIT 0.
DEFINE NEW SHARED VAR  nv_batcnt    AS INT FORMAT "99"              INIT 0.
DEFINE NEW SHARED VAR  nv_batchno   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_batrunno  AS INT FORMAT  ">,>>9"          INIT 0.
DEFINE VAR  nv_imppol    AS INT  FORMAT ">>,>>9"         INIT 0.
DEFINE VAR  nv_impprem   AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.
DEFINE VAR  nv_batprev   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_tmppolrun AS INTEGER FORMAT "999"         INIT 0.            /*Temp Policy Running No.*/
DEFINE VAR  nv_batbrn    AS CHARACTER FORMAT "x(2)"      INIT ""  NO-UNDO.  /*Batch Branch*/
DEFINE VAR  nv_tmppol    AS CHARACTER FORMAT "x(16)"     INIT "".           /*Temp Policy*/
DEFINE VAR  nv_rectot    AS INT  FORMAT ">>,>>9"         INIT 0.            /* Display จำนวน ก/ธ ทั้งไฟล์ */
DEFINE VAR  nv_recsuc    AS INT  FORMAT ">>,>>9"         INIT 0.            /* Display จำนวน ก/ธ ที่นำเข้าได้ */
DEFINE VAR  nv_netprm_t  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.            /* Display เบี้ยรวม ทั้งไฟล์ */
DEFINE VAR  nv_netprm_s  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.            /* Display เบี้ยรวม ที่นำเข้าได้ */
DEFINE VAR  nv_batflg    AS LOG                          INIT NO.           
DEFINE VAR  nv_txtmsg    AS CHAR FORMAT "x(50)"          INIT "".           /* Parameter คู่กับ nv_check */
DEF VAR n_model AS CHAR FORMAT "x(40)".
DEFINE  WORKFILE wuppertxt NO-UNDO
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".
DEFINE  WORKFILE wuppertxt2 NO-UNDO
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".
DEF  VAR n_41   AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.
DEF  VAR n_42   AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.
DEF  VAR n_43   AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.
DEF  VAR nr_use     AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.  
DEF  VAR nr_grpvar  AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.  
DEF  VAR nr_yrvar   AS DECI     FORMAT ">,>>>,>>9.99" INIT 0.  
DEFINE VAR nv_basere   AS DECI        FORMAT ">>,>>>,>>9.99-" INIT 0. 
DEFINE VAR n_sclass72  AS CHAR FORMAT "x(4)".
DEFINE VAR nv_maxdes AS CHAR.
DEFINE VAR nv_mindes AS CHAR.
DEFINE VAR nv_si     AS DECI FORMAT ">>,>>>,>>9.99-".  /* Maximum Sum Insure */
DEFINE VAR nv_maxSI  AS DECI FORMAT ">>,>>>,>>9.99-".  /* Maximum Sum Insure */
DEFINE VAR nv_minSI  AS DECI FORMAT ">>,>>>,>>9.99-".  /* Minimum Sum Insure */
DEFINE VAR nv_newsck AS CHAR FORMAT "x(15)" INIT " ".
DEFINE VAR nv_simat  AS DECI FORMAT ">>>,>>>,>>>,>>9.99-".      
DEFINE VAR nv_simat1  AS DECI FORMAT ">>>,>>>,>>>,>>9.99-".     
DEF VAR nv_uwm301trareg    LIKE sic_bran.uwm301.cha_no INIT "".  
DEF  VAR gv_id AS CHAR FORMAT "X(8)" NO-UNDO.
DEF VAR nv_pwd AS CHAR NO-UNDO.

DEFINE  WORKFILE wuppertxt3 NO-UNDO
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "". 
DEFINE VAR n_insref   AS CHARACTER FORMAT "X(10)".  
DEFINE VAR nv_messagein AS CHAR FORMAT "X(200)". 
DEF VAR nv_usrid    AS CHARACTER FORMAT "X(08)".
DEF VAR nv_transfer AS LOGICAL   .
DEF VAR n_check     AS CHARACTER . 
DEF VAR nv_insref   AS CHARACTER FORMAT "X(10)".  
DEF VAR putchr      AS CHAR FORMAT "X(200)" INIT "" NO-UNDO.
DEF VAR putchr1     AS CHAR FORMAT "X(100)" INIT "" NO-UNDO.
DEF VAR nv_typ      AS CHAR FORMAT "X(2)".
DEF BUFFER buwm100   FOR sic_bran.uwm100. 
DEF  STREAM ns1.  
DEF  VAR nv_type  AS INTEGER  LABEL "Type". 

/*-- A58-0361 --*/
DEFINE VAR nv_producer AS CHAR FORMAT "X(12)".  
DEFINE VAR nv_agent    AS CHAR FORMAT "X(12)".    
/*-- A58-0361 --*/

/*--- A58-0361 ย้ายมาจาก WGWTAYGN.W --*/
/*--------- 722 --------*/
DEF VAR nv_stm_per  AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEF VAR nv_tax_per  AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEF VAR nv_com1_per AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEF VAR nv_com1_prm AS DECIMAL FORMAT ">>>>>9.99-"      NO-UNDO.
DEF VAR s_130bp1    AS RECID                            NO-UNDO.
DEF VAR s_130fp1    AS RECID                            NO-UNDO.
DEF VAR nvffptr     AS RECID                            NO-UNDO.
DEF VAR n_rd132     AS RECID                            NO-UNDO.
DEF VAR nv_gap      AS DECIMAL                          NO-UNDO.
DEF VAR nv_fptr     AS RECID.
DEF VAR nv_bptr     AS RECID.
DEF VAR nv_gap2     AS DECIMAL                          NO-UNDO.
DEF VAR nv_prem2    AS DECIMAL                          NO-UNDO.
DEF VAR nv_rstp     AS DECIMAL                          NO-UNDO.
DEF VAR nv_rtax     AS DECIMAL                          NO-UNDO.
DEF VAR nv_key_a    AS DECIMAL INITIAL 0                NO-UNDO.
DEF VAR nv_rec100   AS RECID .
DEF VAR nv_rec120   AS RECID .
DEF VAR nv_rec130   AS RECID .
DEF VAR nv_rec301   AS RECID .

DEFINE VAR nv_txt1    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt2    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt3    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt4    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt5    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt6    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt7    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt8    AS CHARACTER FORMAT "X(78)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_line1   AS INTEGER   INITIAL 0            NO-UNDO.
DEF    VAR nv_nptr    AS RECID.
DEF    VAR n_index    AS INTE INIT 0 .
DEF    VAR n_index2   AS INTE INIT 0.
DEF    VAR nc_r2      AS CHAR FORMAT "x(20)" INIT "".
DEF    VAR no_policy   AS CHAR FORMAT "x(12)" .
DEF    VAR no_rencnt   AS CHAR FORMAT "99".
DEF    VAR no_endcnt   AS CHAR FORMAT "999".
DEF    VAR no_riskno   AS CHAR FORMAT "999".
DEF    VAR no_itemno   AS CHAR FORMAT "999".
DEFINE VAR nv_chkpol  AS CHAR  FORMAT "X(30)" INITIAL "" NO-UNDO. 
DEFINE VAR nv_name1   AS CHAR  FORMAT "X(50)".                  
DEFINE VAR nv_name2   AS CHAR  FORMAT "X(50)".                  
DEFINE VAR nv_sex1    AS CHAR  FORMAT "X(6)".                   
DEFINE VAR nv_sex2    AS CHAR  FORMAT "X(6)".                   
DEFINE VAR nv_age1    AS CHAR  FORMAT "X(2)".                     
DEFINE VAR nv_age2    AS CHAR  FORMAT "X(2)".                    
DEFINE VAR nv_birdat1 AS DATE  FORMAT "99/99/9999".               
DEFINE VAR nv_birdat2 AS DATE  FORMAT "99/99/9999".              
DEFINE VAR nv_occup1  AS CHAR  FORMAT "X(15)".                  
DEFINE VAR nv_occup2  AS CHAR  FORMAT "X(15)".
/*-- End A58-0361 --*/
/*Add Jiraphon A59-0451*/
DEF VAR naddr1            AS CHAR FORMAT "x(180)" .
DEF VAR naddr2            AS CHAR FORMAT "x(180)" .
DEF VAR naddr3            AS CHAR FORMAT "x(180)" .
DEF VAR naddr4            AS CHAR FORMAT "x(180)" . 
DEF VAR n_soi             AS CHAR FORMAT "x(70)" .
DEF VAR n_road            AS CHAR FORMAT "x(70)" .
DEF VAR r_time   AS CHAR FORMAT "x(10)" .
DEF VAR r_date   AS CHAR FORMAT "x(10)" .
DEF VAR n_filename AS CHAR FORMAT "x(100)".
/*End Jiraphon A59-0451*/

/* add by : A64-0138 */
DEFINE NEW SHARED TEMP-TABLE wkuwd132 LIKE stat.pmuwd132.
DEF    VAR nv_cstflg  AS CHAR FORMAT "X(2)".     /*C=CC ; S=Seat ; T=Tons ; W=Watts*/  
DEFINE VAR nv_engcst  AS DECI FORMAT ">>>>>9.99".

DEFINE VAR nv_driage1 AS INTE FORMAT ">>9".
DEFINE VAR nv_driage2 AS INTE FORMAT ">>9".
DEF    VAR nv_pdprm0  AS DECI FORMAT ">>>,>>>,>>9.99-". /*เบี้ยผู้ขับขี่*/
DEFINE VAR nv_yrmanu  AS INTE FORMAT "9999".

DEFINE VAR nv_vehgrp  AS CHAR FORMAT "X(3)".
DEFINE VAR nv_access  AS CHAR FORMAT "X(3)".
DEFINE VAR nv_supe    AS LOGICAL.
DEFINE VAR nv_totfi   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_tpbi1si AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_tpbi2si AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_tppdsi  AS DECI FORMAT ">>>,>>>,>>9.99-".

DEFINE VAR nv_411si   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_412si   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_413si   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_414si   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_42si    AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_43si    AS DECI FORMAT ">>>,>>>,>>9.99-".

DEFINE VAR nv_ncbp    AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_fletp   AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_dspcp   AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_dstfp   AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_clmp    AS DECI FORMAT ">,>>9.99-".

DEFINE VAR nv_netprem AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_gapprem AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_flagprm AS CHAR FORMAT "X(2)". /* N=Net,G=Gross */

DEFINE VAR nv_effdat  AS DATE FORMAT "99/99/9999".

DEFINE VAR nv_ratatt       AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_siatt        AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_netatt       AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_fltatt       AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_ncbatt       AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_dscatt       AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_fcctv        AS LOGICAL . 
define var nv_uom1_c       as char .
define var nv_uom2_c       as char .
define var nv_uom5_c       as char .

DEFINE VAR nv_41prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_42prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_43prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_pdprem   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_status   AS CHAR .   /*fleet YES=Complete , NO=Not Complete */

/* end A64-0138 */

