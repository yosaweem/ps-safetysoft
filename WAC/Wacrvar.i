DEF VAR  nv_prem    AS DECI FORMAT "->>,>>>,>>>,>>9.99". 
DEF VAR  nv_dfield  AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 18. /*13.*/
DEF VAR  nv_sprem   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 18. /*14.*/
DEF VAR  nv_scomm   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 18. /*14.*/
/*---A50-0218---*/
DEF VAR  nv_svat   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT  18. /*14.*/
DEF VAR  nv_stax   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT  18. /*14.*/
/*--------------*/
DEF VAR  nv_sbal    AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 18. /*14.*/
DEF VAR  nv_sbal1   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 18. /*14.*/
DEF VAR  nv_total   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 18. /*13.*/
DEF VAR  nv_stbal   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 18. /*14.*/
DEF VAR  nv_fieldbal AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*14.*/
DEF VAR  nv_totbal   AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*14.*/
DEF VAR  nv_stotbal  AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. /*14.*/
DEF VAR  nv_notes1   AS CHAR .
DEF VAR  nv_vatt     AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR  nv_netpa    AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR  nv_totnetpa AS DECI FORMAT "->>,>>>,>>>,>>9.99". /*total net paid*/
DEF VAR  nv_totnetam AS DECI FORMAT "->>,>>>,>>>,>>9.99". /*total net amount*/
DEF VAR  nv_gnetpa AS DECI FORMAT "->>,>>>,>>>,>>9.99". /*Grand net paid*/
DEF VAR  nv_gnetam AS DECI FORMAT "->>,>>>,>>>,>>9.99". /*Grand net amount*/
DEF VAR  nv_nsbal   AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 18. 
DEF VAR  nv_ngbal   AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0.    
DEF VAR  nv_nsgbal   AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. 
DEF VAR  nv_nracodeb AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. 
DEF VAR  nv_nrdcodeb AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. 
DEF VAR  nv_nrfcodeb AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. 
DEF VAR  nv_netpaid  AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR  nv_gnetpaid  AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0.    
DEF VAR  nv_snetpaid  AS DECI FORMAT "->>,>>>,>>>,>>9.99" EXTENT 18. 
DEF VAR  nv_sgnetpaid AS DECI  FORMAT "->>,>>>,>>>,>>9.99" INIT 0 EXTENT 18. 
DEF VAR  nv_tnetpaid AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR  nv_godue   AS DECI FORMAT "->>,>>>,>>>,>>9.99". /*Grand net paid*/
DEF VAR  nv_todue   AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR  nv_tsumins AS DECI FORMAT "->>>,>>>,>>>,>>9.99". /*Total suminsure inward*/
DEF VAR  nv_gsumins AS DECI FORMAT "->>>,>>>,>>>,>>9.99". /*Grand suminsure inward*/
DEF VAR  nv_tsumin  AS DECI FORMAT "->>>,>>>,>>>,>>9.99". /*Total suminsure outward*/
DEF VAR  nv_gsumin  AS DECI FORMAT "->>>,>>>,>>>,>>9.99". /*Total suminsure outward*/
DEF VAR  nv_comdat  AS CHAR.
DEF VAR  nv_duedat  AS CHAR.
DEF VAR  nv_trndat  AS CHAR.
DEF VAR  nv_num     AS INT INIT 0.

/* Begin by Phaiboon W. [A59-0125] 20/04/2016 */
DEF VAR  nv_nettol  AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR  nv_nzibran AS CHAR.
DEF VAR  nv_nzibal  AS DECI EXTENT 18 FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR  nv_nzitol  AS DECI EXTENT  9 FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR  nv_grantol AS DECI EXTENT  9 FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR  nv_chkno   AS INT.
DEF VAR  nv_nzino   AS INT.
DEF VAR  nv_granno  AS INT.
DEF TEMP-TABLE tnzi    
    FIELD tbran    AS CHAR
    FIELD trelate  AS CHAR
    FIELD tacno    AS CHAR
    FIELD tacname  AS CHAR          
    FIELD tchkno   AS INT
    FIELD tnotes   AS CHAR
    FIELD tnzibal  AS DECI EXTENT 9 FORMAT "->>,>>>,>>>,>>9.99".
/* End by Phaiboon W. [A59-0125] 20/04/2016 */
