/*programid   : wgwtsgen.i                                                          */
/*programname : load text file tas to GW                                            */
/* Copyright  : Safety Insurance Public Company Limited 			                */
/*			    ����ѷ ��Сѹ������� �ӡѴ (��Ҫ�)				                    */
/*create by   : Kridtiya i. A52-0293   date . 14/11/2009             
                ��Ѻ������������ö����� text file tas to GW system               */ 
/*copy write  : wgwargen.i                                                          */
/*modify by   : Kridtiya i. A54-0112 ���ª�ͧ����¹ö �ҡ 10 �� 11 ��ѡ          */
/*modify by   : Kridtiya i. A56-0211 �����Ţ���ѵû�ЪҪ�                         */
/*modify by   : Kridtiya i. A57-0159 ����������Ѻ���� ��Фӹ�˹�Ҫ���             */
/*modify by   : Kridtiya i. A57-0260 ��������ùѺ�ӹǹ�����§ҹ������             */
/*modify by   : Kridtiya i. A57-0415 ����������ʴ������Ң�,�Ҥ�Ң�                */
/*modify by   : Kridtiya i. A58-0136 ������Ҵ�������                               */
DEFINE NEW SHARED WORKFILE wdetail2 NO-UNDO  
    FIELD id               AS CHAR FORMAT "x(5)"  INIT ""     /*�Ţ���㺤Ӣ�*/
    FIELD TASDay           AS CHAR FORMAT "x(2)"  INIT ""     /*�ѹ���㺤Ӣ�*/
    FIELD TASMonth         AS CHAR FORMAT "x(2)"  INIT ""     /*�Ţ����Ѻ��*/
    FIELD TASYear          AS CHAR FORMAT "x(4)"  INIT ""     /*�ѹ��������������ͧ*/
    FIELD policy           AS CHAR FORMAT "x(20)" INIT ""     /*�ѹ�������ش*/
    FIELD TASreceived      AS CHAR FORMAT "x(10)" INIT ""     /*���ʺ���ѷ��Сѹ���*/  
    FIELD InsCompany       AS CHAR FORMAT "x(5)"  INIT ""     /*������ö*/ 
    FIELD Insurancerefno   AS CHAR FORMAT "x(15)" INIT ""     /*��������â��*/
    FIELD receivedDay      AS CHAR FORMAT "x(2)"  INIT ""     /*��������໭*/
    FIELD receivedMonth    AS CHAR FORMAT "x(2)"  INIT ""     /*�ӹǹ�Թ�����*/
    FIELD receivedYear     AS CHAR FORMAT "x(4)"  INIT ""     /*����������������ͧ*/
    FIELD insnam           AS CHAR FORMAT "x(45)" INIT ""     /*��������Сѹ*/
    FIELD NAME2            AS CHAR FORMAT "x(40)" INIT ""     /*��������ë���*/
    FIELD ICNO             AS CHAR FORMAT "x(20)" INIT ""     /*�Ţ���ѵû�ЪҪ�*//*A56-0211*/
    /*FIELD address        AS CHAR FORMAT "x(20)" INIT ""     /*���ѹ�֡*/   /*A58-0136*/
    FIELD mu               AS CHAR FORMAT "x(10)" INIT ""     /*�ӹ�˹��*/    /*A58-0136*/
    FIELD soi              AS CHAR FORMAT "x(10)" INIT ""     /*�����١���*/  /*A58-0136*/
    FIELD road             AS CHAR FORMAT "x(20)" INIT ""     /*���͡�ҧ*/    /*A58-0136*/
    FIELD tambon           AS CHAR FORMAT "x(20)" INIT ""     /*���ʡ��*/     /*A58-0136*/
    FIELD amper            AS CHAR FORMAT "x(20)" INIT ""     /*�������*/     /*A58-0136*/
    FIELD country          AS CHAR FORMAT "x(20)" INIT ""     /*���*/*/       /*A58-0136*/
    FIELD address          AS CHAR FORMAT "x(150)" INIT ""    /*���ѹ�֡*/   /*A58-0136*/ 
    FIELD mu               AS CHAR FORMAT "x(100)" INIT ""    /*�ӹ�˹��*/    /*A58-0136*/ 
    FIELD soi              AS CHAR FORMAT "x(100)" INIT ""    /*�����١���*/  /*A58-0136*/ 
    FIELD road             AS CHAR FORMAT "x(100)" INIT ""    /*���͡�ҧ*/    /*A58-0136*/ 
    FIELD tambon           AS CHAR FORMAT "x(100)" INIT ""    /*���ʡ��*/     /*A58-0136*/ 
    FIELD amper            AS CHAR FORMAT "x(100)" INIT ""    /*�������*/     /*A58-0136*/ 
    FIELD country          AS CHAR FORMAT "x(50)"  INIT ""    /*���*/         /*A58-0136*/ 
    FIELD post             AS CHAR FORMAT "x(10)" INIT ""     /*�Ӻ�*/         
    FIELD tel              AS CHAR FORMAT "x(15)" INIT ""     /*�����*/
    FIELD model            AS CHAR FORMAT "x(30)" INIT ""     /*�ѧ��Ѵ*/
    FIELD vehuse           AS CHAR FORMAT "x(15)" INIT ""     /*������ɳ���*/
    FIELD coulor           AS CHAR FORMAT "x(10)" INIT ""     /*�Ҫվ*/
    FIELD cc               AS CHAR FORMAT "x(10)" INIT ""     /*�ѹ�Դ*/
    FIELD engno            AS CHAR FORMAT "x(25)" INIT ""     /*�Ţ���ѵû�ЪҪ�*/
    FIELD chasno           AS CHAR FORMAT "x(25)" INIT ""     /*�Ţ���㺢Ѻ���*/
    FIELD nameinsur        AS CHAR FORMAT "x(10)" INIT ""     /*������ö*/
    FIELD comday           AS CHAR FORMAT "x(2)"  INIT ""     /*�����ö¹��*/
    FIELD commonth         AS CHAR FORMAT "x(2)"  INIT ""     /*�����Ţ��Ƕѧ*/
    FIELD comyear          AS CHAR FORMAT "x(4)"  INIT ""     /*�����Ţ����ͧ*/
    FIELD si               AS CHAR FORMAT "x(15)" INIT ""     /*�������ö*/
    FIELD stk              AS CHAR FORMAT "x(25)" INIT ""     /*���ͻ�����ö*/
    FIELD deler            AS CHAR FORMAT "x(40)" INIT ""     /*Ẻ��Ƕѧ*/
    FIELD delerco          AS CHAR FORMAT "x(10)" INIT ""     
    FIELD showroom         AS CHAR FORMAT "x(20)" INIT ""     /*���ʻ�����ö*/
    FIELD typepay          AS CHAR FORMAT "x(20)" INIT ""     /*�����ѡɳС����ҹ*/
    FIELD financename      AS CHAR FORMAT "x(20)" INIT ""     /*�ӹǹ�����*/
    FIELD requresname      AS CHAR FORMAT "x(20)" INIT ""     /*����ҵá�к͡�ٺ*/
    FIELD requresname2     AS CHAR FORMAT "x(20)" INIT ""     /*������ö*/
    FIELD telreq           AS CHAR FORMAT "x(20)" INIT ""     /*�Ţ����¹ö*/
    FIELD staus            AS CHAR FORMAT "x(10)" INIT ""     /*�ѧ��Ѵ��訴����¹*/
    FIELD REMARK1          AS CHAR FORMAT "x(10)" INIT ""     /*�շ�訴����¹*/
    FIELD CHECK1           AS CHAR FORMAT "x(10)" INIT ""     /*�����˵�*/
    FIELD COUNT1           AS CHAR FORMAT "x(10)" INIT ""     /*ǧ�Թ�ع��Сѹ*/
    FIELD financename2     AS CHAR FORMAT "x(10)" INIT ""     /*�����˵�*/
    FIELD branch           AS CHAR FORMAT "x(10)" INIT ""     /*ǧ�Թ�ع��Сѹ*/
    FIELD baseprm          AS CHAR FORMAT "x(10)" INIT "" 
    FIELD dealer_name2     AS CHAR FORMAT "x(60)" INIT ""     /*�����˵�*/ .
