/************************************************************************/
/* wactlt0.i   : Initial Value Text File Sent วางบิล TLT                */
/* Copyright   : Tokio Marine Safety Insurance Public Company Limited 	*/
/*			     บริษัท คุ้มภัยโตเกียวมารีนประกันภัย จำกัด (มหาชน)		*/
/* CREATE BY  : Nontamas H. [A63-0417] Date 12/03/20201      	        */
/************************************************************************/
DEFINE NEW SHARED WORKFILE wdetail2 NO-UNDO 
    FIELD head              AS CHAR   FORMAT "X(4)"               
    FIELD n_binloop         AS CHAR   FORMAT "x(2)"               
    FIELD fi_bindate        AS CHAR   FORMAT "x(8)"               
    FIELD wRecordno         AS CHAR   FORMAT "x(6)"               
    FIELD wjob_nr           AS CHAR   FORMAT "X"                  
    FIELD wnorpol           AS CHAR   FORMAT "X(25)"              
    FIELD wpol72            AS CHAR   FORMAT "X(25)"              
    FIELD winsure           AS CHAR   FORMAT "X(60)"              
    FIELD wcha_no           AS CHAR   FORMAT "X(20)"              
    FIELD wengine           AS CHAR   FORMAT "X(20)"              
    FIELD wnor_comdat       AS CHAR   FORMAT "x(8)"               
    FIELD wnor_expdat       AS CHAR   FORMAT "x(8)"               
    FIELD wnor_covamt       AS DECI   FORMAT "-9999999999.99"     
    FIELD wcomp_covamt      AS DECI   FORMAT "-9999999999.99"     
    FIELD wNetPrem          AS DECI   FORMAT "-9999999999.99"     
    FIELD wCompNetPrem      AS DECI   FORMAT "-9999999999.99"     
    FIELD wgrossprem        AS DECI   FORMAT "-9999999999.99"     
    FIELD wCompGrossPrem    AS DECI   FORMAT "-9999999999.99"     
    FIELD wtotal_prm        AS DECI   FORMAT "-9999999999.99"     
    FIELD wnor_comm         AS DECI   FORMAT "-9999999999.99"     
    FIELD wcomp_comm        AS DECI   FORMAT "-9999999999.99"     
    FIELD wnor_vat          AS DECI   FORMAT "-9999999999.99"     
    FIELD wcomp_vat         AS DECI   FORMAT "-9999999999.99"     
    FIELD wnor_tax3         AS DECI   FORMAT "-9999999999.99"     
    FIELD wcomp_tax3        AS DECI   FORMAT "-9999999999.99"     
    FIELD wNetPayment       AS DECI   FORMAT "-9999999999.99"     
    FIELD wsubins           AS CHAR   FORMAT "X(4)"               
    FIELD wcomp_sub         AS CHAR   FORMAT "X(4)"               
    FIELD wcomp_comdat      AS CHAR   FORMAT "x(8)"               
    FIELD wcomp_expdat      AS CHAR   FORMAT "x(8)"
    FIELD wremark           AS CHAR   FORMAT "X(49)"
    FIELD wdealer           AS CHAR   FORMAT "X(16)"   /*A65-0006*/
    FIELD wendno            AS CHAR   FORMAT "X(10)"   /*A65-0006*/
    .

DEFINE NEW SHARED WORKFILE wdetb3m NO-UNDO 
    FIELD head              AS CHAR   FORMAT "X(4)"               
    FIELD n_binloop         AS CHAR   FORMAT "x(2)"               
    FIELD fi_bindate        AS CHAR   FORMAT "x(8)"               
    FIELD wRecordno         AS CHAR   FORMAT "x(6)"               
    FIELD wjob_nr           AS CHAR   FORMAT "X"                  
    FIELD wnorpol           AS CHAR   FORMAT "X(25)"              
    FIELD wpol72            AS CHAR   FORMAT "X(25)"              
    FIELD winsure           AS CHAR   FORMAT "X(60)"              
    FIELD wcha_no           AS CHAR   FORMAT "X(20)"              
    FIELD wengine           AS CHAR   FORMAT "X(20)"              
    FIELD wnor_comdat       AS CHAR   FORMAT "x(8)"               
    FIELD wnor_expdat       AS CHAR   FORMAT "x(8)"               
    FIELD wnor_covamt       AS DECI   FORMAT "-9999999999.99"     
    FIELD wcomp_covamt      AS DECI   FORMAT "-9999999999.99"     
    FIELD wNetPrem          AS DECI   FORMAT "-9999999999.99"     
    FIELD wCompNetPrem      AS DECI   FORMAT "-9999999999.99"     
    FIELD wgrossprem        AS DECI   FORMAT "-9999999999.99"     
    FIELD wCompGrossPrem    AS DECI   FORMAT "-9999999999.99"     
    FIELD wtotal_prm        AS DECI   FORMAT "-9999999999.99"     
    FIELD wnor_comm         AS DECI   FORMAT "-9999999999.99"     
    FIELD wcomp_comm        AS DECI   FORMAT "-9999999999.99"     
    FIELD wnor_vat          AS DECI   FORMAT "-9999999999.99"     
    FIELD wcomp_vat         AS DECI   FORMAT "-9999999999.99"     
    FIELD wnor_tax3         AS DECI   FORMAT "-9999999999.99"     
    FIELD wcomp_tax3        AS DECI   FORMAT "-9999999999.99"     
    FIELD wNetPayment       AS DECI   FORMAT "-9999999999.99"     
    FIELD wsubins           AS CHAR   FORMAT "X(4)"               
    FIELD wcomp_sub         AS CHAR   FORMAT "X(4)"               
    FIELD wcomp_comdat      AS CHAR   FORMAT "x(8)"               
    FIELD wcomp_expdat      AS CHAR   FORMAT "x(8)"
    FIELD wremark           AS CHAR   FORMAT "X(49)"
    FIELD wdealer           AS CHAR   FORMAT "X(16)"   /*A65-0006*/
    FIELD wendno            AS CHAR   FORMAT "X(10)"   /*A65-0006*/
    .

