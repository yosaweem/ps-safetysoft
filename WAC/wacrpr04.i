/************************************ 
    Create By    : Nattanicha N.      Assign No.  :   A57-0118   27/03/2014
    Program      : wacrpr04.i 
    Main program : wacprm.w                                      
    - count  record เพื่อแยกไฟล์  หากเกิน  65500  limit ของ excel
 ***************************************/ 
        
        
    /*--- DISPLAY DETAIL  ---*/
   IF nv_reccnt > 65500  THEN  DO:
      ASSIGN
          nv_next = nv_next + 1
          n_OutputFile = SUBSTRING(n_OutputFile,1,LENGTH(n_OutputFile) - 1 ) + STRING(nv_next)
          nv_reccnt = 0.

      OUTPUT TO VALUE (n_OutputFile ) NO-ECHO.
          RUN pdPageHeadDet.
      OUTPUT CLOSE.
END.  /* (nv_DetSum = "Detail")  OR (nv_DetSum = "All") */

nv_reccnt = nv_reccnt + 1 .