DEFINE NEW SHARED TEMP-TABLE wdetail
      FIELD cedpol      AS CHAR FORMAT "x(20)" INIT "" 
      FIELD branch      AS CHAR FORMAT "x(10)" INIT "" 
      FIELD entdat      AS CHAR FORMAT "x(10)" INIT ""     /*entry date*/
      FIELD enttim      AS CHAR FORMAT "x(8)"  INIT ""     /*entry time*/
      FIELD trandat     AS CHAR FORMAT "x(10)" INIT ""     /*tran date*/
      FIELD trantim     AS CHAR FORMAT "x(8)"  INIT ""     /*tran time*/
      FIELD poltyp      AS CHAR FORMAT "x(3)"  INIT ""     /*policy type*/
      FIELD policy      AS CHAR FORMAT "x(20)" INIT ""     /*policy*/       /*a40166 chg format from 12 to 16*/
      FIELD renpol      AS CHAR FORMAT "x(16)" INIT ""     /*renew policy*/ /*a40166 chg format from 12 to 16*/
      FIELD comdat      AS CHAR FORMAT "x(10)" INIT ""     /*comm date*/
      FIELD expdat      AS CHAR FORMAT "x(10)" INIT ""     /*expiry date*/
      FIELD compul      AS CHAR FORMAT "x"     INIT ""     /*compulsory*/
      FIELD tiname      AS CHAR FORMAT "x(15)" INIT ""     /*title*/
      FIELD insnam      AS CHAR FORMAT "x(50)" INIT ""     /*name*/
      FIELD name2       AS CHAR FORMAT "x(60)" INIT ""     /*name*/
      FIELD iadd1       AS CHAR FORMAT "x(35)" INIT ""     
      FIELD iadd2       AS CHAR FORMAT "x(35)" INIT ""     
      /*FIELD iadd3       AS CHAR FORMAT "x(34)" INIT ""  *//*A58-0136*/
      FIELD iadd3       AS CHAR FORMAT "x(35)" INIT ""      /*A58-0136*/
      FIELD iadd4       AS CHAR FORMAT "x(20)" INIT ""     
      FIELD prempa      AS CHAR FORMAT "x"     INIT ""     /*premium package*/
      FIELD subclass    AS CHAR FORMAT "x(3)"  INIT ""     /*sub class*/
      FIELD brand       AS CHAR FORMAT "x(30)" INIT ""
      FIELD model       AS CHAR FORMAT "x(50)" INIT ""
      FIELD cc          AS CHAR FORMAT "x(10)" INIT ""
      FIELD weight      AS CHAR FORMAT "x(10)" INIT ""
      FIELD seat        AS CHAR FORMAT "x(2)"  INIT ""
      FIELD body        AS CHAR FORMAT "x(20)" INIT ""
      /*FIELD vehreg      AS CHAR FORMAT "x(10)" INIT ""   /*vehicl registration*/*//*kridtiya i. A54-0112*/
      FIELD vehreg      AS CHAR FORMAT "x(11)" INIT ""     /*vehicl registration*//*kridtiya i. A54-0112*/
      FIELD engno       AS CHAR FORMAT "x(20)" INIT ""     /*engine no*/
      FIELD chasno      AS CHAR FORMAT "x(20)" INIT ""     /*chasis no*/
      FIELD caryear     AS CHAR FORMAT "x(4)"  INIT ""     
      FIELD carprovi    AS CHAR FORMAT "x(2)"  INIT ""     
      FIELD vehuse      AS CHAR FORMAT "x"     INIT ""     /*vehicle use*/
      FIELD garage      AS CHAR FORMAT "x"     INIT ""     
      FIELD stk         AS CHAR FORMAT "x(15)" INIT ""     /*--A51-0253---Amparat*/
      FIELD access      AS CHAR FORMAT "x"     INIT ""     /*accessories*/
      FIELD covcod      AS CHAR FORMAT "x"     INIT ""     /*cover type*/
      FIELD si          AS CHAR FORMAT "x(25)" INIT ""     /*sum insure*/
      FIELD volprem     AS CHAR FORMAT "x(20)" INIT ""     /*voluntory premium*/
      FIELD Compprem    AS CHAR FORMAT "x(20)" INIT ""     /*compulsory prem*/
      FIELD fleet       AS CHAR FORMAT "x(10)" INIT ""     /*fleet*/
      FIELD ncb         AS CHAR FORMAT "x(10)" INIT "" 
      FIELD revday      AS CHAR FORMAT "x(10)" INIT ""  
      FIELD finint      AS CHAR FORMAT "x(10)" INIT ""
     /* FIELD loadclm     AS CHAR FORMAT "x(10)" INIT "" */    /*load claim*/
      FIELD deductpp    AS CHAR FORMAT "x(10)" INIT "500000"   /*deduct da*/
      FIELD deductba    AS CHAR FORMAT "x(10)" INIT "10000000" /*deduct da*/
      FIELD deductpa    AS CHAR FORMAT "x(10)" INIT "1000000"  /*deduct pd*/
      FIELD benname     AS CHAR FORMAT "x(50)" INIT ""         /*benificiary*/
      FIELD n_user      AS CHAR FORMAT "x(10)" INIT ""         /*user id*/
      FIELD n_IMPORT    AS CHAR FORMAT "x(2)"  INIT ""      
      FIELD n_export    AS CHAR FORMAT "x(2)"  INIT ""      
      FIELD drivnam     AS CHAR FORMAT "x" INIT ""         
      FIELD drivnam1    AS CHAR FORMAT "x(50)" INIT ""     /*driver name1*/
      /*FIELD drivnam2    AS CHAR FORMAT "x(50)" INIT ""  */   /*driver name2*/
      FIELD drivbir1    AS CHAR FORMAT "X(10)" INIT ""     /*driver birth date*/
      /*FIELD drivbir2    AS CHAR FORMAT "X(10)" INIT ""     /*driver birth date*/*/
      /*FIELD drivage1    AS CHAR FORMAT "X(2)" INIT ""      /*driver age1*/*/
      /*FIELD drivage2    AS CHAR FORMAT "x(2)" INIT ""    /*driver age2*/*/
      FIELD cancel      AS CHAR FORMAT "x(2)" INIT ""      /*cancel*/
      FIELD WARNING     AS CHAR FORMAT "X(30)" INIT ""     
      FIELD comment     AS CHAR FORMAT "x(512)"  INIT ""   /*a490166 add format from 100 to 512*/
      FIELD seat41      AS INTE FORMAT "99" INIT 0         
      FIELD pass        AS CHAR FORMAT "x"  INIT "n"       
      FIELD OK_GEN      AS CHAR FORMAT "X" INIT "Y"        
      FIELD comper      AS CHAR INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"                  
      FIELD comacc      AS CHAR INIT "50000"    FORMAT ">,>>>,>>>,>>>,>>9"                  
      FIELD NO_41       AS CHAR INIT "50000"   FORMAT ">,>>>,>>>,>>>,>>9"                  
      FIELD NO_42       AS CHAR INIT "50000"   FORMAT ">,>>>,>>>,>>>,>>9"                   
      FIELD NO_43       AS CHAR INIT "200000"  FORMAT ">,>>>,>>>,>>>,>>9"                  
      FIELD tariff      AS CHAR FORMAT "x(2)" INIT ""      
      FIELD baseprem    AS INTE FORMAT ">,>>>,>>>,>>>,>>9" INIT  0
      FIELD cargrp      AS CHAR FORMAT "x(2)" INIT ""      
      FIELD producer    AS CHAR FORMAT "x(7)" INIT ""      
      FIELD agent       AS CHAR FORMAT "x(7)" INIT ""      
      FIELD inscod      AS CHAR INIT ""   
      FIELD premt       AS CHAR FORMAT "x(10)" INIT ""
      FIELD redbook     AS CHAR INIT "" FORMAT "X(8)"      /*note add*/
      FIELD base        AS CHAR INIT "" FORMAT "x(8)"      /*Note add Base Premium 25/09/2006*/
      FIELD accdat      AS CHAR INIT "" FORMAT "x(10)"     /*Account Date For 72*/
      FIELD docno       AS CHAR INIT "" FORMAT "x(10)"     /*Docno For 72*/
      FIELD ICNO        AS CHAR INIT "" FORMAT "x(13)"     /*ICNO For COVER NOTE A51-0071 amparat*/
      FIELD CoverNote   AS CHAR INIT "" FORMAT "x(13)"     /* �к�����繧ҹ COVER NOTE A51-0071 amparat*/
      FIELD nmember     AS CHAR INIT "" FORMAT "x(13)"
      FIELD delerco     AS CHAR FORMAT "x(10)" INIT "" 
      FIELD n_telreq    AS CHAR FORMAT "x(100)" INIT "" .    /*A57-0260*/
