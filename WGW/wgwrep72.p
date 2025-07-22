/*-----
Author: 
       Narin  06/10/10   <Assign A52-242> 
       Create text ลง file >>> filetran.fuw
   สรุปหลักการ Connect Database GW  และ Database local 
   1. DATABASE GW  ที่ CONNECT ได้ ให้ทำการ DISCONNECT ออก SIC_BRAN  กับ  BRSTAT
      และ ทำการ Conncet database : gw_safe  &  gw_stat
          sic_bran  
          brstat    --->  gw_stat
   2. DATABASE Local Connect ดังนี้ 
          bransafe --->  -ld  brsic_bran
          brstat   --->  -ld  brstat
-----*/
DEFINE INPUT-OUTPUT PARAMETER  nv_batchno   AS CHAR FORMAT "X(13)" INIT ""  NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER  nv_batcnt    AS INT  FORMAT "99"    INIT 0.
DEFINE INPUT-OUTPUT PARAMETER  nv_filename  AS CHAR FORMAT "X(50)" INIT ""  NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER  nv_output2   AS CHAR FORMAT "X(50)" INIT ""  NO-UNDO.
/* DEFINE INPUT-OUTPUT PARAMETER  nv_output1   AS CHAR FORMAT "X(50)" INIT ""  NO-UNDO. */

DEFINE STREAM ns1 .
DEFINE STREAM ns2 .
/* DEFINE STREAM ns4 . */

    ASSIGN
     nv_filename =  "C:\SIC_BRAN\TEMP\" + 
                    CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")) + ".FUW".

     nv_output2  =  "C:\SIC_BRAN\TEMP\" + 
                    CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")) + ".ERR".

/*      nv_output1  =  "C:\SIC_BRAN\TEMP\" +                                     */
/*                     CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")) + ".DUP". */

     OUTPUT STREAM ns1 TO value(nv_filename).
     OUTPUT STREAM ns2 TO value(nv_output2).
/*      OUTPUT STREAM ns4 TO value(nv_output1). */

       PUT STREAM ns1
           "Date transfer : " TODAY  FORMAT "99/99/9999"
           " Time : " STRING(TIME,"HH:MM:SS") SKIP.
       PUT STREAM ns1 FILL("-",80) FORMAT "X(80)" SKIP.

loop_uwm100:
FOR EACH brsic_bran.uwm100 USE-INDEX uwm10001 :    

FIND sic_bran.uwm100 WHERE 
     sic_bran.uwm100.policy = brsic_bran.uwm100.policy AND
     sic_bran.uwm100.endcnt = brsic_bran.uwm100.endcnt AND
     sic_bran.uwm100.rencnt = brsic_bran.uwm100.rencnt
NO-ERROR.
    
    IF AVAILABLE brsic_bran.uwm100 THEN DO:
      
          PUT STREAM ns1
                 brsic_bran.uwm100.policy
                 brsic_bran.uwm100.rencnt "/"
                 brsic_bran.uwm100.endcnt " "
                 brsic_bran.uwm100.trndat " "
                 brsic_bran.uwm100.usrid " Entdat " brsic_bran.uwm100.entdat " "
                 TODAY  FORMAT "99/99/9999" " "
                 STRING(TIME,"HH:MM:SS") " ".
          PUT STREAM ns1
              STRING(TIME,"HH:MM:SS") " "
              TRIM(TRIM(brsic_bran.uwm100.ntitle) + " " +
                   TRIM(brsic_bran.uwm100.name1)) FORMAT "x(60)" SKIP.
          NEXT loop_uwm100.
    END.
    ELSE DO:
          /**------- ERROR -------**/
          PUT STREAM ns2
                 brsic_bran.uwm100.policy
                 brsic_bran.uwm100.rencnt "/"
                 brsic_bran.uwm100.endcnt " "
                 brsic_bran.uwm100.trndat " "
                 brsic_bran.uwm100.usrid " Entdat " brsic_bran.uwm100.entdat " "
                 TODAY  FORMAT "99/99/9999" " "
                 STRING(TIME,"HH:MM:SS") " ".
          PUT STREAM ns2
              STRING(TIME,"HH:MM:SS") " "
              TRIM(TRIM(brsic_bran.uwm100.ntitle) + " " +
                   TRIM(brsic_bran.uwm100.name1)) FORMAT "x(60)" SKIP.
          NEXT loop_uwm100.
    END.
END.
 
OUTPUT STREAM ns1 CLOSE.
OUTPUT STREAM ns2 CLOSE.
/* OUTPUT STREAM ns4 CLOSE. */
