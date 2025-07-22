/************   Program   **************/
/* wactis05.i   -   Detail  file Excel  v72*/
/* Modify By : Kanchana C.             A46-0463    27/11/2003 */
/***************************************/

             n_row1 = n_row1 + 1.

    PUT STREAM  filebill2ex "C;Y" string(n_row1)  ";X1;K"   '"' chas '"' skip.
    PUT STREAM  filebill2ex "C;Y" string(n_row1)  ";X2;K"   '"' n_veh1 '"' skip.
    PUT STREAM  filebill2ex "C;Y" string(n_row1)  ";X3;K"   '"'  '"' skip.
    PUT STREAM  filebill2ex "C;Y" string(n_row1)  ";X4;K"   '"' TODAY '"' skip.   /* billing.asdat  */
    PUT STREAM  filebill2ex "C;Y" string(n_row1)  ";X5;K"   '"' "010" '"' skip.
    PUT STREAM  filebill2ex "C;Y" string(n_row1)  ";X6;K"   '"' billing.title1 '"' skip.
    PUT STREAM  filebill2ex "C;Y" string(n_row1)  ";X7;K"   '"' nv_infnam '"' skip.
    PUT STREAM  filebill2ex "C;Y" string(n_row1)  ";X8;K"   '"' nv_inlnam '"' skip.
    PUT STREAM  filebill2ex "C;Y" string(n_row1)  ";X9;K"   '"' billing.nor_policy '"' skip.    /* billing.policy */
    PUT STREAM  filebill2ex "C;Y" string(n_row1)  ";X10;K"   '"' billing.start_date '"' skip.
    PUT STREAM  filebill2ex "C;Y" string(n_row1)  ";X11;K"   '"' billing.expdat '"' skip.
    PUT STREAM  filebill2ex "C;Y" string(n_row1)  ";X12;K"   '"' billing.model '"' skip.
    PUT STREAM  filebill2ex "C;Y" string(n_row1)  ";X13;K"   '"' billing.vehreg '"' skip.
    PUT STREAM  filebill2ex "C;Y" string(n_row1)  ";X14;K"   '"' billing.chassis '"' skip.
       
    PUT STREAM  filebill2ex "C;Y" string(n_row1)  ";X15;K"   '"' billing.engine '"' skip.
    PUT STREAM  filebill2ex "C;Y" string(n_row1)  ";X16;K"   '"' billing.nor_covamt  + billing.comp_covamt FORMAT "->>,>>>,>>9.99" '"' skip.
    PUT STREAM  filebill2ex "C;Y" string(n_row1)  ";X17;K"   '"' billing.nor_grp +  billing.comp_grp  FORMAT "->>,>>>,>>9.99" '"' skip.
    PUT STREAM  filebill2ex "C;Y" string(n_row1)  ";X18;K"   '"' billing.nor_netprm + billing.comp_netprm FORMAT "->>,>>>,>>9.99" '"' skip.
    PUT STREAM  filebill2ex "C;Y" string(n_row1)  ";X19;K"   '"' billing.ben '"' skip.
    PUT STREAM  filebill2ex "C;Y" string(n_row1)  ";X20;K"   '"' nv_notiof  '"' skip.
    PUT STREAM  filebill2ex "C;Y" string(n_row1)  ";X21;K"   '"'  '"' skip.
    PUT STREAM  filebill2ex "C;Y" string(n_row1)  ";X22;K"   '"'billing.acno '"' skip.
    PUT STREAM  filebill2ex "C;Y" string(n_row1)  ";X23;K"   '"'billing.tlt_remark  '"' skip.