def    NEW SHARED VAR   nv_message as   char.
DEF VAR nv_riskgp        LIKE sicuw.uwm120.riskgp                                  NO-UNDO.

/***--- Note Add Condition Base Premium ---***/
DEFINE NEW SHARED VAR no_baseprm AS DECI  FORMAT ">>,>>>,>>9.99-". /*note add test Base Premium 25/09/2006*/
DEFINE NEW SHARED VAR NO_basemsg AS CHAR  FORMAT "x(50)" .         /*Warning Error If Not in Range 25/09/2006 */
DEFINE            VAR nv_accdat  AS DATE  FORMAT "99/99/9999" INIT ?  .     
DEFINE            VAR nv_docno   AS CHAR  FORMAT "9999999"    INIT " ".
/*a490166*/
DEFINE NEW SHARED VAR  nv_batchyr   AS INT FORMAT "9999"            INIT 0.
DEFINE NEW SHARED VAR  nv_batcnt    AS INT FORMAT "99"              INIT 0.
DEFINE NEW SHARED VAR  nv_batchno   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.

DEFINE VAR  nv_batrunno  AS INT FORMAT  ">,>>9"          INIT 0.
DEFINE VAR  nv_imppol    AS INT  FORMAT ">>,>>9"         INIT 0.
DEFINE VAR  nv_impprem   AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.

