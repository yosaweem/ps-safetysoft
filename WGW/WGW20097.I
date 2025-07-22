
IF wkacm002.{1} <> 0 THEN DO:
     ASSIGN
        nt_cnt  = nt_cnt  + 1 
        nt_ac[nt_cnt] = xmm202.{2}
        nt_amt[nt_cnt] = wkacm002.{1}.
END.
