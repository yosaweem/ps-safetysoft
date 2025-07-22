/* WGWTB600.P */
/*
   Sombat Phu. : 26/04/2003
   Description : Transfer data from Brach to Branch
                 brsic_bran ->  sic_bran
                 brstat     ->  stat

   Modify  by  : sombat 04/03/1998
                 Transfer data path frame realay
                 change name host to sicuw
   Modify by   : Narin  15/09/2010    A52-0242  
   DEFINE INPUT-OUTPUT PARAMETER  sh_insref , nv_batchyr , nv_batchno , nv_batcnt
   ค่าดังกล่าวมาจากโปรแกรม Main wgw\wgwtrn72.w >>>> tm\tmcount.p  
   สรุปหลักการ Connect Database GW  และ Database local 
   1. DATABASE GW  ที่ CONNECT ได้ ให้ทำการ DISCONNECT ออก SIC_BRAN  กับ  BRSTAT
      และ ทำการ Conncet database : gw_safe  &  gw_stat
          sic_bran  --->  
          brstat    --->  gw_stat
   2. DATABASE Local Connect ดังนี้ 
          bransafe --->  -ld  brsic_bran
          brstat   --->  -ld  brstat
*/


/* DEF SHARED VAR sh_insref like sic_bran.uwm100.insref init "". /*sombat*/ */
DEFINE INPUT-OUTPUT PARAMETER  sh_insref    AS CHAR FORMAT "X(10)" INIT 0.
DEFINE INPUT-OUTPUT PARAMETER  nv_batchyr   AS INT  FORMAT "9999"  INIT 0.
DEFINE INPUT-OUTPUT PARAMETER  nv_batchno   AS CHAR FORMAT "X(13)" INIT ""  NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER  nv_batcnt    AS INT  FORMAT "99"    INIT 0.

DEF VAR nv_swith  AS LOGICAL   .
DEF VAR nv_add    AS LOGICAL   .

HIDE MESSAGE NO-PAUSE.

FIND brsic_bran.xmm600 WHERE 
     brsic_bran.xmm600.acno =  sh_insref 
NO-ERROR NO-WAIT.