DEFINE VAR  nv_batprev   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_tmppolrun AS INTEGER FORMAT "999"         INIT 0. /*Temp Policy Running No.*/
DEFINE VAR  nv_batbrn    AS CHARACTER FORMAT "x(2)"      INIT ""  NO-UNDO. /*Batch Branch*/
DEFINE VAR  nv_tmppol    AS CHARACTER FORMAT "x(16)"     INIT "". /*Temp Policy*/

DEFINE VAR  nv_rectot    AS INT  FORMAT ">>,>>9"         INIT 0.  /* Display �ӹǹ �/� ������ */
DEFINE VAR  nv_recsuc    AS INT  FORMAT ">>,>>9"         INIT 0.  /* Display �ӹǹ �/� ��������� */
DEFINE VAR  nv_netprm_t  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.  /* Display ������� ������ */
DEFINE VAR  nv_netprm_s  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.  /* Display ������� ��������� */

DEFINE VAR  nv_batflg    AS LOG                          INIT NO.
DEFINE VAR  nv_txtmsg    AS CHAR FORMAT "x(50)"          INIT "".   /* Parameter ���Ѻ nv_check */
DEF    VAR  n_model      AS CHAR FORMAT "x(40)".
DEFINE VAR  n_titlenam   AS CHAR FORMAT "x(100)" .    /* kridtiya i. A57-0159*/
DEFINE VAR  n_name01     AS CHAR FORMAT "x(100)" .    /* kridtiya i. A57-0159*/
def var         nv_cnt   as  int  init 0.             /*A57-0260*/
DEFINE VARIABLE cvData      AS CHARACTER NO-UNDO.      /*A57-0260*/
DEFINE VARIABLE OKpressed   AS LOGICAL INITIAL TRUE.   /*A57-0260*/
DEF VAR         no_add      AS CHAR FORMAT "x(8)" .    /*A57-0260*/
DEF VAR         Branch_Name  AS CHAR FORMAT "x(30)"  INIT "" .  /*A57-0415*/
DEF VAR         Branch_Name2 AS CHAR FORMAT "x(30)"  INIT "" .  /*A57-0415*/
DEF VAR         nRegion      AS CHAR FORMAT "x(30)"  INIT "" .  /*A57-0415*/


