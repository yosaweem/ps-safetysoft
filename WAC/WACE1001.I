/***************************************
wace1001.i  -  DR & CR Matching  ใช้ใน wace1001.w - Debit Note & Credit Note Matching

CREATE  BY :  Kanchana C.        A46-0478  
    - assign  data  เข้า temp-table   เหมือน acm001
***************************************/

DO:
    ASSIGN
        {1}.policy   = {2}.policy
        {1}.recno    = {2}.recno
        {1}.trnty1    = {2}.trnty1
        {1}.trnty2    = {2}.trnty2
        {1}.docno  = {2}.docno
        {1}.baloc   = {2}.baloc
          
        {1}.prem    = {2}.prem
        {1}.comm  = {2}.comm
        {1}.stamp  = {2}.stamp
        {1}.tax        = {2}.tax
        {1}.fee       = {2}.fee
        {1}.netamt = {2}.netamt
        {1}.bal       = {2}.bal
          
          
        {1}.trndat     = {2}.trndat
        {1}.ref          = {2}.ref
        {1}.comdat  = {2}.comdat
        {1}.acno      = {2}.acno
        {1}.agent    = {2}.agent
          
        /**/
        {1}.curcod   = {2}.curcod
        {1}.branch   = {2}.branch
        {1}.netloc    = {2}.netloc
        {1}.poltyp    = {2}.poltyp

        {1}.branch  = {2}.branch
        {1}.vehreg  = {2}.vehreg
        {1}.insno     = {2}.insno
        {1}.instot     = {2}.instot
        {1}.dociln    = {2}.dociln
        
        {1}.disput     = NO
      .

END.