IF AVAILABLE brsic_bran.xmm600 THEN DO:

  FIND sic_bran.xmm600 WHERE 
       sic_bran.xmm600.acno   = brsic_bran.xmm600.acno AND
       sic_bran.xmm600.bchyr  = nv_batchyr             AND
       sic_bran.xmm600.bchno  = nv_batchno             AND
       sic_bran.xmm600.bchcnt = nv_batcnt  

  NO-ERROR .
  IF NOT AVAILABLE sic_bran.xmm600 THEN DO:
    IF LOCKED sic_bran.xmm600 THEN RETURN.

    /*MESSAGE " Create file xmm600." brsic_bran.xmm600.acno. */

    CREATE sic_bran.xmm600.

    ASSIGN
      sic_bran.xmm600.gpstcs     = brsic_bran.xmm600.gpstcs
      sic_bran.xmm600.gpage      = brsic_bran.xmm600.gpage
      sic_bran.xmm600.gpstmt     = brsic_bran.xmm600.gpstmt
      sic_bran.xmm600.or1ref     = brsic_bran.xmm600.or1ref
      sic_bran.xmm600.or2ref     = brsic_bran.xmm600.or2ref
      sic_bran.xmm600.or1com     = brsic_bran.xmm600.or1com
      sic_bran.xmm600.or2com     = brsic_bran.xmm600.or2com
      sic_bran.xmm600.or1gn      = brsic_bran.xmm600.or1gn
      sic_bran.xmm600.or2gn      = brsic_bran.xmm600.or2gn
      sic_bran.xmm600.ntitle     = brsic_bran.xmm600.ntitle
      sic_bran.xmm600.fname      = brsic_bran.xmm600.fname
      sic_bran.xmm600.abname     = brsic_bran.xmm600.abname
      sic_bran.xmm600.addr1      = brsic_bran.xmm600.addr1
      sic_bran.xmm600.addr2      = brsic_bran.xmm600.addr2
      sic_bran.xmm600.addr3      = brsic_bran.xmm600.addr3
      sic_bran.xmm600.addr4      = brsic_bran.xmm600.addr4
      sic_bran.xmm600.postcd     = brsic_bran.xmm600.postcd
      sic_bran.xmm600.clicod     = brsic_bran.xmm600.clicod
      sic_bran.xmm600.acccod     = brsic_bran.xmm600.acccod
      sic_bran.xmm600.relate     = brsic_bran.xmm600.relate
      sic_bran.xmm600.notes1     = brsic_bran.xmm600.notes1
      sic_bran.xmm600.notes2     = brsic_bran.xmm600.notes2.

    ASSIGN
      sic_bran.xmm600.homebr     = brsic_bran.xmm600.homebr
      sic_bran.xmm600.opened     = brsic_bran.xmm600.opened
      sic_bran.xmm600.prindr     = brsic_bran.xmm600.prindr
      sic_bran.xmm600.langug     = brsic_bran.xmm600.langug
      sic_bran.xmm600.cshdat     = brsic_bran.xmm600.cshdat
      sic_bran.xmm600.legal      = brsic_bran.xmm600.legal
      sic_bran.xmm600.stattp     = brsic_bran.xmm600.stattp
      sic_bran.xmm600.autoap     = brsic_bran.xmm600.autoap
      sic_bran.xmm600.ltcurr     = brsic_bran.xmm600.ltcurr
      sic_bran.xmm600.ltamt      = brsic_bran.xmm600.ltamt
      sic_bran.xmm600.exec       = brsic_bran.xmm600.exec
      sic_bran.xmm600.cntry      = brsic_bran.xmm600.cntry
      sic_bran.xmm600.phone      = brsic_bran.xmm600.phone
      sic_bran.xmm600.closed     = brsic_bran.xmm600.closed
      sic_bran.xmm600.crper      = brsic_bran.xmm600.crper
      sic_bran.xmm600.pvfeq      = brsic_bran.xmm600.pvfeq
      sic_bran.xmm600.comtab     = brsic_bran.xmm600.comtab
      sic_bran.xmm600.chgpol     = brsic_bran.xmm600.chgpol
      sic_bran.xmm600.entdat     = brsic_bran.xmm600.entdat
      sic_bran.xmm600.enttim     = brsic_bran.xmm600.enttim
      sic_bran.xmm600.usrid      = brsic_bran.xmm600.usrid
      sic_bran.xmm600.regagt     = brsic_bran.xmm600.regagt
      sic_bran.xmm600.agtreg     = brsic_bran.xmm600.agtreg.

    ASSIGN
      sic_bran.xmm600.debtyn     = brsic_bran.xmm600.debtyn
      sic_bran.xmm600.crcon      = brsic_bran.xmm600.crcon
      sic_bran.xmm600.muldeb     = brsic_bran.xmm600.muldeb
      sic_bran.xmm600.styp20     = brsic_bran.xmm600.styp20
      sic_bran.xmm600.sval20     = brsic_bran.xmm600.sval20
      sic_bran.xmm600.dtyp20     = brsic_bran.xmm600.dtyp20
      sic_bran.xmm600.dval20     = brsic_bran.xmm600.dval20
      sic_bran.xmm600.iblack     = brsic_bran.xmm600.iblack
      sic_bran.xmm600.oldic      = brsic_bran.xmm600.oldic
      sic_bran.xmm600.cardno     = brsic_bran.xmm600.cardno
      sic_bran.xmm600.naddr1     = brsic_bran.xmm600.naddr1
      sic_bran.xmm600.naddr2     = brsic_bran.xmm600.naddr2
      sic_bran.xmm600.naddr3     = brsic_bran.xmm600.naddr3
      sic_bran.xmm600.naddr4     = brsic_bran.xmm600.naddr4
      sic_bran.xmm600.npostcd    = brsic_bran.xmm600.npostcd
      sic_bran.xmm600.nphone     = brsic_bran.xmm600.nphone
      sic_bran.xmm600.regdate    = brsic_bran.xmm600.regdate
      sic_bran.xmm600.taxno      = brsic_bran.xmm600.taxno
      sic_bran.xmm600.taxdate    = brsic_bran.xmm600.taxdate
      /* index */
      sic_bran.xmm600.icno       = brsic_bran.xmm600.icno
      sic_bran.xmm600.name       = brsic_bran.xmm600.name
      sic_bran.xmm600.acno       = brsic_bran.xmm600.acno

      sic_bran.xmm600.bchyr      = nv_batchyr    
      sic_bran.xmm600.bchno      = nv_batchno    
      sic_bran.xmm600.bchcnt     = nv_batcnt     .
    
    HIDE MESSAGE NO-PAUSE.
   
  END.
  ELSE DO:
     
    nv_swith = NO.

    IF sic_bran.xmm600.gpstcs  <> brsic_bran.xmm600.gpstcs  THEN nv_swith = YES.
    IF sic_bran.xmm600.gpage   <> brsic_bran.xmm600.gpage   THEN nv_swith = YES.
    IF sic_bran.xmm600.gpstmt  <> brsic_bran.xmm600.gpstmt  THEN nv_swith = YES.
    IF sic_bran.xmm600.or1ref  <> brsic_bran.xmm600.or1ref  THEN nv_swith = YES.
    IF sic_bran.xmm600.or2ref  <> brsic_bran.xmm600.or2ref  THEN nv_swith = YES.
    IF sic_bran.xmm600.or1com  <> brsic_bran.xmm600.or1com  THEN nv_swith = YES.
    IF sic_bran.xmm600.or2com  <> brsic_bran.xmm600.or2com  THEN nv_swith = YES.
    IF sic_bran.xmm600.or1gn   <> brsic_bran.xmm600.or1gn   THEN nv_swith = YES.
    IF sic_bran.xmm600.or2gn   <> brsic_bran.xmm600.or2gn   THEN nv_swith = YES.
    IF sic_bran.xmm600.ntitle  <> brsic_bran.xmm600.ntitle  THEN nv_swith = YES.
    IF sic_bran.xmm600.fname   <> brsic_bran.xmm600.fname   THEN nv_swith = YES.
    IF sic_bran.xmm600.abname  <> brsic_bran.xmm600.abname  THEN nv_swith = YES.
    IF sic_bran.xmm600.addr1   <> brsic_bran.xmm600.addr1   THEN nv_swith = YES.
    IF sic_bran.xmm600.addr2   <> brsic_bran.xmm600.addr2   THEN nv_swith = YES.
    IF sic_bran.xmm600.addr3   <> brsic_bran.xmm600.addr3   THEN nv_swith = YES.
    IF sic_bran.xmm600.addr4   <> brsic_bran.xmm600.addr4   THEN nv_swith = YES.
    IF sic_bran.xmm600.postcd  <> brsic_bran.xmm600.postcd  THEN nv_swith = YES.
    IF sic_bran.xmm600.clicod  <> brsic_bran.xmm600.clicod  THEN nv_swith = YES.
    IF sic_bran.xmm600.acccod  <> brsic_bran.xmm600.acccod  THEN nv_swith = YES.
    IF sic_bran.xmm600.relate  <> brsic_bran.xmm600.relate  THEN nv_swith = YES.
    IF sic_bran.xmm600.notes1  <> brsic_bran.xmm600.notes1  THEN nv_swith = YES.
    IF sic_bran.xmm600.notes2  <> brsic_bran.xmm600.notes2  THEN nv_swith = YES.

    IF sic_bran.xmm600.homebr  <> brsic_bran.xmm600.homebr  THEN nv_swith = YES.
    IF sic_bran.xmm600.opened  <> brsic_bran.xmm600.opened  THEN nv_swith = YES.
    IF sic_bran.xmm600.prindr  <> brsic_bran.xmm600.prindr  THEN nv_swith = YES.
    IF sic_bran.xmm600.langug  <> brsic_bran.xmm600.langug  THEN nv_swith = YES.
    IF sic_bran.xmm600.cshdat  <> brsic_bran.xmm600.cshdat  THEN nv_swith = YES.
    IF sic_bran.xmm600.legal   <> brsic_bran.xmm600.legal   THEN nv_swith = YES.
    IF sic_bran.xmm600.stattp  <> brsic_bran.xmm600.stattp  THEN nv_swith = YES.
    IF sic_bran.xmm600.autoap  <> brsic_bran.xmm600.autoap  THEN nv_swith = YES.
    IF sic_bran.xmm600.ltcurr  <> brsic_bran.xmm600.ltcurr  THEN nv_swith = YES.
    IF sic_bran.xmm600.ltamt   <> brsic_bran.xmm600.ltamt   THEN nv_swith = YES.
    IF sic_bran.xmm600.exec    <> brsic_bran.xmm600.exec    THEN nv_swith = YES.
    IF sic_bran.xmm600.cntry   <> brsic_bran.xmm600.cntry   THEN nv_swith = YES.
    IF sic_bran.xmm600.phone   <> brsic_bran.xmm600.phone   THEN nv_swith = YES.
    IF sic_bran.xmm600.closed  <> brsic_bran.xmm600.closed  THEN nv_swith = YES.
    IF sic_bran.xmm600.crper   <> brsic_bran.xmm600.crper   THEN nv_swith = YES.
    IF sic_bran.xmm600.pvfeq   <> brsic_bran.xmm600.pvfeq   THEN nv_swith = YES.
    IF sic_bran.xmm600.comtab  <> brsic_bran.xmm600.comtab  THEN nv_swith = YES.
    IF sic_bran.xmm600.chgpol  <> brsic_bran.xmm600.chgpol  THEN nv_swith = YES.
    IF sic_bran.xmm600.entdat  <> brsic_bran.xmm600.entdat  THEN nv_swith = YES.
    IF sic_bran.xmm600.enttim  <> brsic_bran.xmm600.enttim  THEN nv_swith = YES.
    IF sic_bran.xmm600.usrid   <> brsic_bran.xmm600.usrid   THEN nv_swith = YES.
    IF sic_bran.xmm600.regagt  <> brsic_bran.xmm600.regagt  THEN nv_swith = YES.
    IF sic_bran.xmm600.agtreg  <> brsic_bran.xmm600.agtreg  THEN nv_swith = YES.

    IF sic_bran.xmm600.debtyn  <> brsic_bran.xmm600.debtyn  THEN nv_swith = YES.
    IF sic_bran.xmm600.crcon   <> brsic_bran.xmm600.crcon   THEN nv_swith = YES.
    IF sic_bran.xmm600.muldeb  <> brsic_bran.xmm600.muldeb  THEN nv_swith = YES.
    IF sic_bran.xmm600.styp20  <> brsic_bran.xmm600.styp20  THEN nv_swith = YES.
    IF sic_bran.xmm600.sval20  <> brsic_bran.xmm600.sval20  THEN nv_swith = YES.
    IF sic_bran.xmm600.dtyp20  <> brsic_bran.xmm600.dtyp20  THEN nv_swith = YES.
    IF sic_bran.xmm600.dval20  <> brsic_bran.xmm600.dval20  THEN nv_swith = YES.
    IF sic_bran.xmm600.iblack  <> brsic_bran.xmm600.iblack  THEN nv_swith = YES.
    IF sic_bran.xmm600.oldic   <> brsic_bran.xmm600.oldic   THEN nv_swith = YES.
    IF sic_bran.xmm600.cardno  <> brsic_bran.xmm600.cardno  THEN nv_swith = YES.
    IF sic_bran.xmm600.naddr1  <> brsic_bran.xmm600.naddr1  THEN nv_swith = YES.
    IF sic_bran.xmm600.naddr2  <> brsic_bran.xmm600.naddr2  THEN nv_swith = YES.
    IF sic_bran.xmm600.naddr3  <> brsic_bran.xmm600.naddr3  THEN nv_swith = YES.
    IF sic_bran.xmm600.naddr4  <> brsic_bran.xmm600.naddr4  THEN nv_swith = YES.
    IF sic_bran.xmm600.npostcd <> brsic_bran.xmm600.npostcd THEN nv_swith = YES.
    IF sic_bran.xmm600.nphone  <> brsic_bran.xmm600.nphone  THEN nv_swith = YES.
    IF sic_bran.xmm600.regdate <> brsic_bran.xmm600.regdate THEN nv_swith = YES.
    IF sic_bran.xmm600.taxno   <> brsic_bran.xmm600.taxno   THEN nv_swith = YES.
    IF sic_bran.xmm600.taxdate <> brsic_bran.xmm600.taxdate THEN nv_swith = YES.
    /* THEN nv_swith = YES. index  THEN nv_swith = YES. */
    IF sic_bran.xmm600.icno    <> brsic_bran.xmm600.icno    THEN nv_swith = YES.
    IF sic_bran.xmm600.name    <> brsic_bran.xmm600.name    THEN nv_swith = YES.
    IF sic_bran.xmm600.acno    <> brsic_bran.xmm600.acno    THEN nv_swith = YES.

 
    IF nv_swith THEN DO:
      nv_add = YES.
      MESSAGE " Update file xmm600." brsic_bran.xmm600.acno.

      ASSIGN
        sic_bran.xmm600.gpstcs   = brsic_bran.xmm600.gpstcs
        sic_bran.xmm600.gpage    = brsic_bran.xmm600.gpage
        sic_bran.xmm600.gpstmt   = brsic_bran.xmm600.gpstmt
        sic_bran.xmm600.or1ref   = brsic_bran.xmm600.or1ref
        sic_bran.xmm600.or2ref   = brsic_bran.xmm600.or2ref
        sic_bran.xmm600.or1com   = brsic_bran.xmm600.or1com
        sic_bran.xmm600.or2com   = brsic_bran.xmm600.or2com
        sic_bran.xmm600.or1gn    = brsic_bran.xmm600.or1gn
        sic_bran.xmm600.or2gn    = brsic_bran.xmm600.or2gn
        sic_bran.xmm600.ntitle   = brsic_bran.xmm600.ntitle
        sic_bran.xmm600.fname    = brsic_bran.xmm600.fname
        sic_bran.xmm600.abname   = brsic_bran.xmm600.abname
        sic_bran.xmm600.addr1    = brsic_bran.xmm600.addr1
        sic_bran.xmm600.addr2    = brsic_bran.xmm600.addr2
        sic_bran.xmm600.addr3    = brsic_bran.xmm600.addr3
        sic_bran.xmm600.addr4    = brsic_bran.xmm600.addr4
        sic_bran.xmm600.postcd   = brsic_bran.xmm600.postcd
        sic_bran.xmm600.clicod   = brsic_bran.xmm600.clicod
        sic_bran.xmm600.acccod   = brsic_bran.xmm600.acccod
        sic_bran.xmm600.relate   = brsic_bran.xmm600.relate
        sic_bran.xmm600.notes1   = brsic_bran.xmm600.notes1
        sic_bran.xmm600.notes2   = brsic_bran.xmm600.notes2.

      ASSIGN
        sic_bran.xmm600.homebr   = brsic_bran.xmm600.homebr
        sic_bran.xmm600.opened   = brsic_bran.xmm600.opened
        sic_bran.xmm600.prindr   = brsic_bran.xmm600.prindr
        sic_bran.xmm600.langug   = brsic_bran.xmm600.langug
        sic_bran.xmm600.cshdat   = brsic_bran.xmm600.cshdat
        sic_bran.xmm600.legal    = brsic_bran.xmm600.legal
        sic_bran.xmm600.stattp   = brsic_bran.xmm600.stattp
        sic_bran.xmm600.autoap   = brsic_bran.xmm600.autoap
        sic_bran.xmm600.ltcurr   = brsic_bran.xmm600.ltcurr
        sic_bran.xmm600.ltamt    = brsic_bran.xmm600.ltamt
        sic_bran.xmm600.exec     = brsic_bran.xmm600.exec
        sic_bran.xmm600.cntry    = brsic_bran.xmm600.cntry
        sic_bran.xmm600.phone    = brsic_bran.xmm600.phone
        sic_bran.xmm600.closed   = brsic_bran.xmm600.closed
        sic_bran.xmm600.crper    = brsic_bran.xmm600.crper
        sic_bran.xmm600.pvfeq    = brsic_bran.xmm600.pvfeq
        sic_bran.xmm600.comtab   = brsic_bran.xmm600.comtab
        sic_bran.xmm600.chgpol   = brsic_bran.xmm600.chgpol
        sic_bran.xmm600.entdat   = brsic_bran.xmm600.entdat
        sic_bran.xmm600.enttim   = brsic_bran.xmm600.enttim
        sic_bran.xmm600.usrid    = brsic_bran.xmm600.usrid
        sic_bran.xmm600.regagt   = brsic_bran.xmm600.regagt
        sic_bran.xmm600.agtreg   = brsic_bran.xmm600.agtreg.

      ASSIGN
        sic_bran.xmm600.debtyn   = brsic_bran.xmm600.debtyn
        sic_bran.xmm600.crcon    = brsic_bran.xmm600.crcon
        sic_bran.xmm600.muldeb   = brsic_bran.xmm600.muldeb
        sic_bran.xmm600.styp20   = brsic_bran.xmm600.styp20
        sic_bran.xmm600.sval20   = brsic_bran.xmm600.sval20
        sic_bran.xmm600.dtyp20   = brsic_bran.xmm600.dtyp20
        sic_bran.xmm600.dval20   = brsic_bran.xmm600.dval20
        sic_bran.xmm600.iblack   = brsic_bran.xmm600.iblack
        sic_bran.xmm600.oldic    = brsic_bran.xmm600.oldic
        sic_bran.xmm600.cardno   = brsic_bran.xmm600.cardno
        sic_bran.xmm600.naddr1   = brsic_bran.xmm600.naddr1
        sic_bran.xmm600.naddr2   = brsic_bran.xmm600.naddr2
        sic_bran.xmm600.naddr3   = brsic_bran.xmm600.naddr3
        sic_bran.xmm600.naddr4   = brsic_bran.xmm600.naddr4
        sic_bran.xmm600.npostcd  = brsic_bran.xmm600.npostcd
        sic_bran.xmm600.nphone   = brsic_bran.xmm600.nphone
        sic_bran.xmm600.regdate  = brsic_bran.xmm600.regdate
        sic_bran.xmm600.taxno    = brsic_bran.xmm600.taxno
        sic_bran.xmm600.taxdate  = brsic_bran.xmm600.taxdate
        /* index */
        sic_bran.xmm600.icno     = brsic_bran.xmm600.icno
        sic_bran.xmm600.name     = brsic_bran.xmm600.name
        sic_bran.xmm600.acno     = brsic_bran.xmm600.acno
          
        sic_bran.xmm600.bchyr    = nv_batchyr    
        sic_bran.xmm600.bchno    = nv_batchno    
        sic_bran.xmm600.bchcnt   = nv_batcnt  .
    END.
  END.
  
