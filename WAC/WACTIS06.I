/************   Program   **************/
/* wactis06.i   -   Detail  file  text   send to tisco  v70*/
/* Modify By : Kanchana C.             A46-0463    27/11/2003 */

/***************************************/

/*pppppp*/
        IF billing.nor_netprm + billing.comp_netprm = 0 THEN DO:
            OUTPUT STREAM filebill1 CLOSE.
            NEXT loop1.  /* เบี้ยเป็น 0 แต่ยังค้างค่า comm.  ==> bal <> 0*/
        END.

         /*if  billing.bal <> 0  THEN NEXT loop1.*/
        ASSIGN
         n_netloc = 0      y1 = 0         z1 = 0     sum = 0
         p_trnty    = ''      p_policy = ''.

         FOR EACH acd001 USE-INDEX acd00191 WHERE 
                             acd001.trnty1  = billing.trnty1      AND
                             acd001.docno = billing.docno  NO-LOCK.
                             
                  n_netloc =  n_netloc + acd001.netloc.
                  IF acd001.ctrty1 = 'y' THEN   y1 = -(acd001.netloc).
                  IF acd001.ctrty1 = 'z' THEN   z1 = -(acd001.netloc).
                  sum         = y1 + z1.                         
                  p_trnty    = billing.trnty1 + billing.trnty2.          
         END.      /*acd001*/            


         IF billing.bal - (y1 + z1) <= billing.whtax1 THEN DO:
              billing.error = "E".
            OUTPUT STREAM filebill1 CLOSE.
            NEXT loop1.
         END.    
/*pppp*/                                     
/*--------p*/
        ASSIGN
         n_veh = "" 
         n_veh = billing.vehreg.
         
         IF n_veh = "" THEN 
            n_veh1  = "".         /*new vehicle => red label */ 
         ELSE IF SUBSTR(billing.vehreg,1,1) <> '/' THEN 
             RUN pdveh.
          
         IF billing.engine <> "" THEN DO:
             nv_eng1 = billing.engine.
             RUN pdeng.
             ASSIGN
                engine = nv_char1
                nv_char1 = ''
                nv_eng1 = ''.
         END.         
         ELSE 
             engine = ''.
             
         if billing.chassis <> "" then do:
            nv_eng2 = billing.chassis.
            RUN pdchas.
            ASSIGN
                chas = nv_char2
                nv_char2 = ''
                nv_eng2 = ''.
         end.         
         else 
            chas = ''.      

        ASSIGN
            t_comdat = ""
            t_comdat = string(year(billing.start_date) , "9999") + 
                                   string(month(billing.start_date) , "99") + 
                                   string(day(billing.start_date) , "99") .
        ASSIGN
            t_asdat = ""
            t_asdat = string(year(billing.asdat) , "9999") + 
                             string(month(billing.asdat) , "99") + 
                             string(day(billing.asdat) , "99") .

        ASSIGN
            t_expdat = ""
            t_expdat = string(year(billing.expdat) , "9999") + 
                               string(month(billing.expdat) , "99") + 
                               string(day(billing.expdat) , "99") .

        ASSIGN
            t_today = ""
            t_today = string(year(TODAY) , "9999") + 
                             string(month(TODAY) , "99") + 
                             string(day(TODAY) , "99") .


        ASSIGN
             nv_infnam = ""
             nv_inlnam = ""
             nv_notiOf  = "".

             RUN pdName.


        PUT STREAM  filebill1            
            chas                          format 'x(25)'                   /*1.Chassis format tisco 1-25*/
            n_veh1                      format 'x(10)'                   /*2.License format tisco 26-35 */
            fill (" " , 10)               format 'x(10)'                   /*3.Reference format tisco 36-45*/
            t_today                                                              /*4.As of Date format 'yyyymmdd'   46-53*/ /*  t_asdat */
            "010"                                                                  /*5. company  code 54-56*/
            billing.title1               format 'x(30)'                   /*6. Title 57-86*/
            nv_infnam                 format 'x(50)'                   /*7.Fname 87-136*/
            nv_inlnam                  format 'x(50)'                   /*8.Lname 137-186*/
            billing.nor_policy     FORMAT 'X(25)'                  /*9. 187-211  billing.policy             format 'x(25)' */                             
            t_comdat                   FORMAT "99999999"    /* 10.Effective Date format 'yyyymmmddd'  212-219 */
            t_expdat           FORMAT "99999999"     /*11.Expire Date  format 'yyyymmmddd' 220-227*/
            billing.model               format 'x(30)'                   /*12.Make-model 228-257*/
            billing.vehreg           format 'x(10)'                   /*13 License format safety 258-267*/
            billing.chassis          format 'x(25)'                   /*14. Chassis format safety 268-292*/
            billing.engine            format 'x(25)'                   /*15.Engine format  safety 293-317*/
            fuDeciToChar(billing.nor_covamt  + billing.comp_covamt,11)   FORMAT "X(11)"  /*16. sum insure format 8,2 318-328 */
            fuDeciToChar(billing.nor_grp + billing.comp_grp,11)         FORMAT "X(11)"   /*17. gross premium format 8,2 329-339*/
            fuDeciToChar(billing.nor_netprm + billing.comp_netprm,11)   FORMAT "X(11)"   /*18. net premium format 8,2 340-350*/
            billing.ben                 format 'x(50)'             /*19.beneficiary 351-400*/
            nv_notiof                    format 'x(30)'             /*20.notify officer 401-430*/
            fill (" " , 30)                format 'x(30)'                   /*21. insurance officer 431-460*/
            billing.acno               format 'x(10)'                   /*22.agent 461-470*/
            billing.tlt_remark       format 'x(25)'       /*23. remark 471-495*/        
            SKIP.
