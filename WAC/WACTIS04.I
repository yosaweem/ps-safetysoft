/************   Program   **************/
/* wactis04.i   -   Header  file Excel  v72*/
/* Modify By : Kanchana C.             A46-0463    27/11/2003 */
/***************************************/

/*     {wac\wactis04.i}      head excel  */

    PUT  STREAM  filebill2ex  "ID;PND"  SKIP.

/* 1. Header */
    PUT STREAM filebill2ex "C;Y1;X1;K" '"' "Text file to Tisco Leasing (v72)     Export Date : "  + STRING(TODAY,"99/99/9999") + "   As of Date : " + STRING(n_asdat,"99/99/9999")  FORMAT "X(100)" '"' skip.

    PUT STREAM filebill2ex "C;Y2;X1;K" '"' "chassis " '"' skip.
    PUT STREAM filebill2ex "C;Y2;X2;K" '"' "license"  '"' skip.
    PUT STREAM filebill2ex "C;Y2;X3;K" '"' "ref"    '"' skip.
    PUT STREAM filebill2ex "C;Y2;X4;K" '"' "Tran. date " '"' skip.  /* As of date*/
    PUT STREAM filebill2ex "C;Y2;X5;K" '"' "Company" '"' skip.
    PUT STREAM filebill2ex "C;Y2;X6;K" '"' "Title" '"' skip.
    PUT STREAM filebill2ex "C;Y2;X7;K" '"' "Fname " '"' skip.
    PUT STREAM filebill2ex "C;Y2;X8;K" '"' "Lname " '"' skip.
    PUT STREAM filebill2ex "C;Y2;X9;K" '"' "Policy No. " '"' skip.
    PUT STREAM filebill2ex "C;Y2;X10;K" '"' "Effective Date " '"' skip.
    PUT STREAM filebill2ex "C;Y2;X11;K" '"' "Expiry Date " '"' skip.
    PUT STREAM filebill2ex "C;Y2;X12;K" '"' "Make/Model " '"' skip.
    PUT STREAM filebill2ex "C;Y2;X13;K" '"' "License " '"' skip.
    PUT STREAM filebill2ex "C;Y2;X14;K" '"' "Chassis " '"' skip.
    PUT STREAM filebill2ex "C;Y2;X15;K" '"' "Engine " '"' skip.
    PUT STREAM filebill2ex "C;Y2;X16;K" '"' "Sum Insure " '"' skip.
    PUT STREAM filebill2ex "C;Y2;X17;K" '"' "Gross Prem " '"' skip.
    PUT STREAM filebill2ex "C;Y2;X18;K" '"' "Net Prem " '"' skip.
    PUT STREAM filebill2ex "C;Y2;X19;K" '"' "Beneficiary " '"' skip.
    PUT STREAM filebill2ex "C;Y2;X20;K" '"' "Notify Officer " '"' skip.
    PUT STREAM filebill2ex "C;Y2;X21;K" '"' "Agent Code " '"' skip.
    PUT STREAM filebill2ex "C;Y2;X22;K" '"' "Remark " '"' skip.
    
    
/*p*/