END.
HIDE MESSAGE NO-PAUSE.

FIND FIRST brsic_bran.xtm600 WHERE 
           brsic_bran.xtm600.acno = sh_insref
NO-ERROR.
IF AVAILABLE brsic_bran.xtm600 THEN DO:

  FIND FIRST sic_bran.xtm600 WHERE 
             sic_bran.xtm600.acno   = brsic_bran.xtm600.acno AND
             sic_bran.xtm600.bchyr  = nv_batchyr        AND
             sic_bran.xtm600.bchno  = nv_batchno        AND
             sic_bran.xtm600.bchcnt = nv_batcnt  
  NO-ERROR.
  IF NOT AVAILABLE sic_bran.xtm600 THEN DO:
    /*MESSAGE " Create file xtm600." brsic_bran.xtm600.acno. */

    CREATE sic_bran.xtm600.

    ASSIGN
      sic_bran.xtm600.abname  = brsic_bran.xtm600.abname
      sic_bran.xtm600.addr1   = brsic_bran.xtm600.addr1
      sic_bran.xtm600.addr2   = brsic_bran.xtm600.addr2
      sic_bran.xtm600.addr3   = brsic_bran.xtm600.addr3
      sic_bran.xtm600.addr4   = brsic_bran.xtm600.addr4
      sic_bran.xtm600.ntitle  = brsic_bran.xtm600.ntitle
      sic_bran.xtm600.fname   = brsic_bran.xtm600.fname
      sic_bran.xtm600.name    = brsic_bran.xtm600.name
      sic_bran.xtm600.acno    = brsic_bran.xtm600.acno
      sic_bran.xtm600.bchyr   = nv_batchyr        
      sic_bran.xtm600.bchno   = nv_batchno        
      sic_bran.xtm600.bchcnt  = nv_batcnt .
  END.
  ELSE DO:
    nv_swith = NO.
    IF sic_bran.xtm600.abname <> brsic_bran.xtm600.abname THEN nv_swith = YES.
    IF sic_bran.xtm600.addr1  <> brsic_bran.xtm600.addr1  THEN nv_swith = YES.
    IF sic_bran.xtm600.addr2  <> brsic_bran.xtm600.addr2  THEN nv_swith = YES.
    IF sic_bran.xtm600.addr3  <> brsic_bran.xtm600.addr3  THEN nv_swith = YES.
    IF sic_bran.xtm600.addr4  <> brsic_bran.xtm600.addr4  THEN nv_swith = YES.
    IF sic_bran.xtm600.ntitle <> brsic_bran.xtm600.ntitle THEN nv_swith = YES.
    IF sic_bran.xtm600.fname  <> brsic_bran.xtm600.fname  THEN nv_swith = YES.
    IF sic_bran.xtm600.name   <> brsic_bran.xtm600.name   THEN nv_swith = YES.
    IF sic_bran.xtm600.acno   <> brsic_bran.xtm600.acno   THEN nv_swith = YES.

    IF nv_swith THEN DO:
      nv_add = YES.
      MESSAGE " Update file xtm600." brsic_bran.xtm600.acno.

      ASSIGN
        sic_bran.xtm600.abname  = brsic_bran.xtm600.abname
        sic_bran.xtm600.addr1   = brsic_bran.xtm600.addr1
        sic_bran.xtm600.addr2   = brsic_bran.xtm600.addr2
        sic_bran.xtm600.addr3   = brsic_bran.xtm600.addr3
        sic_bran.xtm600.addr4   = brsic_bran.xtm600.addr4
        sic_bran.xtm600.ntitle  = brsic_bran.xtm600.ntitle
        sic_bran.xtm600.fname   = brsic_bran.xtm600.fname
        sic_bran.xtm600.name    = brsic_bran.xtm600.name
        sic_bran.xtm600.acno    = brsic_bran.xtm600.acno
        sic_bran.xtm600.bchyr   = nv_batchyr        
        sic_bran.xtm600.bchno   = nv_batchno        
        sic_bran.xtm600.bchcnt  = nv_batcnt   .
    END.
  END.

END.

HIDE MESSAGE NO-PAUSE.

/* END OF : WGWTB600.P */

