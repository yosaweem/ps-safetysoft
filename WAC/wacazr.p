/*   Post JV ==> Create AZR516 
   : For accode 6,1 dr+ cr-   [A59-0007] date 22/03/2016   */

DEF INPUT PARAMETER   n_amount     AS  DECI     FORMAT "->>,>>>,>>>,>>9.99".
DEF INPUT PARAMETER   n_branch     AS  CHAR     FORMAT "X(2)".
DEF INPUT PARAMETER   n_prgrp      AS  INT      FORMAT "9".
DEF INPUT PARAMETER   n_macc       AS  CHAR     FORMAT "X(16)".
DEF INPUT PARAMETER   n_sacc1      AS  CHAR     FORMAT "X(6)".
DEF INPUT PARAMETER   n_sacc2      AS  CHAR     FORMAT "X(6)".
DEF INPUT PARAMETER   n_date       AS  DATE     FORMAT "99/99/9999".
DEF INPUT PARAMETER   n_source     AS  CHAR     FORMAT "X(2)".
DEF VAR               n_amt        AS  DECI     FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR               n_dc         AS  LOGI.
IF  n_amount < 0  THEN 
   ASSIGN    n_amt  = (-1) * n_amount
             n_dc   = TRUE.
ELSE 
   ASSIGN    n_amt  = n_amount
             n_dc   = FALSE.
FIND  azr516 USE-INDEX azr51601 WHERE azr516.gldat    = n_date        AND
      azr516.branch  = n_branch   AND azr516.prgrp    = n_prgrp       AND
      azr516.macc    = n_macc     AND azr516.sacc1    = n_sacc1       AND
      azr516.sacc2   = n_sacc2    AND azr516.source   = n_source   NO-ERROR.
IF NOT AVAILABLE azr516  THEN DO:
   CREATE  azr516.
   ASSIGN
      azr516.gldat    = n_date
      azr516.branch   = n_branch
      azr516.prgrp    = n_prgrp
      azr516.macc     = n_macc
      azr516.sacc1    = n_sacc1
      azr516.sacc2    = n_sacc2
      azr516.source   = n_source
      azr516.drcr     = n_dc
      azr516.amount   = n_amt.
END.
ELSE DO:
   IF n_dc <> azr516.drcr  THEN DO:
      IF n_amt  >  azr516.amount    THEN
         ASSIGN   azr516.amount  = n_amt - azr516.amount
                  azr516.drcr    = n_dc.
      ELSE  azr516.amount  =  azr516.amount - n_amt.
   END.
   ELSE  azr516.amount  = azr516.amount + n_amt.
END.
DISP "Create JV...."  azr516.gldat
      azr516.branch   azr516.macc
      azr516.sacc1    azr516.sacc2    
      azr516.drcr     azr516.amount  WITH COLOR blue/withe NO-LABEL
      TITLE "Create JV..." WIDTH 60 FRAME amain VIEW-AS DIALOG-BOX.
   PAUSE 0.




