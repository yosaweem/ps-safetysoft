/* uwo10097.i Date:1992/09/30 BY */

    IF wacm002.{1} <> 0 THEN 
    DO:
     assign
       nt_cnt  = nt_cnt  + 1 
       nt_ac[nt_cnt] = xmm202.{2}
       nt_amt[nt_cnt] = wacm002.{1}.
    END.

/* End of uwo10097.i */