DEF VAR nv_percomm        AS INTE FORMAT "99" INIT 0.
DEF VAR nv_perov          AS INTE FORMAT "99" INIT 0.
DEF VAR nv_output         AS CHAR INIT "".
DEF VAR nv_acno1          AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR nv_finint         AS CHAR FORMAT "x(10)" INIT "" .

DEF VAR nv_whead          AS CHAR FORMAT "X(4)"  INIT "".              
DEF VAR nv_wbinloop       AS CHAR FORMAT "x(2)"  INIT "".  
DEF VAR nv_wbindate       AS CHAR FORMAT "x(8)"  INIT "".  
DEF VAR nv_wRecordno      AS CHAR FORMAT "x(6)"  INIT "".  
DEF VAR nv_wjob_nr        AS CHAR FORMAT "X"     INIT "".  
DEF VAR nv_wnorpol        AS CHAR FORMAT "X(25)" INIT "".  
DEF VAR nv_wpol72         AS CHAR FORMAT "X(25)" INIT "".  
DEF VAR nv_winsure        AS CHAR FORMAT "X(60)" INIT "".  
DEF VAR nv_wcha_no        AS CHAR FORMAT "X(20)" INIT "".  
DEF VAR nv_wengine        AS CHAR FORMAT "X(20)" INIT "".  
DEF VAR nv_wnor_comdat    AS CHAR FORMAT "x(8)"  INIT "".  
DEF VAR nv_wnor_expdat    AS CHAR FORMAT "x(8)"  INIT "".  
DEF VAR nv_wnor_covamt    AS CHAR FORMAT "x(20)" INIT "".   
DEF VAR nv_wcomp_covamt   AS CHAR FORMAT "x(20)" INIT "".   
DEF VAR nv_wNetPrem       AS CHAR FORMAT "x(20)" INIT "".   
DEF VAR nv_wCompNetPrem   AS CHAR FORMAT "x(20)" INIT "".   
DEF VAR nv_wgrossprem     AS CHAR FORMAT "x(20)" INIT "".   
DEF VAR nv_wCompGrossPrem AS CHAR FORMAT "x(20)" INIT "".   
DEF VAR nv_wtotal_prm     AS CHAR FORMAT "x(20)" INIT "".   
DEF VAR nv_wnor_comm      AS CHAR FORMAT "x(20)" INIT "".   
DEF VAR nv_wcomp_comm     AS CHAR FORMAT "x(20)" INIT "".   
DEF VAR nv_wnor_vat       AS CHAR FORMAT "x(20)" INIT "".   
DEF VAR nv_wcomp_vat      AS CHAR FORMAT "x(20)" INIT "".   
DEF VAR nv_wnor_tax3      AS CHAR FORMAT "x(20)" INIT "".   
DEF VAR nv_wcomp_tax3     AS CHAR FORMAT "x(20)" INIT "".   
DEF VAR nv_wNetPayment    AS CHAR FORMAT "x(20)" INIT "".   
DEF VAR nv_wsubins        AS CHAR FORMAT "X(4)"  INIT "".  
DEF VAR nv_wcomp_sub      AS CHAR FORMAT "X(4)"  INIT "".  
DEF VAR nv_wcomp_comdat   AS CHAR FORMAT "x(8)"  INIT "".  
DEF VAR nv_wcomp_expdat   AS CHAR FORMAT "x(8)"  INIT "".  
DEF VAR nv_wremark        AS CHAR FORMAT "X(49)" INIT "".

/*------------------End wactlt0.i---------------------------*/
