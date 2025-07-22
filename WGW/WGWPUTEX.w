&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------
File: 
Description: 
Input Parameters:
      <none>
Output Parameters:
      <none>
Author: 
Created: 
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/
CREATE WIDGET-POOL.
/* ***************************  Definitions  ************************** */
/* Parameters Definitions ---                                           */
/* Local Variable Definitions ---                                       */
/*Program name : Import Text file Tisco to excel file                   */
/*create by    : Kridtiya i. A53-0207                                   */
/*               �ŧ෤�����excel                                   */
/*Modify by    : kridtiya i. A54-0061 ��������Ѻ�����ŵ���ٻẺ����    */
/*Modify by    : kridtiya i. A54-0325 ��������Ѻ���ʵ��᷹�ҡ˹�Ҩ�    */
/*Modify By    : Kridtiya i. A55-0184 ��Ѻ��ǹ��÷ӧҹ����              */
/*Modify by    : Kridtiya i. A56-0323 ��������ŧ�������ʴ���������Ң�*/
/*Modify by    : Kridtiya i. A56-0399 ��Ѻ����ŧ�Ң�੾�� Tist...      */
/*Modify by    : Kridtiya i. A57-0017 date. 16/01/2014 add column seat  */
/*Modify by    : Kridtiya i. A57-0262 date. 01/08/2014 add data id,br_id*/
/*Modify by    : Ranu i. A59-0178 date. 17/05/2016 ���� field � Insurance Notification file �ӴѺ��� 64 - 83 */
/*Modify by    : Ranu i. A59-0618 date. 20/12/2016 ����¹�ŧ������ Producer  */
/*Modify By    : Ranu i. A60-0095 date 16/02/2017 ��Ѻ���͹䢡���� Producer code */
/*Modify By    : Ranu i. A60-0225 date 16/05/2017 Producer code mazda , CIR ,CIN*/
/*Modify by    : Ranu I. A61-0045 date 27/01/2018 ��� pack O ���֧����������ͧ������� */
/*Modify by    : Ranu I. A61-0313 date 28/06/2018 ����� Agent �ҹ������ ��� Producer code ��ʴ�ҵ������ */
/*Modify by    : Ranu I. A61-0410 date 20/09/2018 ����� Producer code ��ʴ�� */
/*Modify by    : Ranu I. A62-0386 date 28/08/2019 �Դ�����ҹ�� Mazda �ҹ����ᴧ �������鴧ҹ MPI ������� */
/*Modify by    : Sarinya C. A63-0210 date 26/05/2020 ����¹�ŧ�Layout�Text ������ field� ��ͷ��¨ҡ��� */
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 ������ʵ��᷹ ����Ѻ�ҹ������� */
/*Modify by   : Ranu I. A64-0092 ��� producer / Agent code ��䢧ҹ isuzu ����ᴧ�礻�ö ����ͧ����������*/
/*Modify by   : Ranu I. a64-0271 �������͹䢧ҹ Ford ������� */
/*Modify by   : Sarinya C. A64-0406 �Ѵ������ ͻ�.�ҡ��ͧ remark ��� 72Receipt Name  ������� �ػ�ó쵡�� */
/*Modify by   : Sarinya C. A64-0431 ����礢�����ö��÷ء ISUZU, HINO �������� B3MLTIS202/B3MLTIS200 */
/*Modify by   : Ranu I. A65-0035 ��䢡�ô֧�������ѹ��������ͧ�ͧ �ú.  */
/*Modify by   : Kridtiya i. A65-0361 Date. 03/12/2022 �������͹䢡�� ��������ʵ��᷹ */
/*Modify by   : Kridtiya i. A67-0036 add producer hyundai */
/*Modify by : Ranu I.A67-0087 ��������红�����ö俿�� */ 
/*Modify by : Ranu I. A67-0114 �������͹䢡���� Producer /Agent */
/*---------------------------------------------------------------------*/
DEF  stream ns1.
DEFINE VAR nv_daily       AS CHARACTER FORMAT "X(1024)" INITIAL ""  NO-UNDO.
DEFINE VAR nv_reccnt      AS INT       INIT  0.
DEFINE VAR nv_completecnt AS INT       INIT  0.
DEFINE VAR nv_enttim      AS CHAR      INIT  "".
DEFINE VAR nv_export      as date      init  ""  format "99/99/9999".
DEFINE stream  ns2.
/*--------------------------����Ѻ�����š�������  -------------------------*/
DEFINE  WORKFILE wdetail NO-UNDO
    FIELD RecordID    AS CHAR FORMAT "X(02)"   INIT ""   /*1  Detail Record "D"*/
    FIELD Pro_off     AS CHAR FORMAT "X(02)"   INIT ""   /*2  �����Ңҷ������һ�Сѹ�Դ�ѭ��    */
    FIELD cmr_code    AS CHAR FORMAT "X(03)"   INIT ""   /*3  �������˹�ҷ���õ�Ҵ    */
    FIELD comp_code   AS CHAR FORMAT "X(03)"   INIT ""   /*4  ���� �.��Сѹ���(TLT.COMMENT)   */
    FIELD Notify_no   AS CHAR FORMAT "X(25)"   INIT ""   /*5  �Ţ����Ѻ�駻�Сѹ   */
    FIELD yrmanu      AS CHAR FORMAT "X(4)"    INIT ""   /*6  Year of car  */
    /*FIELD engine      AS CHAR FORMAT "X(25)"   INIT ""   /*7  �����Ţ����ͧ¹��*/*//*A65-0356 */ 
    FIELD engine      AS CHAR FORMAT "X(35)"   INIT ""   /*7  �����Ţ����ͧ¹��*/    /*A65-0356 */ 
    FIELD chassis     AS CHAR FORMAT "X(25)"   INIT ""   /*8  �����Ţ��Ƕѧö*/
    FIELD weight      AS CHAR FORMAT "X(05)"   INIT ""   /*9  WEIGHT KG/TON*/
    FIELD Power       AS CHAR FORMAT "X(07)"   INIT ""   /*10 WEIGHT KG/TON*/
    /*FIELD colorcode   AS CHAR FORMAT "X(10)"   INIT ""   /*11 Color Code*/*/        /*A65-0356 */ 
    /*FIELD licence     AS CHAR FORMAT "X(10)"   INIT ""   /*12 �����Ţ����¹ö */*/ /*A65-0356 */ 
    FIELD colorcode   AS CHAR FORMAT "X(25)"   INIT ""   /*11 Color Code*/            /*A65-0356 */ 
    FIELD licence     AS CHAR FORMAT "X(20)"   INIT ""   /*12 �����Ţ����¹ö */     /*A65-0356 */ 
    FIELD garage      AS CHAR FORMAT "X(01)"   INIT ""   /*13 Claim condition /��ë��� */
    FIELD fleetper    AS CHAR FORMAT "X(05)"   INIT ""   /*14 Fleet Discount     */
    FIELD ncbper      AS CHAR FORMAT "X(05)"   INIT ""   /*15 Experience Discount /��ǹŴ����ѵԴ�  */
    FIELD othper      AS CHAR FORMAT "X(05)"   INIT ""   /*16 Other Discount /��ǹŴ��� �  */
    FIELD vehuse      AS CHAR FORMAT "X(01)"   INIT ""   /*17 �����ҹö */
    FIELD comdat      AS CHAR FORMAT "X(08)"   INIT ""   /*18 �ѹ�������������ͧ */
    FIELD ins_amt     AS CHAR FORMAT "X(11)"   INIT ""   /*19 �ع��Сѹ */
    FIELD name_insur  AS CHAR FORMAT "X(15)"   INIT ""   /*20 �������˹�ҷ���Сѹ */
    FIELD Not_office  AS CHAR FORMAT "X(75)"   INIT ""   /*21 �������˹�ҷ��駻�Сѹ(Tisco)  */
    FIELD Not_date    AS CHAR FORMAT "X(08)"   INIT ""   /*22 �ѹ����駻�Сѹ */
    FIELD Not_time    AS CHAR FORMAT "X(06)"   INIT ""   /*23 ���ҷ���駻�Сѹ */
    FIELD Not_code    AS CHAR FORMAT "X(04)"   INIT ""   /*24 �����駧ҹ �� TF01 */
    FIELD Prem1       AS CHAR FORMAT "X(11)"   INIT ""   /*25 ���»�Сѹ���(������».1 + ���� + �ҡ�) */
    FIELD comp_prm    AS CHAR FORMAT "X(09)"   INIT ""   /*26 ���¾ú.��� */
    FIELD sckno       AS CHAR FORMAT "X(25)"   INIT ""   /*27 �Ţ� � Sticker. */
    FIELD brand       AS CHAR FORMAT "X(50)"   INIT ""   /*28 ������ö */
    FIELD pol_addr1   AS CHAR FORMAT "X(100)"   INIT ""   /*29 �����������һ�Сѹ1  */
    FIELD pol_addr2   AS CHAR FORMAT "X(100)"   INIT ""   /*30 �����������һ�Сѹ2 ���������ɳ���*/
    FIELD pol_title   AS CHAR FORMAT "X(30)"   INIT ""   /*31 �ӹ�˹�Ҫ��ͼ����һ�Сѹ  */
    FIELD pol_fname   AS CHAR FORMAT "X(75)"   INIT ""   /*32 ���ͼ����һ�Сѹ/�ԵԺؤ�� */
    FIELD pol_Lname   AS CHAR FORMAT "X(45)"   INIT ""   /*33 ���ʡ�ż����һ�Сѹ  */
    FIELD Ben_name    AS CHAR FORMAT "X(65)"   INIT ""   /*34 ���ͼ���Ѻ����ª��  */
    FIELD Remark      AS CHAR FORMAT "X(150)"  INIT ""   /*35 �����˵�  */
    FIELD Account_no  AS CHAR FORMAT "X(10)"   INIT ""   /*36 �Ţ����ѭ�Ңͧ�����һ�Сѹ(Tisco)  */
    FIELD Client_no   AS CHAR FORMAT "X(07)"   INIT ""   /*37 ���ʢͧ�����һ�Сѹ  */
    FIELD expdat      AS CHAR FORMAT "X(08)"   INIT ""   /*38 �ѹ������ش����������ͧ */
    FIELD Gross_prm   AS CHAR FORMAT "X(11)"   INIT ""   /*39 ����.����ú. (������) */
    FIELD Province    AS CHAR FORMAT "X(18)"   INIT ""   /*40 �ѧ��Ѵ��訴����¹ö */
    FIELD Receipt_name AS CHAR FORMAT "X(50)"   INIT ""   /*41 ���ͷ����㹡�þ��������� */
    FIELD Agent       AS CHAR FORMAT "X(15)"   INIT ""   /*42 Code ����ѷ �� Tisco,Tisco-pf. */
    FIELD Prev_insur  AS CHAR FORMAT "X(50)"   INIT ""   /*43 ���ͺ���ѷ��Сѹ������ */
    FIELD Prev_pol    AS CHAR FORMAT "X(25)"   INIT ""   /*44 �Ţ������������� */
    FIELD deduct      AS CHAR FORMAT "X(09)"   INIT ""   /*45 �������������ǹ�á */
    /*Add kridtiya i. A54-0062 ...*/
    FIELD addr1_70     AS CHAR FORMAT "X(100)"  INIT ""    /*46*/ 
    FIELD addr2_70     AS CHAR FORMAT "X(100)"  INIT ""    /*47*/ 
    FIELD nsub_dist70  AS CHAR FORMAT "X(30)"  INIT ""    /*48*/ 
    FIELD ndirection70 AS CHAR FORMAT "X(30)"  INIT ""    /*49*/ 
    FIELD nprovin70    AS CHAR FORMAT "X(30)"  INIT ""    /*50*/ 
    FIELD zipcode70    AS CHAR FORMAT "X(5)"   INIT ""    /*51*/ 
    FIELD addr1_72     AS CHAR FORMAT "X(100)"  INIT ""    /*52*/ 
    FIELD addr2_72     AS CHAR FORMAT "X(100)"  INIT ""    /*53*/ 
    FIELD nsub_dist72  AS CHAR FORMAT "X(30)"  INIT ""    /*54*/ 
    FIELD ndirection72 AS CHAR FORMAT "X(30)"  INIT ""    /*55*/ 
    FIELD nprovin72    AS CHAR FORMAT "X(30)"  INIT ""    /*56*/ 
    FIELD zipcode72    AS CHAR FORMAT "X(5)"   INIT ""    /*57*/ 
    FIELD apptyp       AS CHAR FORMAT "X(10)"  INIT ""    /*58*/ 
    FIELD appcode      AS CHAR FORMAT "X(2)"   INIT ""    /*59*/ 
    FIELD nBLANK       AS CHAR FORMAT "X(9)"   INIT ""    /*60*/ 
    FIELD nproducer    AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD nagent       AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD n_covcod     AS CHAR FORMAT "x(3)"   INIT "" 
    FIELD n_branch     AS CHAR FORMAT "x(3)"   INIT "" 
    FIELD n_pack       AS CHAR FORMAT "x(4)"   INIT ""    /*A55-0184*/
    FIELD n_typpol     AS CHAR FORMAT "x(20)"  INIT ""    /*A55-0184*/
    FIELD n_seattisco  AS INT  FORMAT ">>>9"   INIT 0     /*A57-0017*/
    FIELD redbook      AS CHAR FORMAT "X(10)"  INIT ""    /*A57-0017*/
    FIELD price_ford   AS CHAR FORMAT "x(30)"  INIT ""    /*A57-0088*/
    FIELD id_recive70  AS CHAR FORMAT "x(13)"  INIT ""    /*��Ţ���ѵû�Шӵ�ǻ�ЪҪ�/�Ţ��˹ѧ����Թ�ҧ /�Ţ����¹�ҳԪ��*/
    FIELD br_recive70  AS CHAR FORMAT "x(20)"  INIT ""    /*�ҢҢͧʶҹ��Сͺ����١���*/
    FIELD id_recive72  AS CHAR FORMAT "x(13)"  INIT ""    /*��Ţ���ѵû�Шӵ�ǻ�ЪҪ�/�Ţ��˹ѧ����Թ�ҧ /�Ţ����¹�ҳԪ��*/
    FIELD br_recive72  AS CHAR FORMAT "x(20)"  INIT ""   /*�ҢҢͧʶҹ��Сͺ����١���*/
    /*--- A59-0178------*/
    FIELD comp_comdat   AS CHAR FORMAT "X(8)"  INIT ""     /*Effective Date Accidential*/           
    FIELD comp_expdat   AS CHAR FORMAT "X(8)"  INIT ""     /*Expiry Date Accidential*/              
    FIELD fi            AS CHAR FORMAT "X(11)" INIT ""     /*Coverage Amount Theft*/                
    FIELD class         AS CHAR FORMAT "X(3)"  INIT ""     /*Car code*/                             
    FIELD usedtype      AS CHAR FORMAT "x(1)"  INIT ""     /*Per Used*/                             
    FIELD driveno1      AS CHAR FORMAT "x(2)"  INIT ""     /*Driver Seq1*/                          
    FIELD drivename1    AS CHAR FORMAT "x(40)" INIT ""     /*Driver Name1*/                         
    FIELD bdatedriv1    AS CHAR FORMAT "x(8)"  INIT ""     /*Birthdate Driver1*/                    
    FIELD occupdriv1    AS CHAR FORMAT "x(75)" INIT ""     /*Occupation Driver1*/                   
    FIELD positdriv1    AS CHAR FORMAT "X(40)" INIT ""     /*Position Driver1 */                    
    FIELD driveno2      AS CHAR FORMAT "x(2)"  INIT ""     /*Driver Seq2*/                          
    FIELD drivename2    AS CHAR FORMAT "x(40)" INIT ""     /*Driver Name2*/                         
    FIELD bdatedriv2    AS CHAR FORMAT "x(8)"  INIT ""     /*Birthdate Driver2*/                    
    FIELD occupdriv2    AS CHAR FORMAT "x(75)" INIT ""     /*Occupation Driver2*/                   
    FIELD positdriv2    AS CHAR FORMAT "X(40)" INIT ""     /*Position Driver2*/                     
    FIELD driveno3      AS CHAR FORMAT "x(2)"  INIT ""     /*Driver Seq3*/                          
    FIELD drivename3    AS CHAR FORMAT "x(40)" INIT ""     /*Driver Name3*/                         
    FIELD bdatedriv3    AS CHAR FORMAT "x(8)"  INIT ""     /*Birthdate Driver3*/                    
    FIELD occupdriv3    AS CHAR FORMAT "x(75)" INIT ""     /*Occupation Driver3*/                   
    FIELD positdriv3    AS CHAR FORMAT "X(40)" INIT ""     /*Position Driver3*/ 
    FIELD bi            AS CHAR FORMAT "X(20)" INIT ""    /*A60-0095*/
    FIELD pa            AS CHAR FORMAT "X(20)" INIT ""    /*A60-0095*/
    FIELD pd            AS CHAR FORMAT "x(20)" INIT ""    /*A60-0095*/
    FIELD n_class       AS CHAR FORMAT "x(5)"  INIT ""    /*A60-0095*/
    /*FIELD caracc        AS CHAR FORMAT "x(250)" INIT ""  /*A65-0356*/*/
    FIELD caracc     AS CHAR FORMAT "x(1750)" INIT ""   /*A65-0356 */ 
    FIELD Rec_name72 AS CHAR FORMAT "x(150)"  INIT ""   /*A65-0356 */ 
    FIELD Rec_add1   AS CHAR FORMAT "x(60)"   INIT ""   /*A65-0356 */ 
    FIELD Rec_add2   AS CHAR FORMAT "x(60)"   INIT ""   /*A65-0356 */ 
    FIELD polold     AS CHAR FORMAT "x(12)"   INIT ""   /*A65-0356 */ 
    FIELD acctyp     AS CHAR FORMAT "x(1)"    INIT ""   /*A65-0356 */ 
    FIELD acccovins  AS CHAR FORMAT "x(11)"   INIT ""   /*A65-0356 */ 
    FIELD accpremt   AS CHAR FORMAT "x(11)"   INIT ""   /*A65-0356 */ 
    FIELD inspecttyp AS CHAR FORMAT "x(1)"    INIT ""   /*A65-0356 */ 
    FIELD quotation  AS CHAR FORMAT "x(20)"   INIT ""   /*A65-0356 */
    FIELD covcodtype AS CHAR FORMAT "x(20)"   INIT ""   /*A65-0356 */
    /* A67-0087 */
    FIELD Schanel    AS Char FORMAT "X(1)"   init "" 
    FIELD bev        AS Char FORMAT "X(1)"   init "" 
    FIELD driveno4   AS CHAR FORMAT "x(2)"   INIT "" 
    FIELD drivename4 AS Char FORMAT "X(40)"  init "" 
    FIELD bdatedriv4 AS CHAR FORMAT "x(8)"   INIT "" 
    FIELD occupdriv4 AS Char FORMAT "X(75)"  init "" 
    FIELD positdriv4 AS Char FORMAT "X(40)"  init "" 
    FIELD driveno5   AS CHAR FORMAT "x(2)"   INIT ""  
    FIELD drivename5 AS Char FORMAT "X(40)"  init "" 
    FIELD bdatedriv5 AS CHAR FORMAT "x(8)"   INIT "" 
    FIELD occupdriv5 AS Char FORMAT "X(75)"  init "" 
    FIELD positdriv5 AS Char FORMAT "X(40)"  init "" 
    FIELD campagin   AS Char FORMAT "X(20)"  init "" 
    FIELD inspic     AS Char FORMAT "X(1)"   init "" 
    FIELD engcount   AS Char FORMAT "X(2)"   init "" 
    FIELD engno2     AS Char FORMAT "X(35)"  init "" 
    FIELD engno3     AS Char FORMAT "X(35)"  init "" 
    FIELD engno4     AS Char FORMAT "X(35)"  init "" 
    FIELD engno5     AS Char FORMAT "X(35)"  init "" 
    FIELD classcomp  AS Char FORMAT "X(5)"   init ""  
    FIELD carbrand   AS CHAR FORMAT "X(50)"  INIT "" .
   /* end : A67-0087 */
   /*end..Add kridtiya i. A54-0062 ...*/
/*------------------------------�����ż��Ѻ��� -------------------------*/
DEFINE WORKFILE  wdriver NO-UNDO                             
    FIELD RecordID      AS CHAR FORMAT "X(02)"   INIT ""     /*1 Detail Record "D"*/
    FIELD Pro_off       AS CHAR FORMAT "X(02)"   INIT ""     /*2 �����Ңҷ������һ�Сѹ�Դ�ѭ��    */
    FIELD chassis       AS CHAR FORMAT "X(25)"   INIT ""     /*3 �����Ţ��Ƕѧ    */
    FIELD dri_no        AS CHAR FORMAT "X(02)"   INIT ""     /*4 �ӴѺ��褹�Ѻ  */
    FIELD dri_name      AS CHAR FORMAT "X(40)"   INIT ""     /*5 ���ͤ��Ѻ   */
    FIELD Birthdate     AS CHAR FORMAT "X(8)"    INIT ""     /*6 �ѹ��͹���Դ  */
    FIELD occupn        AS CHAR FORMAT "X(75)"   INIT ""     /*7 �Ҫվ*/
    FIELD position      AS CHAR FORMAT "X(40)"   INIT ""  .  /*8 ���˹觧ҹ */
DEF VAR nv_accdat   AS DATE      FORMAT "99/99/9999"    NO-UNDO.
DEF VAR nv_comdat   AS DATE      FORMAT "99/99/9999"    NO-UNDO.
DEF VAR nv_expdat   AS DATE      FORMAT "99/99/9999"    NO-UNDO.
DEF VAR nv_notdat   AS DATE      FORMAT "99/99/9999"    NO-UNDO.
DEF VAR nv_nottim   AS CHAR      FORMAT  "X(8)"         no-undo.
DEF VAR nv_comchr   AS CHAR      .                       
DEF VAR nv_dd       AS INT       FORMAT "99".           
DEF VAR nv_mm       AS INT       FORMAT "99".           
DEF VAR nv_yy       AS INT       FORMAT "9999".
DEF VAR nv_cpamt1   AS DECI      INIT 0.
DEF VAR nv_cpamt2   AS DECI      INIT 0.
DEF VAR nv_cpamt3   AS DECI      INIT 0.
DEF VAR nv_coamt1   AS DECI      INIT 0.
DEF VAR nv_coamt2   AS DECI      INIT 0.
DEF VAR nv_coamt3   AS DECI      INIT 0.
DEF VAR nv_insamt1  AS DECI      INIT 0.
DEF VAR nv_insamt2  AS DECI      INIT 0.
DEF VAR nv_insamt3  AS DECI      INIT 0   format ">>>,>>>,>>9.99".
DEF VAR nv_premt1   AS DECI      INIT 0.  
DEF VAR nv_premt2   AS DECI      INIT 0.  
DEF VAR nv_premt3   AS DECI      INIT 0.  
DEF VAR nv_fleet1   AS DECI      INIT 0.  
DEF VAR nv_fleet2   AS DECI      INIT 0.  
DEF VAR nv_fleet3   AS DECI      INIT 0   Format ">>9.99".
DEF VAR nv_ncb1     AS DECI      INIT 0.  
DEF VAR nv_ncb2     AS DECI      INIT 0.  
DEF VAR nv_ncb3     AS DECI      INIT 0   Format ">>9.99".
DEF VAR nv_oth1     AS DECI      INIT 0.  
DEF VAR nv_oth2     AS DECI      INIT 0.  
DEF VAR nv_oth3     AS DECI      INIT 0   Format ">>9.99".
DEF VAR nv_deduct1  AS DECI      INIT 0.  
DEF VAR nv_deduct2  AS DECI      INIT 0.  
DEF VAR nv_deduct3  AS DECI      INIT 0   Format "->>,>>9.99".
DEF VAR nv_power1   AS DECI      INIT 0.  
DEF VAR nv_power2   AS DECI      INIT 0.  
DEF VAR nv_power3   AS DECI      INIT 0   Format ">,>>9.99".
DEF VAR nv_name1    AS CHAR      INIT ""  Format "X(50)".
DEF VAR nv_ntitle   AS CHAR      INIT ""  Format  "X(10)". 
DEF VAR nv_titleno  AS INT       INIT 0   . 
DEF VAR nv_policy   AS CHAR      INIT ""  Format  "X(12)".
DEF VAR nv_oldpol   AS CHAR      INIT "".
DEF VAR nv_source   AS CHAR      FORMAT  "X(35)".
DEF VAR nv_indexno  AS INTE INIT  0.
DEF VAR nv_indexno1 AS INTE INIT  0.
DEF VAR nv_cnt      AS INTE INIT  1.
DEF VAR nv_addr     AS CHAR EXTENT 4  FORMAT "X(35)".
DEF VAR nv_pol      AS CHAR INIT   "".
DEF VAR nv_row      AS INTE INIT   0.
DEF VAR n_typpol    AS CHAR FORMAT "x(20)" INIT   "".
DEF VAR n_prepol    AS CHAR FORMAT "x(20)" INIT   "".
DEF VAR n_brand     AS CHAR FORMAT "x(30)" INIT   "".
DEF VAR n_model     AS CHAR FORMAT "x(50)" INIT   "".
DEF VAR n_classpack AS CHARACTER FORMAT "X(3)"  INITIAL "".
DEFINE  WORKFILE wcomp NO-UNDO
    FIELD cartyp   AS CHARACTER FORMAT "X(10)" INITIAL ""
    FIELD brand    AS CHARACTER FORMAT "X(20)" INITIAL ""
    FIELD package  AS CHARACTER FORMAT "X(1)"  INITIAL ""
    FIELD branch   AS CHARACTER FORMAT "X(2)"  INITIAL ""
     /*A60-0095*/
    FIELD cover    AS CHAR  FORMAT "x(3)" INIT ""   
    FIELD BI       AS CHAR  FORMAT "X(15)" INIT ""  
    FIELD PA       AS CHAR  FORMAT "x(15)" INIT ""  
    FIELD PD       AS CHAR  FORMAT "x(15)" INIT "" 
    FIELD n_class  AS CHAR  FORMAT "x(5)" INIT ""
    FIELD seat     AS CHAR  FORMAT "x(2)"  INIT "" .
   /*A60-0095*/
DEF VAR np_dealer AS CHAR FORMAT "x(20)" INIT "".    /*A56-0399*/
DEF VAR np_brand AS CHAR .
DEF VAR np_model AS CHAR .
DEF VAR np_class AS CHAR .
/*--A59-0178--*/   
DEF VAR nv_compcomdat   AS DATE  FORMAT "99/99/9999"    NO-UNDO.   
DEF VAR nv_compexpdat   AS DATE  FORMAT "99/99/9999"    NO-UNDO.
DEF VAR nv_bdatdriv1    AS DATE  FORMAT "99/99/9999"    NO-UNDO.
DEF VAR nv_bdatdriv2    AS DATE  FORMAT "99/99/9999"    NO-UNDO.
DEF VAR nv_bdatdriv3    AS DATE  FORMAT "99/99/9999"    NO-UNDO.
DEF VAR nv_sumfi1       AS DECI  INIT 0.
DEF VAR nv_sumfi2       AS DECI  INIT 0.
DEF VAR nv_sumfi3       AS DECI  INIT 0   format ">>>,>>>,>>9.99".
DEF VAR nv_72Reciept    AS CHAR  FORMAT "X(50)"         .
/* end : A59-0178*/
/* A64-0278 */             
def var n_address  as char format "x(250)".
def var n_build    as char format "x(150)".
def var n_tambon   as char format "x(50)".
def var n_amper    as char format "x(50)".
def var n_country  as char format "x(50)".
def var n_post     as char format "x(50)".
/* end A64-0278 */         
DEF VAR nv_caracc  AS CHAR FORMAT "X(50)"  INIT "" . /*A64-0406*/
DEF VAR nv_bdatdriv4    AS DATE  FORMAT "99/99/9999"    NO-UNDO.
DEF VAR nv_bdatdriv5    AS DATE  FORMAT "99/99/9999"    NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_comp

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wcomp

/* Definitions for BROWSE br_comp                                       */
&Scoped-define FIELDS-IN-QUERY-br_comp wcomp.cartyp wcomp.brand wcomp.package wcomp.cover wcomp.branch wcomp.n_class wcomp.bi wcomp.pa wcomp.pd wcomp.seat   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_comp   
&Scoped-define SELF-NAME br_comp
&Scoped-define QUERY-STRING-br_comp FOR EACH wcomp BREAK BY wcomp.brand
&Scoped-define OPEN-QUERY-br_comp OPEN QUERY br_comp FOR EACH wcomp BREAK BY wcomp.brand.
&Scoped-define TABLES-IN-QUERY-br_comp wcomp
&Scoped-define FIRST-TABLE-IN-QUERY-br_comp wcomp


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_comp fi_agbkcode ra_txttyp ra_poltyp ~
fi_producerford fi_agentford fi_producertisco fi_agenttisco fi_model ~
fi_filename fi_year fi_outfile bu_ok bu_file bu_exit fi_producer83 ~
fi_agenttisco83 fi_produceris fi_agenttiscois fi_producerford2 ~
fi_agentford2 fi_producermpi fi_agenttiscompi fi_producerCIR ~
fi_agenttiscoCIR fi_pdbkcode fi_agtkcode fi_pdtkcode fi_pdtkdesc ~
fi_pdbkdesc fi_agtkdesc fi_agbkdesc fi_producernis fi_agentnis ~
fi_producernis2 fi_agentnis2 fi_producerford2y fi_agentford2y ~
fi_producerhaval fi_agenthaval fi_producerHi1 fi_agenthi1 fi_producerHi2 ~
fi_agenthi2 fi_producerbig fi_agentbig fi_proHyundai fi_agentHyundai ~
fi_proreHyundai fi_agentreHyundai RECT-76 RECT-457 RECT-459 RECT-460 
&Scoped-Define DISPLAYED-OBJECTS fi_agbkcode ra_txttyp ra_poltyp ~
fi_producerford fi_agentford fi_producertisco fi_agenttisco fi_model ~
fi_filename fi_year fi_outfile fi_producer83 fi_agenttisco83 fi_produceris ~
fi_agenttiscois fi_producerford2 fi_agentford2 fi_producermpi ~
fi_agenttiscompi fi_producerCIR fi_agenttiscoCIR fi_pdbkcode fi_agtkcode ~
fi_pdtkcode fi_pdtkdesc fi_pdbkdesc fi_agtkdesc fi_agbkdesc fi_producernis ~
fi_agentnis fi_producernis2 fi_agentnis2 fi_producerford2y fi_agentford2y ~
fi_producerhaval fi_agenthaval fi_producerHi1 fi_agenthi1 fi_producerHi2 ~
fi_agenthi2 fi_producerbig fi_agentbig fi_proHyundai fi_agentHyundai ~
fi_proreHyundai fi_agentreHyundai 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 3.5 BY 1.05.

DEFINE BUTTON bu_ok 
     LABEL "Ok" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE VARIABLE fi_agbkcode AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agbkdesc AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 20.5 BY .81
     BGCOLOR 18 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_agentbig AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agentford AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agentford2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agentford2y AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agenthaval AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agenthi1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agenthi2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agentHyundai AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agentnis AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agentnis2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agentreHyundai AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agenttisco AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agenttisco83 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agenttiscoCIR AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agenttiscois AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agenttiscompi AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agtkcode AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agtkdesc AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 20.5 BY .81
     BGCOLOR 18 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 70 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_model AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 70 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_pdbkcode AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_pdbkdesc AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 23.5 BY .81
     BGCOLOR 18 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_pdtkcode AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_pdtkdesc AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 23.5 BY .81
     BGCOLOR 18 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producer83 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_producerbig AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_producerCIR AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_producerford AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_producerford2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_producerford2y AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_producerhaval AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_producerHi1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_producerHi2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_produceris AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_producermpi AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_producernis AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_producernis2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_producertisco AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_proHyundai AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_proreHyundai AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 15.17 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE ra_poltyp AS INTEGER INITIAL 1 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "�������", 1,
"����ᴧ", 2
     SIZE 40 BY 1
     BGCOLOR 3 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_txttyp AS INTEGER INITIAL 1 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Detail Notification", 1,
"Detail Driver", 2
     SIZE 40 BY 1
     BGCOLOR 3 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-457
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 127.5 BY 22.24.

DEFINE RECTANGLE RECT-459
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.5 BY 1.67
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-460
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 1.67
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-76
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 131.5 BY 23.81
     BGCOLOR 19 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_comp FOR 
      wcomp SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_comp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_comp C-Win _FREEFORM
  QUERY br_comp DISPLAY
      wcomp.cartyp     COLUMN-LABEL "cartyp"    FORMAT "x(8)"
      wcomp.brand      COLUMN-LABEL "brand  "   FORMAT "x(15)"
      wcomp.package    COLUMN-LABEL "package"   FORMAT "x(4)"
      wcomp.cover      COLUMN-LABEL "cover"     FORMAT "x(3)" 
      wcomp.branch     COLUMN-LABEL "branch"    FORMAT "x(10)"
      wcomp.n_class    COLUMN-LABEL "Class"     FORMAT "X(4)"
      wcomp.bi         COLUMN-LABEL "BI"        FORMAT "x(10)"
      wcomp.pa         COLUMN-LABEL "PA"        FORMAT "x(10)"
      wcomp.pd         COLUMN-LABEL "PD"        FORMAT "x(10)"
      wcomp.seat       COLUMN-LABEL "Seat"      FORMAT "x(2)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 98.5 BY 3.67
         BGCOLOR 15 FONT 1 ROW-HEIGHT-CHARS .67 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_comp AT ROW 18.24 COL 8.5
     fi_agbkcode AT ROW 12.05 COL 67.83 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     ra_txttyp AT ROW 2.52 COL 65.67 NO-LABEL
     ra_poltyp AT ROW 3.62 COL 65.67 NO-LABEL
     fi_producerford AT ROW 4.81 COL 31.5 COLON-ALIGNED NO-LABEL
     fi_agentford AT ROW 4.81 COL 67.83 COLON-ALIGNED NO-LABEL
     fi_producertisco AT ROW 6.57 COL 31.67 COLON-ALIGNED NO-LABEL
     fi_agenttisco AT ROW 6.57 COL 67.83 COLON-ALIGNED NO-LABEL
     fi_model AT ROW 16.95 COL 28.67 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 22.24 COL 28.5 COLON-ALIGNED NO-LABEL
     fi_year AT ROW 16.95 COL 67.17 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 23.38 COL 28.5 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 22.57 COL 109.33
     bu_file AT ROW 22.29 COL 101.83
     bu_exit AT ROW 22.62 COL 120
     fi_producer83 AT ROW 7.48 COL 31.67 COLON-ALIGNED NO-LABEL
     fi_agenttisco83 AT ROW 7.52 COL 67.83 COLON-ALIGNED NO-LABEL
     fi_produceris AT ROW 8.38 COL 31.67 COLON-ALIGNED NO-LABEL
     fi_agenttiscois AT ROW 8.43 COL 67.83 COLON-ALIGNED NO-LABEL
     fi_producerford2 AT ROW 5.67 COL 31.5 COLON-ALIGNED NO-LABEL
     fi_agentford2 AT ROW 5.67 COL 67.83 COLON-ALIGNED NO-LABEL
     fi_producermpi AT ROW 9.29 COL 31.67 COLON-ALIGNED NO-LABEL
     fi_agenttiscompi AT ROW 9.33 COL 67.83 COLON-ALIGNED NO-LABEL
     fi_producerCIR AT ROW 10.19 COL 31.67 COLON-ALIGNED NO-LABEL
     fi_agenttiscoCIR AT ROW 10.24 COL 67.83 COLON-ALIGNED NO-LABEL
     fi_pdbkcode AT ROW 12 COL 31.67 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     fi_agtkcode AT ROW 11.1 COL 67.83 COLON-ALIGNED NO-LABEL WIDGET-ID 12
     fi_pdtkcode AT ROW 11.05 COL 31.67 COLON-ALIGNED NO-LABEL WIDGET-ID 14
     fi_pdtkdesc AT ROW 11.19 COL 7 COLON-ALIGNED NO-LABEL WIDGET-ID 20
     fi_pdbkdesc AT ROW 12.1 COL 7 COLON-ALIGNED NO-LABEL WIDGET-ID 22
     fi_agtkdesc AT ROW 11.1 COL 46.5 COLON-ALIGNED NO-LABEL WIDGET-ID 30
     fi_agbkdesc AT ROW 12 COL 46.5 COLON-ALIGNED NO-LABEL WIDGET-ID 28
     fi_producernis AT ROW 13 COL 31.67 COLON-ALIGNED NO-LABEL WIDGET-ID 34
     fi_agentnis AT ROW 13 COL 67.83 COLON-ALIGNED NO-LABEL WIDGET-ID 32
     fi_producernis2 AT ROW 13.91 COL 31.67 COLON-ALIGNED NO-LABEL WIDGET-ID 42
     fi_agentnis2 AT ROW 13.91 COL 67.83 COLON-ALIGNED NO-LABEL WIDGET-ID 40
     fi_producerford2y AT ROW 14.81 COL 31.67 COLON-ALIGNED NO-LABEL WIDGET-ID 54
     fi_agentford2y AT ROW 14.81 COL 67.83 COLON-ALIGNED NO-LABEL WIDGET-ID 52
     fi_producerhaval AT ROW 15.76 COL 31.67 COLON-ALIGNED NO-LABEL WIDGET-ID 64
     fi_agenthaval AT ROW 15.76 COL 67.83 COLON-ALIGNED NO-LABEL WIDGET-ID 62
     fi_producerHi1 AT ROW 4.81 COL 96.83 COLON-ALIGNED NO-LABEL WIDGET-ID 72
     fi_agenthi1 AT ROW 4.81 COL 114.5 COLON-ALIGNED NO-LABEL WIDGET-ID 76
     fi_producerHi2 AT ROW 5.71 COL 96.83 COLON-ALIGNED NO-LABEL WIDGET-ID 82
     fi_agenthi2 AT ROW 5.71 COL 114.5 COLON-ALIGNED NO-LABEL WIDGET-ID 80
     fi_producerbig AT ROW 6.67 COL 96.83 COLON-ALIGNED NO-LABEL WIDGET-ID 90
     fi_agentbig AT ROW 6.67 COL 114.5 COLON-ALIGNED NO-LABEL WIDGET-ID 88
     fi_proHyundai AT ROW 7.52 COL 96.83 COLON-ALIGNED NO-LABEL WIDGET-ID 98
     fi_agentHyundai AT ROW 7.52 COL 114.5 COLON-ALIGNED NO-LABEL WIDGET-ID 96
     fi_proreHyundai AT ROW 8.43 COL 96.83 COLON-ALIGNED NO-LABEL WIDGET-ID 106
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 8 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_agentreHyundai AT ROW 8.43 COL 114.5 COLON-ALIGNED NO-LABEL WIDGET-ID 104
     "Text file name (TISCO) :" VIEW-AS TEXT
          SIZE 23.5 BY 1.05 AT ROW 22.24 COL 6.33
          BGCOLOR 31 FGCOLOR 7 FONT 6
     "Data From Campaign :" VIEW-AS TEXT
          SIZE 21 BY 1 AT ROW 16.95 COL 9.17
          BGCOLOR 5 FGCOLOR 7 FONT 6
     "�ҹ����ᴧ�� :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 16.95 COL 54.5
          BGCOLOR 5 FGCOLOR 7 FONT 6
     "Ford 2Y" VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 14.86 COL 85.33 WIDGET-ID 60
          BGCOLOR 19 
     "           Producer Haval :" VIEW-AS TEXT
          SIZE 23.5 BY .81 AT ROW 15.76 COL 9 WIDGET-ID 66
          BGCOLOR 18 FONT 6
     "Re Hyundai" VIEW-AS TEXT
          SIZE 14 BY .81 AT ROW 8.43 COL 84.5 WIDGET-ID 110
          BGCOLOR 18 FONT 6
     "�͹����" VIEW-AS TEXT
          SIZE 8 BY .91 AT ROW 13.86 COL 85.33 WIDGET-ID 50
          BGCOLOR 19 
     "/" VIEW-AS TEXT
          SIZE 2 BY .81 AT ROW 8.43 COL 113.67 WIDGET-ID 108
          BGCOLOR 18 FONT 6
     "ö��� Hi-Way:" VIEW-AS TEXT
          SIZE 14 BY .81 AT ROW 4.81 COL 84.5 WIDGET-ID 74
          BGCOLOR 18 FONT 6
     "Agent Code NISSAN:" VIEW-AS TEXT
          SIZE 20.5 BY .81 AT ROW 13.91 COL 48.67 WIDGET-ID 46
          BGCOLOR 18 FONT 6
     " PD_Code MAZDA MPI:" VIEW-AS TEXT
          SIZE 23.5 BY .81 AT ROW 9.33 COL 9
          BGCOLOR 18 FONT 6
     "   Producer Ford Other :" VIEW-AS TEXT
          SIZE 23.5 BY .81 AT ROW 5.67 COL 9
          BGCOLOR 18 FONT 6
     "   Producer Ford 2 Year :" VIEW-AS TEXT
          SIZE 23.5 BY .81 AT ROW 14.81 COL 9 WIDGET-ID 58
          BGCOLOR 18 FONT 6
     "/" VIEW-AS TEXT
          SIZE 2 BY .81 AT ROW 5.71 COL 113.67 WIDGET-ID 86
          BGCOLOR 18 FONT 6
     "Output to Excel (.SLK) :" VIEW-AS TEXT
          SIZE 23.5 BY 1.05 AT ROW 23.38 COL 6.33
          BGCOLOR 31 FGCOLOR 7 FONT 6
     "/" VIEW-AS TEXT
          SIZE 2 BY .81 AT ROW 4.81 COL 113.67 WIDGET-ID 78
          BGCOLOR 18 FONT 6
     "/" VIEW-AS TEXT
          SIZE 2 BY .81 AT ROW 6.67 COL 113.67 WIDGET-ID 94
          BGCOLOR 18 FONT 6
     "     Agent Code CIR :" VIEW-AS TEXT
          SIZE 20.67 BY .81 AT ROW 10.24 COL 48.5
          BGCOLOR 18 FONT 6
     "   Agent Code Tisco:" VIEW-AS TEXT
          SIZE 20.5 BY .81 AT ROW 7.52 COL 48.67
          BGCOLOR 18 FONT 6
     "  Agent Code ISUZU:" VIEW-AS TEXT
          SIZE 20.5 BY .81 AT ROW 8.43 COL 48.67
          BGCOLOR 18 FONT 6
     "   Agent Ford 2 Year :" VIEW-AS TEXT
          SIZE 20.5 BY .81 AT ROW 14.81 COL 48.67 WIDGET-ID 56
          BGCOLOR 18 FONT 6
     "Producer Ford Ranger :" VIEW-AS TEXT
          SIZE 23.5 BY .81 AT ROW 4.81 COL 9
          BGCOLOR 18 FONT 6
     "Renew" VIEW-AS TEXT
          SIZE 8 BY .91 AT ROW 12.91 COL 85.17 WIDGET-ID 48
          BGCOLOR 19 
     "  Producer Code �Դ8.3:" VIEW-AS TEXT
          SIZE 23.5 BY .81 AT ROW 7.52 COL 9
          BGCOLOR 18 FONT 6
     "   Agent Ford Other :" VIEW-AS TEXT
          SIZE 20.5 BY .81 AT ROW 5.67 COL 48.67
          BGCOLOR 18 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 8 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "�������/�͹����" VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 15.81 COL 85.33 WIDGET-ID 68
          BGCOLOR 19 
     "  Producer Code ISUZU:" VIEW-AS TEXT
          SIZE 23.5 BY .81 AT ROW 8.43 COL 9
          BGCOLOR 18 FONT 6
     "  Producer Code Tisco:" VIEW-AS TEXT
          SIZE 23.5 BY .81 AT ROW 6.57 COL 9
          BGCOLOR 18 FONT 6
     "  Agent MAZDA MPI:" VIEW-AS TEXT
          SIZE 20.67 BY .81 AT ROW 9.33 COL 48.5
          BGCOLOR 18 FONT 6
     "Producer Code NISSAN:" VIEW-AS TEXT
          SIZE 23.5 BY .81 AT ROW 13.91 COL 9 WIDGET-ID 44
          BGCOLOR 18 FONT 6
     "                          IMPORT TEXT FILE TISCO [ NEW/RENEW ] TO EXCEL" VIEW-AS TEXT
          SIZE 83 BY 1 AT ROW 1.24 COL 26.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "ö��÷ء�˭�" VIEW-AS TEXT
          SIZE 14 BY .81 AT ROW 6.67 COL 84.5 WIDGET-ID 92
          BGCOLOR 18 FONT 6
     "Producer Code NISSAN:" VIEW-AS TEXT
          SIZE 23.5 BY .81 AT ROW 13 COL 9 WIDGET-ID 36
          BGCOLOR 18 FONT 6
     "/" VIEW-AS TEXT
          SIZE 2 BY .81 AT ROW 7.52 COL 113.67 WIDGET-ID 100
          BGCOLOR 18 FONT 6
     "OEM Hyundai" VIEW-AS TEXT
          SIZE 14 BY .81 AT ROW 7.52 COL 84.5 WIDGET-ID 102
          BGCOLOR 18 FONT 6
     "           Agent Haval :" VIEW-AS TEXT
          SIZE 20.5 BY .81 AT ROW 15.76 COL 48.67 WIDGET-ID 70
          BGCOLOR 18 FONT 6
     " Agent Ford Ranger :" VIEW-AS TEXT
          SIZE 20.5 BY .81 AT ROW 4.81 COL 48.67
          BGCOLOR 18 FONT 6
     " ���͡Ẻ������ ����ᴧ / ������� :" VIEW-AS TEXT
          SIZE 31.5 BY 1 AT ROW 3.62 COL 29.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Day.03/02/2024" VIEW-AS TEXT
          SIZE 14.5 BY .91 AT ROW 21 COL 109 WIDGET-ID 2
          BGCOLOR 19 
     "   Agent Code Tisco:" VIEW-AS TEXT
          SIZE 20.5 BY .81 AT ROW 6.57 COL 48.67
          BGCOLOR 18 FONT 6
     "     ���͡Ẻ�����ŷ���ͧ����ŧ :" VIEW-AS TEXT
          SIZE 31.5 BY 1 AT ROW 2.52 COL 29.33
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "ö�˭�Hi-Way:" VIEW-AS TEXT
          SIZE 14 BY .81 AT ROW 5.71 COL 84.5 WIDGET-ID 84
          BGCOLOR 18 FONT 6
     "   Producer Code CIR :" VIEW-AS TEXT
          SIZE 23.5 BY .81 AT ROW 10.29 COL 9
          BGCOLOR 18 FONT 6
     "Agent Code NISSAN:" VIEW-AS TEXT
          SIZE 20.5 BY .81 AT ROW 13 COL 48.67 WIDGET-ID 38
          BGCOLOR 18 FONT 6
     RECT-76 AT ROW 1.05 COL 2
     RECT-457 AT ROW 2.38 COL 4
     RECT-459 AT ROW 22.29 COL 107.83
     RECT-460 AT ROW 22.33 COL 118.83
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 8 .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Import Text file TISCO[new/renew] to Excel"
         HEIGHT             = 24
         WIDTH              = 133.17
         MAX-HEIGHT         = 45.76
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.76
         VIRTUAL-WIDTH      = 213.33
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT C-Win:LOAD-ICON("wimage\safety":U) THEN
    MESSAGE "Unable to load icon: wimage\safety"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_comp 1 fr_main */
ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_comp
/* Query rebuild information for BROWSE br_comp
     _START_FREEFORM
OPEN QUERY br_comp FOR EACH wcomp BREAK BY wcomp.brand.
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_comp */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Import Text file TISCO[new/renew] to Excel */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Import Text file TISCO[new/renew] to Excel */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_comp
&Scoped-define SELF-NAME br_comp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_comp C-Win
ON ROW-DISPLAY OF br_comp IN FRAME fr_main
DO:

    DEF VAR z AS INTE  INIT 0.
    DEF VAR s AS INTE  INIT 0.
    s = 1.
    z = 26.
    wcomp.cartyp :BGCOLOR IN BROWSE BR_comp = z NO-ERROR.  
    wcomp.brand  :BGCOLOR IN BROWSE BR_comp = z NO-ERROR.
    wcomp.package:BGCOLOR IN BROWSE BR_comp = z NO-ERROR.
    wcomp.branch:BGCOLOR IN BROWSE BR_comp = z NO-ERROR.
    wcomp.cover:BGCOLOR IN BROWSE BR_comp = z NO-ERROR.
    wcomp.n_class:BGCOLOR IN BROWSE BR_comp = z NO-ERROR.   
    wcomp.bi     :BGCOLOR IN BROWSE BR_comp = z NO-ERROR.   
    wcomp.pa     :BGCOLOR IN BROWSE BR_comp = z NO-ERROR.   
    wcomp.pd     :BGCOLOR IN BROWSE BR_comp = z NO-ERROR.   
    wcomp.seat   :BGCOLOR IN BROWSE BR_comp = z NO-ERROR. 

    wcomp.cartyp :FGCOLOR IN BROWSE BR_comp = s NO-ERROR.  
    wcomp.brand  :FGCOLOR IN BROWSE BR_comp = s NO-ERROR.  
    wcomp.package:FGCOLOR IN BROWSE BR_comp = s NO-ERROR.  
    wcomp.branch:FGCOLOR IN BROWSE BR_comp = s NO-ERROR.
    wcomp.cover:FGCOLOR IN BROWSE BR_comp = s NO-ERROR.
    wcomp.n_class:FGCOLOR IN BROWSE BR_comp = s NO-ERROR.         
    wcomp.bi  :FGCOLOR IN BROWSE BR_comp = s NO-ERROR.    
    wcomp.pa  :FGCOLOR IN BROWSE BR_comp = s NO-ERROR.    
    wcomp.pd  :FGCOLOR IN BROWSE BR_comp = s NO-ERROR.      
    wcomp.seat:FGCOLOR IN BROWSE BR_comp = s NO-ERROR.      
               

 
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* Exit */
DO:
  Apply "Close" to this-procedure.
  Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file C-Win
ON CHOOSE OF bu_file IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.

   SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    "Text Files (*.txt)" "*.txt",
                            "Data Files (*.*)"     "*.*"
                            
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
      
    IF OKpressed = TRUE THEN DO:
        ASSIGN 
            fi_filename  = cvData
            fi_outfile   = IF substr(fi_filename,LENGTH(fi_filename) - 3 ) = ".txt" THEN
                 substr(fi_filename,1,r-index(fi_filename,".txt") - 1 ) + ".slk" 
                ELSE fi_filename + ".slk" .
        DISP fi_filename fi_outfile WITH FRAME fr_main.     
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* Ok */
DO:
    ASSIGN 
        nv_daily  =  ""
        nv_reccnt  =  0.
    For each  wdetail:
        DELETE  wdetail.
    END.
    FOR EACH wdriver.
        DELETE wdriver.
    END.
    If  ra_txttyp  =  1  Then  Run  Import_insur.
    Else  Run  Import_driver.
    Message "Process data Complete"  View-as alert-box.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agbkcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agbkcode C-Win
ON LEAVE OF fi_agbkcode IN FRAME fr_main
DO:
    fi_agbkcode = INPUT fi_agbkcode.
  IF  fi_agbkcode <> " " THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
            sicsyac.xmm600.acno = Input fi_agbkcode  
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
            Apply "Entry" To  fi_agbkcode.
            RETURN NO-APPLY. 
        END.
        ELSE fi_agbkcode = caps(INPUT fi_agbkcode) .
  END.
  DISP fi_agbkcode WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agentbig
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agentbig C-Win
ON LEAVE OF fi_agentbig IN FRAME fr_main
DO:
  fi_agentbig = INPUT fi_agentbig .
  IF  fi_agentbig <> " " THEN DO:
      FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
          sicsyac.xmm600.acno = Input fi_agentbig  
          NO-LOCK NO-ERROR NO-WAIT.
      IF NOT AVAIL sicsyac.xmm600 THEN DO:
          Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
          Apply "Entry" To  fi_agentbig. 
          RETURN NO-APPLY. 
      END.
      ELSE fi_agentbig = caps(INPUT fi_agentbig) .
  END.
  DISP fi_agentbig WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agentford
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agentford C-Win
ON LEAVE OF fi_agentford IN FRAME fr_main
DO:
  fi_agentford = INPUT fi_agentford.
  IF  fi_agentford <> " " THEN DO:
      FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
          sicsyac.xmm600.acno = Input fi_agentford  
          NO-LOCK NO-ERROR NO-WAIT.
      IF NOT AVAIL sicsyac.xmm600 THEN DO:
          Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
          Apply "Entry" To  fi_agentford.
          RETURN NO-APPLY. 
      END.
      ELSE fi_agentford = caps(INPUT fi_agentford) .
  END.
  DISP fi_agentford WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agentford2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agentford2 C-Win
ON LEAVE OF fi_agentford2 IN FRAME fr_main
DO:
  fi_agentford2 = INPUT fi_agentford2.
  IF  fi_agentford2 <> " " THEN DO:
      FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
          sicsyac.xmm600.acno = Input fi_agentford2  
          NO-LOCK NO-ERROR NO-WAIT.
      IF NOT AVAIL sicsyac.xmm600 THEN DO:
          Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
          Apply "Entry" To  fi_agentford2.
          RETURN NO-APPLY. 
      END.
      ELSE fi_agentford2 = caps(INPUT fi_agentford2) .
  END.
  DISP fi_agentford2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agentford2y
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agentford2y C-Win
ON LEAVE OF fi_agentford2y IN FRAME fr_main
DO:
  fi_agentford2y = INPUT fi_agentford2y.
  IF  fi_agentford2y <> " " THEN DO:
      FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
          sicsyac.xmm600.acno = Input fi_agentford2y  
          NO-LOCK NO-ERROR NO-WAIT.
      IF NOT AVAIL sicsyac.xmm600 THEN DO:
          Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
          Apply "Entry" To  fi_agentford2y.
          RETURN NO-APPLY. 
      END.
      ELSE fi_agentford2y = caps(INPUT fi_agentford2y) .
  END.
  DISP fi_agentford2y WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agenthaval
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agenthaval C-Win
ON LEAVE OF fi_agenthaval IN FRAME fr_main
DO:
  fi_agenthaval = INPUT fi_agenthaval.
  IF  fi_agenthaval <> " " THEN DO:
      FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
          sicsyac.xmm600.acno = Input fi_agenthaval 
          NO-LOCK NO-ERROR NO-WAIT.
      IF NOT AVAIL sicsyac.xmm600 THEN DO:
          Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
          Apply "Entry" To  fi_agenthaval.
          RETURN NO-APPLY. 
      END.
      ELSE fi_agenthaval = caps(INPUT fi_agenthaval) .
  END.
  DISP fi_agenthaval WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agenthi1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agenthi1 C-Win
ON LEAVE OF fi_agenthi1 IN FRAME fr_main
DO:
  fi_agenthi1 = INPUT fi_agenthi1.
  IF  fi_agenthi1 <> " " THEN DO:
      FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
          sicsyac.xmm600.acno = Input fi_agenthi1 
          NO-LOCK NO-ERROR NO-WAIT.
      IF NOT AVAIL sicsyac.xmm600 THEN DO:
          Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
          Apply "Entry" To  fi_agenthi1 .
          RETURN NO-APPLY. 
      END.
      ELSE fi_agenthi1 = caps(INPUT fi_agenthi1) .
  END.
  DISP fi_agenthi1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agenthi2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agenthi2 C-Win
ON LEAVE OF fi_agenthi2 IN FRAME fr_main
DO:
  fi_agenthi2 = INPUT fi_agenthi2.
  IF  fi_agenthi2 <> " " THEN DO:
      FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
          sicsyac.xmm600.acno = Input fi_agenthi2 
          NO-LOCK NO-ERROR NO-WAIT.
      IF NOT AVAIL sicsyac.xmm600 THEN DO:
          Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
          Apply "Entry" To  fi_agenthi2.
          RETURN NO-APPLY. 
      END.
      ELSE fi_agenthi2 = caps(INPUT fi_agenthi2) .
  END.
  DISP fi_agenthi2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agentHyundai
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agentHyundai C-Win
ON LEAVE OF fi_agentHyundai IN FRAME fr_main
DO:
  fi_agentHyundai = INPUT fi_agentHyundai .
  IF  fi_agentHyundai <> " " THEN DO:
      FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
          sicsyac.xmm600.acno = Input fi_agentHyundai  
          NO-LOCK NO-ERROR NO-WAIT.
      IF NOT AVAIL sicsyac.xmm600 THEN DO:
          Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
          Apply "Entry" To  fi_agentHyundai. 
          RETURN NO-APPLY. 
      END.
      ELSE fi_agentHyundai = caps(INPUT fi_agentHyundai) .
  END.
  DISP fi_agentHyundai WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agentnis
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agentnis C-Win
ON LEAVE OF fi_agentnis IN FRAME fr_main
DO:
    fi_agentnis = INPUT fi_agentnis.
    IF  fi_agentnis <> " " THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
            sicsyac.xmm600.acno = Input fi_agentnis 
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
            Apply "Entry" To  fi_agentnis.
            RETURN NO-APPLY. 
        END.
        ELSE fi_agentnis = caps(INPUT fi_agentnis) .
    END.
    DISP fi_agentnis WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agentnis2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agentnis2 C-Win
ON LEAVE OF fi_agentnis2 IN FRAME fr_main
DO:
    fi_agentnis2 = INPUT fi_agentnis2.
    IF  fi_agentnis2 <> " " THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
            sicsyac.xmm600.acno = Input fi_agentnis2 
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
            Apply "Entry" To  fi_agentnis2.
            RETURN NO-APPLY. 
        END.
        ELSE fi_agentnis2 = caps(INPUT fi_agentnis2) .
    END.
    DISP fi_agentnis2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agentreHyundai
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agentreHyundai C-Win
ON LEAVE OF fi_agentreHyundai IN FRAME fr_main
DO:
  fi_agentreHyundai = INPUT fi_agentreHyundai .
  IF  fi_agentreHyundai <> " " THEN DO:
      FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
          sicsyac.xmm600.acno = Input fi_agentreHyundai  
          NO-LOCK NO-ERROR NO-WAIT.
      IF NOT AVAIL sicsyac.xmm600 THEN DO:
          Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
          Apply "Entry" To  fi_agentreHyundai. 
          RETURN NO-APPLY. 
      END.
      ELSE fi_agentreHyundai = caps(INPUT fi_agentreHyundai) .
  END.
  DISP fi_agentreHyundai WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agenttisco
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agenttisco C-Win
ON LEAVE OF fi_agenttisco IN FRAME fr_main
DO:
  fi_agenttisco = INPUT fi_agenttisco.
  IF  fi_agenttisco <> " " THEN DO:
      FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
          sicsyac.xmm600.acno = Input fi_agenttisco  
          NO-LOCK NO-ERROR NO-WAIT.
      IF NOT AVAIL sicsyac.xmm600 THEN DO:
          Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
          Apply "Entry" To  fi_agenttisco.
          RETURN NO-APPLY. 
      END.
      ELSE fi_agenttisco = caps(INPUT fi_agenttisco) .
  END.
  DISP fi_agenttisco WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agenttisco83
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agenttisco83 C-Win
ON LEAVE OF fi_agenttisco83 IN FRAME fr_main
DO:
    fi_agenttisco83 = INPUT fi_agenttisco83.
    IF  fi_agenttisco83 <> " " THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
            sicsyac.xmm600.acno = Input fi_agenttisco83  
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
            Apply "Entry" To  fi_agenttisco83.
            RETURN NO-APPLY. 
        END.
        ELSE fi_agenttisco83 = caps(INPUT fi_agenttisco83) .
    END.
    DISP fi_agenttisco83 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agenttiscoCIR
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agenttiscoCIR C-Win
ON LEAVE OF fi_agenttiscoCIR IN FRAME fr_main
DO:
    fi_agenttiscocir = INPUT fi_agenttiscocir.
    IF  fi_agenttiscocir <> " " THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
            sicsyac.xmm600.acno = Input fi_agenttiscocir  
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
            Apply "Entry" To  fi_agenttiscocir.
            RETURN NO-APPLY. 
        END.
        ELSE fi_agenttiscocir = caps(INPUT fi_agenttiscocir) .
    END.
    DISP fi_agenttiscocir WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agenttiscois
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agenttiscois C-Win
ON LEAVE OF fi_agenttiscois IN FRAME fr_main
DO:
    fi_agenttiscois = INPUT fi_agenttiscois.
    IF  fi_agenttiscois <> " " THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
            sicsyac.xmm600.acno = Input fi_agenttiscois  
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
            Apply "Entry" To  fi_agenttiscois.
            RETURN NO-APPLY. 
        END.
        ELSE fi_agenttiscois = caps(INPUT fi_agenttiscois) .
    END.
    DISP fi_agenttiscois WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agenttiscompi
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agenttiscompi C-Win
ON LEAVE OF fi_agenttiscompi IN FRAME fr_main
DO:
    fi_agenttiscompi = INPUT fi_agenttiscompi.
    IF  fi_agenttiscompi <> " " THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
            sicsyac.xmm600.acno = Input fi_agenttiscompi  
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
            Apply "Entry" To  fi_agenttiscompi.
            RETURN NO-APPLY. 
        END.
        ELSE fi_agenttiscompi = caps(INPUT fi_agenttiscompi) .
    END.
    DISP fi_agenttiscompi WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agtkcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agtkcode C-Win
ON LEAVE OF fi_agtkcode IN FRAME fr_main
DO:
    fi_agtkcode = INPUT fi_agtkcode.
  IF  fi_agtkcode <> " " THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
            sicsyac.xmm600.acno = Input fi_agtkcode  
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
            Apply "Entry" To  fi_agtkcode.
            RETURN NO-APPLY. 
        END.
        ELSE fi_agtkcode = caps(INPUT fi_agtkcode) .
  END.
  DISP fi_agtkcode WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename C-Win
ON LEAVE OF fi_filename IN FRAME fr_main
DO:
  fi_filename  =  Input  fi_filename.
  Disp  fi_filename  with frame  fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_model
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_model C-Win
ON LEAVE OF fi_model IN FRAME fr_main
DO:
  fi_model = INPUT fi_model.
  DISP fi_model WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile C-Win
ON LEAVE OF fi_outfile IN FRAME fr_main
DO:
  fi_outfile  =  Input  fi_outfile.
  Disp  fi_outfile with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pdbkcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pdbkcode C-Win
ON LEAVE OF fi_pdbkcode IN FRAME fr_main
DO:
    fi_pdbkcode = INPUT fi_pdbkcode.
  IF  fi_pdbkcode <> " " THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
            sicsyac.xmm600.acno = Input fi_pdbkcode  
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
            Apply "Entry" To  fi_pdbkcode.
            RETURN NO-APPLY. 
        END.
        ELSE fi_pdbkcode = caps(INPUT fi_pdbkcode) .
  END.
  DISP fi_pdbkcode WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pdtkcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pdtkcode C-Win
ON LEAVE OF fi_pdtkcode IN FRAME fr_main
DO:
    fi_pdtkcode = INPUT fi_pdtkcode.
  IF  fi_pdtkcode <> " " THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
            sicsyac.xmm600.acno = Input fi_pdtkcode  
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
            Apply "Entry" To  fi_pdtkcode.
            RETURN NO-APPLY. 
        END.
        ELSE fi_pdtkcode = caps(INPUT fi_pdtkcode) .
  END.
  DISP fi_pdtkcode WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer83
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer83 C-Win
ON LEAVE OF fi_producer83 IN FRAME fr_main
DO:
    fi_producer83 = INPUT fi_producer83.
    IF  fi_producer83 <> " " THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX  xmm60001 WHERE
            sicsyac.xmm600.acno = Input fi_producer83  
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
            Apply "Entry" To  fi_producer83.
            RETURN NO-APPLY. 
        END.
        ELSE fi_producer83 = caps(INPUT fi_producer83) .
    END.
    DISP fi_producer83  WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producerbig
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producerbig C-Win
ON LEAVE OF fi_producerbig IN FRAME fr_main
DO:
  fi_producerbig = INPUT fi_producerbig.
  IF  fi_producerbig <> " " THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
            sicsyac.xmm600.acno = Input fi_producerbig 
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
            Apply "Entry" To  fi_producerbig.
            RETURN NO-APPLY. 
        END.
        ELSE fi_producerbig = caps(INPUT fi_producerbig) .
  END.
  DISP fi_producerbig WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producerCIR
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producerCIR C-Win
ON LEAVE OF fi_producerCIR IN FRAME fr_main
DO:
    fi_producercir = INPUT fi_producercir.
    IF  fi_producercir <> " " THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX  xmm60001 WHERE
            sicsyac.xmm600.acno = Input fi_producercir  
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
            Apply "Entry" To  fi_producercir.
            RETURN NO-APPLY. 
        END.
        ELSE fi_producercir = caps(INPUT fi_producercir) .
    END.
    DISP fi_producercir  WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producerford
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producerford C-Win
ON LEAVE OF fi_producerford IN FRAME fr_main
DO:
  fi_producerford = INPUT fi_producerford.
  IF  fi_producerford <> " " THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
            sicsyac.xmm600.acno = Input fi_producerford  
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
            Apply "Entry" To  fi_producerford.
            RETURN NO-APPLY. 
        END.
        ELSE fi_producerford = caps(INPUT fi_producerford) .
  END.
  DISP fi_producerford WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producerford2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producerford2 C-Win
ON LEAVE OF fi_producerford2 IN FRAME fr_main
DO:
  fi_producerford2 = INPUT fi_producerford2.
  IF  fi_producerford <> " " THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
            sicsyac.xmm600.acno = Input fi_producerford2  
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
            Apply "Entry" To  fi_producerford2.
            RETURN NO-APPLY. 
        END.
        ELSE fi_producerford2 = caps(INPUT fi_producerford2) .
  END.
  DISP fi_producerford2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producerford2y
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producerford2y C-Win
ON LEAVE OF fi_producerford2y IN FRAME fr_main
DO:
  fi_producerford2y = INPUT fi_producerford2y.
  IF  fi_producerford <> " " THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
            sicsyac.xmm600.acno = Input fi_producerford2y  
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
            Apply "Entry" To  fi_producerford2y.
            RETURN NO-APPLY. 
        END.
        ELSE fi_producerford2y = caps(INPUT fi_producerford2y) .
  END.
  DISP fi_producerford2y WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producerhaval
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producerhaval C-Win
ON LEAVE OF fi_producerhaval IN FRAME fr_main
DO:
  fi_producerhaval = INPUT fi_producerhaval.
  IF  fi_producerhaval <> " " THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
            sicsyac.xmm600.acno = Input fi_producerhaval
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
            Apply "Entry" To  fi_producerhaval .
            RETURN NO-APPLY. 
        END.
        ELSE fi_producerhaval = caps(INPUT fi_producerhaval) .
  END.
  DISP fi_producerhaval WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producerHi1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producerHi1 C-Win
ON LEAVE OF fi_producerHi1 IN FRAME fr_main
DO:
  fi_producerHi1 = INPUT fi_producerHi1.
  IF  fi_producerHi1 <> " " THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
            sicsyac.xmm600.acno = Input fi_producerHi1 
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
            Apply "Entry" To  fi_producerHi1 .
            RETURN NO-APPLY. 
        END.
        ELSE fi_producerHi1 = caps(INPUT fi_producerHi1) .
  END.
  DISP fi_producerHi1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producerHi2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producerHi2 C-Win
ON LEAVE OF fi_producerHi2 IN FRAME fr_main
DO:
  fi_producerHi2 = INPUT fi_producerHi2.
  IF  fi_producerHi2 <> " " THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
            sicsyac.xmm600.acno = Input fi_producerHi2
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
            Apply "Entry" To  fi_producerHi2.
            RETURN NO-APPLY. 
        END.
        ELSE fi_producerHi2 = caps(INPUT fi_producerHi2) .
  END.
  DISP fi_producerHi2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_produceris
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_produceris C-Win
ON LEAVE OF fi_produceris IN FRAME fr_main
DO:
    fi_produceris = INPUT fi_produceris.
    IF  fi_produceris <> " " THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX  xmm60001 WHERE
            sicsyac.xmm600.acno = Input fi_produceris  
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
            Apply "Entry" To  fi_produceris.
            RETURN NO-APPLY. 
        END.
        ELSE fi_produceris = caps(INPUT fi_produceris) .
    END.
    DISP fi_produceris  WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producermpi
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producermpi C-Win
ON LEAVE OF fi_producermpi IN FRAME fr_main
DO:
    fi_producermpi = INPUT fi_producermpi.
    IF  fi_producermpi <> " " THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX  xmm60001 WHERE
            sicsyac.xmm600.acno = Input fi_producermpi  
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
            Apply "Entry" To  fi_producermpi.
            RETURN NO-APPLY. 
        END.
        ELSE fi_producermpi = caps(INPUT fi_producermpi) .
    END.
    DISP fi_producermpi  WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producernis
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producernis C-Win
ON LEAVE OF fi_producernis IN FRAME fr_main
DO:
    fi_producernis = INPUT fi_producernis.
    IF  fi_producernis <> " " THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX  xmm60001 WHERE
            sicsyac.xmm600.acno = Input fi_producernis 
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
            Apply "Entry" To  fi_producernis.
            RETURN NO-APPLY. 
        END.
        ELSE fi_producernis = caps(INPUT fi_producernis) .
    END.
    DISP fi_producernis  WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producernis2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producernis2 C-Win
ON LEAVE OF fi_producernis2 IN FRAME fr_main
DO:
    fi_producernis2 = INPUT fi_producernis2.
    IF  fi_producernis2 <> " " THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX  xmm60001 WHERE
            sicsyac.xmm600.acno = Input fi_producernis2 
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
            Apply "Entry" To  fi_producernis2.
            RETURN NO-APPLY. 
        END.
        ELSE fi_producernis2 = caps(INPUT fi_producernis2) .
    END.
    DISP fi_producernis2  WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producertisco
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producertisco C-Win
ON LEAVE OF fi_producertisco IN FRAME fr_main
DO:
  fi_producertisco = INPUT fi_producertisco.
  IF  fi_producertisco <> " " THEN DO:
      FIND FIRST sicsyac.xmm600 USE-INDEX  xmm60001 WHERE
          sicsyac.xmm600.acno = Input fi_producertisco  
          NO-LOCK NO-ERROR NO-WAIT.
      IF NOT AVAIL sicsyac.xmm600 THEN DO:
          Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
          Apply "Entry" To  fi_producertisco.
          RETURN NO-APPLY. 
      END.
      ELSE fi_producertisco = caps(INPUT fi_producertisco) .
  END.
  DISP fi_producertisco WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_proHyundai
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_proHyundai C-Win
ON LEAVE OF fi_proHyundai IN FRAME fr_main
DO:
  fi_proHyundai = INPUT fi_proHyundai.
  IF  fi_proHyundai <> " " THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
            sicsyac.xmm600.acno = Input fi_proHyundai 
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
            Apply "Entry" To  fi_proHyundai.
            RETURN NO-APPLY. 
        END.
        ELSE fi_proHyundai = caps(INPUT fi_proHyundai) .
  END.
  DISP fi_proHyundai WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_proreHyundai
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_proreHyundai C-Win
ON LEAVE OF fi_proreHyundai IN FRAME fr_main
DO:
  fi_proreHyundai = INPUT fi_proreHyundai.
  IF  fi_proreHyundai <> " " THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
            sicsyac.xmm600.acno = Input fi_proreHyundai 
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File sicsyac.xmm600" View-as alert-box.
            Apply "Entry" To  fi_proreHyundai.
            RETURN NO-APPLY. 
        END.
        ELSE fi_proreHyundai = caps(INPUT fi_proreHyundai) .
  END.
  DISP fi_proreHyundai WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_year
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_year C-Win
ON LEAVE OF fi_year IN FRAME fr_main
DO:
  fi_year = INPUT fi_year.
  DISP fi_year WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_poltyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_poltyp C-Win
ON VALUE-CHANGED OF ra_poltyp IN FRAME fr_main
DO:
  ra_poltyp  =  Input  ra_poltyp.
  IF ra_poltyp = 2 THEN DO:  /*����ᴧ */
      ASSIGN 
          /* comment by : A64-0092..
      /*fi_producerford  = "B3M0032"*/  /*A59-0618*/
      fi_producerford  = "B3M0002"      /*A59-0618*/
      fi_agentford     = "B3M0002"
      fi_producerford2 = "B3M0032"   /*A59-0618*/     
      fi_agentford2    = "B3M0002"   /*A59-0618*/ 
      fi_producertisco = "B3M0003"
      fi_agenttisco    = "B3M0002"       
      /*fi_producerma    = "B3M0043"      /*A59-0618*/ */  /*A62-0386*/          
      /*fi_agenttiscoma  = "B3M0002"      /*A59-0618*/ */ /*A62-0386*/ 
      fi_produceris    = "B3M0029"      /*A59-0618*/ 
      fi_agenttiscois  = "B3M0002"      /*A59-0618*/
      /*fi_producermpi   = "A0M1046"   /*A60-0225*/*/  /*A62-0386*/
      /*fi_agenttiscompi = "B3M0002"   /*A60-0225*/ */  /*A62-0386*/ 
      fi_producermpi   = ""     /*A62-0386*/   
      fi_agenttiscompi = ""     /*A62-0386*/  
      fi_producercir   = "A0M2010"  /*A60-0225*/     
      fi_agenttiscocir = "B3M0002"  /*A60-0225*/
      fi_producer83    = "A0M2012"   /*A61-0313*/
      fi_agenttisco83  = "B3M0002" . /*A61-0313*/
      ... end A64-0092 */
      /* add by : A64-0092 */         
      fi_producerford  = "B3M0002"   
      fi_agentford     = "B3M0002"   
      fi_producerford2 = "B3M0002"        /*"B3M0032" */  
      fi_agentford2    = "B3M0002"   
      fi_producertisco = "B3MLTIS201"    /*"B3M0003" */  
      fi_agenttisco    = "B3MLTIS200"    /*"B3M0002" */  
      fi_produceris    = "B3MLTIS204"    /*"B3M0029" */  
      fi_agenttiscois  = "B3MLTIS200"    /*"B3M0002" */  
      fi_producermpi   = ""          
      fi_agenttiscompi = ""          
      fi_producercir   = "B3MLTIS102"   /* "A0M2010"*/   
      fi_agenttiscocir = "B3MLTIS100"   /* "B3M0002"*/   
      fi_producer83    = "B3MLTIS104"   /* "A0M2012"*/   
      fi_agenttisco83  = "B3MLTIS100"   /* "B3M0002"*/ 
      fi_pdbkdesc      = "    Producer BIGBIKE:" 
      fi_pdbkcode      = "B3MLTIS203"  /*B3M0028 */  
      fi_agbkdesc      = "    Agent BIGBIKE:"
      fi_agbkcode      = "B3MLTIS200" 
      fi_pdtkdesc      = "    Producer TRUCK:"
      fi_pdtkcode      = "B3MLTIS202"  /*B3M0007*/
      fi_agtkdesc      = "    Agent TRUCK:"
      fi_agtkcode      = "B3MLTIS200" .
      /* end A64-0092 */
      ENABLE fi_producerford fi_agentford fi_producertisco fi_agenttisco  WITH FRAME fr_main.
      ENABLE fi_pdbkcode   fi_agbkcode  fi_pdtkcode   fi_agtkcode 
             fi_pdbkdesc   fi_agbkdesc  fi_pdtkdesc   fi_agtkdesc WITH FRAME fr_main . /*A64-0092*/
      DISABLE fi_producermpi fi_agenttiscompi WITH FRAME fr_main . /*a62-0386*/
      DISP   fi_producerford fi_agentford fi_producertisco fi_agenttisco  fi_producer83 fi_agenttisco83 /*a61-0313*/
             fi_producermpi  fi_agenttiscompi fi_producercir  fi_agenttiscocir   /*A60-0225*/  with frame  fr_main.
      DISP   fi_produceris  fi_agenttiscois fi_producerford2  fi_agentford2 WITH FRAME fr_main. /*A59-0618*/
      DISP   fi_pdbkcode   fi_agbkcode  fi_pdtkcode   fi_agtkcode                     
             fi_pdbkdesc   fi_agbkdesc  fi_pdtkdesc   fi_agtkdesc WITH FRAME fr_main .
      /*APPLY "ENTRY" TO fi_producerford IN FRAME fr_main . */
  END.                                                       
  ELSE DO: /*������� */
      ASSIGN /* comment by A61-0313 ...
             fi_producertisco = "A0M2008" 
             fi_agenttisco    = "B3M0002"     
             fi_producerford  = "B3M0033"
             fi_agentford     = "B3M0002" 
             fi_producerford2 = "B3M0033"   /*A59-0618*/     
             fi_agentford2    = "B3M0002"   /*A59-0618*/ 
             fi_producerma    = "B3M0044"   /*A59-0618*/
             fi_agenttiscoma  = "B3M0002"   /*A59-0618*/
             fi_produceris    = "A0M2008"   /*A59-0618*/
             fi_agenttiscois  = "B3M0002"   /*A59-0618*/
             fi_producermpi   = "A0M1046"   /*A60-0225*/
             fi_agenttiscompi = "B3M0002"   /*A60-0225*/
             fi_producercir   = "A0M2010"  /*A60-0225*/
             fi_agenttiscocir = "B3M0002" . /*A60-0225*/
             ... end A61-0313...*/
            /* create by A61-0313 */
            /*fi_producertisco = "A0M2008"    /*A63-00472*/
             fi_agenttisco    = "B3M0035" */  /*A63-00472*/
             fi_producertisco = "B3MLTIS101"  /*A63-00472*/
             fi_agenttisco    = "B3MLTIS100"  /*A63-00472*/
             fi_producerford  = "B3M0033"  
             fi_agentford     = "B3M0035"  
             fi_producerford2 = "B3M0033"  
             fi_agentford2    = "B3M0035"  
             /*fi_producerma    = "B3M0044"  */  /*A62-0386 */
            /* fi_agenttiscoma  = "B3M0035"  */  /*A62-0386 */
             /*fi_produceris    = "A0M2008"  
             fi_agenttiscois  = "B3M0035"  */
             fi_produceris    = "B3MLTIS101"  
             fi_agenttiscois  = "B3MLTIS100" 
             /*fi_producermpi   = "B3M0044"  */ /*A62-0386*/
             /*fi_producermpi   = "A0M2012"      /*A62-0386*/
             fi_agenttiscompi = "B3M0035"  */
             fi_producermpi   = "B3MLTIS104"      /*A62-0386*/
             fi_agenttiscompi = "B3MLTIS100" 
             /*fi_producercir   = "A0M2010"  
             fi_agenttiscocir = "B3M0035" */
             fi_producercir   = "B3MLTIS102"  
             fi_agenttiscocir = "B3MLTIS100" 
             /*fi_producer83    = "A0M2012"    /*A61-0313*/  /*A63-00472*/  
             fi_agenttisco83  = "B3M0035" .    /*A61-0313*/*//*A63-00472*/  
             fi_producer83    = "B3MLTIS104"   /*A63-00472*/
             fi_agenttisco83  = "B3MLTIS100"  /*A63-00472*/
             /* Add by : A64-0271 �2 �3 �ҹ�͹���� */
             fi_pdtkdesc      = "   Producer TRANF23 :"                 
             fi_pdtkcode      = "B3MLTIS103"        /*A0M2011*/           
             fi_agtkdesc      = "   Agent TRANF23 : "
             fi_agtkcode      = "B3MLTIS100"        /*B3M0035*/ 
   fi_producerHi1   = "B3MLTIS301"
   fi_agenthi1      = "B3MLTIS300"
   fi_producerHi2   = "B3MLTIS302"
   fi_agenthi2      = "B3MLTIS300"
   fi_producerbig   = "B3MLTIS105"
   fi_agentbig      = "B3MLTIS100".

             /* end : A64-0271 �2 �3 �ҹ�͹���� */

            /* end A61-0313 */
      /*ENABLE fi_producerford fi_agentford fi_producertisco fi_agenttisco  WITH FRAME fr_main.*/
      ENABLE  fi_producerford   fi_agentford     WITH FRAME fr_main.
      ENABLE  fi_producertisco fi_agenttisco  WITH FRAME fr_main. 
      ENABLE  fi_producermpi fi_agenttiscompi WITH FRAME fr_main . /*a62-0386*/
      Disp  fi_producertisco fi_agenttisco fi_producerford  fi_agentford fi_producer83 fi_agenttisco83  
          fi_producerHi1  fi_agenthi1    fi_producerHi2 fi_agenthi2    fi_producerbig fi_agentbig    
          
          
          
          with  frame fr_main.
      DISP /*fi_producerma  fi_agenttiscoma*/ fi_produceris  fi_agenttiscois fi_producerford2  fi_agentford2 WITH FRAME fr_main. /*A59-0618 */
      DISP fi_producermpi  fi_agenttiscompi fi_producercir  fi_agenttiscocir WITH FRAME fr_main. /*A60-0225*/
      DISP fi_pdtkcode fi_agtkcode fi_pdtkdesc  fi_agtkdesc WITH FRAME fr_main .  /*A64-0271*/
      /* A64-0092*/
      HIDE fi_pdbkcode . 
      HIDE fi_agbkcode .
      /*HIDE fi_pdtkcode . */  /*A64-0271*/
      /*HIDE fi_agtkcode . */  /*A64-0271*/
      HIDE fi_pdbkdesc .     
      HIDE fi_agbkdesc .
      /*HIDE fi_pdtkdesc .*/   /*A64-0271*/
      /*HIDE fi_agtkdesc .*/   /*A64-0271*/
      /* end A64-0092 */
      /*APPLY "ENTRY" TO fi_producertisco IN FRAME fr_main .*/ 

  END.
  Disp  ra_poltyp  with  frame fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_txttyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_txttyp C-Win
ON VALUE-CHANGED OF ra_txttyp IN FRAME fr_main
DO:
  ra_txttyp  =  Input  ra_txttyp.
  Disp  ra_txttyp  with  frame fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  
   /********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR.
  DEF  VAR  gv_prog    AS   CHAR.
  
  gv_prgid = "WGWPUTEX".
  gv_prog  = "Import Text File(TISCO) to Excel".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
   RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE).  
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  ASSIGN ra_poltyp = 2
      ra_txttyp    = 1
      /* comment by : Ranu I. A64-0092...
      /*fi_producerford  = "B3M0032"*/ /*A59-0418*/
      fi_producerford  = "B3M0002" /*A59-0418*/
      fi_agentford     = "B3M0002"
      fi_producerford2 = "B3M0032" /*A59-0418*/ 
      fi_agentford2    = "B3M0002"  /*A59-0418*/
      fi_producertisco = "B3M0003"
      fi_agenttisco    = "B3M0002"
      /*fi_producer83    = "A0M2012"   /*A63-00472*/ 
      fi_agenttisco83  = "B3M0002"*/   /*A63-00472*/ 
      fi_producer83    = "B3MLTIS104"  /*A63-00472*/
      fi_agenttisco83  = "B3MLTIS100"  /*A63-00472*/
      /*fi_producerma    = "B3M0043"  /*A59-0418*/ */ /*A62-0386*/
      /*fi_agenttiscoma  = "B3M0002"  /*A59-0418*/ */ /*A62-0386*/
      fi_produceris    = "B3M0029"  /*A59-0418*/
      fi_agenttiscois  = "B3M0002"  /*A59-0418*/
     /* fi_producermpi   = "A0M1046"  /*A60-0225*/ */ /*A62-0386*/
     /* fi_agenttiscompi = "B3M0002"  /*A60-0225*/ */ /*A62-0386*/
      /*fi_producercir   = "A0M2010"  /*A60-0225*//*A63-00472*/
      fi_agenttiscocir = "B3M0002"  /*A60-0225*/*//*A63-00472*/
      fi_producercir   = "B3MLTIS102"  /*A63-00472*/ 
      fi_agenttiscocir = "B3MLTIS100"  /*A63-00472*/
      /*fi_model         = "MODEL_TIS"*/ /*A60-0095*/
       .. end A64-0092..*/
      /* create by : A64-0092*/
      fi_producerford  = "B3M0002" 
      fi_agentford     = "B3M0002"
      fi_producerford2 = "B3M0002"     /*"B3M0032" */
      fi_agentford2    = "B3M0002"     
      fi_producertisco = "B3MLTIS201"  /* "B3M0003" */
      fi_agenttisco    = "B3MLTIS200"  /* "B3M0002" */
      fi_producer83    = "B3MLTIS104"  /*A63-00472*/
      fi_agenttisco83  = "B3MLTIS100"  /*A63-00472*/
      fi_produceris    = "B3MLTIS204"  /*"B3M0029" */   
      fi_agenttiscois  = "B3MLTIS200"  /*"B3M0002" */   
      fi_producercir   = "B3MLTIS102"  /*A63-00472*/ 
      fi_agenttiscocir = "B3MLTIS100"  /*A63-00472*/
      fi_producernis   = "B3DM000002"  /*Nissan Premium Protection (NPP)*/
      fi_agentnis      = "B3M0035"     /*Nissan Premium Protection (NPP)*/
      fi_producernis2  = "B3DM000003"  /*Nissan Premium Protection (NPP)*/
      fi_agentnis2     = "B3M0035"     /*Nissan Premium Protection (NPP)*/
      fi_producerford2y = "B3DM000004"
      fi_agentford2y    = "B3M0002"
      fi_producerhaval  = "B3DM000007"  
      fi_agenthaval     = "B3M0035"
      fi_producerHi1   = "B3MLTIS301"
      fi_agenthi1      = "B3MLTIS300"
      fi_producerHi2   = "B3MLTIS302"
      fi_agenthi2      = "B3MLTIS300"
      fi_producerbig   = "B3MLTIS105"
      fi_agentbig      = "B3MLTIS100"
      fi_pdbkdesc      = "    Producer BIGBIKE:" 
      fi_pdbkcode      = "B3MLTIS203"  /*B3M0028 */  
      fi_agbkdesc      = "    Agent BIGBIKE:"
      fi_agbkcode      = "B3MLTIS200" 
      fi_pdtkdesc      = "     Producer TRUCK:"
      fi_pdtkcode      = "B3MLTIS202"  /*B3M0007*/
      fi_agtkdesc      = "     Agent TRUCK:"
      fi_agtkcode      = "B3MLTIS200" 
      /* end A64-0092*/
      fi_proHyundai    = "B3MF000004"
      fi_agentHyundai  = "A0MF299970"
      fi_proreHyundai   = "B3MF000005"
      fi_agentreHyundai = "B3MF000005"  

      fi_model         = "PACK_TISCO"   /*A60-0095*/
      fi_year          = STRING(YEAR(TODAY),"9999") .  /*A60-0095*/

  RUN proc_createcomp.
  OPEN QUERY br_comp FOR EACH wcomp.
  ENABLE  fi_producerford fi_agentford fi_producertisco fi_agenttisco   WITH FRAME fr_main.
  DISABLE fi_producermpi fi_agenttiscompi WITH FRAME fr_main . /*a62-0386*/
  fi_producermpi:BGCOLOR = 19 .
  fi_agenttiscompi:BGCOLOR = 19 .
  DISP   fi_producerford fi_agentford fi_producertisco fi_agenttisco    with frame  fr_main.
  DISP ra_poltyp ra_txttyp fi_model fi_producer83  fi_agenttisco83      with frame fr_main.
  DISP fi_produceris  fi_agenttiscois fi_producerford2 fi_agentford2 
       fi_year /*A60-0095*/ fi_producermpi fi_agenttiscompi fi_producercir fi_agenttiscocir /*A60-0225*/  
       fi_producernis    fi_agentnis       fi_producernis2  fi_agentnis2     fi_producerford2y fi_agentford2y   
       fi_producerhaval  fi_agenthaval     fi_producerHi1   fi_agenthi1    fi_producerHi2 fi_agenthi2    fi_producerbig fi_agentbig    
       fi_proHyundai     fi_agentHyundai   fi_proreHyundai  fi_agentreHyundai
       WITH FRAME fr_main. /* A59-0418 */

  DISP fi_pdbkdesc  fi_pdbkcode  fi_agbkdesc  fi_agbkcode  
       fi_pdtkdesc  fi_pdtkcode  fi_agtkdesc  fi_agtkcode  WITH FRAME fr_main. /*a64-0092*/
                                                             
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-Import_insur-old C-Win 
PROCEDURE 00-Import_insur-old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by Ranu i. A59-0178...........
INPUT FROM VALUE (fi_filename) .  /*create in TEMP-TABLE wImport*/
REPEAT:    
    IMPORT UNFORMATTED nv_daily.
    If  nv_daily  <>  ""  And  substr(nv_daily,1,2)  =  "01"  Then 
        ASSIGN nv_export   = DATE(INT(SUBSTR(nv_daily,84,2)),
                                  INT(SUBSTR(nv_daily,86,2)),
                                  INT(SUBSTR(nv_daily,80,4))).
    IF  nv_daily  <>  ""  And  Substr(nv_daily,1,2)  =  "02"  THEN DO:
        nv_reccnt   =  nv_reccnt  +  1.
        CREATE  wdetail.
        ASSIGN wdetail.recordID  = TRIM(SUBSTR(nv_daily,1,2))          
            wdetail.Pro_off      = TRIM(SUBSTR(nv_daily,3,2))  
            wdetail.cmr_code     = TRIM(SUBSTR(nv_daily,5,3))
            wdetail.comp_code    = TRIM(SUBSTR(nv_daily,8,3))
            wdetail.Notify_no    = TRIM(SUBSTR(nv_daily,11,25))
            wdetail.yrmanu       = TRIM(SUBSTR(nv_daily,36,4))
            wdetail.engine       = TRIM(SUBSTR(nv_daily,40,25))
            wdetail.chassis      = TRIM(SUBSTR(nv_daily,65,25))
            wdetail.weight       = TRIM(SUBSTR(nv_daily,90,5))
            wdetail.power        = TRIM(String(SUBSTR(nv_daily,95,7),"9999999"))
            wdetail.colorcode    = TRIM(SUBSTR(nv_daily,102,10))
            wdetail.licence      = TRIM(SUBSTR(nv_daily,112,10))
            wdetail.garage       = TRIM(SUBSTR(nv_daily,122,1))
            wdetail.fleetper     = TRIM(SUBSTR(nv_daily,123,5))
            wdetail.ncbper       = TRIM(SUBSTR(nv_daily,128,5))
            wdetail.othper       = TRIM(SUBSTR(nv_daily,123,5))
            wdetail.vehuse       = TRIM(SUBSTR(nv_daily,138,1))
            wdetail.comdat       = TRIM(SUBSTR(nv_daily,139,8))
            wdetail.ins_amt      = TRIM(SUBSTR(nv_daily,147,11))
            wdetail.name_insur   = TRIM(SUBSTR(nv_daily,158,15))
            wdetail.not_office   = TRIM(SUBSTR(nv_daily,173,75))
            wdetail.not_date     = TRIM(SUBSTR(nv_daily,248,8))
            wdetail.not_time     = TRIM(SUBSTR(nv_daily,256,6))
            wdetail.not_code     = TRIM(SUBSTR(nv_daily,262,4))
            wdetail.prem1        = TRIM(SUBSTR(nv_daily,266,11))
            wdetail.comp_prm     = TRIM(SUBSTR(nv_daily,277,9))
            wdetail.sckno        = TRIM(SUBSTR(nv_daily,286,25))
            wdetail.brand        = TRIM(SUBSTR(nv_daily,311,50))
            wdetail.pol_addr1    = TRIM(SUBSTR(nv_daily,361,50))
            wdetail.pol_addr2    = TRIM(SUBSTR(nv_daily,411,60))
            wdetail.pol_title    = TRIM(SUBSTR(nv_daily,471,30))
            wdetail.pol_fname    = TRIM(SUBSTR(nv_daily,501,75))
            wdetail.pol_lname    = TRIM(SUBSTR(nv_daily,576,45))
            wdetail.ben_name     = TRIM(SUBSTR(nv_daily,621,65))
            wdetail.remark       = TRIM(SUBSTR(nv_daily,686,150)).
        ASSIGN 
            wdetail.Account_no   = TRIM(SUBSTR(nv_daily,836,10))
            wdetail.client_no    = TRIM(SUBSTR(nv_daily,846,7))
            wdetail.expdat       = TRIM(SUBSTR(nv_daily,853,8))
            wdetail.gross_prm    = TRIM(SUBSTR(nv_daily,861,11))
            wdetail.province     = TRIM(SUBSTR(nv_daily,872,18))
            wdetail.receipt_name = TRIM(SUBSTR(nv_daily,890,50))
            wdetail.agent        = TRIM(SUBSTR(nv_daily,940,15))
            wdetail.prev_insur   = TRIM(SUBSTR(nv_daily,955,50))
            wdetail.prev_pol     = TRIM(SUBSTR(nv_daily,1005,25))
            wdetail.deduct       = TRIM(SUBSTR(nv_daily,1030,9))   /*Add kridtiya i. A54-0062 ...*/
   /*46*/   wdetail.addr1_70     = TRIM(SUBSTR(nv_daily,1039,50))  
   /*47*/   wdetail.addr2_70     = TRIM(SUBSTR(nv_daily,1089,60))  
   /*48*/   wdetail.nsub_dist70  = TRIM(SUBSTR(nv_daily,1149,30))  
   /*49*/   wdetail.ndirection70 = TRIM(SUBSTR(nv_daily,1179,30))  
   /*50*/   wdetail.nprovin70    = TRIM(SUBSTR(nv_daily,1209,30))  
   /*51*/   wdetail.zipcode70    = TRIM(SUBSTR(nv_daily,1239,5))   
   /*52*/   wdetail.addr1_72     = TRIM(SUBSTR(nv_daily,1244,50))  
   /*53*/   wdetail.addr2_72     = TRIM(SUBSTR(nv_daily,1294,60))  
   /*54*/   wdetail.nsub_dist72  = TRIM(SUBSTR(nv_daily,1354,30))  
   /*55*/   wdetail.ndirection72 = TRIM(SUBSTR(nv_daily,1384,30))  
   /*56*/   wdetail.nprovin72    = TRIM(SUBSTR(nv_daily,1414,30))  
   /*57*/   wdetail.zipcode72    = TRIM(SUBSTR(nv_daily,1444,5))   
   /*58*/   wdetail.apptyp       = TRIM(SUBSTR(nv_daily,1449,10))  
   /*59*/   wdetail.appcode      = TRIM(SUBSTR(nv_daily,1459,2)) 
   /*/*60*/   wdetail.nBLANK       = TRIM(SUBSTR(nv_daily,1461,9)).*/  /*end...Add kridtiya i. A54-0062 ...*/
            wdetail.id_recive70  = TRIM(SUBSTR(nv_daily,1461,13))    /*��Ţ���ѵû�Шӵ�ǻ�ЪҪ�/�Ţ��˹ѧ����Թ�ҧ /�Ţ����¹�ҳԪ��*/
            wdetail.br_recive70  = TRIM(SUBSTR(nv_daily,1474,20))    /*�ҢҢͧʶҹ��Сͺ����١���*/
            wdetail.id_recive72  = TRIM(SUBSTR(nv_daily,1494,13))    /*��Ţ���ѵû�Шӵ�ǻ�ЪҪ�/�Ţ��˹ѧ����Թ�ҧ /�Ţ����¹�ҳԪ��*/
            wdetail.br_recive72  = TRIM(SUBSTR(nv_daily,1507,20))    /*�ҢҢͧʶҹ��Сͺ����١���*/
            wdetail.nBLANK       = TRIM(SUBSTR(nv_daily,1527,14)) .  /*64** Blank NVOW NVU] 14 Char*/ 
    END.
END.    /* repeat  */
FOR EACH wdetail.
    /*comment by kridtiya i. A54-0325....
    IF (wdetail.prev_pol = "") AND ( index(wdetail.brand,"Ford") <> 0) THEN
    ASSIGN wdetail.nproducer = "B3M0028"
    wdetail.nagent    = "A0M1009".
    ELSE IF wdetail.prev_pol = "" THEN
    ASSIGN wdetail.nproducer = "B3M0003"
    wdetail.nagent    = "B3M0002".
    ELSE end....comment by kridtiya i. A54-0325....*/
    RUN proc_cutengno.     /*A56-0323*/
    RUN proc_cutchassis.   /*A56-0323*/
    ASSIGN 
        wdetail.Notify_no     = REPLACE(wdetail.Notify_no,"-","")
        wdetail.Notify_no     = REPLACE(wdetail.Notify_no,"/","")
        wdetail.Notify_no     = REPLACE(wdetail.Notify_no,"\","")
        wdetail.Notify_no     = REPLACE(wdetail.Notify_no," ","")
        wdetail.price_ford    =  ""
        nv_cpamt3 = 0
        nv_cpamt1 = 0
        nv_cpamt2 = 0 
        nv_premt1  = 0   
        nv_premt2  = 0   
        nv_premt3  = 0
        nv_cpamt1 = DECIMAL(SUBSTRING(wdetail.comp_prm,1,7)) 
        nv_premt1 = DECIMAL(SUBSTRING(wdetail.prem1,1,9)).
    IF nv_premt1 < 0 THEN nv_premt2 = (DECIMAL(SUBSTRING(wdetail.prem1,10,2)) * -1) / 100.
    ELSE  nv_premt2 = DECIMAL(SUBSTRING(wdetail.prem1,10,2)) / 100.
    nv_premt3 = nv_premt1 + nv_premt2.
    IF nv_cpamt1 < 0 THEN nv_cpamt2 = (DECIMAL(SUBSTRING(wdetail.comp_prm,8,2)) * -1) / 100.
    ELSE  nv_cpamt2 = DECIMAL(SUBSTRING(wdetail.comp_prm,8,2)) / 100.
    nv_cpamt3 = nv_cpamt1 + nv_cpamt2.
    IF      nv_cpamt3 =  645.21 THEN 
        ASSIGN wdetail.n_pack  = wdetail.n_pack + "110"  
        wdetail.n_seattisco = 7 .  /*A57-0017*/
    ELSE IF nv_cpamt3 =  967.28 THEN 
        ASSIGN wdetail.n_pack  = wdetail.n_pack + "320"  
        wdetail.n_seattisco = 3 .  /*A57-0017*/
    ELSE IF nv_cpamt3 = 1310.75 THEN 
        ASSIGN wdetail.n_pack  = wdetail.n_pack + "320"  
        wdetail.n_seattisco = 3 .  /*A57-0017*/
    ELSE IF nv_cpamt3 = 1408.12 THEN 
        ASSIGN wdetail.n_pack  = wdetail.n_pack + "320"  
        wdetail.n_seattisco = 3 .  /*A57-0017*/
    ELSE IF nv_cpamt3 = 1826.49 THEN 
        ASSIGN wdetail.n_pack  = wdetail.n_pack + "320"  
        wdetail.n_seattisco = 3 .  /*A57-0017*/
    ELSE IF nv_cpamt3 = 1182.35 THEN 
        ASSIGN wdetail.n_pack  = wdetail.n_pack + "210"  
        wdetail.n_seattisco = 12 .  /*A57-0017*/
    ELSE IF nv_cpamt3 = 2203.13 THEN 
        ASSIGN wdetail.n_pack  = wdetail.n_pack + "210"  
        wdetail.n_seattisco = 12 .  /*A57-0017*/
    ELSE IF nv_cpamt3 = 3437.91 THEN 
        ASSIGN wdetail.n_pack  = wdetail.n_pack + "210"  
        wdetail.n_seattisco = 12 .  /*A57-0017*/
    ELSE IF nv_cpamt3 = 4017.85 THEN 
        ASSIGN wdetail.n_pack  = wdetail.n_pack + "210"  
        wdetail.n_seattisco = 12 .  /*A57-0017*/
    ELSE 
        ASSIGN 
            wdetail.n_pack  = ""
            wdetail.n_seattisco = 0 .
    IF ra_poltyp = 1  THEN DO:      /* ������� */
        /*ASSIGN n_brand = IF INDEX(wdetail.brand," ") <> 0 THEN SUBSTR(wdetail.brand,1,INDEX(wdetail.brand," ") - 1 ) ELSE wdetail.brand.*/
        FIND FIRST stat.insure USE-INDEX insure01 WHERE 
            stat.insure.compno = fi_model          AND
            stat.insure.fname  = wdetail.brand     NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.insure THEN DO: 
            ASSIGN 
                /*wdetail.n_pack = trim(stat.insure.lname) */ /*A57-0088*/ 
                wdetail.n_pack = trim(stat.insure.text5)      /*A57-0088*/ 
                np_class = "" 
                np_brand = ""
                np_model = ""
                /*np_class =  trim(stat.insure.lname) *//*A57-0088*/   
                np_class =  trim(stat.insure.text5)     /*A57-0088*/   
                np_brand =  Insure.text1    
                np_model =  insure.text2  .
            IF      wdetail.n_pack = "110" THEN ASSIGN wdetail.n_seattisco = 7 .   /*A57-0017*/
            ELSE IF wdetail.n_pack = "320" THEN ASSIGN wdetail.n_seattisco = 3 .   /*A57-0017*/
            ELSE IF wdetail.n_pack = "320" THEN ASSIGN wdetail.n_seattisco = 3 .   /*A57-0017*/
            ELSE IF wdetail.n_pack = "320" THEN ASSIGN wdetail.n_seattisco = 3 .   /*A57-0017*/
            ELSE IF wdetail.n_pack = "320" THEN ASSIGN wdetail.n_seattisco = 3 .   /*A57-0017*/
            ELSE IF wdetail.n_pack = "210" THEN ASSIGN wdetail.n_seattisco = 12 .  /*A57-0017*/
            ELSE IF wdetail.n_pack = "210" THEN ASSIGN wdetail.n_seattisco = 12 .  /*A57-0017*/
            ELSE IF wdetail.n_pack = "210" THEN ASSIGN wdetail.n_seattisco = 12 .  /*A57-0017*/
            ELSE IF wdetail.n_pack = "210" THEN ASSIGN wdetail.n_seattisco = 12 .  /*A57-0017*/
        END.
        ELSE ASSIGN wdetail.n_seattisco = 0 .   /*A57-0017*/
        ASSIGN 
            wdetail.n_covcod    = ""
            wdetail.n_typpol    = "RENEW"              
            wdetail.nproducer   = fi_producertisco     
            wdetail.nagent      = fi_agenttisco  
            wdetail.n_branch    = "M"
            wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"*","")
            wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"-","")
            wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"/","")
            wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"\","")
            wdetail.prev_pol    = REPLACE(wdetail.prev_pol,".","").   
        IF INDEX(wdetail.ben_name,"�к� 8.3") <> 0  THEN   /*case : add 8.3 */
            ASSIGN wdetail.nproducer  = fi_producer83      
                   wdetail.nagent     = fi_agenttisco83.
        IF  index(wdetail.brand,"Ford") <> 0 THEN          /*case : Ford  */
            ASSIGN wdetail.n_branch  = ""
            wdetail.nproducer        = fi_producerford
            wdetail.nagent           = fi_agentford    .
        IF ( nv_premt3 <= 10000 ) AND (nv_premt3 > 2500 )  THEN DO: 
            ASSIGN wdetail.n_covcod  = "2"
                wdetail.n_pack       = "Y" +  wdetail.n_pack
                wdetail.n_branch     = "M".
        END.
        ELSE IF (nv_premt3 <= 2500 ) THEN DO:
            ASSIGN  wdetail.n_covcod = "3"
                wdetail.n_pack       = "R" +  wdetail.n_pack
                wdetail.n_branch     = "M".
        END.
        ELSE IF  nv_premt3  >  10000   THEN DO: 
            ASSIGN  wdetail.n_covcod = "1".
            IF (wdetail.garage = "0")  THEN DO:
                IF  index(wdetail.brand,"Ford") <> 0 THEN
                    ASSIGN wdetail.n_pack = "O" +  wdetail.n_pack.
                ELSE DO:
                    FIND LAST WComp WHERE  
                        wcomp.cartyp   = "renew"    AND
                        wcomp.brand    = "garage"   NO-LOCK  NO-ERROR NO-WAIT.
                    IF AVAIL wcomp THEN  
                        ASSIGN wdetail.n_pack = wcomp.package + wdetail.n_pack .
                END.
            END.
            ELSE DO:    /*�������*/
                FIND LAST WComp WHERE 
                    wcomp.cartyp   = "renew" AND
                    wcomp.brand    = ""      NO-LOCK  NO-ERROR NO-WAIT.
                IF AVAIL wcomp THEN  ASSIGN wdetail.n_pack = wcomp.package + wdetail.n_pack .
            END.
        END.
        IF wdetail.prev_pol <> "" THEN DO:
            FIND LAST sicuw.uwm100 USE-INDEX uwm10001
                WHERE sicuw.uwm100.policy = trim(wdetail.prev_pol) NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm100 THEN ASSIGN wdetail.n_branch  =  sicuw.uwm100.branch.
        END.
    END.
    ELSE DO:    /* ����ᴧ *//* wdetail.brand */
        ASSIGN  
            wdetail.n_covcod      = "" 
            wdetail.price_ford    = IF INDEX(wdetail.remark,"P.") <> 0 THEN trim(SUBSTR(wdetail.remark,INDEX(wdetail.remark,"P.") + 2 )) ELSE ""
            wdetail.price_ford    = IF wdetail.price_ford = "" THEN "" 
                                    ELSE IF INDEX(wdetail.price_ford," ") <> 0 THEN trim(SUBSTR(wdetail.price_ford,1,INDEX(wdetail.price_ford," ")))
                                    ELSE trim(wdetail.price_ford).
        RUN proc_redbook.    /* A57-0088 */
        IF  nv_premt3 >  10000   THEN  
            ASSIGN  wdetail.n_covcod = "1".
        ELSE IF ( nv_premt3 <= 10000 ) AND ( nv_premt3 > 2500 )  THEN  
            ASSIGN wdetail.n_covcod = "2".
        ELSE ASSIGN  wdetail.n_covcod = "3" .
        ASSIGN 
            n_brand = IF INDEX(wdetail.brand," ") <> 0 THEN trim(SUBSTR(wdetail.brand,1,INDEX(wdetail.brand," ") - 1 ))
                      ELSE trim(wdetail.brand).
        /*FIND FIRST stat.insure USE-INDEX insure01    WHERE 
            stat.insure.compno = fi_model            AND
             stat.insure.fname = trim(wdetail.brand) NO-LOCK NO-ERROR .
        IF AVAIL stat.insure THEN ASSIGN wdetail.n_pack = trim(stat.insure.lname).*/
        FIND LAST WComp WHERE  
            wcomp.cartyp   = "new" AND
            wcomp.brand    = trim(n_brand) NO-LOCK  NO-ERROR NO-WAIT.
        IF NOT AVAIL wcomp THEN DO:
            FIND LAST WComp WHERE  wcomp.cartyp   = "new" AND
                wcomp.brand    = "oth" NO-LOCK  NO-ERROR NO-WAIT.
            IF AVAIL wcomp THEN 
                ASSIGN wdetail.n_pack   = wcomp.package + wdetail.n_pack
                wdetail.n_branch = trim(wcomp.branch) .
        END.
        ELSE ASSIGN wdetail.n_pack   = wcomp.package + wdetail.n_pack
            wdetail.n_branch = trim(wcomp.branch).
        ASSIGN wdetail.n_typpol  = "NEW".
        /*add...kridtiya i. A54-0325*/
        /*IF  index(wdetail.brand,"Ford") <> 0 THEN DO: */ /*A56-0399*/
        IF  index(wdetail.Notify_no,"Tis") <> 0 THEN DO:   /*A56-0399*/
            ASSIGN  np_dealer = ""
                np_dealer = IF index(wdetail.Notify_no,",") <> 0 THEN trim(SUBSTR(wdetail.Notify_no,index(wdetail.Notify_no,",") + 1 )) ELSE ""  /*A56-0399*/
                wdetail.n_branch  = "".
            IF  index(wdetail.brand,"Ford") <> 0 THEN 
                ASSIGN wdetail.nproducer  = fi_producerford               
                wdetail.nagent            = fi_agentford .
            ELSE ASSIGN wdetail.nproducer = fi_producertisco              
                wdetail.nagent            = fi_agenttisco .
            /*FIND FIRST stat.insure USE-INDEX insure01 WHERE 
                stat.insure.compno = "TISCO" AND
                index(wdetail.remark,stat.insure.lname) <> 0 NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL stat.insure THEN 
                ASSIGN  wdetail.n_branch  = trim(stat.insure.branch).
            ELSE ASSIGN  wdetail.n_branch  = "".*/
            IF  np_dealer <> "" THEN DO:
                FIND FIRST stat.insure USE-INDEX insure01 WHERE 
                    stat.insure.compno = "TISCO" AND
                    stat.insure.lname  = np_dealer NO-LOCK NO-WAIT NO-ERROR.
                IF AVAIL stat.insure THEN 
                    ASSIGN  wdetail.n_branch  = trim(stat.insure.branch).
                ELSE ASSIGN  wdetail.n_branch  = "".
            END.
            ELSE ASSIGN  wdetail.n_branch  = "".
            /*IF wdetail.n_branch     = "" THEN DO:
                FIND FIRST stat.insure USE-INDEX insure01 WHERE 
                    stat.insure.compno = "TISCO" AND
                    index(wdetail.receipt_name,stat.insure.lname) <> 0 NO-LOCK NO-WAIT NO-ERROR.
                IF AVAIL stat.insure THEN 
                    ASSIGN  wdetail.n_branch  = trim(stat.insure.branch).
                ELSE ASSIGN wdetail.n_branch  = "".
            END.*/
        END.
        ELSE DO: 
            ASSIGN wdetail.nproducer = fi_producertisco
                wdetail.nagent    = fi_agenttisco  .  
            /*wdetail.n_branch  = "M".*/ /*A56-0399*/
            /* add A56-0399*/
            IF wdetail.Notify_no = "" THEN wdetail.n_branch = "".
            ELSE DO:
                IF (index("123456789",SUBSTR(wdetail.Notify_no,1,1)) <> 0 ) AND 
                (index("123456789",SUBSTR(wdetail.Notify_no,2,1)) <> 0 ) THEN  
                    ASSIGN wdetail.n_branch = substr(wdetail.Notify_no,1,2) .
                ELSE ASSIGN wdetail.n_branch = substr(wdetail.Notify_no,2,1) .
            END.
            /* add A56-0399*/
        END.    /*add...kridtiya i. A54-0325 */
    END.   /*end... ����ᴧ             */
    /*Add Kridtiya i. A55-0184 ... */
    /*IF wdetail.n_branch  = "" THEN DO:
        IF (wdetail.Notify_no <> "") AND (INDEX(wdetail.Notify_no,",") <> 0 ) THEN DO:
            FIND FIRST stat.insure USE-INDEX insure01 WHERE 
                stat.insure.compno = "TISCO" AND
                index(wdetail.Notify_no,stat.insure.lname) <> 0 NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL stat.insure THEN 
                ASSIGN  wdetail.n_branch  = trim(stat.insure.branch).
            ELSE ASSIGN wdetail.n_branch  = "".
        END.
        IF SUBSTR(wdetail.Notify_no,1,4) <> "TIST" THEN DO:
            IF SUBSTR(wdetail.Notify_no,1,1) = "D" THEN 
                 ASSIGN wdetail.n_branch  = SUBSTR(wdetail.Notify_no,2,1).
            ELSE IF (index("123456789",SUBSTR(wdetail.Notify_no,1,1)) <> 0 ) AND 
                (index("123456789",SUBSTR(wdetail.Notify_no,2,1)) <> 0 ) THEN 
                 ASSIGN wdetail.n_branch  = SUBSTR(wdetail.Notify_no,1,2).
            ELSE ASSIGN wdetail.n_branch  = "".
        END.
    END. */  /*end...Add Kridtiya i. A55-0184 ... */
END.
IF ra_poltyp = 2 THEN  Run  Pro_createfile.
ELSE Run  Pro_createfile_re.   /*A57-0088*/
---- end A59-0178-------------*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-import_insur-old1 C-Win 
PROCEDURE 00-import_insur-old1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by a64-0271      
------------------------------------------------------------------------------*/
INPUT FROM VALUE (fi_filename) .  /*create in TEMP-TABLE wImport*/
REPEAT:    
    IMPORT UNFORMATTED nv_daily.
    If  nv_daily  <>  ""  And  substr(nv_daily,1,2)  =  "01"  Then 
        ASSIGN nv_export   = DATE(INT(SUBSTR(nv_daily,84,2)),
                                  INT(SUBSTR(nv_daily,86,2)),
                                  INT(SUBSTR(nv_daily,80,4))).
    IF  nv_daily  <>  ""  And  Substr(nv_daily,1,2)  =  "02"  THEN DO:
        nv_reccnt   =  nv_reccnt  +  1.
        CREATE  wdetail.
        ASSIGN wdetail.recordID     = TRIM(SUBSTR(nv_daily,1,2))          
/*1 */         wdetail.Pro_off      = TRIM(SUBSTR(nv_daily,3,2))  
/*2 */         wdetail.cmr_code     = TRIM(SUBSTR(nv_daily,5,3))
/*3 */         wdetail.comp_code    = TRIM(SUBSTR(nv_daily,8,3))
/*4 */         wdetail.Notify_no    = TRIM(SUBSTR(nv_daily,11,25))
/*5 */         wdetail.yrmanu       = TRIM(SUBSTR(nv_daily,36,4))
/*6 */         wdetail.engine       = TRIM(SUBSTR(nv_daily,40,25))   /****  ���� 25- 35 */
/*7 */         wdetail.chassis      = TRIM(SUBSTR(nv_daily,65,25))
/*8 */         wdetail.weight       = TRIM(SUBSTR(nv_daily,90,5))
/*9 */         wdetail.power        = TRIM(String(SUBSTR(nv_daily,95,7),"9999999"))
/*10 */        wdetail.colorcode    = TRIM(SUBSTR(nv_daily,102,10))  /****  ���� 10- 25*/
/*11 */        wdetail.licence      = TRIM(SUBSTR(nv_daily,112,10))  /****  ���� 10- 20 */
/*12 */        wdetail.garage       = TRIM(SUBSTR(nv_daily,122,1))
/*13 */        wdetail.fleetper     = TRIM(SUBSTR(nv_daily,123,5))
/*14 */        wdetail.ncbper       = TRIM(SUBSTR(nv_daily,128,5))
/*15 */        wdetail.othper       = TRIM(SUBSTR(nv_daily,123,5))
/*16 */        wdetail.vehuse       = TRIM(SUBSTR(nv_daily,138,1))
/*17 */        wdetail.comdat       = TRIM(SUBSTR(nv_daily,139,8))
/*18 */        wdetail.ins_amt      = TRIM(SUBSTR(nv_daily,147,11))
/*19 */        wdetail.name_insur   = TRIM(SUBSTR(nv_daily,158,15))
/*20 */        wdetail.not_office   = TRIM(SUBSTR(nv_daily,173,75))
/*21 */        wdetail.not_date     = TRIM(SUBSTR(nv_daily,248,8))
/*22 */        wdetail.not_time     = TRIM(SUBSTR(nv_daily,256,6))
/*23 */        wdetail.not_code     = TRIM(SUBSTR(nv_daily,262,4))
/*24 */        wdetail.prem1        = TRIM(SUBSTR(nv_daily,266,11))
/*25 */        wdetail.comp_prm     = TRIM(SUBSTR(nv_daily,277,9))
/*26 */        wdetail.sckno        = TRIM(SUBSTR(nv_daily,286,25))
/*27 */        wdetail.brand        = TRIM(SUBSTR(nv_daily,311,50))
/*28 */        wdetail.pol_addr1    = TRIM(SUBSTR(nv_daily,361,50))
/*29 */        wdetail.pol_addr2    = TRIM(SUBSTR(nv_daily,411,60))
/*30 */        wdetail.pol_title    = TRIM(SUBSTR(nv_daily,471,30))
/*31 */        wdetail.pol_fname    = TRIM(SUBSTR(nv_daily,501,75))
/*32 */        wdetail.pol_lname    = TRIM(SUBSTR(nv_daily,576,45))
/*33 */        wdetail.ben_name     = TRIM(SUBSTR(nv_daily,621,65))
/*34 */        wdetail.remark       = TRIM(SUBSTR(nv_daily,686,150)).
         ASSIGN 
/*35 */        wdetail.Account_no   = TRIM(SUBSTR(nv_daily,836,10))
/*36 */        wdetail.client_no    = TRIM(SUBSTR(nv_daily,846,7))
/*37 */        wdetail.expdat       = TRIM(SUBSTR(nv_daily,853,8))
/*38 */        wdetail.gross_prm    = TRIM(SUBSTR(nv_daily,861,11))
/*39 */        wdetail.province     = TRIM(SUBSTR(nv_daily,872,18))
/*40 */        wdetail.receipt_name = TRIM(SUBSTR(nv_daily,890,50))
/*41 */        wdetail.agent        = TRIM(SUBSTR(nv_daily,940,15))
/*42 */        wdetail.prev_insur   = TRIM(SUBSTR(nv_daily,955,50))
/*43 */        wdetail.prev_pol     = TRIM(SUBSTR(nv_daily,1005,25))
/*44 */        wdetail.deduct       = TRIM(SUBSTR(nv_daily,1030,9))    
/*45 */        wdetail.addr1_70     = TRIM(SUBSTR(nv_daily,1039,50))  
/*46 */        wdetail.addr2_70     = TRIM(SUBSTR(nv_daily,1089,60))  
/*47 */        wdetail.nsub_dist70  = TRIM(SUBSTR(nv_daily,1149,30))  
/*48 */        wdetail.ndirection70 = TRIM(SUBSTR(nv_daily,1179,30))  
/*49 */        wdetail.nprovin70    = TRIM(SUBSTR(nv_daily,1209,30))  
/*50 */        wdetail.zipcode70    = TRIM(SUBSTR(nv_daily,1239,5))   
/*51 */        wdetail.addr1_72     = TRIM(SUBSTR(nv_daily,1244,50))  
/*52 */        wdetail.addr2_72     = TRIM(SUBSTR(nv_daily,1294,60))  
/*53 */        wdetail.nsub_dist72  = TRIM(SUBSTR(nv_daily,1354,30))  
/*54 */        wdetail.ndirection72 = TRIM(SUBSTR(nv_daily,1384,30))  
/*55 */        wdetail.nprovin72    = TRIM(SUBSTR(nv_daily,1414,30))  
/*56 */        wdetail.zipcode72    = TRIM(SUBSTR(nv_daily,1444,5))   
/*57 */        wdetail.apptyp       = TRIM(SUBSTR(nv_daily,1449,10))  
/*58 */        wdetail.appcode      = TRIM(SUBSTR(nv_daily,1459,2)) 
/*59 */        wdetail.id_recive70  = TRIM(SUBSTR(nv_daily,1461,13))        /*��Ţ���ѵû�Шӵ�ǻ�ЪҪ�/�Ţ��˹ѧ����Թ�ҧ /�Ţ����¹�ҳԪ��*/
/*60 */        wdetail.br_recive70  = TRIM(SUBSTR(nv_daily,1474,20))        /*�ҢҢͧʶҹ��Сͺ����١���*/
/*61 */        wdetail.id_recive72  = TRIM(SUBSTR(nv_daily,1494,13))        /*��Ţ���ѵû�Шӵ�ǻ�ЪҪ�/�Ţ��˹ѧ����Թ�ҧ /�Ţ����¹�ҳԪ��*/
/*62 */        wdetail.br_recive72  = TRIM(SUBSTR(nv_daily,1507,20))        /*�ҢҢͧʶҹ��Сͺ����١���*/
/*63 */        wdetail.comp_comdat  = TRIM(SUBSTR(nv_daily,1527,8))         /*Effective Date Accidential*/ /* start : A59-0178*/ 
/*64 */        wdetail.comp_expdat  = TRIM(SUBSTR(nv_daily,1535,8))         /*Expiry Date Accidential*/     
/*65 */        wdetail.fi           = TRIM(SUBSTR(nv_daily,1543,11))        /*Coverage Amount Theft*/       
/*66 */        wdetail.class        = TRIM(SUBSTR(nv_daily,1554,3))         /*Car code*/                    
/*67 */        wdetail.usedtype     = TRIM(SUBSTR(nv_daily,1557,1))         /*Per Used*/                    
/*68 */        wdetail.driveno1     = TRIM(SUBSTR(nv_daily,1558,2))         /*Driver Seq1*/                 
/*69 */        wdetail.drivename1   = TRIM(SUBSTR(nv_daily,1560,40))        /*Driver Name1*/                
/*70 */        wdetail.bdatedriv1   = TRIM(SUBSTR(nv_daily,1600,8))         /*Birthdate Driver1*/           
/*71 */        wdetail.occupdriv1   = TRIM(SUBSTR(nv_daily,1608,75))        /*Occupation Driver1*/          
/*72 */        wdetail.positdriv1   = TRIM(SUBSTR(nv_daily,1683,40))        /*Position Driver1 */           
/*73 */        wdetail.driveno2     = TRIM(SUBSTR(nv_daily,1723,2))         /*Driver Seq2*/                 
/*74 */        wdetail.drivename2   = TRIM(SUBSTR(nv_daily,1725,40))        /*Driver Name2*/                
/*75 */        wdetail.bdatedriv2   = TRIM(SUBSTR(nv_daily,1765,8))         /*Birthdate Driver2*/           
/*76 */        wdetail.occupdriv2   = TRIM(SUBSTR(nv_daily,1773,75))        /*Occupation Driver2*/          
/*77 */        wdetail.positdriv2   = TRIM(SUBSTR(nv_daily,1848,40))        /*Position Driver2*/            
/*78 */        wdetail.driveno3     = TRIM(SUBSTR(nv_daily,1888,2))         /*Driver Seq3*/                 
/*79 */        wdetail.drivename3   = TRIM(SUBSTR(nv_daily,1890,40))        /*Driver Name3*/                
/*80 */        wdetail.bdatedriv3   = TRIM(SUBSTR(nv_daily,1930,8))         /*Birthdate Driver3*/           
/*81 */        wdetail.occupdriv3   = TRIM(SUBSTR(nv_daily,1938,75))        /*Occupation Driver3*/          
/*82 */        wdetail.positdriv3   = TRIM(SUBSTR(nv_daily,2013,40))        /*Position Driver3*/    
             
/*83 */        wdetail.caracc       = TRIM(SUBSTR(nv_daily,2053,250))       /*Car Accessories*/    /** Car Accessories  2088 3837 1750 �ػ�ó쵡��   */  /* start : A63-0210*/ 
/*84 */        wdetail.Rec_name72   = TRIM(SUBSTR(nv_daily,2303,150))       /*Accidential Receipt name*/        
/*85 */        wdetail.Rec_add1     = TRIM(SUBSTR(nv_daily,2453,60))        /*Accidential Receipt Address 1*/   
/*86 */        wdetail.Rec_add2     = TRIM(SUBSTR(nv_daily,2513,60))        /*Accidential Receipt Address 2*/   /* end : A63-0210*/ 
/*88** accessories Y/N 4108 4108 1  accessories Y/N �ó��բ������ػ�ó�����ʴ���� Y /N  */
/*89** accessories coverage 4109 4119 11  �ʴ��ع��Сѹ��ǹ���� */
/*90** accessories premium 4120 4130 11   �ʴ�������»�Сѹ��ǹ���� */
/*91** ��Ǩ��Ҿö (Y/N) 4131 4131 1      ��Ǩ��Ҿö Y/N �óյ�Ǩ��Ҿ����ʴ���� Y �������ͧ��Ǩ��Ҿ����ʴ���� N */
/*92** �Ţ�����ҧ�ԧ���������  4132 4151 20*/
/*93** TYPE OF INSURANCE    4152 4152 1 ��������Сѹ 1 2 3 */ 

/*87 */        wdetail.nBLANK       = TRIM(SUBSTR(nv_daily,2573,28)) .      /* Blank */ /* end : A59-0178*/ 
    END.
END.    /* repeat  */ 
FOR EACH wdetail.
    RUN proc_cutengno.     /*A56-0323*/
    RUN proc_cutchassis.   /*A56-0323*/
    RUN proc_licence.      /*A60-0095*/
    RUN proc_addclass.     /*A60-0095*/
    /*add by : A64-0271*/
    ASSIGN n_address  = "" 
           /* ranu 07/08/2021 */ 
           n_build    = ""      n_tambon   = ""      
           n_amper    = ""      n_country  = ""      
           n_post     = "".
          /* end :ranu 07/08/2021 */
           n_address   = trim(trim(wdetail.pol_addr1) + " " + trim(wdetail.pol_addr2)).
    IF n_address <> ""  AND index(n_address,"��Ҥ�÷����") = 0 THEN DO:
        RUN proc_chkaddr.
        ASSIGN wdetail.pol_addr1 = trim(n_build)
               wdetail.pol_addr2 = trim(n_tambon) + " " + trim(n_amper) + " " + trim(n_country) + " " + trim(n_post) .
    END.

    ASSIGN  
        n_address = ""
        /* ranu 07/08/2021 */ 
        n_build    = ""      n_tambon   = ""      
        n_amper    = ""      n_country  = ""      
        n_post     = ""
        /* end :ranu 07/08/2021 */
        n_address = trim(trim(wdetail.addr1_70) + " " + trim(wdetail.addr2_70)     + " " +
                    trim(wdetail.nsub_dist70)   + " " + trim(wdetail.ndirection70) + " " + 
                    trim(wdetail.nprovin70)     + " " + trim(wdetail.zipcode70)) .   
    IF n_address <> "" AND index(n_address,"��Ҥ�÷����") = 0 THEN DO: 
        RUN proc_chkaddr .  
        ASSIGN wdetail.addr1_70      = trim(n_build)  
              wdetail.addr2_70       = ""
              wdetail.nsub_dist70    = trim(n_tambon) 
              wdetail.ndirection70   = trim(n_amper)  
              wdetail.nprovin70      = trim(n_country)
              wdetail.zipcode70      = trim(n_post) .
    END.

    ASSIGN n_address = ""
           /* ranu 07/08/2021 */ 
           n_build    = ""      n_tambon   = ""      
           n_amper    = ""      n_country  = ""      
           n_post     = ""
          /* end :ranu 07/08/2021 */ 
           n_address = trim(trim(wdetail.addr1_72) + " " + trim(wdetail.addr2_72)     + " " +
                       trim(wdetail.nsub_dist72)   + " " + trim(wdetail.ndirection72) + " " + 
                       trim(wdetail.nprovin72)     + " " + trim(wdetail.zipcode72)) .   
    IF n_address <> "" AND index(n_address,"��Ҥ�÷����") = 0 THEN DO: 
        RUN proc_chkaddr .   
        ASSIGN wdetail.addr1_72      = trim(n_build)  
              wdetail.addr2_72       = ""
              wdetail.nsub_dist72    = trim(n_tambon) 
              wdetail.ndirection72   = trim(n_amper)  
              wdetail.nprovin72      = trim(n_country)
              wdetail.zipcode72      = trim(n_post) .
    END.

    ASSIGN n_address = ""
           /* ranu 07/08/2021 */ 
           n_build    = ""      n_tambon   = ""      
           n_amper    = ""      n_country  = ""      
           n_post     = ""
          /* end :ranu 07/08/2021 */
           n_address =  trim(trim(wdetail.Rec_add1) + " " + trim(wdetail.Rec_add2)).
    IF n_address <> "" AND index(n_address,"��Ҥ�÷����") = 0 THEN DO: 
        RUN proc_chkaddr . /* ranu 07/08/2021*/
        ASSIGN wdetail.Rec_add1 = trim(n_build)
               wdetail.Rec_add2 = trim(n_tambon) + " " + trim(n_amper) + " " + trim(n_country) + " " + trim(n_post) .
    END.
    
    IF ra_poltyp = 1  THEN RUN proc_renew. /*A60-0095*/
    ELSE RUN proc_new. /*A60-0095*/
   
END.    
IF ra_poltyp = 2 THEN  Run  Pro_createfile.
ELSE Run  Pro_createfile_re.   /*A57-0088*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_new-02 C-Win 
PROCEDURE 00-proc_new-02 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* COMMENT by A67-0114..
IF ra_poltyp = 2  THEN DO:      /* ����ᴧ */
    ASSIGN  wdetail.n_covcod      = "" 
            wdetail.price_ford    = IF INDEX(wdetail.remark,"P.") <> 0 THEN trim(SUBSTR(wdetail.remark,INDEX(wdetail.remark,"P.") + 2 )) ELSE ""
            wdetail.price_ford    = IF wdetail.price_ford = "" THEN "" 
                                    ELSE IF INDEX(wdetail.price_ford," ") <> 0 THEN trim(SUBSTR(wdetail.price_ford,1,INDEX(wdetail.price_ford," ")))
                                    ELSE trim(wdetail.price_ford)
            wdetail.comdat        = IF wdetail.comdat = "00000000" THEN wdetail.comp_comdat ELSE wdetail.comdat
            wdetail.expdat        = IF wdetail.expdat = "00000000" THEN wdetail.comp_expdat ELSE wdetail.expdat.
        RUN proc_redbook.    /* A57-0088 */
        /*-- create by : Ranu I. A60-0095 ---*/
        IF nv_premt3 = 0 THEN DO:               /*A61-0045*/ 
            ASSIGN wdetail.n_covcod  = "T".     /*A61-0045*/ 
        END.                                    /*A61-0045*/ 
        ELSE IF nv_premt3 = 7500.70 OR nv_premt3 = 8500.08 OR nv_premt3 = 9500.53  THEN DO:
            ASSIGN wdetail.n_covcod  = "2.2".
        END.
        ELSE IF nv_premt3 = 6300 OR nv_premt3 = 7300 OR nv_premt3 = 7500 OR nv_premt3 = 8300  THEN DO:
            ASSIGN  wdetail.n_covcod = "3.2".
        END.
        ELSE IF ( nv_premt3 <= 10000 ) AND (nv_premt3 > 3500 )  THEN DO: 
            ASSIGN wdetail.n_covcod  = "2".
        END.
        ELSE IF (nv_premt3 <= 3000 ) THEN DO:
            ASSIGN  wdetail.n_covcod = "3".
        END.
        ELSE IF (nv_premt3 >= 10000 ) THEN DO:
            ASSIGN  wdetail.n_covcod = "1".
        END.
        /*-- end : A60-0095 ---*/
        ASSIGN 
            n_brand = IF INDEX(wdetail.brand," ") <> 0 THEN trim(SUBSTR(wdetail.brand,1,INDEX(wdetail.brand," ") - 1 )) ELSE trim(wdetail.brand).
        IF n_brand = "ISUZU" THEN DO:
           IF      nv_premt3 = 17355.40 THEN ASSIGN wdetail.n_pack = "110" .
           ELSE IF nv_premt3 = 17033.33 THEN ASSIGN wdetail.n_pack = "210" . 
           ELSE IF nv_premt3 = 20855.37 THEN ASSIGN wdetail.n_pack = "110" .
           ELSE IF nv_premt3 = 21566.22 THEN ASSIGN wdetail.n_pack = "110" .
           IF      wdetail.n_pack = "110" THEN ASSIGN wdetail.n_seattisc = 7.
           ELSE IF wdetail.n_pack = "210" THEN ASSIGN wdetail.n_seattisc = 5.
           ELSE ASSIGN wdetail.n_seattisc = 3.
        END.
        /*-----------A60-0225-------------*/
        IF ((n_brand = "Mazda" ) AND (nv_premt3 = 17148.89 OR nv_premt3 = 18986.08 OR
           nv_premt3 = 16536.85  OR   nv_premt3 = 17760.93 OR nv_premt3 = 46546.07 OR
           nv_premt3 = 51445.60 )) THEN DO:
            FIND LAST WComp WHERE wcomp.cartyp = "MPI" AND wcomp.brand  = trim(n_brand) NO-LOCK  NO-ERROR NO-WAIT.
                        IF AVAIL wcomp THEN 
                            ASSIGN wdetail.n_pack   = wcomp.package + wdetail.n_pack
                                   wdetail.n_branch =  "" .
                        IF wdetail.n_pack = "M110" THEN ASSIGN wdetail.n_seattisc = 7.
                        IF wdetail.n_pack = "M320" THEN ASSIGN wdetail.n_seattisc = 5.
        END.
        ELSE DO:
        /*-------- end : A60-0225 ------*/
            FIND LAST WComp WHERE  wcomp.cartyp = "new" AND wcomp.brand  = trim(n_brand) NO-LOCK  NO-ERROR NO-WAIT.
                IF NOT AVAIL wcomp THEN DO:
                    FIND LAST WComp WHERE  wcomp.cartyp  = "new" AND wcomp.brand   = "OTHER" AND
                                           wcomp.cover   = "1" NO-LOCK  NO-ERROR NO-WAIT.
                            IF AVAIL wcomp THEN 
                                ASSIGN wdetail.n_pack   = wcomp.package + wdetail.n_pack
                                       wdetail.n_branch = trim(wcomp.branch) 
                                       wdetail.bi       = TRIM(wcomp.bi)  
                                       wdetail.pa       = TRIM(wcomp.pa)  
                                       wdetail.pd       = TRIM(wcomp.pd) . 
                END.
                ELSE ASSIGN wdetail.n_pack   = wcomp.package + wdetail.n_pack
                            wdetail.n_branch = trim(wcomp.branch).
                IF wdetail.n_pack = "O320"  THEN ASSIGN wdetail.n_seattisc = 5.
        END.
        /*-- A60-0095--*/
        IF wdetail.n_covcod = "1" THEN DO: /*A60-0095*/
            IF n_brand = "CHEVROLET" THEN DO:
               FIND LAST wcomp WHERE wcomp.brand = trim(n_brand) AND wcomp.n_class = substr(wdetail.n_pack,2,3) NO-LOCK NO-ERROR .
                   IF AVAIL wcomp THEN
                        ASSIGN wdetail.n_branch = trim(wcomp.branch)
                               wdetail.bi       = TRIM(wcomp.bi)
                               wdetail.pa       = TRIM(wcomp.pa)
                               wdetail.pd       = TRIM(wcomp.pd)
                               wdetail.n_seattisco = INT(wcomp.seat).
            END.
            ELSE IF n_brand = "ISUZU" THEN DO:
               FIND LAST wcomp WHERE wcomp.brand = trim(n_brand) NO-LOCK NO-ERROR .
                   IF AVAIL wcomp THEN
                       ASSIGN wdetail.bi   = TRIM(wcomp.bi)
                          wdetail.pa       = TRIM(wcomp.pa)
                          wdetail.pd       = TRIM(wcomp.pd).
            END. /*-- end:A60-0095--*/
            /*--A60-0225--*/
            ELSE IF n_brand = "MAZDA" AND wdetail.n_pack = "M320" OR wdetail.n_pack = "M110" THEN DO:
                FIND LAST wcomp WHERE wcomp.brand = trim(n_brand) NO-LOCK NO-ERROR .
                   IF AVAIL wcomp THEN
                       ASSIGN wdetail.bi   = TRIM(wcomp.bi)
                              wdetail.pa   = TRIM(wcomp.pa)
                              wdetail.pd   = TRIM(wcomp.pd).
            END.
            /*-- end : A60-0225--*/
            ELSE IF n_brand = "HYUNDAI" THEN DO:
               FIND LAST wcomp WHERE wcomp.brand = trim(n_brand) NO-LOCK NO-ERROR .
                   IF AVAIL wcomp THEN
                       ASSIGN wdetail.bi   = TRIM(wcomp.bi)
                          wdetail.pa       = TRIM(wcomp.pa)
                          wdetail.pd       = TRIM(wcomp.pd).
            END.
            ELSE DO: 
                /* Add by : A67-0087 */
                IF wdetail.bev = "Y" THEN DO:
                    FIND LAST wcomp WHERE wcomp.brand = trim(n_brand) NO-LOCK NO-ERROR .
                       IF AVAIL wcomp THEN
                           ASSIGN wdetail.bi   = TRIM(wcomp.bi)
                              wdetail.pa       = TRIM(wcomp.pa)
                              wdetail.pd       = TRIM(wcomp.pd).
                END.
                ELSE DO:
                   FIND LAST wcomp WHERE wcomp.brand = trim(n_brand) AND wcomp.cover = TRIM(wdetail.n_covcod) NO-LOCK NO-ERROR .
                       IF AVAIL wcomp THEN
                           ASSIGN wdetail.n_pack   = wcomp.package + substr(wdetail.n_pack,2,LENGTH(wdetail.n_pack))
                              wdetail.bi       = TRIM(wcomp.bi)
                              wdetail.pa       = TRIM(wcomp.pa)
                              wdetail.pd       = TRIM(wcomp.pd).
                       ELSE ASSIGN wdetail.bi  = ""
                                  wdetail.pa   = ""
                                  wdetail.pd   = "".
                END. /* end : A67-0087 */
            END.
        END. /* end �.1 */
        ELSE IF wdetail.n_covcod = "2" OR wdetail.n_covcod = "3" THEN DO:
            FIND LAST WComp WHERE  wcomp.cover = "2-3" NO-LOCK  NO-ERROR NO-WAIT.
               IF AVAIL wcomp THEN 
                   ASSIGN wdetail.n_branch = trim(wcomp.branch) 
                          wdetail.bi       = TRIM(wcomp.bi)
                          wdetail.pa       = TRIM(wcomp.pa)
                          wdetail.pd       = TRIM(wcomp.pd)
                          wdetail.n_pack   = IF wdetail.n_covcod = "2" THEN "Y" + SUBSTR(wdetail.n_pack,2,3) 
                                             ELSE  "R" + SUBSTR(wdetail.n_pack,2,3).
        END.
        /*--A60-0095--*/
        ELSE DO:
            FIND LAST wcomp WHERE wcomp.cover = wdetail.n_covcod NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL wcomp THEN
                 ASSIGN wdetail.n_pack   = IF LENGTH(wdetail.n_pack) <> 4 THEN  wcomp.package + wdetail.n_pack 
                                           ELSE wcomp.package + SUBSTR(wdetail.n_pack,2,3)
                        wdetail.n_branch = trim(wcomp.branch)
                        wdetail.bi       = TRIM(wcomp.bi)
                        wdetail.pa       = TRIM(wcomp.pa)
                        wdetail.pd       = TRIM(wcomp.pd).
            ELSE ASSIGN wdetail.n_pack   = IF LENGTH(wdetail.n_pack) <> 4 THEN  "C" + wdetail.n_pack 
                                           ELSE "C" + SUBSTR(wdetail.n_pack,2,3)
                        wdetail.n_branch = "" .
        END.
        /*-- end:A60-0095--*/
        IF INDEX(wdetail.n_pack,"F") <> 0 THEN ASSIGN wdetail.n_pack = TRIM("T" + SUBSTR(wdetail.n_pack,2,3)) . /*A67-0114*/
        ASSIGN wdetail.n_typpol  = "NEW".
        ASSIGN  np_dealer = ""
            np_dealer = IF index(wdetail.Notify_no,",") <> 0 THEN trim(SUBSTR(wdetail.Notify_no,index(wdetail.Notify_no,",") + 1 )) ELSE ""  /*A56-0399*/
            wdetail.n_branch  = "".
        IF  index(wdetail.brand,"FORD") <> 0 THEN DO:
            ASSIGN wdetail.n_branch  = ""
                   wdetail.nproducer = fi_producerford   
                   wdetail.nagent    = fi_agentford .
            IF INDEX(wdetail.remark,"_2Y") <> 0  THEN 
                ASSIGN wdetail.n_branch  = ""
                   wdetail.nproducer = fi_producerford2y  
                   wdetail.nagent    = fi_agentford2y . 
        END.
        /* Add by : A67-0087 */
        ELSE IF  index(wdetail.brand,"HAVAL") <> 0 OR index(wdetail.brand,"TANK") <> 0  OR (index(wdetail.brand,"ORA") <> 0 AND wdetail.carbrand = "ORA" ) THEN DO:
            RUN proc_new_producer. /*A67-0114*/
            /* comment by : a67-0114..
            IF INDEX(wdetail.remark,"_2Y") <> 0  THEN DO:
                ASSIGN wdetail.n_branch  = ""
                   wdetail.nproducer = "B3DM000008"  
                   wdetail.nagent    = "B3M0002" .  
            END.
            ELSE IF INDEX(wdetail.remark,"Demo") <> 0 OR  INDEX(wdetail.remark,"���ͧ�Ѻ") <> 0 OR INDEX(wdetail.remark,"ö������������") <> 0 THEN DO:
                ASSIGN wdetail.n_branch  = ""
                   wdetail.n_pack    = "E12"
                   wdetail.nproducer = "B3DM000005"  
                   wdetail.nagent    = "B3M0002" .  
            END.
            ELSE IF INDEX(wdetail.remark,"CPO") <> 0 THEN DO:
                ASSIGN wdetail.n_branch  = ""
                   wdetail.nproducer = "B3DM000007"  
                   wdetail.nagent    = "B3M0002" .  
            END.
            ELSE IF INTE(wdetail.yrmanu) = YEAR(TODAY) THEN DO:
                ASSIGN wdetail.n_branch  = ""
                   wdetail.nproducer = "B3DM000006"  
                   wdetail.nagent    = "B3M0002" .  
            END.
            ELSE 
                 ASSIGN wdetail.n_branch  = ""
                   wdetail.nproducer = "B3DM000007"  
                   wdetail.nagent    = "B3M0002" .  
            ...end a67-0114 ..*/
        END.
        /* end : A67-0087 */
        ELSE IF  index(wdetail.brand,"HYUNDAI") <> 0 THEN DO:     /*Kridtiya i. A67-0036*/
            IF nv_premt3 = 0  THEN
                ASSIGN wdetail.n_branch  = ""
                   wdetail.nproducer = fi_proHyundai  
                   wdetail.nagent    = fi_proHyundai  . /*cmi*/
            ELSE 
                ASSIGN wdetail.n_branch  = ""
                    wdetail.nproducer = fi_proHyundai  
                    wdetail.nagent    = fi_agentHyundai.  
        END.          /*Kridtiya i. A67-0036*/
       
        ELSE DO:
            IF index(wdetail.brand,"ISUZU") <> 0 THEN DO:   /*case : ISUZU */
                /* A64-0092  ö��÷ء */
                IF index(wdetail.brand,"Wheels") <> 0 OR index(wdetail.brand,"Trailer") <> 0 
                OR index(wdetail.brand,"TRUCK")  <> 0 /* A64-0431*/ THEN DO: 
                     ASSIGN wdetail.nproducer = fi_pdtkcode   
                            wdetail.nagent    = fi_agtkcode .
                END.
                /* end A64-0092*/
                /*--A60-0225---*/
                ELSE IF INDEX(wdetail.not_office,"CIN(FEET)") <> 0 THEN DO:
                    ASSIGN wdetail.nproducer = fi_producercir   
                           wdetail.nagent    = fi_agenttiscocir .
                END.
                /*-- end : A60-0225---*/
                /* A64-0092 ö��硻���ᴧ */
                ELSE IF wdetail.yrmanu = trim(fi_year) THEN DO: 
                    ASSIGN wdetail.n_branch  = ""
                           wdetail.nproducer = fi_produceris
                           wdetail.nagent    = fi_agenttiscois.
                END.
                /* end : A64-0092 */
                ELSE ASSIGN wdetail.nproducer = fi_producertisco              
                           wdetail.nagent    = fi_agenttisco .
            END.
            /* A64-0092 */
            ELSE IF index(wdetail.brand,"HINO")  <> 0 OR index(wdetail.brand,"Trailer") <> 0 OR index(wdetail.brand,"TRUCK") <> 0 /* A64-0431*/ THEN DO: /*ö��÷ء */
                ASSIGN wdetail.nproducer = fi_pdtkcode   
                       wdetail.nagent    = fi_agtkcode .
            END.
            ELSE IF index(wdetail.brand,"YAMAHA") <> 0 OR index(wdetail.brand,"TRIUMPH") <> 0 OR index(wdetail.brand,"KAWASAKI") <> 0 THEN DO:  /* bigbike*/
                    ASSIGN wdetail.nproducer = fi_pdbkcode   
                           wdetail.nagent    = fi_agbkcode .
            END.
            ELSE IF (index(wdetail.brand,"SUZUKI") <> 0 AND  DECI(wdetail.power) < 1000 ) OR
                    (index(wdetail.brand,"HONDA")  <> 0 AND DECI(wdetail.power) < 1000 ) AND
                    (index(wdetail.remark,"Deduct") <> 0 OR index(wdetail.remark,"DD") <> 0 ) THEN DO: /* bigbike*/
                    ASSIGN wdetail.nproducer = fi_pdbkcode   
                           wdetail.nagent    = fi_agbkcode .
            END.
            /* end A64-0092 */
            /*--A60-0225---*/
            ELSE IF INDEX(wdetail.not_office,"CIN(FEET)") <> 0 THEN DO:
                ASSIGN wdetail.nproducer = fi_producercir   
                       wdetail.nagent    = fi_agenttiscocir .
            END.
            /*-- end : A60-0225---*/
            ELSE ASSIGN wdetail.nproducer = fi_producertisco              
                        wdetail.nagent    = fi_agenttisco .
            /*-- end A59-0618 --*/
            /*-- A60-0095 --*/
            IF wdetail.n_covcod  <> "1" AND index(wdetail.Notify_no,"TISTY") <> 0  THEN DO:
                /*--A60-0225---*/
                IF INDEX(wdetail.not_office,"CIN(FEET)") <> 0 THEN DO:
                    ASSIGN wdetail.nproducer = fi_producercir   
                           wdetail.nagent    = fi_agenttiscocir .
                END.
                /*-- end : A60-0225---*/
                /* A64-0092 */
                ELSE IF index(wdetail.brand,"HINO") <> 0 OR index(wdetail.brand,"Trailer") <> 0 THEN DO: /*ö��÷ء */
                    ASSIGN wdetail.nproducer = fi_pdtkcode   
                           wdetail.nagent    = fi_agtkcode .
                END.
                ELSE IF index(wdetail.brand,"YAMAHA") <> 0 OR index(wdetail.brand,"TRIUMPH") <> 0 OR index(wdetail.brand,"KAWASAKI") <> 0 THEN DO:  /* bigbike*/
                        ASSIGN wdetail.nproducer = fi_pdbkcode   
                               wdetail.nagent    = fi_agbkcode .
                END.
                ELSE IF (index(wdetail.brand,"SUZUKI") <> 0 AND  DECI(wdetail.power) < 1000 ) OR
                         (index(wdetail.brand,"HONDA")  <> 0 AND DECI(wdetail.power) < 1000 ) AND
                         (index(wdetail.remark,"Deduct") <> 0 OR index(wdetail.remark,"DD") <> 0 ) THEN DO: /* bigbike*/
                        ASSIGN wdetail.nproducer = fi_pdbkcode   
                               wdetail.nagent    = fi_agbkcode .
                END.
                /* end A64-0092 */
                ELSE IF wdetail.Pro_off <> "17" THEN DO:
                    ASSIGN wdetail.n_branch  = "M"
                           wdetail.nproducer = "B3MLTIS103"  /*A64-0092*/ 
                           wdetail.nagent    = "B3MLTIS100". /*A64-0092*/ 
                          /* wdetail.nproducer = "A0M2011" */ /*A64-0092*/
                          /* wdetail.nagent    = "B3M0002".*/ /*A64-0092*/
                END.
                ELSE 
                    ASSIGN wdetail.n_branch  = "U"
                           wdetail.nproducer = "B3MLTIS201"  /*A64-0092*/  
                           wdetail.nagent    = "B3MLTIS200". /*A64-0092*/     
                           /*wdetail.nproducer = "B3M0003" */ /*A64-0092*/
                           /*wdetail.nagent    = "B3M0002".*/ /*A64-0092*/
            END.
        END. /* A64-0271 */
        IF INDEX(fi_filename,"Solution_") <> 0 THEN DO:
            ASSIGN wdetail.nproducer = "B3MLTIS104"
                   wdetail.nagent    = "B3MLTIS100" .
        END.
        IF  np_dealer <> "" THEN DO:
            FIND FIRST stat.insure USE-INDEX insure01 WHERE 
                stat.insure.compno = "TISCO" AND stat.insure.lname  = np_dealer NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL stat.insure THEN ASSIGN  wdetail.n_branch  = trim(stat.insure.branch).
            ELSE DO: 
                /* A65-0035 */
                FIND FIRST stat.insure USE-INDEX insure01 WHERE 
                stat.insure.compno = "GWM" AND stat.insure.lname  = np_dealer NO-LOCK NO-WAIT NO-ERROR.
                IF AVAIL stat.insure THEN ASSIGN  wdetail.n_branch  = trim(stat.insure.branch).
                ELSE DO: 
                    FIND FIRST stat.insure USE-INDEX insure01 WHERE 
                        stat.insure.compno = "HYUNDAI" AND stat.insure.lname  = np_dealer NO-LOCK NO-WAIT NO-ERROR.    /*Kridtiya i. A67-0036*/
                    IF AVAIL stat.insure THEN ASSIGN  wdetail.n_branch  = trim(stat.insure.branch).
                    ELSE ASSIGN  wdetail.n_branch  = "" .
                END.
            END.
        END.
        ELSE DO:  /* start : A59-0618 */
            ASSIGN  wdetail.n_branch  = "".
            IF wdetail.Notify_no = "" THEN wdetail.n_branch = "".
            ELSE DO:
                IF (index("123456789",SUBSTR(wdetail.Notify_no,1,1)) <> 0 ) AND 
                (index("123456789",SUBSTR(wdetail.Notify_no,2,1)) <> 0 ) THEN  
                    ASSIGN wdetail.n_branch = substr(wdetail.Notify_no,1,2) .
                ELSE DO: 
                    IF SUBSTR(wdetail.notify,1,1) <> "D" THEN ASSIGN wdetail.n_branch = "" .
                    ELSE ASSIGN wdetail.n_branch = substr(wdetail.Notify_no,2,1) .
                END.
            END.
        END. /* end A59-0618 */
       IF INDEX(wdetail.n_pack,"O") <> 0  THEN DO:
            FIND LAST WComp WHERE trim(wcomp.package) = "O" NO-LOCK  NO-ERROR NO-WAIT.
                IF AVAIL wcomp THEN DO:
                  ASSIGN wdetail.bi   = TRIM(wcomp.bi)
                         wdetail.pa   = TRIM(wcomp.pa)
                         wdetail.pd   = TRIM(wcomp.pd).
                END.
        END.
END. */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_new_01 C-Win 
PROCEDURE 00-proc_new_01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Create by A61-0410     
------------------------------------------------------------------------------*/
/* comment by :  A63-0472 
IF ra_poltyp = 2  THEN DO:      /* ����ᴧ */
    ASSIGN  wdetail.n_covcod      = "" 
            wdetail.price_ford    = IF INDEX(wdetail.remark,"P.") <> 0 THEN trim(SUBSTR(wdetail.remark,INDEX(wdetail.remark,"P.") + 2 )) ELSE ""
            wdetail.price_ford    = IF wdetail.price_ford = "" THEN "" 
                                    ELSE IF INDEX(wdetail.price_ford," ") <> 0 THEN trim(SUBSTR(wdetail.price_ford,1,INDEX(wdetail.price_ford," ")))
                                    ELSE trim(wdetail.price_ford)
            wdetail.comdat        = IF wdetail.comdat = "00000000" THEN wdetail.comp_comdat ELSE wdetail.comdat
            wdetail.expdat        = IF wdetail.expdat = "00000000" THEN wdetail.comp_expdat ELSE wdetail.expdat.
        RUN proc_redbook.    /* A57-0088 */
        
        /*-- create by : Ranu I. A60-0095 ---*/
        IF nv_premt3 = 0 THEN DO:               /*A61-0045*/ 
            ASSIGN wdetail.n_covcod  = "T".     /*A61-0045*/ 
        END.                                    /*A61-0045*/ 
        ELSE IF nv_premt3 = 7500.70 OR nv_premt3 = 8500.08 OR nv_premt3 = 9500.53  THEN DO:
            ASSIGN wdetail.n_covcod  = "2.2".
        END.
        ELSE IF nv_premt3 = 6300 OR nv_premt3 = 7300 OR nv_premt3 = 7500 OR nv_premt3 = 8300  THEN DO:
            ASSIGN  wdetail.n_covcod = "3.2".
        END.
        ELSE IF ( nv_premt3 <= 10000 ) AND (nv_premt3 > 3500 )  THEN DO: 
            ASSIGN wdetail.n_covcod  = "2".
        END.
        ELSE IF (nv_premt3 <= 3000 ) THEN DO:
            ASSIGN  wdetail.n_covcod = "3".
        END.
        ELSE IF (nv_premt3 >= 10000 ) THEN DO:
            ASSIGN  wdetail.n_covcod = "1".
        END.
        /*-- end : A60-0095 ---*/
        ASSIGN 
            n_brand = IF INDEX(wdetail.brand," ") <> 0 THEN trim(SUBSTR(wdetail.brand,1,INDEX(wdetail.brand," ") - 1 )) ELSE trim(wdetail.brand).
        IF n_brand = "ISUZU" THEN DO:
           IF      nv_premt3 = 17355.40 THEN ASSIGN wdetail.n_pack = "110" .
           ELSE IF nv_premt3 = 17033.33 THEN ASSIGN wdetail.n_pack = "210" . 
           ELSE IF nv_premt3 = 20855.37 THEN ASSIGN wdetail.n_pack = "110" .
           ELSE IF nv_premt3 = 21566.22 THEN ASSIGN wdetail.n_pack = "110" .

           IF      wdetail.n_pack = "110" THEN ASSIGN wdetail.n_seattisc = 7.
           ELSE IF wdetail.n_pack = "210" THEN ASSIGN wdetail.n_seattisc = 5.
           ELSE ASSIGN wdetail.n_seattisc = 3.
        END.
        /*-----------A60-0225-------------*/
        IF ((n_brand = "Mazda" ) AND (nv_premt3 = 17148.89 OR nv_premt3 = 18986.08 OR
           nv_premt3 = 16536.85  OR   nv_premt3 = 17760.93 OR nv_premt3 = 46546.07 OR
           nv_premt3 = 51445.60 )) THEN DO:
            FIND LAST WComp WHERE wcomp.cartyp = "MPI" AND wcomp.brand  = trim(n_brand) NO-LOCK  NO-ERROR NO-WAIT.
                        IF AVAIL wcomp THEN 
                            ASSIGN wdetail.n_pack   = wcomp.package + wdetail.n_pack
                                   wdetail.n_branch =  "" .

                        IF wdetail.n_pack = "M110" THEN ASSIGN wdetail.n_seattisc = 7.
                        IF wdetail.n_pack = "M320" THEN ASSIGN wdetail.n_seattisc = 5.
        END.
        ELSE DO:
        /*-------- end : A60-0225 ------*/
            FIND LAST WComp WHERE  wcomp.cartyp = "new" AND wcomp.brand  = trim(n_brand) NO-LOCK  NO-ERROR NO-WAIT.
                IF NOT AVAIL wcomp THEN DO:
                    FIND LAST WComp WHERE  wcomp.cartyp  = "new" AND wcomp.brand   = "OTHER" AND
                                           wcomp.cover   = "1" NO-LOCK  NO-ERROR NO-WAIT.
                            IF AVAIL wcomp THEN 
                                ASSIGN wdetail.n_pack   = wcomp.package + wdetail.n_pack
                                       wdetail.n_branch = trim(wcomp.branch) 
                                       wdetail.bi       = TRIM(wcomp.bi)  
                                       wdetail.pa       = TRIM(wcomp.pa)  
                                       wdetail.pd       = TRIM(wcomp.pd) . 
                END.
                ELSE ASSIGN wdetail.n_pack   = wcomp.package + wdetail.n_pack
                            wdetail.n_branch = trim(wcomp.branch).
                
                IF wdetail.n_pack = "O320"  THEN ASSIGN wdetail.n_seattisc = 5.
        END.
        /*-- A60-0095--*/
        IF wdetail.n_covcod = "1" THEN DO: /*A60-0095*/
            IF n_brand = "CHEVROLET" THEN DO:
               FIND LAST wcomp WHERE wcomp.brand = trim(n_brand) AND wcomp.n_class = substr(wdetail.n_pack,2,3) NO-LOCK NO-ERROR .
                   IF AVAIL wcomp THEN
                        ASSIGN wdetail.n_branch = trim(wcomp.branch)
                               wdetail.bi       = TRIM(wcomp.bi)
                               wdetail.pa       = TRIM(wcomp.pa)
                               wdetail.pd       = TRIM(wcomp.pd)
                               wdetail.n_seattisco = INT(wcomp.seat).
            END.
            ELSE IF n_brand = "ISUZU" THEN DO:
               FIND LAST wcomp WHERE wcomp.brand = trim(n_brand) NO-LOCK NO-ERROR .
                   IF AVAIL wcomp THEN
                       ASSIGN wdetail.bi   = TRIM(wcomp.bi)
                          wdetail.pa       = TRIM(wcomp.pa)
                          wdetail.pd       = TRIM(wcomp.pd).
            END.
            /*-- end:A60-0095--*/
            /*--A60-0225--*/
            ELSE IF n_brand = "MAZDA" AND wdetail.n_pack = "M320" OR wdetail.n_pack = "M110" THEN DO:
                FIND LAST wcomp WHERE wcomp.brand = trim(n_brand) NO-LOCK NO-ERROR .
                   IF AVAIL wcomp THEN
                       ASSIGN wdetail.bi   = TRIM(wcomp.bi)
                              wdetail.pa   = TRIM(wcomp.pa)
                              wdetail.pd   = TRIM(wcomp.pd).
            END.
            /*-- end : A60-0225--*/
            ELSE  
                ASSIGN wdetail.bi   = ""
                       wdetail.pa   = ""
                       wdetail.pd   = "".
           
        END.
        ELSE IF wdetail.n_covcod = "2" OR wdetail.n_covcod = "3" THEN DO:
            FIND LAST WComp WHERE  wcomp.cover = "2-3" NO-LOCK  NO-ERROR NO-WAIT.
               IF AVAIL wcomp THEN 
                   ASSIGN wdetail.n_branch = trim(wcomp.branch) 
                          wdetail.bi       = TRIM(wcomp.bi)
                          wdetail.pa       = TRIM(wcomp.pa)
                          wdetail.pd       = TRIM(wcomp.pd)
                          wdetail.n_pack   = IF wdetail.n_covcod = "2" THEN "Y" + SUBSTR(wdetail.n_pack,2,3) 
                                             ELSE  "R" + SUBSTR(wdetail.n_pack,2,3).
        END.
        /*--A60-0095--*/
        ELSE DO:
            FIND LAST wcomp WHERE wcomp.cover = wdetail.n_covcod NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL wcomp THEN
                 ASSIGN wdetail.n_pack   = IF LENGTH(wdetail.n_pack) <> 4 THEN  wcomp.package + wdetail.n_pack 
                                           ELSE wcomp.package + SUBSTR(wdetail.n_pack,2,3)
                        wdetail.n_branch = trim(wcomp.branch)
                        wdetail.bi       = TRIM(wcomp.bi)
                        wdetail.pa       = TRIM(wcomp.pa)
                        wdetail.pd       = TRIM(wcomp.pd).
            ELSE 
                 ASSIGN wdetail.n_pack   = IF LENGTH(wdetail.n_pack) <> 4 THEN  "C" + wdetail.n_pack 
                                           ELSE "C" + SUBSTR(wdetail.n_pack,2,3)
                        wdetail.n_branch = "" .
        END.
        /*-- end:A60-0095--*/
        ASSIGN wdetail.n_typpol  = "NEW".
    
        ASSIGN  np_dealer = ""
                np_dealer = IF index(wdetail.Notify_no,",") <> 0 THEN trim(SUBSTR(wdetail.Notify_no,index(wdetail.Notify_no,",") + 1 )) ELSE ""  /*A56-0399*/
                wdetail.n_branch  = "".
       
        IF  index(wdetail.brand,"FORD RANGER") <> 0 THEN DO:
            IF wdetail.yrmanu = trim(fi_year) THEN DO: /* A60-0095 */
                ASSIGN wdetail.n_branch  = ""
                       wdetail.nproducer = fi_producerford   
                       wdetail.nagent    = fi_agentford .
            END.
            /*--A60-0225---*/
            ELSE IF INDEX(wdetail.not_office,"CIN(FEET)") <> 0 THEN DO:
                ASSIGN wdetail.nproducer = fi_producercir   
                       wdetail.nagent    = fi_agenttiscocir .
            END.
            /*-- end : A60-0225---*/
            ELSE 
                ASSIGN wdetail.nproducer = fi_producertisco               
                       wdetail.nagent    = fi_agenttisco .
        END.
        /*-- start : A59-0618 --*/
        ELSE IF index(wdetail.brand,"FORD") <> 0 THEN DO:
            IF wdetail.yrmanu = trim(fi_year) THEN DO: /* A60-0095 */
                ASSIGN wdetail.n_branch  = "" 
                       wdetail.nproducer  = fi_producerford2   
                       wdetail.nagent     = fi_agentford2 .
            END.
             /*--A60-0225---*/
            ELSE IF INDEX(wdetail.not_office,"CIN(FEET)") <> 0 THEN DO:
                ASSIGN wdetail.nproducer = fi_producercir   
                       wdetail.nagent    = fi_agenttiscocir .
            END.
            /*-- end : A60-0225---*/
            ELSE 
                ASSIGN wdetail.nproducer = fi_producertisco              
                       wdetail.nagent    = fi_agenttisco .
        END.
        ELSE IF  index(wdetail.brand,"MAZDA") <> 0 THEN DO:   /*case : Mazda */
            IF wdetail.yrmanu = trim(fi_year) THEN DO: /* A60-0095 */
                /*--A60-0225--*/
                IF SUBSTR(wdetail.n_pack,1,1) = "M" THEN DO:
                    ASSIGN  wdetail.n_branch  = ""
                            wdetail.nproducer        = fi_producermpi
                            wdetail.nagent           = fi_agenttiscompi.
                END.
                ELSE IF INDEX(wdetail.not_office,"CIN(FEET)") <> 0 THEN DO:
                    ASSIGN wdetail.nproducer = fi_producercir   
                           wdetail.nagent    = fi_agenttiscocir .
                END.
                /*-- end : A60-0225---*/
                ELSE 
                    ASSIGN wdetail.n_branch  = ""
                           wdetail.nproducer        = fi_producerma
                           wdetail.nagent           = fi_agenttiscoma .
            END. 
            /*--A60-0225---*/
            ELSE IF INDEX(wdetail.not_office,"CIN(FEET)") <> 0 THEN DO:
                ASSIGN wdetail.nproducer = fi_producercir   
                       wdetail.nagent    = fi_agenttiscocir .
            END. /*-- end : A60-0225---*/
            /*--A60-0095--*/
            ELSE 
                ASSIGN wdetail.n_branch  = ""
                wdetail.nproducer        = "B3M0044" 
                wdetail.nagent           = "B3M0002". 
           /*--A60-0095--*/
        END.
        ELSE IF  index(wdetail.brand,"ISUZU") <> 0 THEN DO:   /*case : ISUZU */
            IF wdetail.yrmanu = trim(fi_year) /*AND index(wdetail.Notify_no,"TIS") <> 0*/ AND 
              (nv_premt3 = 17355.40    OR  nv_premt3  = 17033.33 OR nv_premt3  = 20855.37 OR  
               nv_premt3 = 21566.22 )  THEN DO: /* A60-0095 */
                ASSIGN wdetail.n_branch  = ""
                       wdetail.nproducer = fi_produceris
                       wdetail.nagent    = fi_agenttiscois.
            END.
            /*--A60-0225---*/
            ELSE IF INDEX(wdetail.not_office,"CIN(FEET)") <> 0 THEN DO:
                ASSIGN wdetail.nproducer = fi_producercir   
                       wdetail.nagent    = fi_agenttiscocir .
            END.
            /*-- end : A60-0225---*/
            ELSE 
                ASSIGN wdetail.nproducer = fi_producertisco              
                       wdetail.nagent    = fi_agenttisco .
        END.
        /*--A60-0225---*/
        ELSE IF INDEX(wdetail.not_office,"CIN(FEET)") <> 0 THEN DO:
            ASSIGN wdetail.nproducer = fi_producercir   
                   wdetail.nagent    = fi_agenttiscocir .
        END.
        /*-- end : A60-0225---*/
        ELSE IF wdetail.n_covcod = "1" AND INDEX(wdetail.ben_name,"�к� 8.3") <> 0  AND INDEX(wdetail.ben_name,"����к� 8.3") = 0 THEN DO:
                ASSIGN  wdetail.nproducer = fi_producer83              
                        wdetail.nagent    = fi_agenttisco83 .
        END.
        ELSE ASSIGN wdetail.nproducer = fi_producertisco              
                    wdetail.nagent    = fi_agenttisco .
        /*-- end A59-0618 --*/
        /*-- A60-0095 --*/
        IF wdetail.n_covcod  <> "1" AND index(wdetail.Notify_no,"TISTY") <> 0  THEN DO:
             /*--A60-0225---*/
            IF INDEX(wdetail.not_office,"CIN(FEET)") <> 0 THEN DO:
                ASSIGN wdetail.nproducer = fi_producercir   
                       wdetail.nagent    = fi_agenttiscocir .
            END.
            /*-- end : A60-0225---*/
            ELSE IF wdetail.Pro_off <> "17" THEN DO:
                ASSIGN wdetail.n_branch  = "M"
                       wdetail.nproducer = "A0M2011"
                       wdetail.nagent    = "B3M0002".
            END.
            ELSE 
                ASSIGN wdetail.n_branch  = "U"
                       wdetail.nproducer = "B3M0003"
                       wdetail.nagent    = "B3M0002".
        END.
        /*-- end A60-0095 --*/

        IF  np_dealer <> "" THEN DO:
            FIND FIRST stat.insure USE-INDEX insure01 WHERE 
                stat.insure.compno = "TISCO" AND
                stat.insure.lname  = np_dealer NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL stat.insure THEN 
                ASSIGN  wdetail.n_branch  = trim(stat.insure.branch).
            ELSE ASSIGN  wdetail.n_branch  = "".
        END.
        ELSE DO:  /* start : A59-0618 */
            ASSIGN  wdetail.n_branch  = "".
            IF wdetail.Notify_no = "" THEN wdetail.n_branch = "".
            ELSE DO:
                IF (index("123456789",SUBSTR(wdetail.Notify_no,1,1)) <> 0 ) AND 
                (index("123456789",SUBSTR(wdetail.Notify_no,2,1)) <> 0 ) THEN  
                    ASSIGN wdetail.n_branch = substr(wdetail.Notify_no,1,2) .
                ELSE DO: 
                    IF SUBSTR(wdetail.notify,1,1) <> "D" THEN
                        ASSIGN wdetail.n_branch = "" .
                    ELSE ASSIGN wdetail.n_branch = substr(wdetail.Notify_no,2,1) .
                END.
            END.
        END. /* end A59-0618 */
        /*--- create by A61-0045 Pack O-----*/
       IF INDEX(wdetail.n_pack,"O") <> 0  THEN DO:
            FIND LAST WComp WHERE trim(wcomp.package) = "O" NO-LOCK  NO-ERROR NO-WAIT.
                IF AVAIL wcomp THEN DO:
                  ASSIGN wdetail.bi   = TRIM(wcomp.bi)
                         wdetail.pa   = TRIM(wcomp.pa)
                         wdetail.pd   = TRIM(wcomp.pd).
                END.
        END.
        /*----- end A61-0045-------*/

END.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_new_oldx C-Win 
PROCEDURE 00-proc_new_oldx :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Create by A60-0095      
------------------------------------------------------------------------------*/
/*IF ra_poltyp = 2  THEN DO:      /* ����ᴧ */
    ASSIGN  wdetail.n_covcod      = "" 
            wdetail.price_ford    = IF INDEX(wdetail.remark,"P.") <> 0 THEN trim(SUBSTR(wdetail.remark,INDEX(wdetail.remark,"P.") + 2 )) ELSE ""
            wdetail.price_ford    = IF wdetail.price_ford = "" THEN "" 
                                    ELSE IF INDEX(wdetail.price_ford," ") <> 0 THEN trim(SUBSTR(wdetail.price_ford,1,INDEX(wdetail.price_ford," ")))
                                    ELSE trim(wdetail.price_ford)
            wdetail.comdat        = IF wdetail.comdat = "00000000" THEN wdetail.comp_comdat ELSE wdetail.comdat
            wdetail.expdat        = IF wdetail.expdat = "00000000" THEN wdetail.comp_expdat ELSE wdetail.expdat.
        RUN proc_redbook.    /* A57-0088 */
        /*-- create by : Ranu I. A60-0095 ---*/
        IF nv_premt3 = 0 THEN DO:               /*A61-0045*/ 
            ASSIGN wdetail.n_covcod  = "T".     /*A61-0045*/ 
        END.                                    /*A61-0045*/ 
        ELSE IF nv_premt3 = 7500.70 OR nv_premt3 = 8500.08 OR nv_premt3 = 9500.53  THEN DO:
            ASSIGN wdetail.n_covcod  = "2.2".
        END.
        ELSE IF nv_premt3 = 6300 OR nv_premt3 = 7300 OR nv_premt3 = 7500 OR nv_premt3 = 8300  THEN DO:
            ASSIGN  wdetail.n_covcod = "3.2".
        END.
        ELSE IF ( nv_premt3 <= 10000 ) AND (nv_premt3 > 3500 )  THEN DO: 
            ASSIGN wdetail.n_covcod  = "2".
        END.
        ELSE IF (nv_premt3 <= 3000 ) THEN DO:
            ASSIGN  wdetail.n_covcod = "3".
        END.
        ELSE IF (nv_premt3 >= 10000 ) THEN DO:
            ASSIGN  wdetail.n_covcod = "1".
        END.
        /*-- end : A60-0095 ---*/
        ASSIGN 
            n_brand = IF INDEX(wdetail.brand," ") <> 0 THEN trim(SUBSTR(wdetail.brand,1,INDEX(wdetail.brand," ") - 1 )) ELSE trim(wdetail.brand).
        IF n_brand = "ISUZU" THEN DO:
           IF      nv_premt3 = 17355.40 THEN ASSIGN wdetail.n_pack = "110" .
           ELSE IF nv_premt3 = 17033.33 THEN ASSIGN wdetail.n_pack = "210" . 
           ELSE IF nv_premt3 = 20855.37 THEN ASSIGN wdetail.n_pack = "110" .
           ELSE IF nv_premt3 = 21566.22 THEN ASSIGN wdetail.n_pack = "110" .

           IF      wdetail.n_pack = "110" THEN ASSIGN wdetail.n_seattisc = 7.
           ELSE IF wdetail.n_pack = "210" THEN ASSIGN wdetail.n_seattisc = 5.
           ELSE ASSIGN wdetail.n_seattisc = 3.
        END.
        /*-----------A60-0225-------------*/
        IF ((n_brand = "Mazda" ) AND (nv_premt3 = 17148.89 OR nv_premt3 = 18986.08 OR
           nv_premt3 = 16536.85  OR   nv_premt3 = 17760.93 OR nv_premt3 = 46546.07 OR
           nv_premt3 = 51445.60 )) THEN DO:
            FIND LAST WComp WHERE wcomp.cartyp = "MPI" AND wcomp.brand  = trim(n_brand) NO-LOCK  NO-ERROR NO-WAIT.
                        IF AVAIL wcomp THEN 
                            ASSIGN wdetail.n_pack   = wcomp.package + wdetail.n_pack
                                   wdetail.n_branch =  "" .

                        IF wdetail.n_pack = "M110" THEN ASSIGN wdetail.n_seattisc = 7.
                        IF wdetail.n_pack = "M320" THEN ASSIGN wdetail.n_seattisc = 5.
        END.
        ELSE DO:
        /*-------- end : A60-0225 ------*/
            FIND LAST WComp WHERE  wcomp.cartyp = "new" AND wcomp.brand  = trim(n_brand) NO-LOCK  NO-ERROR NO-WAIT.
                IF NOT AVAIL wcomp THEN DO:
                    FIND LAST WComp WHERE  wcomp.cartyp  = "new" AND wcomp.brand   = "OTHER" AND
                                           wcomp.cover   = "1" NO-LOCK  NO-ERROR NO-WAIT.
                            IF AVAIL wcomp THEN 
                                ASSIGN wdetail.n_pack   = wcomp.package + wdetail.n_pack
                                       wdetail.n_branch = trim(wcomp.branch) 
                                       wdetail.bi       = TRIM(wcomp.bi)  
                                       wdetail.pa       = TRIM(wcomp.pa)  
                                       wdetail.pd       = TRIM(wcomp.pd) . 
                END.
                ELSE ASSIGN wdetail.n_pack   = wcomp.package + wdetail.n_pack
                            wdetail.n_branch = trim(wcomp.branch).
                
                IF wdetail.n_pack = "O320"  THEN ASSIGN wdetail.n_seattisc = 5.
        END.
        /*-- A60-0095--*/
        IF wdetail.n_covcod = "1" THEN DO: /*A60-0095*/
            IF n_brand = "CHEVROLET" THEN DO:
               FIND LAST wcomp WHERE wcomp.brand = trim(n_brand) AND wcomp.n_class = substr(wdetail.n_pack,2,3) NO-LOCK NO-ERROR .
                   IF AVAIL wcomp THEN
                        ASSIGN wdetail.n_branch = trim(wcomp.branch)
                               wdetail.bi       = TRIM(wcomp.bi)
                               wdetail.pa       = TRIM(wcomp.pa)
                               wdetail.pd       = TRIM(wcomp.pd)
                               wdetail.n_seattisco = INT(wcomp.seat).
            END.
            ELSE IF n_brand = "ISUZU" THEN DO:
               FIND LAST wcomp WHERE wcomp.brand = trim(n_brand) NO-LOCK NO-ERROR .
                   IF AVAIL wcomp THEN
                       ASSIGN wdetail.bi   = TRIM(wcomp.bi)
                          wdetail.pa       = TRIM(wcomp.pa)
                          wdetail.pd       = TRIM(wcomp.pd).
            END.
            /*-- end:A60-0095--*/
            /*--A60-0225--*/
            ELSE IF n_brand = "MAZDA" AND wdetail.n_pack = "M320" OR wdetail.n_pack = "M110" THEN DO:
                FIND LAST wcomp WHERE wcomp.brand = trim(n_brand) NO-LOCK NO-ERROR .
                   IF AVAIL wcomp THEN
                       ASSIGN wdetail.bi   = TRIM(wcomp.bi)
                              wdetail.pa   = TRIM(wcomp.pa)
                              wdetail.pd   = TRIM(wcomp.pd).
            END.
            /*-- end : A60-0225--*/
            ELSE  
                ASSIGN wdetail.bi   = ""
                       wdetail.pa   = ""
                       wdetail.pd   = "".
        END.
        ELSE IF wdetail.n_covcod = "2" OR wdetail.n_covcod = "3" THEN DO:
            FIND LAST WComp WHERE  wcomp.cover = "2-3" NO-LOCK  NO-ERROR NO-WAIT.
               IF AVAIL wcomp THEN 
                   ASSIGN wdetail.n_branch = trim(wcomp.branch) 
                          wdetail.bi       = TRIM(wcomp.bi)
                          wdetail.pa       = TRIM(wcomp.pa)
                          wdetail.pd       = TRIM(wcomp.pd)
                          wdetail.n_pack   = IF wdetail.n_covcod = "2" THEN "Y" + SUBSTR(wdetail.n_pack,2,3) 
                                             ELSE  "R" + SUBSTR(wdetail.n_pack,2,3).
        END.
        /*--A60-0095--*/
        ELSE DO:
            FIND LAST wcomp WHERE wcomp.cover = wdetail.n_covcod NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL wcomp THEN
                 ASSIGN wdetail.n_pack   = IF LENGTH(wdetail.n_pack) <> 4 THEN  wcomp.package + wdetail.n_pack 
                                           ELSE wcomp.package + SUBSTR(wdetail.n_pack,2,3)
                        wdetail.n_branch = trim(wcomp.branch)
                        wdetail.bi       = TRIM(wcomp.bi)
                        wdetail.pa       = TRIM(wcomp.pa)
                        wdetail.pd       = TRIM(wcomp.pd).
            ELSE 
                 ASSIGN wdetail.n_pack   = IF LENGTH(wdetail.n_pack) <> 4 THEN  "C" + wdetail.n_pack 
                                           ELSE "C" + SUBSTR(wdetail.n_pack,2,3)
                        wdetail.n_branch = "" .
        END.
        /*-- end:A60-0095--*/
        ASSIGN wdetail.n_typpol  = "NEW".
    
        ASSIGN  np_dealer = ""
            np_dealer = IF index(wdetail.Notify_no,",") <> 0 THEN trim(SUBSTR(wdetail.Notify_no,index(wdetail.Notify_no,",") + 1 )) ELSE ""  /*A56-0399*/
            wdetail.n_branch  = "".
        /* comment by : A64-0271 ....
        IF  index(wdetail.brand,"FORD RANGER") <> 0 THEN DO:
            IF wdetail.yrmanu = trim(fi_year) THEN DO: /* A60-0095 */
                ASSIGN wdetail.n_branch  = ""
                       wdetail.nproducer = fi_producerford   
                       wdetail.nagent    = fi_agentford .
            END.
            /*--A60-0225---*/
            ELSE IF INDEX(wdetail.not_office,"CIN(FEET)") <> 0 THEN DO:
                ASSIGN wdetail.nproducer = fi_producercir   
                       wdetail.nagent    = fi_agenttiscocir .
            END.
            /*-- end : A60-0225---*/
            ELSE 
                ASSIGN wdetail.nproducer = fi_producertisco               
                       wdetail.nagent    = fi_agenttisco .
        END.
        /*-- start : A59-0618 --*/
        ELSE IF index(wdetail.brand,"FORD") <> 0 THEN DO:
            IF wdetail.yrmanu = trim(fi_year) THEN DO: /* A60-0095 */
                ASSIGN wdetail.n_branch  = "" 
                       wdetail.nproducer  = fi_producerford2   
                       wdetail.nagent     = fi_agentford2 .
            END.
             /*--A60-0225---*/
            ELSE IF INDEX(wdetail.not_office,"CIN(FEET)") <> 0 THEN DO:
                ASSIGN wdetail.nproducer = fi_producercir   
                       wdetail.nagent    = fi_agenttiscocir .
            END.
            /*-- end : A60-0225---*/
            ELSE 
                ASSIGN wdetail.nproducer = fi_producertisco              
                       wdetail.nagent    = fi_agenttisco .
        END.
        ...end A64-0271...*/
        /* comment by Ranu I. A62-0386 ...........
        ELSE IF  index(wdetail.brand,"MAZDA") <> 0 THEN DO:   /*case : Mazda */
            IF wdetail.yrmanu = trim(fi_year) THEN DO: /* A60-0095 */
                /*--A60-0225--*/
                IF SUBSTR(wdetail.n_pack,1,1) = "M" THEN DO:
                    ASSIGN  wdetail.n_branch  = ""
                            wdetail.nproducer        = fi_producermpi
                            wdetail.nagent           = fi_agenttiscompi.
                END.
                ELSE IF INDEX(wdetail.not_office,"CIN(FEET)") <> 0 THEN DO:
                    ASSIGN wdetail.nproducer = fi_producercir   
                           wdetail.nagent    = fi_agenttiscocir .
                END.
                /*-- end : A60-0225---*/
                ELSE 
                    ASSIGN wdetail.n_branch  = ""
                           wdetail.nproducer        = fi_producerma
                           wdetail.nagent           = fi_agenttiscoma .
            END. 
            /*--A60-0225---*/
            ELSE IF INDEX(wdetail.not_office,"CIN(FEET)") <> 0 THEN DO:
                ASSIGN wdetail.nproducer = fi_producercir   
                       wdetail.nagent    = fi_agenttiscocir .
            END. /*-- end : A60-0225---*/
            /*--A60-0095--*/
            ELSE 
                ASSIGN wdetail.n_branch  = ""
                wdetail.nproducer        = "B3M0044" 
                wdetail.nagent           = "B3M0002". 
           /*--A60-0095--*/
        END.
        .........end A62-0386............*/
        IF  index(wdetail.brand,"FORD") <> 0 THEN DO:
            ASSIGN wdetail.n_branch  = ""
                   wdetail.nproducer = fi_producerford   
                   wdetail.nagent    = fi_agentford .
            IF INDEX(wdetail.remark,"_2Y") <> 0  THEN 
                ASSIGN wdetail.n_branch  = ""
                   wdetail.nproducer = fi_producerford2y  
                   wdetail.nagent    = fi_agentford2y .  

        END.
        ELSE IF  index(wdetail.brand,"HAVAL") <> 0 THEN DO:
            ASSIGN wdetail.n_branch  = ""
                   wdetail.nproducer = fi_producerford2y  
                   wdetail.nagent    = fi_agentford2y .  
        END.

        ELSE DO:
            IF index(wdetail.brand,"ISUZU") <> 0 THEN DO:   /*case : ISUZU */
                /* comment by : A64-0092 ¡��ԡ���������....
                IF wdetail.yrmanu = trim(fi_year) /*AND index(wdetail.Notify_no,"TIS") <> 0*/ AND 
                  (nv_premt3 = 17355.40    OR  nv_premt3  = 17033.33 OR nv_premt3  = 20855.37 OR  
                   nv_premt3 = 21566.22 )  THEN DO: /* A60-0095 */
                    ASSIGN wdetail.n_branch  = ""
                           wdetail.nproducer = fi_produceris
                           wdetail.nagent    = fi_agenttiscois.
                END.
                ..end A64-0092..*/
                /* A64-0092  ö��÷ء */
                IF index(wdetail.brand,"Wheels") <> 0 OR index(wdetail.brand,"Trailer") <> 0 
                OR index(wdetail.brand,"TRUCK")  <> 0 /* A64-0431*/ THEN DO: 
                     ASSIGN wdetail.nproducer = fi_pdtkcode   
                            wdetail.nagent    = fi_agtkcode .
                END.
                /* end A64-0092*/
                /*--A60-0225---*/
                ELSE IF INDEX(wdetail.not_office,"CIN(FEET)") <> 0 THEN DO:
                    ASSIGN wdetail.nproducer = fi_producercir   
                           wdetail.nagent    = fi_agenttiscocir .
                END.
                /*-- end : A60-0225---*/
                /* A64-0092 ö��硻���ᴧ */
                ELSE IF wdetail.yrmanu = trim(fi_year) THEN DO: 
                    ASSIGN wdetail.n_branch  = ""
                           wdetail.nproducer = fi_produceris
                           wdetail.nagent    = fi_agenttiscois.
                END.
                /* end : A64-0092 */
                ELSE ASSIGN wdetail.nproducer = fi_producertisco              
                           wdetail.nagent    = fi_agenttisco .
            END.
            /* A64-0092 */
            ELSE IF index(wdetail.brand,"HINO")  <> 0 OR index(wdetail.brand,"Trailer") <> 0 OR index(wdetail.brand,"TRUCK") <> 0 /* A64-0431*/ THEN DO: /*ö��÷ء */
                ASSIGN wdetail.nproducer = fi_pdtkcode   
                       wdetail.nagent    = fi_agtkcode .
            END.
            ELSE IF index(wdetail.brand,"YAMAHA") <> 0 OR index(wdetail.brand,"TRIUMPH") <> 0 OR index(wdetail.brand,"KAWASAKI") <> 0 THEN DO:  /* bigbike*/
                    ASSIGN wdetail.nproducer = fi_pdbkcode   
                           wdetail.nagent    = fi_agbkcode .
            END.
            ELSE IF (index(wdetail.brand,"SUZUKI") <> 0 AND  DECI(wdetail.power) < 1000 ) OR
                    (index(wdetail.brand,"HONDA")  <> 0 AND DECI(wdetail.power) < 1000 ) AND
                    (index(wdetail.remark,"Deduct") <> 0 OR index(wdetail.remark,"DD") <> 0 ) THEN DO: /* bigbike*/
                    ASSIGN wdetail.nproducer = fi_pdbkcode   
                           wdetail.nagent    = fi_agbkcode .
            END.
            /* end A64-0092 */
            /*--A60-0225---*/
            ELSE IF INDEX(wdetail.not_office,"CIN(FEET)") <> 0 THEN DO:
                ASSIGN wdetail.nproducer = fi_producercir   
                       wdetail.nagent    = fi_agenttiscocir .
            END.
            /*-- end : A60-0225---*/
            ELSE ASSIGN wdetail.nproducer = fi_producertisco              
                        wdetail.nagent    = fi_agenttisco .
            /*-- end A59-0618 --*/
            /*-- A60-0095 --*/
            IF wdetail.n_covcod  <> "1" AND index(wdetail.Notify_no,"TISTY") <> 0  THEN DO:
                /*--A60-0225---*/
                IF INDEX(wdetail.not_office,"CIN(FEET)") <> 0 THEN DO:
                    ASSIGN wdetail.nproducer = fi_producercir   
                           wdetail.nagent    = fi_agenttiscocir .
                END.
                /*-- end : A60-0225---*/
                /* A64-0092 */
                ELSE IF index(wdetail.brand,"HINO") <> 0 OR index(wdetail.brand,"Trailer") <> 0 THEN DO: /*ö��÷ء */
                    ASSIGN wdetail.nproducer = fi_pdtkcode   
                           wdetail.nagent    = fi_agtkcode .
                END.
                ELSE IF index(wdetail.brand,"YAMAHA") <> 0 OR index(wdetail.brand,"TRIUMPH") <> 0 OR index(wdetail.brand,"KAWASAKI") <> 0 THEN DO:  /* bigbike*/
                        ASSIGN wdetail.nproducer = fi_pdbkcode   
                               wdetail.nagent    = fi_agbkcode .
                END.
                ELSE IF (index(wdetail.brand,"SUZUKI") <> 0 AND  DECI(wdetail.power) < 1000 ) OR
                         (index(wdetail.brand,"HONDA")  <> 0 AND DECI(wdetail.power) < 1000 ) AND
                         (index(wdetail.remark,"Deduct") <> 0 OR index(wdetail.remark,"DD") <> 0 ) THEN DO: /* bigbike*/
                        ASSIGN wdetail.nproducer = fi_pdbkcode   
                               wdetail.nagent    = fi_agbkcode .
                END.
                /* end A64-0092 */
                ELSE IF wdetail.Pro_off <> "17" THEN DO:
                    ASSIGN wdetail.n_branch  = "M"
                           wdetail.nproducer = "B3MLTIS103"  /*A64-0092*/ 
                           wdetail.nagent    = "B3MLTIS100". /*A64-0092*/ 
                          /* wdetail.nproducer = "A0M2011" */ /*A64-0092*/
                          /* wdetail.nagent    = "B3M0002".*/ /*A64-0092*/
                END.
                ELSE 
                    ASSIGN wdetail.n_branch  = "U"
                           wdetail.nproducer = "B3MLTIS201"  /*A64-0092*/  
                           wdetail.nagent    = "B3MLTIS200". /*A64-0092*/     
                           /*wdetail.nproducer = "B3M0003" */ /*A64-0092*/
                           /*wdetail.nagent    = "B3M0002".*/ /*A64-0092*/
            END.
        END. /* A64-0271 */
        /*-- end A60-0095 --*/
        IF  np_dealer <> "" THEN DO:
            FIND FIRST stat.insure USE-INDEX insure01 WHERE 
                stat.insure.compno = "TISCO" AND stat.insure.lname  = np_dealer NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL stat.insure THEN ASSIGN  wdetail.n_branch  = trim(stat.insure.branch).
            ELSE DO: 
                /* A65-0035 */
                FIND FIRST stat.insure USE-INDEX insure01 WHERE 
                stat.insure.compno = "GWM" AND stat.insure.lname  = np_dealer NO-LOCK NO-WAIT NO-ERROR.
                IF AVAIL stat.insure THEN ASSIGN  wdetail.n_branch  = trim(stat.insure.branch).
                ELSE ASSIGN  wdetail.n_branch  = "" .
                /*  end : A65-0035 */
            END.
        END.
        ELSE DO:  /* start : A59-0618 */
            ASSIGN  wdetail.n_branch  = "".
            IF wdetail.Notify_no = "" THEN wdetail.n_branch = "".
            ELSE DO:
                IF (index("123456789",SUBSTR(wdetail.Notify_no,1,1)) <> 0 ) AND 
                (index("123456789",SUBSTR(wdetail.Notify_no,2,1)) <> 0 ) THEN  
                    ASSIGN wdetail.n_branch = substr(wdetail.Notify_no,1,2) .
                ELSE DO: 
                    IF SUBSTR(wdetail.notify,1,1) <> "D" THEN ASSIGN wdetail.n_branch = "" .
                    ELSE ASSIGN wdetail.n_branch = substr(wdetail.Notify_no,2,1) .
                END.
            END.
        END. /* end A59-0618 */
        /*--- create by A61-0045 Pack O-----*/
       IF INDEX(wdetail.n_pack,"O") <> 0  THEN DO:
            FIND LAST WComp WHERE trim(wcomp.package) = "O" NO-LOCK  NO-ERROR NO-WAIT.
                IF AVAIL wcomp THEN DO:
                  ASSIGN wdetail.bi   = TRIM(wcomp.bi)
                         wdetail.pa   = TRIM(wcomp.pa)
                         wdetail.pd   = TRIM(wcomp.pd).
                END.
        END.
        /*----- end A61-0045-------*/
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_renew C-Win 
PROCEDURE 00-proc_renew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF ra_poltyp = 1  THEN DO:      /* ������� */
    FIND FIRST stat.insure USE-INDEX insure01 WHERE 
        stat.insure.compno = fi_model          AND
        stat.insure.fname  = wdetail.brand     NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.insure THEN DO: 
        ASSIGN 
            wdetail.n_pack = trim(stat.insure.text5)       
            np_class = ""       np_brand = ""
            np_model = ""       np_class =  trim(stat.insure.text5)    
            np_brand =  Insure.text1    
            np_model =  insure.text2  .
        IF      wdetail.n_pack = "110" THEN ASSIGN wdetail.n_seattisco = 7 . 
        ELSE IF wdetail.n_pack = "320" THEN ASSIGN wdetail.n_seattisco = 3 . 
        ELSE IF wdetail.n_pack = "210" THEN ASSIGN wdetail.n_seattisco = 12 .
    END.
    ELSE DO: 
        ASSIGN  n_brand = IF INDEX(wdetail.brand," ") <> 0 THEN trim(SUBSTR(wdetail.brand,1,INDEX(wdetail.brand," ") - 1 )) 
                          ELSE trim(wdetail.brand).
        IF n_brand = "ISUZU" THEN
            ASSIGN wdetail.n_seattisco = IF wdetail.n_pack = "110" THEN 7 ELSE IF wdetail.n_pack = "210" THEN 5 ELSE 3.  
        ELSE DO: 
            IF      wdetail.n_pack = "110" THEN ASSIGN wdetail.n_seattisco = 7  .   
            ELSE IF wdetail.n_pack = "320" THEN ASSIGN wdetail.n_seattisco = 3  .   
            ELSE IF wdetail.n_pack = "210" THEN ASSIGN wdetail.n_seattisco = 12 .  
            ELSE ASSIGN wdetail.n_seattisco = 0 .   
        END.
    END.
    ASSIGN  wdetail.n_covcod    = ""
    wdetail.n_typpol    = "RENEW"              
    wdetail.nproducer   = fi_producertisco    
    wdetail.nagent      = fi_agenttisco     
    wdetail.n_branch    = "M"
    wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"*","")
    wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"-","")
    wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"/","")
    wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"\","")
    wdetail.prev_pol    = REPLACE(wdetail.prev_pol,".",""). 
    IF nv_premt3 = 0 THEN DO:            
        ASSIGN wdetail.n_covcod  = "T".  
    END.
    ELSE IF nv_premt3 = 7500.70 OR nv_premt3 = 8500.08 OR nv_premt3 = 9500.53  THEN DO:
        ASSIGN wdetail.n_covcod  = "2.2"
            wdetail.n_pack       = "C" +  trim(wdetail.n_pack).
    END.
    ELSE IF nv_premt3 = 6300 OR nv_premt3 = 7300 OR nv_premt3 = 7500 OR nv_premt3 = 8300  THEN DO:
        ASSIGN  wdetail.n_covcod = "3.2"
            wdetail.n_pack       = "C" +  trim(wdetail.n_pack).
    END.
    ELSE IF ( nv_premt3 <= 10000 ) AND (nv_premt3 > 2500 )  THEN DO: 
        ASSIGN wdetail.n_covcod  = "2"
            wdetail.n_pack       = "Y" +  trim(wdetail.n_pack).
    END.
    ELSE IF (nv_premt3 < 2500 )THEN DO:
        ASSIGN  wdetail.n_covcod = "3"
            wdetail.n_pack       = "R" +  trim(wdetail.n_pack).
        IF wdetail.n_pack = "R110" THEN ASSIGN wdetail.n_seattisco = 7. 
    END.
    ELSE IF  nv_premt3  >  10000   THEN DO: 
        ASSIGN  wdetail.n_covcod = "1".
        IF (wdetail.garage = "0")  THEN DO:
            IF  index(wdetail.brand,"Ford") <> 0 AND 
                index(wdetail.remark,"FORD ENSURE") <> 0 OR    
                INDEX(wdetail.remark,"FD")          <> 0 OR    
                SUBSTRING(wdetail.prev_pol,7,1)     = "F" THEN DO: 
                ASSIGN wdetail.n_pack = "O" +  trim(wdetail.n_pack).
                IF wdetail.n_pack = "O320" THEN ASSIGN wdetail.n_seattisco = 5.
            END.
            ELSE IF  index(wdetail.brand,"MAZDA")    <> 0   AND 
                     /*SUBSTRING(wdetail.prev_pol,7,2) = "MI" OR *//*A62-0386*/
                     index(wdetail.remark,"MPI")     <> 0   THEN DO:  
                     ASSIGN wdetail.n_pack = "M" +  trim(wdetail.n_pack).
                     IF wdetail.n_pack = "M110" THEN ASSIGN wdetail.n_seattisco = 7.
                     IF wdetail.n_pack = "M320" THEN ASSIGN wdetail.n_seattisco = 5.
            END.
            ELSE DO:
                FIND LAST WComp WHERE wcomp.cartyp   = "renew"    AND
                                      wcomp.brand    = "garage"   NO-LOCK  NO-ERROR NO-WAIT.
                IF AVAIL wcomp THEN  ASSIGN wdetail.n_pack = trim(wcomp.package) + trim(wdetail.n_pack).
            END.
        END.
        ELSE DO:    /*�������*/
            FIND LAST WComp WHERE wcomp.cartyp   = "renew" AND
                                  wcomp.brand    = ""      NO-LOCK  NO-ERROR NO-WAIT.
            IF AVAIL wcomp THEN  ASSIGN wdetail.n_pack = trim(wcomp.package) + trim(wdetail.n_pack) .
        END.
    END.
    /* FORD */
    IF  index(wdetail.brand,"FORD")  <> 0 THEN DO:  /* Ford       */
        ASSIGN wdetail.nproducer = fi_producerford  /* "B3M0033"  */ 
               wdetail.nagent    = fi_agentford .   /* "B3M0035"  */ 
        IF ((YEAR(TODAY) - INT(wdetail.yrmanu) <= 7 )  AND 
           (nv_premt1 = 8300.00  OR nv_premt1 = 9500.00  OR 
            nv_premt1 = 10400.00 OR nv_premt1 = 12300.00 OR 
            nv_premt1 = 14100.00 )) THEN DO:
            ASSIGN 
               /* wdetail.n_covcod = "" wdetail.garage = "" wdetail.nproducer = ""  wdetail.remark = "" 
                wdetail.n_pack   = "" wdetail.bi     = "" wdetail.pa        = ""  wdetail.pd     = ""*/
                wdetail.n_covcod  = "2.2"
                wdetail.garage    = "0"
                wdetail.remark    = "FE2+"
                wdetail.bi        = "500000"
                wdetail.pa        = "10000000"
                wdetail.pd        = "2500000".
            IF      wdetail.n_seattisco = 7 THEN wdetail.n_pack = "U110".
            ELSE IF wdetail.n_seattisco = 3 THEN ASSIGN wdetail.n_pack = "U320" 
                                                        wdetail.n_seattisco = 5.
        END.
    END.
    ELSE IF index(wdetail.bran,"Nissan") <> 0 THEN DO:   /* Nissan */
        IF INDEX(wdetail.prev_insur,"SAFETY INSURANCE") <> 0 THEN DO:
            ASSIGN                 
                wdetail.nproducer = fi_producernis    /*"B3DM000002" */
                wdetail.nagent    = fi_agentnis     . /*"B3M0035"    */

            FIND LAST sicuw.uwm301 Use-index uwm30121 Where 
                sicuw.uwm301.cha_no      = trim(wdetail.chassis)  AND 
                substr(sicuw.uwm301.policy,3,2) = "70"  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm301 THEN DO:
                ASSIGN 
                    wdetail.nproducer =  fi_producernis     /*"B3DM000002" */ 
                    wdetail.nagent    =  fi_agentnis .      /*"B3M0035"    */ 
                IF trim(wdetail.polold) = "" THEN wdetail.polold = sicuw.uwm301.policy .
                Find LAST sicuw.uwm100 Use-index uwm10001       Where
                    sicuw.uwm100.policy = sicuw.uwm301.policy   and
                    sicuw.uwm100.rencnt = sicuw.uwm301.rencnt   and 
                    sicuw.uwm100.poltyp = "V70"  No-lock no-error no-wait.
                If avail sicuw.uwm100 Then DO:
                    ASSIGN wdetail.n_branch  =  sicuw.uwm100.branch
                        wdetail.n_branch  =  IF sicuw.uwm100.acno1 = "B3W0020" OR sicuw.uwm100.acno1 = "B3W0016" THEN "W" ELSE "MF" .
                    /*IF sicuw.uwm100.branch <> "W" AND sicuw.uwm100.branch <> "MF" THEN DO:
                        IF INDEX(wdetail.ben_name,"�к� 8.3") <> 0 THEN 
                            ASSIGN                  
                            wdetail.nproducer =  fi_producer83     /* "B3MLTIS104"  */ /*A65-0361*/
                            wdetail.nagent    =  fi_agenttisco83.  /* "B3MLTIS100". */ /*A65-0361*/
                        ELSE ASSIGN                  
                            wdetail.nproducer =  fi_producertisco  /*"B3MLTIS101" */  /*A65-0361*/
                            wdetail.nagent    =  fi_agenttisco.     /*"B3MLTIS100".*/  /*A65-0361*/
                    END.*/
                    IF sicuw.uwm100.acno1 = "B3DM000003" THEN DO:
                      IF (sicuw.uwm100.branch = "W") OR (sicuw.uwm100.branch = "MF") THEN DO:  /*A67-0114*/
                        ASSIGN wdetail.nproducer =  fi_producernis   
                               wdetail.nagent    =  fi_agentnis .
                      END.
                      /* add : A67-0114*/
                      ELSE DO:
                        ASSIGN wdetail.nproducer =  fi_producernis2   
                               wdetail.nagent    =  fi_agentnis2 .
                      END. /* end A67-0114*/
                    END.
                    ELSE IF sicuw.uwm100.branch <> "W" AND sicuw.uwm100.branch <> "MF" THEN DO:
                        /*IF  INDEX(wdetail.ben_name,"����к� 8.3") <> 0 THEN */ /* A67-0114*/
                        IF  (INDEX(wdetail.ben_name,"����к� 8.3") <> 0) OR (INDEX(wdetail.ben_name,"���Դ 8.3") <> 0) THEN DO:  /* A67-0114*/
                            ASSIGN wdetail.nproducer =  fi_producertisco    /* "B3MLTIS101" */
                                   wdetail.nagent    =  fi_agenttisco  .    /* "B3MLTIS100" */
                        END.
                        /*ELSE IF INDEX(wdetail.ben_name,"�к� 8.3") <> 0   THEN*/ /* A67-0114*/
                        ELSE IF INDEX(wdetail.ben_name,"�к� 8.3") <> 0 OR (INDEX(wdetail.ben_name,"�Դ 8.3") <> 0)  THEN DO: /* A67-0114*/
                            ASSIGN                  
                            wdetail.nproducer =  fi_producer83     /* "B3MLTIS104"  */ /*A65-0361*/
                            wdetail.nagent    =  fi_agenttisco83.  /* "B3MLTIS100". */ /*A65-0361*/
                        END.
                    END.
                END.
            END.
            ELSE ASSIGN wdetail.n_branch  = "M" /* A67-0114*/
                        wdetail.nproducer = fi_producernis2  /*"B3DM000003"*/
                        wdetail.nagent    = fi_agentnis2 .   /*"B3M0035"   */
        END.                                                 
        ELSE ASSIGN wdetail.n_branch  = "M" /* A67-0114*/
                    wdetail.nproducer = fi_producernis2      /*"B3DM000003"*/  
                    wdetail.nagent    = fi_agentnis2 .       /*"B3M0035"   */  
    END.
    /*ELSE IF  index(wdetail.brand,"HAVAL") <> 0  OR index(wdetail.brand,"ORA") <> 0 THEN DO:*/ /*A67-0087*/
    ELSE IF  index(wdetail.brand,"HAVAL") <> 0  OR index(wdetail.brand,"ORA") <> 0 OR index(wdetail.brand,"TANK") <> 0 THEN DO: /*A67-0087*/
        ASSIGN 
            wdetail.nproducer = fi_producerhaval   /*A65-0361*/
            wdetail.nagent    = fi_agenthaval   .  /*A65-0361*/
        /* A67-0087*/
        IF INDEX(wdetail.prev_insur,"SAFETY INSURANCE") <> 0 THEN DO:
           FIND LAST sicuw.uwm301 Use-index uwm30121 Where 
                sicuw.uwm301.cha_no      = trim(wdetail.chassis)  AND 
                substr(sicuw.uwm301.policy,3,2) = "70"  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm301 THEN DO:
                IF trim(wdetail.polold) = "" THEN wdetail.polold = sicuw.uwm301.policy .
                Find LAST sicuw.uwm100 Use-index uwm10001       Where
                    sicuw.uwm100.policy = sicuw.uwm301.policy   and
                    sicuw.uwm100.rencnt = sicuw.uwm301.rencnt   and 
                    sicuw.uwm100.poltyp = "V70"  No-lock no-error no-wait.
                If avail sicuw.uwm100 Then DO:
                    IF sicuw.uwm100.acno1 = "B3DM000005" THEN DO:
                       ASSIGN wdetail.n_branch  =  sicuw.uwm100.branch 
                              wdetail.n_pack    = "TE12"
                              wdetail.nproducer =  "B3DM000005" 
                              wdetail.nagent    =  "B3M0035" .
                    END.
                END.
            END.
        END.
        ELSE IF INDEX(wdetail.remark,"Demo") <> 0 OR  INDEX(wdetail.remark,"���ͧ�Ѻ") <> 0 OR INDEX(wdetail.remark,"ö������������") <> 0 OR
           INDEX(wdetail.remark,"�����ҧ����") <> 0  OR INDEX(wdetail.remark,"TEST DRIVE") <> 0 THEN DO:
            ASSIGN wdetail.n_branch  = ""
                   wdetail.n_pack    = "TE12"
                   wdetail.nproducer = "B3DM000005"  
                   /*wdetail.nagent    = "B3M0002" */ /*A67-0114*/
                   wdetail.nagent    = "B3M0035" .  
        END.
        /* end : A67-0087 */
    END.
    ELSE IF  index(wdetail.brand,"Hyundai") <> 0 THEN DO:
    ASSIGN                  
       wdetail.nproducer =  fi_proreHyundai    
       wdetail.nagent    =  fi_agentreHyundai  .
    END.
    ELSE IF index(wdetail.agent,"HI-WAY") <> 0  THEN DO: 
        IF  wdetail.n_covcod = "1" THEN DO:
            IF   index(wdetail.brand,"WHEELS") <> 0 OR index(wdetail.brand,"TRAILER") <> 0  OR 
                index(wdetail.brand,"TRUCK")  <> 0 OR index(wdetail.brand,"SEMI")    <> 0  THEN
                ASSIGN 
                wdetail.nproducer = fi_producerHi2  /*fi_producerHi2     = "B3MLTIS302"*/
                wdetail.nagent    = fi_agenthi2 .   /*fi_agenthi2        = "B3MLTIS300"*/
            ELSE ASSIGN 
                wdetail.nproducer = fi_producerHi1  /*fi_producerHi1     = "B3MLTIS301" */
                wdetail.nagent    = fi_agenthi1 .   /*fi_agenthi1        = "B3MLTIS300" */
        END.
        ELSE ASSIGN 
                wdetail.nproducer = "B3MLTIS103" 
                wdetail.nagent    = "B3MLTIS300" .
    END.
    ELSE IF INDEX(wdetail.prev_insur,"SAFETY INSURANCE") <> 0 THEN DO:  /* ������� STY */
        IF  INDEX(wdetail.not_office,"CIR(RETAIL)") <> 0 OR INDEX(wdetail.not_office,"CIR(FLEET)") <> 0 OR 
            INDEX(wdetail.remark,"L/CI/CODE")       <> 0 OR INDEX(wdetail.remark,"C CI") <> 0           OR 
            INDEX(wdetail.remark,"L/CI")            <> 0 OR INDEX(wdetail.remark,"J CI") <> 0           OR 
            INDEX(wdetail.remark,"P CI")            <> 0 OR INDEX(wdetail.remark,"L/CI") <> 0  THEN DO:

            IF   index(wdetail.brand,"WHEELS") <> 0 OR index(wdetail.brand,"TRAILER") <> 0  OR 
                index(wdetail.brand,"TRUCK")  <> 0 OR index(wdetail.brand,"SEMI")    <> 0  THEN
                ASSIGN 
                wdetail.nproducer = fi_producerbig      /* "B3MLTIS105"  */ 
                wdetail.nagent    = fi_agentbig  .      /* "B3MLTIS100". */ 
            ELSE ASSIGN wdetail.nproducer =   fi_producercir     /*= "B3MLTIS102"  */
                        wdetail.nagent    =   fi_agenttiscocir .  /*= "B3MLTIS100"  */
        END.
        ELSE IF INDEX(wdetail.ben_name,"����к� 8.3") <> 0 THEN 
            ASSIGN 
            wdetail.nproducer =  fi_producertisco    /* "B3MLTIS101" */
            wdetail.nagent    =  fi_agenttisco  .    /* "B3MLTIS100" */
        ELSE IF INDEX(wdetail.ben_name,"�к� 8.3") <> 0   THEN 
            ASSIGN                  
            wdetail.nproducer =  fi_producer83     /* "B3MLTIS104"  */ /*A65-0361*/
            wdetail.nagent    =  fi_agenttisco83.  /* "B3MLTIS100". */ /*A65-0361*/
    END.
    ELSE DO:  /* �ҹ�͹����  */
        IF  wdetail.n_covcod = "1" THEN DO:
            IF  INDEX(wdetail.not_office,"CIR(RETAIL)") <> 0 OR INDEX(wdetail.not_office,"CIR(FLEET)") <> 0 OR 
                INDEX(wdetail.remark,"L/CI/CODE")       <> 0 OR INDEX(wdetail.remark,"C CI") <> 0           OR 
                INDEX(wdetail.remark,"L/CI")            <> 0 OR INDEX(wdetail.remark,"J CI") <> 0           OR 
                INDEX(wdetail.remark,"P CI")            <> 0 OR INDEX(wdetail.remark,"L/CI") <> 0  THEN DO:
                IF   index(wdetail.brand,"WHEELS") <> 0 OR index(wdetail.brand,"TRAILER") <> 0  OR 
                     index(wdetail.brand,"TRUCK")  <> 0 OR index(wdetail.brand,"SEMI")    <> 0  THEN
                     ASSIGN 
                     wdetail.nproducer = fi_producerbig      /* "B3MLTIS105"  */ 
                     wdetail.nagent    = fi_agentbig  .      /* "B3MLTIS100". */ 
                ELSE ASSIGN              
                     wdetail.nproducer = fi_producercir      /*= "B3MLTIS102"  */
                     wdetail.nagent    = fi_agenttiscocir .  /*= "B3MLTIS100"  */
            END.
            ELSE IF INDEX(wdetail.ben_name,"����к� 8.3") <> 0 THEN 
                ASSIGN 
                wdetail.nproducer =  fi_producertisco    /* "B3MLTIS101" */
                wdetail.nagent    =  fi_agenttisco  .    /* "B3MLTIS100" */
            ELSE IF INDEX(wdetail.ben_name,"�к� 8.3") <> 0   THEN 
                ASSIGN                  
                wdetail.nproducer =  fi_producer83     /* "B3MLTIS104"  */ /*A65-0361*/
                wdetail.nagent    =  fi_agenttisco83.  /* "B3MLTIS100". */ /*A65-0361*/
        END.
        ELSE  IF (wdetail.n_covcod <> "1") THEN DO:  /* ����� �.1 �ҹ�͹���� */
            IF INDEX(wdetail.not_office,"CIR(RETAIL)") <> 0 OR INDEX(wdetail.not_office,"CIR(FLEET)") <> 0 OR
                INDEX(wdetail.remark,"L/CI/CODE")      <> 0 OR INDEX(wdetail.remark,"C CI")           <> 0 OR 
                INDEX(wdetail.remark,"L/CI")           <> 0 OR INDEX(wdetail.remark,"J CI") <> 0           OR 
                INDEX(wdetail.remark,"P CI")           <> 0 OR INDEX(wdetail.remark,"L/CI") <> 0  /* A65-0035*/
                THEN DO:
                ASSIGN wdetail.n_branch  = "ML"
                    wdetail.nproducer = fi_pdtkcode    /* fi_producercir   = "B3MLTIS103"  */
                    wdetail.nagent    = fi_agtkcode  . /* fi_agenttiscocir = "B3MLTIS100"  */
            END.
            ELSE ASSIGN  wdetail.n_branch  = "ML"
               wdetail.nproducer = fi_pdbkcode   /* B3MLTIS103" */  /*A63-00472*/  
               wdetail.nagent    = fi_agbkcode . /* B3MLTIS100".*/  /*A63-00472*/ 

            FIND LAST wcomp WHERE wcomp.cover = wdetail.n_covcod NO-LOCK NO-ERROR.
            IF AVAIL wcomp THEN DO:
                ASSIGN wdetail.bi       = TRIM(wcomp.bi)
                       wdetail.pa       = TRIM(wcomp.pa)
                       wdetail.pd       = TRIM(wcomp.pd).
            END.
            ELSE DO:
                FIND LAST WComp WHERE  wcomp.cover = "2-3" NO-LOCK  NO-ERROR NO-WAIT.
                IF AVAIL wcomp THEN 
                    ASSIGN wdetail.bi       = TRIM(wcomp.bi)
                           wdetail.pa       = TRIM(wcomp.pa)
                           wdetail.pd       = TRIM(wcomp.pd).
            END.
            IF index(wdetail.bran,"Nissan") = 0 AND  index(wdetail.bran,"Ford") = 0 THEN  /*A65-0361*/
                ASSIGN 
                       wdetail.nproducer =  "B3MLTIS103"   /*A65-0361*/
                       wdetail.nagent    =  "B3MLTIS100".  /*A65-0361*/
        END.
    END.
 
    IF wdetail.prev_pol <> "" THEN DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy = trim(wdetail.prev_pol) NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN ASSIGN wdetail.n_branch  =  sicuw.uwm100.branch.
    END.
     
    IF INDEX(wdetail.n_pack,"O") <> 0  THEN DO:
        FIND LAST WComp WHERE trim(wcomp.package) = "O" NO-LOCK  NO-ERROR NO-WAIT.
            IF AVAIL wcomp THEN DO:
              ASSIGN wdetail.bi   = TRIM(wcomp.bi)
                     wdetail.pa   = TRIM(wcomp.pa)
                     wdetail.pd   = TRIM(wcomp.pd).
            END.
    END. 

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_renew-02 C-Win 
PROCEDURE 00-proc_renew-02 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  create by A61-0410    
------------------------------------------------------------------------------*/
/* comment by : A64-0271.....
IF ra_poltyp = 1  THEN DO:      /* ������� */
    FIND FIRST stat.insure USE-INDEX insure01 WHERE 
        stat.insure.compno = fi_model          AND
        stat.insure.fname  = wdetail.brand     NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.insure THEN DO: 
        ASSIGN 
            wdetail.n_pack = trim(stat.insure.text5)       
            np_class = ""       np_brand = ""
            np_model = ""       np_class =  trim(stat.insure.text5)    
            np_brand =  Insure.text1    
            np_model =  insure.text2  .

        IF      wdetail.n_pack = "110" THEN ASSIGN wdetail.n_seattisco = 7 . 
        ELSE IF wdetail.n_pack = "320" THEN ASSIGN wdetail.n_seattisco = 3 . 
        ELSE IF wdetail.n_pack = "210" THEN ASSIGN wdetail.n_seattisco = 12 .
    END.
    ELSE DO: 
        ASSIGN  n_brand = IF INDEX(wdetail.brand," ") <> 0 THEN trim(SUBSTR(wdetail.brand,1,INDEX(wdetail.brand," ") - 1 )) 
                          ELSE trim(wdetail.brand).
        IF n_brand = "ISUZU" THEN
            ASSIGN wdetail.n_seattisco = IF wdetail.n_pack = "110" THEN 7 ELSE IF wdetail.n_pack = "210" THEN 5 ELSE 3.  
        ELSE DO: 
            IF      wdetail.n_pack = "110" THEN ASSIGN wdetail.n_seattisco = 7  .   
            ELSE IF wdetail.n_pack = "320" THEN ASSIGN wdetail.n_seattisco = 3  .   
            ELSE IF wdetail.n_pack = "210" THEN ASSIGN wdetail.n_seattisco = 12 .  
            ELSE ASSIGN wdetail.n_seattisco = 0 .   
        END.
    END.
     
    ASSIGN  wdetail.n_covcod    = ""
        wdetail.n_typpol    = "RENEW"              
        wdetail.nproducer   = fi_producertisco    
        wdetail.nagent      = fi_agenttisco     
        wdetail.n_branch    = "M"
        wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"*","")
        wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"-","")
        wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"/","")
        wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"\","")
        wdetail.prev_pol    = REPLACE(wdetail.prev_pol,".","").  
 
    IF nv_premt3 = 0 THEN DO:            
        ASSIGN wdetail.n_covcod  = "T".  
    END.                                 
    ELSE IF nv_premt3 = 7500.70 OR nv_premt3 = 8500.08 OR nv_premt3 = 9500.53  THEN DO:
        ASSIGN wdetail.n_covcod  = "2.2"
            wdetail.n_pack       = "C" +  trim(wdetail.n_pack).
    END.
    ELSE IF nv_premt3 = 6300 OR nv_premt3 = 7300 OR nv_premt3 = 7500 OR nv_premt3 = 8300  THEN DO:
        ASSIGN  wdetail.n_covcod = "3.2"
            wdetail.n_pack       = "C" +  trim(wdetail.n_pack).
    END.
    ELSE IF ( nv_premt3 <= 10000 ) AND (nv_premt3 > 2500 )  THEN DO: 
        ASSIGN wdetail.n_covcod  = "2"
            wdetail.n_pack       = "Y" +  trim(wdetail.n_pack).
    END.
    ELSE IF (nv_premt3 < 2500 )THEN DO:
        ASSIGN  wdetail.n_covcod = "3"
            wdetail.n_pack       = "R" +  trim(wdetail.n_pack).
        IF wdetail.n_pack = "R110" THEN ASSIGN wdetail.n_seattisco = 7. 
    END.
    ELSE IF  nv_premt3  >  10000   THEN DO: 
        ASSIGN  wdetail.n_covcod = "1".
        IF (wdetail.garage = "0")  THEN DO:
            IF  index(wdetail.brand,"Ford") <> 0 AND 
                index(wdetail.remark,"FORD ENSURE") <> 0 OR    
                INDEX(wdetail.remark,"FD")          <> 0 OR    
                SUBSTRING(wdetail.prev_pol,7,1)     = "F" THEN DO: 
                ASSIGN wdetail.n_pack = "O" +  trim(wdetail.n_pack).
                IF wdetail.n_pack = "O320" THEN ASSIGN wdetail.n_seattisco = 5.
            END.
            ELSE IF  index(wdetail.brand,"MAZDA")    <> 0   AND 
                     /*SUBSTRING(wdetail.prev_pol,7,2) = "MI" OR *//*A62-0386*/
                     index(wdetail.remark,"MPI")     <> 0   THEN DO:  
                     ASSIGN wdetail.n_pack = "M" +  trim(wdetail.n_pack).
                     IF wdetail.n_pack = "M110" THEN ASSIGN wdetail.n_seattisco = 7.
                     IF wdetail.n_pack = "M320" THEN ASSIGN wdetail.n_seattisco = 5.
            END.
            ELSE DO:
                FIND LAST WComp WHERE wcomp.cartyp   = "renew"    AND
                                      wcomp.brand    = "garage"   NO-LOCK  NO-ERROR NO-WAIT.
                IF AVAIL wcomp THEN  ASSIGN wdetail.n_pack = trim(wcomp.package) + trim(wdetail.n_pack).
            END.
        END.
        ELSE DO:    /*�������*/
            FIND LAST WComp WHERE wcomp.cartyp   = "renew" AND
                                  wcomp.brand    = ""      NO-LOCK  NO-ERROR NO-WAIT.
            IF AVAIL wcomp THEN  ASSIGN wdetail.n_pack = trim(wcomp.package) + trim(wdetail.n_pack) .
        END.
    END.
    
    IF INDEX(wdetail.prev_insur,"SAFETY INSURANCE") <> 0 THEN DO:  /* ������� STY */
        IF INDEX(wdetail.ben_name,"�к� 8.3") <> 0 AND INDEX(wdetail.ben_name,"����к� 8.3") = 0  THEN DO:   /*case : add 8.3 */
            IF  index(wdetail.brand,"FORD")         <> 0 AND 
                index(wdetail.remark,"FORD ENSURE") <> 0 OR
                INDEX(wdetail.remark,"FD")          <> 0 OR
                INDEX(wdetail.remark,"FE2+")        <> 0 OR  /*���Ҥ FE2+(�繧ҹ������ 2+ ������ҧ ����ç���FD)  ��������"B3M0033" / "B3M0035" */
                /*(SUBSTRING(wdetail.prev_pol,7,1) = "F" AND wdetail.n_covcod = "1" AND wdetail.garage = "0") */ /*A64-0271*/
                SUBSTRING(wdetail.prev_pol,7,1) = "F"  /*A64-0271*/ 
                THEN DO: /* Ford  */
                ASSIGN wdetail.n_branch  = ""
                    wdetail.nproducer = fi_producerford  /* "B3M0033"  */ 
                    wdetail.nagent    = fi_agentford .   /* "B3M0035"  */ 
            END.
            ELSE IF  index(wdetail.brand,"MAZDA")     <> 0   AND  /*Mazda MPI */
                /*SUBSTRING(wdetail.prev_pol,7,2)  = "MI" OR*/ /*A62-0386*/
                index(wdetail.remark,"MPI")      <> 0   THEN DO:  /*A61-0313*/
                ASSIGN  wdetail.n_branch  = ""
                    wdetail.nproducer  = fi_producermpi
                    wdetail.nagent     = fi_agenttiscompi.
            END.
            ELSE IF INDEX(wdetail.not_office,"CIR(RETAIL)") <> 0 OR INDEX(wdetail.not_office,"CIR(FLEET)") <> 0 OR
                INDEX(wdetail.remark,"L/CI/CODE")       <> 0 OR  INDEX(wdetail.remark,"C CI") <> 0        OR 
                INDEX(wdetail.remark,"L/CI") <> 0  THEN DO:
                ASSIGN wdetail.nproducer = fi_producercir   
                    wdetail.nagent    = fi_agenttiscocir .
            END.
            ELSE
                ASSIGN wdetail.nproducer  = fi_producer83      
                    wdetail.nagent     = fi_agenttisco83.
        END.  /* end add 8.3 */
        ELSE DO:                                                  /*case : NO 8.3 */
            IF index(wdetail.brand,"FORD") <> 0  THEN  DO:        /*case : Ford  */
                IF  index(wdetail.remark,"FORD ENSURE") <> 0 OR
                    INDEX(wdetail.remark,"FD")          <> 0 OR
                    INDEX(wdetail.remark,"FE2+")        <> 0 OR /*���Ҥ FE2+(�繧ҹ������ 2+ ������ҧ ����ç���FD)  ��������"B3M0033" / "B3M0035" */
                    /*(SUBSTRING(wdetail.prev_pol,7,1) = "F"    AND wdetail.n_covcod = "1" AND wdetail.garage = "0")*/ /*A64-0271*/
                    SUBSTRING(wdetail.prev_pol,7,1) = "F"  /*A64-0271*/   
                    THEN DO:
                    ASSIGN wdetail.n_branch  = ""
                        wdetail.nproducer = fi_producerford   /* "B3M0033"  */
                        wdetail.nagent    = fi_agentford .    /* "B3M0035"  */
                END.
                ELSE IF INDEX(wdetail.not_office,"CIR(RETAIL)") <> 0 OR INDEX(wdetail.not_office,"CIR(FLEET)") <> 0 OR
                    INDEX(wdetail.remark,"L/CI/CODE")       <> 0 OR INDEX(wdetail.remark,"C CI") <> 0        OR 
                    INDEX(wdetail.remark,"L/CI") <> 0  THEN DO:
                    ASSIGN wdetail.nproducer = fi_producercir   
                           wdetail.nagent    = fi_agenttiscocir .
                END.
            END.
            /*ELSE IF SUBSTRING(wdetail.prev_pol,7,2)  = "MI" OR*/  /* Mazda MPI */ /*a62-0386*/
            ELSE IF  index(wdetail.remark,"MPI")     <> 0   THEN DO:   
                ASSIGN  wdetail.n_branch  = ""
                    /*wdetail.nproducer  = fi_producermpi    fi_producermpi   = "B3MLTIS104"   
                    wdetail.nagent     = fi_agenttiscompi.   fi_agenttiscompi = "B3MLTIS100"    */
                    wdetail.nproducer  = fi_producertisco    /* "B3MLTIS101" */ /*A63-00472*/  
                    wdetail.nagent     = fi_agenttisco.      /* "B3MLTIS100" */ /*A63-00472*/  
            END.
            ELSE IF INDEX(wdetail.not_office,"CIR(RETAIL)") <> 0 OR INDEX(wdetail.not_office,"CIR(FLEET)") <> 0 OR
                INDEX(wdetail.remark,"L/CI/CODE")       <> 0 OR INDEX(wdetail.remark,"C CI") <> 0        OR 
                INDEX(wdetail.remark,"L/CI") <> 0  THEN DO:
                ASSIGN wdetail.nproducer = fi_producercir   
                    wdetail.nagent    = fi_agenttiscocir .
            END.
        END.  /* end No 8.3 */
    END.
    ELSE DO:  /* �ҹ�͹����  */
        IF index(wdetail.brand,"FORD") <> 0  AND       /*case : Ford  */
          (index(wdetail.remark,"FORD ENSURE")  <> 0 OR
           INDEX(wdetail.remark,"FD")           <> 0 OR
           INDEX(wdetail.remark,"FE2+")         <> 0 OR 
           SUBSTRING(wdetail.prev_pol,7,1) = "F" )   THEN DO:
            ASSIGN wdetail.n_branch  = ""
                   wdetail.nproducer = fi_producerford
                   wdetail.nagent    = fi_agentford .
        END.
        /*ELSE IF SUBSTRING(wdetail.prev_pol,7,2)  = "MI" OR */ /*A62-0386*/ /* Mazda MPI */
        ELSE IF  index(wdetail.remark,"MPI")     <> 0   THEN DO:   
            ASSIGN  wdetail.n_branch  = ""
                /*wdetail.nproducer  = fi_producermpi
                wdetail.nagent     = fi_agenttiscompi. */
                wdetail.nproducer  = fi_producertisco   
                wdetail.nagent     = fi_agenttisco.  
        END.
        ELSE IF INDEX(wdetail.not_office,"CIR(RETAIL)") <> 0 OR INDEX(wdetail.not_office,"CIR(FLEET)") <> 0 OR
                INDEX(wdetail.remark,"L/CI/CODE")   <> 0     OR INDEX(wdetail.remark,"C CI") <> 0        OR 
                INDEX(wdetail.remark,"L/CI") <> 0  THEN DO:
            ASSIGN wdetail.n_branch  = ""
                wdetail.nproducer = fi_producercir   
                wdetail.nagent    = fi_agenttiscocir .
        END.
        /*ELSE IF INDEX(wdetail.ben_name,"�к� 8.3") <> 0  THEN DO:   /* �к� 8.3 */     
            ASSIGN wdetail.nproducer  = fi_producer83
                   wdetail.nagent     = fi_agenttisco83.
        END.*/ 
        IF (wdetail.n_covcod <> "1") AND (INDEX(wdetail.prev_insur,"SAFETY INSURANCE") = 0 ) THEN DO: /* ����� �.1 �ҹ�͹���� */
            IF INDEX(wdetail.not_office,"CIR(RETAIL)") <> 0 OR INDEX(wdetail.not_office,"CIR(FLEET)") <> 0 OR
                INDEX(wdetail.remark,"L/CI/CODE")       <> 0 OR INDEX(wdetail.remark,"C CI") <> 0        OR 
                INDEX(wdetail.remark,"L/CI") <> 0  THEN DO:
                ASSIGN wdetail.n_branch  = "M"
                    wdetail.nproducer = fi_producercir     /* fi_producercir   = "B3MLTIS102" */
                    wdetail.nagent    = fi_agenttiscocir . /* fi_agenttiscocir = "B3MLTIS100" */
            END.
            ELSE IF index(wdetail.brand,"FORD") <> 0 AND INDEX(wdetail.remark,"FE2+") <> 0 THEN DO:  /*case : Ford  */ /*A63/00472*/
                ASSIGN wdetail.n_branch  = "M"
                    wdetail.nproducer = fi_producerford    /*A63/00472*/
                    wdetail.nagent    = fi_agentford .     /*A63/00472*/
            END.
            ELSE ASSIGN  wdetail.n_branch  = "M"
                /*wdetail.nproducer = "A0M2011"     /*A63-00472*/
                wdetail.nagent    = "B3M0035". */ /*A63-00472*/
                wdetail.nproducer = "B3MLTIS103"   /*A63-00472*/    
                wdetail.nagent    = "B3MLTIS100".  /*A63-00472*/    
            FIND LAST wcomp WHERE wcomp.cover = wdetail.n_covcod NO-LOCK NO-ERROR.
            IF AVAIL wcomp THEN DO:
                ASSIGN wdetail.bi       = TRIM(wcomp.bi)
                    wdetail.pa       = TRIM(wcomp.pa)
                    wdetail.pd       = TRIM(wcomp.pd).
            END.
            ELSE DO:
                FIND LAST WComp WHERE  wcomp.cover = "2-3" NO-LOCK  NO-ERROR NO-WAIT.
                IF AVAIL wcomp THEN 
                    ASSIGN wdetail.bi       = TRIM(wcomp.bi)
                    wdetail.pa       = TRIM(wcomp.pa)
                    wdetail.pd       = TRIM(wcomp.pd).
            END.
        END.
    END.
    /* Sarinya C. A63-0210 Campaign C63-001416 2+ */
    IF nv_premt1 = 8300.00 OR nv_premt1 = 9500.00 OR nv_premt1 = 10400.00 OR nv_premt1 = 12300.00 OR nv_premt1 = 14100.00 THEN DO:
        
        ASSIGN 
            wdetail.n_covcod = "" wdetail.garage = "" wdetail.nproducer = ""  wdetail.remark = "" 
            wdetail.n_pack   = "" wdetail.bi     = "" wdetail.pa        = ""  wdetail.pd     = ""
            wdetail.n_covcod  = "2.2"
            wdetail.garage    = "0"
            /*wdetail.nproducer = "B3M0033"                */ /*A64-0092*/
            /*wdetail.nagent    = "B3M0035"   /*A63/00472*/*/ /*A64-0092*/
            wdetail.nproducer = fi_producerford  /*A64-0092*/ 
            wdetail.nagent    = fi_agentford    /*A64-0092*/ 
            wdetail.remark    = "FE2+"
            wdetail.bi        = "500000"
            wdetail.pa        = "10000000"
            wdetail.pd        = "2500000".
        IF      wdetail.n_seattisco = 7 THEN wdetail.n_pack = "U110".
        ELSE IF wdetail.n_seattisco = 3 THEN ASSIGN wdetail.n_pack = "U320" 
                                                    wdetail.n_seattisco = 5.
    END.

    /*-- end : A60-0095 ---*/
    IF wdetail.prev_pol <> "" THEN DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy = trim(wdetail.prev_pol) NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN ASSIGN wdetail.n_branch  =  sicuw.uwm100.branch.
    END.
    /*--- create by A61-0045 Pack O-----*/
    IF INDEX(wdetail.n_pack,"O") <> 0  THEN DO:
        FIND LAST WComp WHERE trim(wcomp.package) = "O" NO-LOCK  NO-ERROR NO-WAIT.
            IF AVAIL wcomp THEN DO:
              ASSIGN wdetail.bi   = TRIM(wcomp.bi)
                     wdetail.pa   = TRIM(wcomp.pa)
                     wdetail.pd   = TRIM(wcomp.pd).
            END.
    END.
    /*----- end A61-0045-------*/
   
END.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_renew_BP C-Win 
PROCEDURE 00-proc_renew_BP :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  create by A60-0095     
------------------------------------------------------------------------------*/
/*IF ra_poltyp = 1  THEN DO:      /* ������� */
    FIND FIRST stat.insure USE-INDEX insure01 WHERE 
        stat.insure.compno = fi_model          AND
        stat.insure.fname  = wdetail.brand     NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.insure THEN DO: 
        ASSIGN 
            wdetail.n_pack = trim(stat.insure.text5)      /*A57-0088*/ 
            np_class = ""       np_brand = ""
            np_model = ""       np_class =  trim(stat.insure.text5)     /*A57-0088*/   
            np_brand =  Insure.text1    
            np_model =  insure.text2  .

        IF      wdetail.n_pack = "110" THEN ASSIGN wdetail.n_seattisco = 7 .   /*A57-0017*/
        ELSE IF wdetail.n_pack = "320" THEN ASSIGN wdetail.n_seattisco = 3 .   /*A57-0017*/
        ELSE IF wdetail.n_pack = "210" THEN ASSIGN wdetail.n_seattisco = 12 .  /*A57-0017*/
    END.
    /*--A60-0095--*/
    ELSE DO: 
        ASSIGN  n_brand = IF INDEX(wdetail.brand," ") <> 0 THEN trim(SUBSTR(wdetail.brand,1,INDEX(wdetail.brand," ") - 1 )) 
                          ELSE trim(wdetail.brand).
        IF n_brand = "ISUZU" THEN
            ASSIGN wdetail.n_seattisco = IF wdetail.n_pack = "110" THEN 7 ELSE IF wdetail.n_pack = "210" THEN 5 ELSE 3.  
        ELSE DO: 
            IF      wdetail.n_pack = "110" THEN ASSIGN wdetail.n_seattisco = 7  .   
            ELSE IF wdetail.n_pack = "320" THEN ASSIGN wdetail.n_seattisco = 3  .   
            ELSE IF wdetail.n_pack = "210" THEN ASSIGN wdetail.n_seattisco = 12 .  
            ELSE ASSIGN wdetail.n_seattisco = 0 .   
        END.
    END.
     /*-- end : A60-0095--*/
    ASSIGN  wdetail.n_covcod    = ""
        wdetail.n_typpol    = "RENEW"              
        wdetail.nproducer   = fi_producertisco  /*A0M2008 */    
        wdetail.nagent      = fi_agenttisco     /*B3M0035 */
        wdetail.n_branch    = "M"
        wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"*","")
        wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"-","")
        wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"/","")
        wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"\","")
        wdetail.prev_pol    = REPLACE(wdetail.prev_pol,".","").  

  /*-- create by : Ranu I. A60-0095 ---*/
    IF nv_premt3 = 0 THEN DO:            /*A61-0045*/
        ASSIGN wdetail.n_covcod  = "T".  /*A61-0045*/
    END.                                 /*A61-0045*/
    ELSE IF nv_premt3 = 7500.70 OR nv_premt3 = 8500.08 OR nv_premt3 = 9500.53  THEN DO:
        ASSIGN wdetail.n_covcod  = "2.2"
            wdetail.n_pack       = "C" +  trim(wdetail.n_pack)
            /*wdetail.n_branch     = "M"*/ .
    END.
    ELSE IF nv_premt3 = 6300 OR nv_premt3 = 7300 OR nv_premt3 = 7500 OR nv_premt3 = 8300  THEN DO:
        ASSIGN  wdetail.n_covcod = "3.2"
            wdetail.n_pack       = "C" +  trim(wdetail.n_pack)
            /*wdetail.n_branch     = "M"*/ .
    END.
    ELSE IF ( nv_premt3 <= 10000 ) AND (nv_premt3 > 2500 )  THEN DO: 
        ASSIGN wdetail.n_covcod  = "2"
            wdetail.n_pack       = "Y" +  trim(wdetail.n_pack)
            /*wdetail.n_branch     = "M"*/ .
    END.
    ELSE IF (nv_premt3 < 2500 )THEN DO:
        ASSIGN  wdetail.n_covcod = "3"
            wdetail.n_pack       = "R" +  trim(wdetail.n_pack)
            /*wdetail.n_branch     = "M"*/ .
        IF wdetail.n_pack = "R110" THEN ASSIGN wdetail.n_seattisco = 7.  /*A60-0095*/    
    END.
    /*-- end : A60-0095 ---*/
    ELSE IF  nv_premt3  >  10000   THEN DO: 
        ASSIGN  wdetail.n_covcod = "1".
        IF (wdetail.garage = "0")  THEN DO:
            IF  index(wdetail.brand,"Ford") <> 0 AND 
                index(wdetail.remark,"FORD ENSURE") <> 0 OR     /*A60-0095*/    
                INDEX(wdetail.remark,"FD")          <> 0 OR     /*A60-0095*/
                SUBSTRING(wdetail.prev_pol,7,1)     = "F" THEN DO: /*A60-0095*/
                ASSIGN wdetail.n_pack = "O" +  trim(wdetail.n_pack).
                IF wdetail.n_pack = "O320" THEN ASSIGN wdetail.n_seattisco = 5.
            END.
            /*---A60-0225---*/
            ELSE IF  index(wdetail.brand,"MAZDA")    <> 0   AND 
                     SUBSTRING(wdetail.prev_pol,7,2) = "MI" OR 
                     index(wdetail.remark,"MPI")     <> 0   THEN DO:  /*A61-0313*/
                     ASSIGN wdetail.n_pack = "M" +  trim(wdetail.n_pack).
                     IF wdetail.n_pack = "M110" THEN ASSIGN wdetail.n_seattisco = 7.
                     IF wdetail.n_pack = "M320" THEN ASSIGN wdetail.n_seattisco = 5.
            END.
            /*-- end: A60-0225---*/
            ELSE DO:
                FIND LAST WComp WHERE wcomp.cartyp   = "renew"    AND
                                      wcomp.brand    = "garage"   NO-LOCK  NO-ERROR NO-WAIT.
                IF AVAIL wcomp THEN  ASSIGN wdetail.n_pack = trim(wcomp.package) + trim(wdetail.n_pack).
            END.
        END.
        ELSE DO:    /*�������*/
            FIND LAST WComp WHERE wcomp.cartyp   = "renew" AND
                                  wcomp.brand    = ""      NO-LOCK  NO-ERROR NO-WAIT.
            IF AVAIL wcomp THEN  ASSIGN wdetail.n_pack = trim(wcomp.package) + trim(wdetail.n_pack) .
        END.
    END.
    /*-- create by : Ranu I. A60-0095 ---*/
    IF INDEX(wdetail.prev_insur,"SAFETY INSURANCE") <> 0 THEN DO:  /* ������� STY */

        IF INDEX(wdetail.ben_name,"�к� 8.3") <> 0  THEN DO:   /*case : add 8.3 */

            IF  index(wdetail.brand,"FORD")         <> 0 AND 
                index(wdetail.remark,"FORD ENSURE") <> 0 OR
                INDEX(wdetail.remark,"FD")          <> 0 OR
                SUBSTRING(wdetail.prev_pol,7,1)     = "F" THEN DO: /* Ford  */
                ASSIGN wdetail.n_branch  = ""
                       wdetail.nproducer = fi_producerford
                       wdetail.nagent    = fi_agentford .
            END.
             /*--A60-0225---*/
            ELSE IF  index(wdetail.brand,"MAZDA")     <> 0   AND  /*Mazda MPI */
                     SUBSTRING(wdetail.prev_pol,7,2)  = "MI" OR
                     index(wdetail.remark,"MPI")      <> 0   THEN DO:  /*A61-0313*/
                ASSIGN  wdetail.n_branch  = ""
                        wdetail.nproducer  = fi_producermpi
                        wdetail.nagent     = fi_agenttiscompi.
            END.
            /* create : A61-0410 */
            ELSE  IF (wdetail.n_covcod = "1") AND index(wdetail.brand,"MAZDA") <> 0 THEN DO: /* MAZDA �.1*/
                    ASSIGN wdetail.nproducer  = fi_producerma
                           wdetail.nagent     = fi_agenttiscoma .
            END.
            /* end A61-0410*/
            ELSE IF INDEX(wdetail.not_office,"CIR(RETAIL)") <> 0 THEN DO:
                ASSIGN wdetail.nproducer = fi_producercir   
                       wdetail.nagent    = fi_agenttiscocir .
            END.
            /*-- end : A60-0225---*/
            ELSE
                ASSIGN wdetail.nproducer  = fi_producer83      
                       wdetail.nagent     = fi_agenttisco83.
        END. /* end add 8.3 */
        ELSE DO:                                                  /*case : NO 8.3 */
            IF index(wdetail.brand,"FORD") <> 0  THEN  DO:        /*case : Ford  */
                 IF (index(wdetail.remark,"FORD ENSURE") <> 0 OR
                    INDEX(wdetail.remark,"FD")           <> 0 OR
                    SUBSTRING(wdetail.prev_pol,7,1) = "F" )   THEN DO:
                    ASSIGN wdetail.n_branch  = ""
                           wdetail.nproducer = fi_producerford
                           wdetail.nagent    = fi_agentford .
                 END.
                 /*--A60-0225---*/
                 ELSE IF INDEX(wdetail.not_office,"CIR(RETAIL)") <> 0 THEN DO:
                     ASSIGN wdetail.nproducer = fi_producercir   
                            wdetail.nagent    = fi_agenttiscocir .
                 END.
                 /*-- end : A60-0225---*/
            END.
            /* create :  A61-0410 */
            ELSE IF SUBSTRING(wdetail.prev_pol,7,2)  = "MI" OR  /* Mazda MPI */
              index(wdetail.remark,"MPI")     <> 0   THEN DO:   
              ASSIGN  wdetail.n_branch  = ""
                     wdetail.nproducer  = fi_producermpi
                     wdetail.nagent     = fi_agenttiscompi.
            END.
            ELSE  IF (wdetail.n_covcod = "1") AND index(wdetail.brand,"MAZDA") <> 0 THEN DO:  /* MAZDA �.1*/
                ASSIGN wdetail.nproducer  = fi_producerma
                       wdetail.nagent     = fi_agenttiscoma .
            END.
            /* end A61-0410*/
           /*--A60-0225---*/
            ELSE IF INDEX(wdetail.not_office,"CIR(RETAIL)") <> 0 THEN DO:
                ASSIGN wdetail.nproducer = fi_producercir   
                       wdetail.nagent    = fi_agenttiscocir .
            END.
            /*-- end : A60-0225---*/
        END.  /* end No 8.3 */
        /* comment by A61-0410...
       /*--A60-0225--*/
        IF  index(wdetail.brand,"MAZDA") <> 0 THEN DO:
            /*--- A60-0225---*/
           IF SUBSTRING(wdetail.prev_pol,7,2)  = "MI" OR 
              index(wdetail.remark,"MPI")     <> 0   THEN DO:  /*A61-0313*/ 
              ASSIGN  wdetail.n_branch  = ""
                     wdetail.nproducer  = fi_producermpi
                     wdetail.nagent     = fi_agenttiscompi.
            END.
            ELSE IF INDEX(wdetail.not_office,"CIR(RETAIL)") <> 0 THEN DO:
                ASSIGN wdetail.nproducer = fi_producercir   
                       wdetail.nagent    = fi_agenttiscocir .
            END.
            /*-- end : A60-0225---*/
            ELSE DO:         /*case : Mazda */
                    ASSIGN wdetail.n_branch  = ""
                    wdetail.nproducer        = fi_producerma
                    wdetail.nagent           = fi_agenttiscoma .
            END.
        END.
        ... end A61-0410...*/
    END.
    ELSE DO:
         /*--A60-0225---*/
        IF INDEX(wdetail.not_office,"CIR(RETAIL)") <> 0 THEN DO:
           ASSIGN wdetail.n_branch  = ""
                  wdetail.nproducer = fi_producercir   
                  wdetail.nagent    = fi_agenttiscocir .
        END.
        /*-- end : A60-0225---*/
        /*ELSE IF (wdetail.n_covcod = "1") AND INDEX(wdetail.ben_name,"�к� 8.3") <> 0 AND index(wdetail.brand,"MAZDA") <> 0 THEN DO:*/ /*A61-0410*/
        ELSE IF (wdetail.n_covcod = "1") AND index(wdetail.brand,"MAZDA") <> 0 THEN DO: /*A61-0410*/
        ASSIGN wdetail.n_branch   = "M"
               wdetail.nproducer  = fi_producerma
               wdetail.nagent     = fi_agenttiscoma .
        END.
        ELSE IF INDEX(wdetail.ben_name,"�к� 8.3") <> 0  THEN DO:        
            ASSIGN wdetail.nproducer  = fi_producer83
                   wdetail.nagent     = fi_agenttisco83.
        END.

        IF (wdetail.n_covcod <> "1") AND (INDEX(wdetail.prev_insur,"SAFETY INSURANCE") = 0 ) THEN DO:
             /*--A60-0225---*/
            IF INDEX(wdetail.not_office,"CIR(RETAIL)") <> 0 THEN DO:
               ASSIGN wdetail.n_branch  = ""
                      wdetail.nproducer = fi_producercir   
                      wdetail.nagent    = fi_agenttiscocir .
            END.
            /*-- end : A60-0225---*/
            ELSE ASSIGN  wdetail.n_branch  = "M"
                         wdetail.nproducer = "A0M2011"
                         wdetail.nagent    = "B3M0035". /*A61-0313*/
                         /*wdetail.nagent    = "B3M0002".*/ /*A61-0313*/
           FIND LAST wcomp WHERE wcomp.cover = wdetail.n_covcod NO-LOCK NO-ERROR.
           IF AVAIL wcomp THEN DO:
                ASSIGN wdetail.bi       = TRIM(wcomp.bi)
                       wdetail.pa       = TRIM(wcomp.pa)
                       wdetail.pd       = TRIM(wcomp.pd).
           END.
           ELSE DO:
               FIND LAST WComp WHERE  wcomp.cover = "2-3" NO-LOCK  NO-ERROR NO-WAIT.
               IF AVAIL wcomp THEN 
                   ASSIGN wdetail.bi       = TRIM(wcomp.bi)
                          wdetail.pa       = TRIM(wcomp.pa)
                          wdetail.pd       = TRIM(wcomp.pd).
           END.
        END.
    END.
    /*-- end : A60-0095 ---*/
    IF wdetail.prev_pol <> "" THEN DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy = trim(wdetail.prev_pol) NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN ASSIGN wdetail.n_branch  =  sicuw.uwm100.branch.
    END.
    /*--- create by A61-0045 Pack O-----*/
    IF INDEX(wdetail.n_pack,"O") <> 0  THEN DO:
        FIND LAST WComp WHERE trim(wcomp.package) = "O" NO-LOCK  NO-ERROR NO-WAIT.
            IF AVAIL wcomp THEN DO:
              ASSIGN wdetail.bi   = TRIM(wcomp.bi)
                     wdetail.pa   = TRIM(wcomp.pa)
                     wdetail.pd   = TRIM(wcomp.pd).
            END.
    END.
    /*----- end A61-0045-------*/


END.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_renew_old C-Win 
PROCEDURE 00-proc_renew_old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  add by A64-0271 
------------------------------------------------------------------------------*/
IF ra_poltyp = 1  THEN DO:      /* ������� */
    FIND FIRST stat.insure USE-INDEX insure01 WHERE 
        stat.insure.compno = fi_model          AND
        stat.insure.fname  = wdetail.brand     NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.insure THEN DO: 
        ASSIGN 
            wdetail.n_pack = trim(stat.insure.text5)       
            np_class = ""       np_brand = ""
            np_model = ""       np_class =  trim(stat.insure.text5)    
            np_brand =  Insure.text1    
            np_model =  insure.text2  .

        IF      wdetail.n_pack = "110" THEN ASSIGN wdetail.n_seattisco = 7 . 
        ELSE IF wdetail.n_pack = "320" THEN ASSIGN wdetail.n_seattisco = 3 . 
        ELSE IF wdetail.n_pack = "210" THEN ASSIGN wdetail.n_seattisco = 12 .
    END.
    ELSE DO: 
        ASSIGN  n_brand = IF INDEX(wdetail.brand," ") <> 0 THEN trim(SUBSTR(wdetail.brand,1,INDEX(wdetail.brand," ") - 1 )) 
                          ELSE trim(wdetail.brand).
        IF n_brand = "ISUZU" THEN
            ASSIGN wdetail.n_seattisco = IF wdetail.n_pack = "110" THEN 7 ELSE IF wdetail.n_pack = "210" THEN 5 ELSE 3.  
        ELSE DO: 
            IF      wdetail.n_pack = "110" THEN ASSIGN wdetail.n_seattisco = 7  .   
            ELSE IF wdetail.n_pack = "320" THEN ASSIGN wdetail.n_seattisco = 3  .   
            ELSE IF wdetail.n_pack = "210" THEN ASSIGN wdetail.n_seattisco = 12 .  
            ELSE ASSIGN wdetail.n_seattisco = 0 .   
        END.
    END.
     
    ASSIGN  wdetail.n_covcod    = ""
        wdetail.n_typpol    = "RENEW"              
        wdetail.nproducer   = fi_producertisco    
        wdetail.nagent      = fi_agenttisco     
        wdetail.n_branch    = "M"
        wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"*","")
        wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"-","")
        wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"/","")
        wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"\","")
        wdetail.prev_pol    = REPLACE(wdetail.prev_pol,".","").  
 
    IF nv_premt3 = 0 THEN DO:            
        ASSIGN wdetail.n_covcod  = "T".  
    END.                                 
    ELSE IF nv_premt3 = 7500.70 OR nv_premt3 = 8500.08 OR nv_premt3 = 9500.53  THEN DO:
        ASSIGN wdetail.n_covcod  = "2.2"
            wdetail.n_pack       = "C" +  trim(wdetail.n_pack).
    END.
    ELSE IF nv_premt3 = 6300 OR nv_premt3 = 7300 OR nv_premt3 = 7500 OR nv_premt3 = 8300  THEN DO:
        ASSIGN  wdetail.n_covcod = "3.2"
            wdetail.n_pack       = "C" +  trim(wdetail.n_pack).
    END.
    ELSE IF ( nv_premt3 <= 10000 ) AND (nv_premt3 > 2500 )  THEN DO: 
        ASSIGN wdetail.n_covcod  = "2"
            wdetail.n_pack       = "Y" +  trim(wdetail.n_pack).
    END.
    ELSE IF (nv_premt3 < 2500 )THEN DO:
        ASSIGN  wdetail.n_covcod = "3"
            wdetail.n_pack       = "R" +  trim(wdetail.n_pack).
        IF wdetail.n_pack = "R110" THEN ASSIGN wdetail.n_seattisco = 7. 
    END.
    ELSE IF  nv_premt3  >  10000   THEN DO: 
        ASSIGN  wdetail.n_covcod = "1".
        IF (wdetail.garage = "0")  THEN DO:
            IF  index(wdetail.brand,"Ford") <> 0 AND 
                index(wdetail.remark,"FORD ENSURE") <> 0 OR    
                INDEX(wdetail.remark,"FD")          <> 0 OR    
                SUBSTRING(wdetail.prev_pol,7,1)     = "F" THEN DO: 
                ASSIGN wdetail.n_pack = "O" +  trim(wdetail.n_pack).
                IF wdetail.n_pack = "O320" THEN ASSIGN wdetail.n_seattisco = 5.
            END.
            ELSE IF  index(wdetail.brand,"MAZDA")    <> 0   AND 
                     /*SUBSTRING(wdetail.prev_pol,7,2) = "MI" OR *//*A62-0386*/
                     index(wdetail.remark,"MPI")     <> 0   THEN DO:  
                     ASSIGN wdetail.n_pack = "M" +  trim(wdetail.n_pack).
                     IF wdetail.n_pack = "M110" THEN ASSIGN wdetail.n_seattisco = 7.
                     IF wdetail.n_pack = "M320" THEN ASSIGN wdetail.n_seattisco = 5.
            END.
            ELSE DO:
                FIND LAST WComp WHERE wcomp.cartyp   = "renew"    AND
                                      wcomp.brand    = "garage"   NO-LOCK  NO-ERROR NO-WAIT.
                IF AVAIL wcomp THEN  ASSIGN wdetail.n_pack = trim(wcomp.package) + trim(wdetail.n_pack).
            END.
        END.
        ELSE DO:    /*�������*/
            FIND LAST WComp WHERE wcomp.cartyp   = "renew" AND
                                  wcomp.brand    = ""      NO-LOCK  NO-ERROR NO-WAIT.
            IF AVAIL wcomp THEN  ASSIGN wdetail.n_pack = trim(wcomp.package) + trim(wdetail.n_pack) .
        END.
    END.

    IF  index(wdetail.brand,"FORD")  <> 0 THEN DO: /* Ford  */
        ASSIGN wdetail.nproducer = fi_producerford  /* "B3M0033"  */ 
               wdetail.nagent    = fi_agentford .   /* "B3M0035"  */ 

        IF ((YEAR(TODAY) - INT(wdetail.yrmanu) <= 7 )  AND 
           (nv_premt1 = 8300.00  OR nv_premt1 = 9500.00  OR 
            nv_premt1 = 10400.00 OR nv_premt1 = 12300.00 OR 
            nv_premt1 = 14100.00 )) THEN DO:
            ASSIGN 
               /* wdetail.n_covcod = "" wdetail.garage = "" wdetail.nproducer = ""  wdetail.remark = "" 
                wdetail.n_pack   = "" wdetail.bi     = "" wdetail.pa        = ""  wdetail.pd     = ""*/
                wdetail.n_covcod  = "2.2"
                wdetail.garage    = "0"
                wdetail.remark    = "FE2+"
                wdetail.bi        = "500000"
                wdetail.pa        = "10000000"
                wdetail.pd        = "2500000".
            IF      wdetail.n_seattisco = 7 THEN wdetail.n_pack = "U110".
            ELSE IF wdetail.n_seattisco = 3 THEN ASSIGN wdetail.n_pack = "U320" 
                                                        wdetail.n_seattisco = 5.
        END.
    END.
    ELSE IF INDEX(wdetail.prev_insur,"SAFETY INSURANCE") <> 0 THEN DO:  /* ������� STY */
        IF INDEX(wdetail.ben_name,"�к� 8.3") <> 0 AND INDEX(wdetail.ben_name,"����к� 8.3") = 0  THEN DO:   /*case : add 8.3 */
            IF  index(wdetail.brand,"MAZDA")     <> 0   AND       /*Mazda MPI */
                index(wdetail.remark,"MPI")      <> 0   THEN DO:  /*A61-0313*/
                ASSIGN  wdetail.n_branch  = ""
                    wdetail.nproducer  = fi_producermpi
                    wdetail.nagent     = fi_agenttiscompi.
            END.
            ELSE IF INDEX(wdetail.not_office,"CIR(RETAIL)") <> 0 OR INDEX(wdetail.not_office,"CIR(FLEET)") <> 0 OR 
                    INDEX(wdetail.remark,"L/CI/CODE")       <> 0 OR INDEX(wdetail.remark,"C CI") <> 0           OR 
                    INDEX(wdetail.remark,"L/CI")            <> 0 OR 
                    INDEX(wdetail.remark,"P CI")            <> 0 OR INDEX(wdetail.remark,"L/CI") <> 0  /* A65-0035*/
                    THEN DO:
                ASSIGN wdetail.nproducer = fi_producercir   
                    wdetail.nagent    = fi_agenttiscocir .
            END.
            ELSE
                ASSIGN wdetail.nproducer  = fi_producer83      
                    wdetail.nagent     = fi_agenttisco83.
        END.  /* end add 8.3 */
        ELSE DO:                                                  /*case : NO 8.3 */
            IF  index(wdetail.remark,"MPI")     <> 0   THEN DO:   
                ASSIGN  wdetail.n_branch  = ""
                    wdetail.nproducer  = fi_producertisco    /* "B3MLTIS101" */ /*A63-00472*/  
                    wdetail.nagent     = fi_agenttisco.      /* "B3MLTIS100" */ /*A63-00472*/  
            END.
            ELSE IF INDEX(wdetail.not_office,"CIR(RETAIL)") <> 0 OR INDEX(wdetail.not_office,"CIR(FLEET)") <> 0 OR
                INDEX(wdetail.remark,"L/CI/CODE")           <> 0 OR INDEX(wdetail.remark,"C CI")           <> 0 OR 
                INDEX(wdetail.remark,"L/CI")                <> 0 OR
                INDEX(wdetail.remark,"P CI")                <> 0 OR INDEX(wdetail.remark,"L/CI") <> 0  /* A65-0035*/
                THEN DO:
                ASSIGN wdetail.nproducer = fi_producercir   
                    wdetail.nagent    = fi_agenttiscocir .
            END.
        END.  /* end No 8.3 */
    END.
    ELSE DO:  /* �ҹ�͹����  */
        IF  index(wdetail.remark,"MPI")     <> 0   THEN DO:   
            ASSIGN  wdetail.n_branch  = ""
                wdetail.nproducer  = fi_producertisco   
                wdetail.nagent     = fi_agenttisco.  
        END.
        ELSE IF INDEX(wdetail.not_office,"CIR(RETAIL)") <> 0 OR INDEX(wdetail.not_office,"CIR(FLEET)") <> 0 OR
                INDEX(wdetail.remark,"L/CI/CODE")       <> 0 OR INDEX(wdetail.remark,"C CI")           <> 0 OR 
                INDEX(wdetail.remark,"L/CI")            <> 0 OR 
                INDEX(wdetail.remark,"P CI")            <> 0 OR INDEX(wdetail.remark,"L/CI") <> 0  /* A65-0035*/ 
            THEN DO:
            ASSIGN wdetail.n_branch  = ""
                wdetail.nproducer = fi_producercir   
                wdetail.nagent    = fi_agenttiscocir .
        END.
        ELSE IF (wdetail.n_covcod = "1") AND INDEX(wdetail.ben_name,"�к� 8.3") <> 0 AND INDEX(wdetail.ben_name,"����к� 8.3") = 0 THEN DO:
            ASSIGN wdetail.nproducer = fi_producer83      
                    wdetail.nagent   = fi_agenttisco83.
        END.

        IF (wdetail.n_covcod <> "1") AND (INDEX(wdetail.prev_insur,"SAFETY INSURANCE") = 0 ) THEN DO: /* ����� �.1 �ҹ�͹���� */
            IF INDEX(wdetail.not_office,"CIR(RETAIL)") <> 0 OR INDEX(wdetail.not_office,"CIR(FLEET)") <> 0 OR
                INDEX(wdetail.remark,"L/CI/CODE")      <> 0 OR INDEX(wdetail.remark,"C CI")           <> 0 OR 
                INDEX(wdetail.remark,"L/CI")           <> 0 OR
                INDEX(wdetail.remark,"P CI")           <> 0 OR INDEX(wdetail.remark,"L/CI") <> 0  /* A65-0035*/
                THEN DO:
                ASSIGN wdetail.n_branch  = "ML"
                    wdetail.nproducer = fi_producercir     /* fi_producercir   = "B3MLTIS102" */
                    wdetail.nagent    = fi_agenttiscocir . /* fi_agenttiscocir = "B3MLTIS100" */
            END.
            ELSE ASSIGN  wdetail.n_branch  = "ML"
               wdetail.nproducer = fi_pdbkcode   /* B3MLTIS103" */  /*A63-00472*/  
               wdetail.nagent    = fi_agbkcode . /* B3MLTIS100".*/  /*A63-00472*/  
            FIND LAST wcomp WHERE wcomp.cover = wdetail.n_covcod NO-LOCK NO-ERROR.
            IF AVAIL wcomp THEN DO:
                ASSIGN wdetail.bi       = TRIM(wcomp.bi)
                    wdetail.pa       = TRIM(wcomp.pa)
                    wdetail.pd       = TRIM(wcomp.pd).
            END.
            ELSE DO:
                FIND LAST WComp WHERE  wcomp.cover = "2-3" NO-LOCK  NO-ERROR NO-WAIT.
                IF AVAIL wcomp THEN 
                    ASSIGN wdetail.bi       = TRIM(wcomp.bi)
                    wdetail.pa       = TRIM(wcomp.pa)
                    wdetail.pd       = TRIM(wcomp.pd).
            END.
            IF index(wdetail.bran,"Nissan") = 0 AND  index(wdetail.bran,"Ford") = 0 THEN  /*A65-0361*/
                ASSIGN 
                       wdetail.nproducer =  "B3MLTIS103"   /*A65-0361*/
                       wdetail.nagent    =  "B3MLTIS100".  /*A65-0361*/
        END.
    END.
    /*-- end : A60-0095 ---*/
    /* comment by : a65-0035.....
    IF wdetail.prev_pol <> ""  THEN DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy = trim(wdetail.prev_pol) NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO: 
            ASSIGN wdetail.n_branch  =  sicuw.uwm100.branch.
            IF  index(wdetail.brand,"NISSAN")  <> 0 THEN DO:
                ASSIGN wdetail.nproducer = fi_producernis  
                    wdetail.nagent       = fi_agentnis     
                    wdetail.n_branch     = IF sicuw.uwm100.acno1 = "B3W0020" THEN "W" ELSE "MF".
            END.
        END.
        ELSE IF index(wdetail.brand,"NISSAN")  <> 0 THEN ASSIGN wdetail.nproducer = fi_producernis2
                                                            wdetail.nagent    = fi_agentnis2 .

    END.
    ELSE IF index(wdetail.brand,"NISSAN")  <> 0 THEN ASSIGN wdetail.nproducer = fi_producernis2
                                                            wdetail.nagent    = fi_agentnis2 .
  ..end :  a65-0035.....*/
    /*..add by :  a65-0035.....*/
    IF index(wdetail.bran,"Nissan") <> 0 THEN DO:
        IF INDEX(wdetail.prev_insur,"SAFETY INSURANCE") <> 0 THEN DO:
            FIND LAST sicuw.uwm301 Use-index uwm30121 Where 
                      sicuw.uwm301.cha_no      = trim(wdetail.chassis)  AND 
                      substr(sicuw.uwm301.policy,3,2) = "70"  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm301 THEN DO:
                ASSIGN 
                       wdetail.nproducer =  fi_producernis  
                       wdetail.nagent    =  fi_agentnis .
                IF trim(wdetail.polold) = "" THEN wdetail.polold = sicuw.uwm301.policy .
                Find LAST sicuw.uwm100 Use-index uwm10001       Where
                    sicuw.uwm100.policy = sicuw.uwm301.policy   and
                    sicuw.uwm100.rencnt = sicuw.uwm301.rencnt   and 
                    sicuw.uwm100.poltyp = "V70"  No-lock no-error no-wait.
                If avail sicuw.uwm100 Then DO:
                    ASSIGN wdetail.n_branch  =  sicuw.uwm100.branch
                        wdetail.n_branch  =  IF sicuw.uwm100.acno1 = "B3W0020" OR sicuw.uwm100.acno1 = "B3W0016" THEN "W" ELSE "MF" .
                    IF sicuw.uwm100.branch <> "W" AND sicuw.uwm100.branch <> "MF" THEN DO:
                        IF INDEX(wdetail.ben_name,"�к� 8.3") <> 0 THEN 
                            ASSIGN                  
                            wdetail.nproducer =    "B3MLTIS104"   /*A65-0361*/
                            wdetail.nagent    =    "B3MLTIS100".  /*A65-0361*/
                        ELSE ASSIGN                  
                            wdetail.nproducer =    "B3MLTIS101"   /*A65-0361*/
                            wdetail.nagent    =    "B3MLTIS100".  /*A65-0361*/
                    END.
                END.
                
            END.
            ELSE IF index(wdetail.brand,"NISSAN")  <> 0 THEN ASSIGN wdetail.nproducer = fi_producernis2
                                                                wdetail.nagent    = fi_agentnis2 .
        END.
        ELSE IF index(wdetail.brand,"NISSAN")  <> 0 THEN ASSIGN wdetail.nproducer = fi_producernis2
                                                                wdetail.nagent    = fi_agentnis2 .
    END.
    ELSE IF  index(wdetail.brand,"HAVAL") <> 0 THEN DO:
            ASSIGN wdetail.n_branch  = ""
                   wdetail.nproducer = fi_producerhaval   /*A65-0361*/
                   wdetail.nagent    = fi_agenthaval   .  /*A65-0361*/
    END.
    IF wdetail.agent = "HI-WAY" AND index(wdetail.brand,"WHEELS") <> 0 THEN


 /* end : a65-0043 */
    IF wdetail.prev_pol <> "" THEN DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy = trim(wdetail.prev_pol) NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN ASSIGN wdetail.n_branch  =  sicuw.uwm100.branch.
    END.
    /*--- create by A61-0045 Pack O-----*/
    IF INDEX(wdetail.n_pack,"O") <> 0  THEN DO:
        FIND LAST WComp WHERE trim(wcomp.package) = "O" NO-LOCK  NO-ERROR NO-WAIT.
            IF AVAIL wcomp THEN DO:
              ASSIGN wdetail.bi   = TRIM(wcomp.bi)
                     wdetail.pa   = TRIM(wcomp.pa)
                     wdetail.pd   = TRIM(wcomp.pd).
            END.
    END.
    /*----- end A61-0045-------*/


END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_renew_oldbk C-Win 
PROCEDURE 00-proc_renew_oldbk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF ra_poltyp = 1  THEN DO:      /* ������� */
    FIND FIRST stat.insure USE-INDEX insure01 WHERE 
        stat.insure.compno = fi_model          AND
        stat.insure.fname  = wdetail.brand     NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.insure THEN DO: 
        ASSIGN 
            wdetail.n_pack = trim(stat.insure.text5)       
            np_class = ""       np_brand = ""
            np_model = ""       np_class =  trim(stat.insure.text5)    
            np_brand =  Insure.text1    
            np_model =  insure.text2  .
        IF      wdetail.n_pack = "110" THEN ASSIGN wdetail.n_seattisco = 7 . 
        ELSE IF wdetail.n_pack = "320" THEN ASSIGN wdetail.n_seattisco = 3 . 
        ELSE IF wdetail.n_pack = "210" THEN ASSIGN wdetail.n_seattisco = 12 .
    END.
    ELSE DO: 
        ASSIGN  n_brand = IF INDEX(wdetail.brand," ") <> 0 THEN trim(SUBSTR(wdetail.brand,1,INDEX(wdetail.brand," ") - 1 )) 
                          ELSE trim(wdetail.brand).
        IF n_brand = "ISUZU" THEN
            ASSIGN wdetail.n_seattisco = IF wdetail.n_pack = "110" THEN 7 ELSE IF wdetail.n_pack = "210" THEN 5 ELSE 3.  
        ELSE DO: 
            IF      wdetail.n_pack = "110" THEN ASSIGN wdetail.n_seattisco = 7  .   
            ELSE IF wdetail.n_pack = "320" THEN ASSIGN wdetail.n_seattisco = 3  .   
            ELSE IF wdetail.n_pack = "210" THEN ASSIGN wdetail.n_seattisco = 12 .  
            ELSE ASSIGN wdetail.n_seattisco = 0 .   
        END.
    END.
    ASSIGN  wdetail.n_covcod    = ""
    wdetail.n_typpol    = "RENEW"              
    wdetail.nproducer   = fi_producertisco    
    wdetail.nagent      = fi_agenttisco     
    wdetail.n_branch    = "M"
    wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"*","")
    wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"-","")
    wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"/","")
    wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"\","")
    wdetail.prev_pol    = REPLACE(wdetail.prev_pol,".",""). 
    IF nv_premt3 = 0 THEN DO:            
        ASSIGN wdetail.n_covcod  = "T".  
    END.
    ELSE IF nv_premt3 = 7500.70 OR nv_premt3 = 8500.08 OR nv_premt3 = 9500.53  THEN DO:
        ASSIGN wdetail.n_covcod  = "2.2"
            wdetail.n_pack       = "C" +  trim(wdetail.n_pack).
    END.
    ELSE IF nv_premt3 = 6300 OR nv_premt3 = 7300 OR nv_premt3 = 7500 OR nv_premt3 = 8300  THEN DO:
        ASSIGN  wdetail.n_covcod = "3.2"
            wdetail.n_pack       = "C" +  trim(wdetail.n_pack).
    END.
    ELSE IF ( nv_premt3 <= 10000 ) AND (nv_premt3 > 2500 )  THEN DO: 
        ASSIGN wdetail.n_covcod  = "2"
            wdetail.n_pack       = "Y" +  trim(wdetail.n_pack).
    END.
    ELSE IF (nv_premt3 < 2500 )THEN DO:
        ASSIGN  wdetail.n_covcod = "3"
            wdetail.n_pack       = "R" +  trim(wdetail.n_pack).
        IF wdetail.n_pack = "R110" THEN ASSIGN wdetail.n_seattisco = 7. 
    END.
    ELSE IF  nv_premt3  >  10000   THEN DO: 
        ASSIGN  wdetail.n_covcod = "1".
        IF (wdetail.garage = "0")  THEN DO:
            IF  index(wdetail.brand,"Ford") <> 0 AND 
                index(wdetail.remark,"FORD ENSURE") <> 0 OR    
                INDEX(wdetail.remark,"FD")          <> 0 OR    
                SUBSTRING(wdetail.prev_pol,7,1)     = "F" THEN DO: 
                ASSIGN wdetail.n_pack = "O" +  trim(wdetail.n_pack).
                IF wdetail.n_pack = "O320" THEN ASSIGN wdetail.n_seattisco = 5.
            END.
            ELSE IF  index(wdetail.brand,"MAZDA")    <> 0   AND 
                     /*SUBSTRING(wdetail.prev_pol,7,2) = "MI" OR *//*A62-0386*/
                     index(wdetail.remark,"MPI")     <> 0   THEN DO:  
                     ASSIGN wdetail.n_pack = "M" +  trim(wdetail.n_pack).
                     IF wdetail.n_pack = "M110" THEN ASSIGN wdetail.n_seattisco = 7.
                     IF wdetail.n_pack = "M320" THEN ASSIGN wdetail.n_seattisco = 5.
            END.
            ELSE DO:
                FIND LAST WComp WHERE wcomp.cartyp   = "renew"    AND
                                      wcomp.brand    = "garage"   NO-LOCK  NO-ERROR NO-WAIT.
                IF AVAIL wcomp THEN  ASSIGN wdetail.n_pack = trim(wcomp.package) + trim(wdetail.n_pack).
            END.
        END.
        ELSE DO:    /*�������*/
            FIND LAST WComp WHERE wcomp.cartyp   = "renew" AND
                                  wcomp.brand    = ""      NO-LOCK  NO-ERROR NO-WAIT.
            IF AVAIL wcomp THEN  ASSIGN wdetail.n_pack = trim(wcomp.package) + trim(wdetail.n_pack) .
        END.
    END.

    IF  index(wdetail.brand,"FORD")  <> 0 THEN DO: /* Ford  */
        ASSIGN wdetail.nproducer = fi_producerford  /* "B3M0033"  */ 
               wdetail.nagent    = fi_agentford .   /* "B3M0035"  */ 
        IF ((YEAR(TODAY) - INT(wdetail.yrmanu) <= 7 )  AND 
           (nv_premt1 = 8300.00  OR nv_premt1 = 9500.00  OR 
            nv_premt1 = 10400.00 OR nv_premt1 = 12300.00 OR 
            nv_premt1 = 14100.00 )) THEN DO:
            ASSIGN 
               /* wdetail.n_covcod = "" wdetail.garage = "" wdetail.nproducer = ""  wdetail.remark = "" 
                wdetail.n_pack   = "" wdetail.bi     = "" wdetail.pa        = ""  wdetail.pd     = ""*/
                wdetail.n_covcod  = "2.2"
                wdetail.garage    = "0"
                wdetail.remark    = "FE2+"
                wdetail.bi        = "500000"
                wdetail.pa        = "10000000"
                wdetail.pd        = "2500000".
            IF      wdetail.n_seattisco = 7 THEN wdetail.n_pack = "U110".
            ELSE IF wdetail.n_seattisco = 3 THEN ASSIGN wdetail.n_pack = "U320" 
                                                        wdetail.n_seattisco = 5.
        END.
    END.
    ELSE IF index(wdetail.bran,"Nissan") <> 0 THEN DO:
        IF INDEX(wdetail.prev_insur,"SAFETY INSURANCE") <> 0 THEN DO:
            FIND LAST sicuw.uwm301 Use-index uwm30121 Where 
                sicuw.uwm301.cha_no      = trim(wdetail.chassis)  AND 
                substr(sicuw.uwm301.policy,3,2) = "70"  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm301 THEN DO:
                ASSIGN 
                    wdetail.nproducer =  fi_producernis  
                    wdetail.nagent    =  fi_agentnis .

                IF trim(wdetail.polold) = "" THEN wdetail.polold = sicuw.uwm301.policy .
                Find LAST sicuw.uwm100 Use-index uwm10001       Where
                    sicuw.uwm100.policy = sicuw.uwm301.policy   and
                    sicuw.uwm100.rencnt = sicuw.uwm301.rencnt   and 
                    sicuw.uwm100.poltyp = "V70"  No-lock no-error no-wait.
                If avail sicuw.uwm100 Then DO:
                    ASSIGN wdetail.n_branch  =  sicuw.uwm100.branch
                        wdetail.n_branch  =  IF sicuw.uwm100.acno1 = "B3W0020" OR sicuw.uwm100.acno1 = "B3W0016" THEN "W" ELSE "MF" .
                    IF sicuw.uwm100.branch <> "W" AND sicuw.uwm100.branch <> "MF" THEN DO:
                        IF INDEX(wdetail.ben_name,"�к� 8.3") <> 0 THEN 
                            ASSIGN                  
                            wdetail.nproducer =  fi_producer83     /* "B3MLTIS104"  */ /*A65-0361*/
                            wdetail.nagent    =  fi_agenttisco83.  /* "B3MLTIS100". */ /*A65-0361*/
                        ELSE ASSIGN                  
                            wdetail.nproducer =  fi_producertisco  /*"B3MLTIS101" */  /*A65-0361*/
                            wdetail.nagent    =  fi_agenttisco.     /*"B3MLTIS100".*/  /*A65-0361*/
                    END.
                END.
                
            END.
            ELSE ASSIGN wdetail.nproducer = fi_producernis2
                        wdetail.nagent    = fi_agentnis2 .
        END.
        ELSE ASSIGN wdetail.nproducer = fi_producernis2
                    wdetail.nagent    = fi_agentnis2 .
    END.
    ELSE IF  index(wdetail.brand,"HAVAL") <> 0 THEN DO:
        ASSIGN 
            wdetail.nproducer = fi_producerhaval   /*A65-0361*/
            wdetail.nagent    = fi_agenthaval   .  /*A65-0361*/
    END.
    ELSE IF index(wdetail.agent,"HI-WAY") <> 0  THEN DO:
        IF   index(wdetail.brand,"WHEELS") <> 0 THEN ASSIGN wdetail.nproducer = fi_producerHi2  wdetail.nagent = fi_agenthi2 .
                                                ELSE ASSIGN wdetail.nproducer = fi_producerHi1  wdetail.nagent = fi_agenthi1 .
    END.
    ELSE IF INDEX(wdetail.prev_insur,"SAFETY INSURANCE") <> 0 THEN DO:  /* ������� STY */


        IF INDEX(wdetail.ben_name,"�к� 8.3") <> 0 AND INDEX(wdetail.ben_name,"����к� 8.3") = 0  THEN DO:   /*case : add 8.3 */

            IF  index(wdetail.brand,"MAZDA")     <> 0   AND       /*Mazda MPI */
                index(wdetail.remark,"MPI")      <> 0   THEN DO:  /*A61-0313*/
                ASSIGN  wdetail.n_branch  = ""
                    wdetail.nproducer  = fi_producermpi
                    wdetail.nagent     = fi_agenttiscompi.
            END.
            ELSE IF INDEX(wdetail.not_office,"CIR(RETAIL)") <> 0 OR INDEX(wdetail.not_office,"CIR(FLEET)") <> 0 OR 
                    INDEX(wdetail.remark,"L/CI/CODE")       <> 0 OR INDEX(wdetail.remark,"C CI") <> 0           OR 
                    INDEX(wdetail.remark,"L/CI")            <> 0 OR INDEX(wdetail.remark,"J CI") <> 0           OR 
                    INDEX(wdetail.remark,"P CI")            <> 0 OR INDEX(wdetail.remark,"L/CI") <> 0  /* A65-0035*/
                    THEN DO:
                ASSIGN wdetail.nproducer = fi_producercir   
                    wdetail.nagent    = fi_agenttiscocir .
            END.
            ELSE
                ASSIGN wdetail.nproducer  = fi_producer83      
                       wdetail.nagent     = fi_agenttisco83.
        END.  /* end add 8.3 */
        ELSE DO:                                                  /*case : NO 8.3 */
            IF  index(wdetail.remark,"MPI")     <> 0   THEN DO:   
                ASSIGN  wdetail.n_branch  = ""
                    wdetail.nproducer  = fi_producertisco    /* "B3MLTIS101" */ /*A63-00472*/  
                    wdetail.nagent     = fi_agenttisco.      /* "B3MLTIS100" */ /*A63-00472*/  
            END.
            ELSE IF INDEX(wdetail.not_office,"CIR(RETAIL)") <> 0 OR INDEX(wdetail.not_office,"CIR(FLEET)") <> 0 OR
                INDEX(wdetail.remark,"L/CI/CODE")           <> 0 OR INDEX(wdetail.remark,"C CI")           <> 0 OR 
                INDEX(wdetail.remark,"L/CI")                <> 0 OR INDEX(wdetail.remark,"J CI") <> 0           OR 
                INDEX(wdetail.remark,"P CI")                <> 0 OR INDEX(wdetail.remark,"L/CI") <> 0  /* A65-0035*/
                THEN DO:
                ASSIGN wdetail.nproducer = fi_producercir   
                       wdetail.nagent    = fi_agenttiscocir .
            END.
            ELSE ASSIGN wdetail.nproducer = fi_producertisco   
                        wdetail.nagent    = fi_agenttisco. 

        END.  /* end No 8.3 */
    END.
    ELSE DO:  /* �ҹ�͹����  */
        IF  index(wdetail.remark,"MPI")     <> 0   THEN DO:   
            ASSIGN  wdetail.n_branch  = ""
                wdetail.nproducer  = fi_producertisco   
                wdetail.nagent     = fi_agenttisco.  
        END.
        ELSE IF INDEX(wdetail.not_office,"CIR(RETAIL)") <> 0 OR INDEX(wdetail.not_office,"CIR(FLEET)") <> 0 OR
                INDEX(wdetail.remark,"L/CI/CODE")       <> 0 OR INDEX(wdetail.remark,"C CI")           <> 0 OR 
                INDEX(wdetail.remark,"L/CI")            <> 0 OR INDEX(wdetail.remark,"J CI") <> 0           OR 
                INDEX(wdetail.remark,"P CI")            <> 0 OR INDEX(wdetail.remark,"L/CI") <> 0  /* A65-0035*/ 
            THEN DO:
            ASSIGN wdetail.n_branch  = ""
                wdetail.nproducer = fi_producercir   
                wdetail.nagent    = fi_agenttiscocir .
        END.
        ELSE IF (wdetail.n_covcod = "1") AND INDEX(wdetail.ben_name,"�к� 8.3") <> 0 AND INDEX(wdetail.ben_name,"����к� 8.3") = 0 THEN DO:
            ASSIGN wdetail.nproducer = fi_producer83      
                    wdetail.nagent   = fi_agenttisco83.
        END.

        IF (wdetail.n_covcod <> "1") AND (INDEX(wdetail.prev_insur,"SAFETY INSURANCE") = 0 ) THEN DO: /* ����� �.1 �ҹ�͹���� */
            IF INDEX(wdetail.not_office,"CIR(RETAIL)") <> 0 OR INDEX(wdetail.not_office,"CIR(FLEET)") <> 0 OR
                INDEX(wdetail.remark,"L/CI/CODE")      <> 0 OR INDEX(wdetail.remark,"C CI")           <> 0 OR 
                INDEX(wdetail.remark,"L/CI")           <> 0 OR INDEX(wdetail.remark,"J CI") <> 0           OR 
                INDEX(wdetail.remark,"P CI")           <> 0 OR INDEX(wdetail.remark,"L/CI") <> 0  /* A65-0035*/
                THEN DO:
                ASSIGN wdetail.n_branch  = "ML"
                    wdetail.nproducer = fi_producercir     /* fi_producercir   = "B3MLTIS102" */
                    wdetail.nagent    = fi_agenttiscocir . /* fi_agenttiscocir = "B3MLTIS100" */
            END.
            ELSE ASSIGN  wdetail.n_branch  = "ML"
               wdetail.nproducer = fi_pdbkcode   /* B3MLTIS103" */  /*A63-00472*/  
               wdetail.nagent    = fi_agbkcode . /* B3MLTIS100".*/  /*A63-00472*/  
            FIND LAST wcomp WHERE wcomp.cover = wdetail.n_covcod NO-LOCK NO-ERROR.
            IF AVAIL wcomp THEN DO:
                ASSIGN wdetail.bi       = TRIM(wcomp.bi)
                    wdetail.pa       = TRIM(wcomp.pa)
                    wdetail.pd       = TRIM(wcomp.pd).
            END.
            ELSE DO:
                FIND LAST WComp WHERE  wcomp.cover = "2-3" NO-LOCK  NO-ERROR NO-WAIT.
                IF AVAIL wcomp THEN 
                    ASSIGN wdetail.bi       = TRIM(wcomp.bi)
                    wdetail.pa       = TRIM(wcomp.pa)
                    wdetail.pd       = TRIM(wcomp.pd).
            END.
            IF index(wdetail.bran,"Nissan") = 0 AND  index(wdetail.bran,"Ford") = 0 THEN  /*A65-0361*/
                ASSIGN 
                       wdetail.nproducer =  "B3MLTIS103"   /*A65-0361*/
                       wdetail.nagent    =  "B3MLTIS100".  /*A65-0361*/
        END.
    END.
     
    
   


 
    IF wdetail.prev_pol <> "" THEN DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy = trim(wdetail.prev_pol) NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN ASSIGN wdetail.n_branch  =  sicuw.uwm100.branch.
    END.
     
    IF INDEX(wdetail.n_pack,"O") <> 0  THEN DO:
        FIND LAST WComp WHERE trim(wcomp.package) = "O" NO-LOCK  NO-ERROR NO-WAIT.
            IF AVAIL wcomp THEN DO:
              ASSIGN wdetail.bi   = TRIM(wcomp.bi)
                     wdetail.pa   = TRIM(wcomp.pa)
                     wdetail.pd   = TRIM(wcomp.pd).
            END.
    END. 


END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE BK-import_insur C-Win 
PROCEDURE BK-import_insur :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*comment by : A64-0271...
INPUT FROM VALUE (fi_filename) .  /*create in TEMP-TABLE wImport*/
REPEAT:    
    IMPORT UNFORMATTED nv_daily.
    If  nv_daily  <>  ""  And  substr(nv_daily,1,2)  =  "01"  Then 
        ASSIGN nv_export   = DATE(INT(SUBSTR(nv_daily,84,2)),
                                  INT(SUBSTR(nv_daily,86,2)),
                                  INT(SUBSTR(nv_daily,80,4))).
    IF  nv_daily  <>  ""  And  Substr(nv_daily,1,2)  =  "02"  THEN DO:
        nv_reccnt   =  nv_reccnt  +  1.
        CREATE  wdetail.
        ASSIGN wdetail.recordID     = TRIM(SUBSTR(nv_daily,1,2))          
/*1 */         wdetail.Pro_off      = TRIM(SUBSTR(nv_daily,3,2))  
/*2 */         wdetail.cmr_code     = TRIM(SUBSTR(nv_daily,5,3))
/*3 */         wdetail.comp_code    = TRIM(SUBSTR(nv_daily,8,3))
/*4 */         wdetail.Notify_no    = TRIM(SUBSTR(nv_daily,11,25))
/*5 */         wdetail.yrmanu       = TRIM(SUBSTR(nv_daily,36,4))
/*6 */         wdetail.engine       = TRIM(SUBSTR(nv_daily,40,25))
/*7 */         wdetail.chassis      = TRIM(SUBSTR(nv_daily,65,25))
/*8 */         wdetail.weight       = TRIM(SUBSTR(nv_daily,90,5))
/*9 */         wdetail.power        = TRIM(String(SUBSTR(nv_daily,95,7),"9999999"))
/*10 */        wdetail.colorcode    = TRIM(SUBSTR(nv_daily,102,10))
/*11 */        wdetail.licence      = TRIM(SUBSTR(nv_daily,112,10))
/*12 */        wdetail.garage       = TRIM(SUBSTR(nv_daily,122,1))
/*13 */        wdetail.fleetper     = TRIM(SUBSTR(nv_daily,123,5))
/*14 */        wdetail.ncbper       = TRIM(SUBSTR(nv_daily,128,5))
/*15 */        wdetail.othper       = TRIM(SUBSTR(nv_daily,123,5))
/*16 */        wdetail.vehuse       = TRIM(SUBSTR(nv_daily,138,1))
/*17 */        wdetail.comdat       = TRIM(SUBSTR(nv_daily,139,8))
/*18 */        wdetail.ins_amt      = TRIM(SUBSTR(nv_daily,147,11))
/*19 */        wdetail.name_insur   = TRIM(SUBSTR(nv_daily,158,15))
/*20 */        wdetail.not_office   = TRIM(SUBSTR(nv_daily,173,75))
/*21 */        wdetail.not_date     = TRIM(SUBSTR(nv_daily,248,8))
/*22 */        wdetail.not_time     = TRIM(SUBSTR(nv_daily,256,6))
/*23 */        wdetail.not_code     = TRIM(SUBSTR(nv_daily,262,4))
/*24 */        wdetail.prem1        = TRIM(SUBSTR(nv_daily,266,11))
/*25 */        wdetail.comp_prm     = TRIM(SUBSTR(nv_daily,277,9))
/*26 */        wdetail.sckno        = TRIM(SUBSTR(nv_daily,286,25))
/*27 */        wdetail.brand        = TRIM(SUBSTR(nv_daily,311,50))
/*28 */        wdetail.pol_addr1    = TRIM(SUBSTR(nv_daily,361,50))
/*29 */        wdetail.pol_addr2    = TRIM(SUBSTR(nv_daily,411,60))
/*30 */        wdetail.pol_title    = TRIM(SUBSTR(nv_daily,471,30))
/*31 */        wdetail.pol_fname    = TRIM(SUBSTR(nv_daily,501,75))
/*32 */        wdetail.pol_lname    = TRIM(SUBSTR(nv_daily,576,45))
/*33 */        wdetail.ben_name     = TRIM(SUBSTR(nv_daily,621,65))
/*34 */        wdetail.remark       = TRIM(SUBSTR(nv_daily,686,150)).
         ASSIGN 
/*35 */        wdetail.Account_no   = TRIM(SUBSTR(nv_daily,836,10))
/*36 */        wdetail.client_no    = TRIM(SUBSTR(nv_daily,846,7))
/*37 */        wdetail.expdat       = TRIM(SUBSTR(nv_daily,853,8))
/*38 */        wdetail.gross_prm    = TRIM(SUBSTR(nv_daily,861,11))
/*39 */        wdetail.province     = TRIM(SUBSTR(nv_daily,872,18))
/*40 */        wdetail.receipt_name = TRIM(SUBSTR(nv_daily,890,50))
/*41 */        wdetail.agent        = TRIM(SUBSTR(nv_daily,940,15))
/*42 */        wdetail.prev_insur   = TRIM(SUBSTR(nv_daily,955,50))
/*43 */        wdetail.prev_pol     = TRIM(SUBSTR(nv_daily,1005,25))
/*44 */        wdetail.deduct       = TRIM(SUBSTR(nv_daily,1030,9))    
/*45 */        wdetail.addr1_70     = TRIM(SUBSTR(nv_daily,1039,50))  
/*46 */        wdetail.addr2_70     = TRIM(SUBSTR(nv_daily,1089,60))  
/*47 */        wdetail.nsub_dist70  = TRIM(SUBSTR(nv_daily,1149,30))  
/*48 */        wdetail.ndirection70 = TRIM(SUBSTR(nv_daily,1179,30))  
/*49 */        wdetail.nprovin70    = TRIM(SUBSTR(nv_daily,1209,30))  
/*50 */        wdetail.zipcode70    = TRIM(SUBSTR(nv_daily,1239,5))   
/*51 */        wdetail.addr1_72     = TRIM(SUBSTR(nv_daily,1244,50))  
/*52 */        wdetail.addr2_72     = TRIM(SUBSTR(nv_daily,1294,60))  
/*53 */        wdetail.nsub_dist72  = TRIM(SUBSTR(nv_daily,1354,30))  
/*54 */        wdetail.ndirection72 = TRIM(SUBSTR(nv_daily,1384,30))  
/*55 */        wdetail.nprovin72    = TRIM(SUBSTR(nv_daily,1414,30))  
/*56 */        wdetail.zipcode72    = TRIM(SUBSTR(nv_daily,1444,5))   
/*57 */        wdetail.apptyp       = TRIM(SUBSTR(nv_daily,1449,10))  
/*58 */        wdetail.appcode      = TRIM(SUBSTR(nv_daily,1459,2)) 
/*59 */        wdetail.id_recive70  = TRIM(SUBSTR(nv_daily,1461,13))        /*��Ţ���ѵû�Шӵ�ǻ�ЪҪ�/�Ţ��˹ѧ����Թ�ҧ /�Ţ����¹�ҳԪ��*/
/*60 */        wdetail.br_recive70  = TRIM(SUBSTR(nv_daily,1474,20))        /*�ҢҢͧʶҹ��Сͺ����١���*/
/*61 */        wdetail.id_recive72  = TRIM(SUBSTR(nv_daily,1494,13))        /*��Ţ���ѵû�Шӵ�ǻ�ЪҪ�/�Ţ��˹ѧ����Թ�ҧ /�Ţ����¹�ҳԪ��*/
/*62 */        wdetail.br_recive72  = TRIM(SUBSTR(nv_daily,1507,20))        /*�ҢҢͧʶҹ��Сͺ����١���*/
/*63 */        wdetail.comp_comdat  = TRIM(SUBSTR(nv_daily,1527,8))         /*Effective Date Accidential*/ /* start : A59-0178*/ 
/*64 */        wdetail.comp_expdat  = TRIM(SUBSTR(nv_daily,1535,8))         /*Expiry Date Accidential*/     
/*65 */        wdetail.fi           = TRIM(SUBSTR(nv_daily,1543,11))        /*Coverage Amount Theft*/       
/*66 */        wdetail.class        = TRIM(SUBSTR(nv_daily,1554,3))         /*Car code*/                    
/*67 */        wdetail.usedtype     = TRIM(SUBSTR(nv_daily,1557,1))         /*Per Used*/                    
/*68 */        wdetail.driveno1     = TRIM(SUBSTR(nv_daily,1558,2))         /*Driver Seq1*/                 
/*69 */        wdetail.drivename1   = TRIM(SUBSTR(nv_daily,1560,40))        /*Driver Name1*/                
/*70 */        wdetail.bdatedriv1   = TRIM(SUBSTR(nv_daily,1600,8))         /*Birthdate Driver1*/           
/*71 */        wdetail.occupdriv1   = TRIM(SUBSTR(nv_daily,1608,75))        /*Occupation Driver1*/          
/*72 */        wdetail.positdriv1   = TRIM(SUBSTR(nv_daily,1683,40))        /*Position Driver1 */           
/*73 */        wdetail.driveno2     = TRIM(SUBSTR(nv_daily,1723,2))         /*Driver Seq2*/                 
/*74 */        wdetail.drivename2   = TRIM(SUBSTR(nv_daily,1725,40))        /*Driver Name2*/                
/*75 */        wdetail.bdatedriv2   = TRIM(SUBSTR(nv_daily,1765,8))         /*Birthdate Driver2*/           
/*76 */        wdetail.occupdriv2   = TRIM(SUBSTR(nv_daily,1773,75))        /*Occupation Driver2*/          
/*77 */        wdetail.positdriv2   = TRIM(SUBSTR(nv_daily,1848,40))        /*Position Driver2*/            
/*78 */        wdetail.driveno3     = TRIM(SUBSTR(nv_daily,1888,2))         /*Driver Seq3*/                 
/*79 */        wdetail.drivename3   = TRIM(SUBSTR(nv_daily,1890,40))        /*Driver Name3*/                
/*80 */        wdetail.bdatedriv3   = TRIM(SUBSTR(nv_daily,1930,8))         /*Birthdate Driver3*/           
/*81 */        wdetail.occupdriv3   = TRIM(SUBSTR(nv_daily,1938,75))        /*Occupation Driver3*/          
/*82 */        wdetail.positdriv3   = TRIM(SUBSTR(nv_daily,2013,40))        /*Position Driver3*/            
/*83 */        wdetail.caracc       = TRIM(SUBSTR(nv_daily,2053,250))       /*Car Accessories*/                 /* start : A63-0210*/ 
/*84 */        wdetail.Rec_name72   = TRIM(SUBSTR(nv_daily,2303,150))       /*Accidential Receipt name*/        
/*85 */        wdetail.Rec_add1     = TRIM(SUBSTR(nv_daily,2453,60))        /*Accidential Receipt Address 1*/   
/*86 */        wdetail.Rec_add2     = TRIM(SUBSTR(nv_daily,2513,60))        /*Accidential Receipt Address 2*/   /* end : A63-0210*/ 
/*87 */        wdetail.nBLANK       = TRIM(SUBSTR(nv_daily,2573,28)) .      /* Blank */ /* end : A59-0178*/ 
    END.
END.    /* repeat  */ 
FOR EACH wdetail.
    RUN proc_cutengno.     /*A56-0323*/
    RUN proc_cutchassis.   /*A56-0323*/
    RUN proc_licence.      /*A60-0095*/
    RUN proc_addclass.     /*A60-0095*/
    IF ra_poltyp = 1  THEN RUN proc_renew. /*A60-0095*/
    ELSE RUN proc_new. /*A60-0095*/
   /* comment by : Ranu I. A60-0095 ----
    IF ra_poltyp = 1  THEN DO:      /* ������� */
        FIND FIRST stat.insure USE-INDEX insure01 WHERE 
            stat.insure.compno = fi_model          AND
            stat.insure.fname  = wdetail.brand     NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.insure THEN DO: 
            ASSIGN 
                wdetail.n_pack = trim(stat.insure.text5)      /*A57-0088*/ 
                np_class = ""       np_brand = ""
                np_model = ""       np_class =  trim(stat.insure.text5)     /*A57-0088*/   
                np_brand =  Insure.text1    
                np_model =  insure.text2  .
            IF      wdetail.n_pack = "110" THEN ASSIGN wdetail.n_seattisco = 7 .   /*A57-0017*/
            ELSE IF wdetail.n_pack = "320" THEN ASSIGN wdetail.n_seattisco = 3 .   /*A57-0017*/
            ELSE IF wdetail.n_pack = "320" THEN ASSIGN wdetail.n_seattisco = 3 .   /*A57-0017*/
            ELSE IF wdetail.n_pack = "320" THEN ASSIGN wdetail.n_seattisco = 3 .   /*A57-0017*/
            ELSE IF wdetail.n_pack = "320" THEN ASSIGN wdetail.n_seattisco = 3 .   /*A57-0017*/
            ELSE IF wdetail.n_pack = "210" THEN ASSIGN wdetail.n_seattisco = 12 .  /*A57-0017*/
            ELSE IF wdetail.n_pack = "210" THEN ASSIGN wdetail.n_seattisco = 12 .  /*A57-0017*/
            ELSE IF wdetail.n_pack = "210" THEN ASSIGN wdetail.n_seattisco = 12 .  /*A57-0017*/
            ELSE IF wdetail.n_pack = "210" THEN ASSIGN wdetail.n_seattisco = 12 .  /*A57-0017*/
        END.
        ELSE ASSIGN wdetail.n_seattisco = 0 .   /*A57-0017*/
        ASSIGN  wdetail.n_covcod    = ""
            wdetail.n_typpol    = "RENEW"              
            wdetail.nproducer   = fi_producertisco     
            wdetail.nagent      = fi_agenttisco  
            wdetail.n_branch    = "M"
            wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"*","")
            wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"-","")
            wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"/","")
            wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"\","")
            wdetail.prev_pol    = REPLACE(wdetail.prev_pol,".","").  

        IF INDEX(wdetail.ben_name,"�к� 8.3") <> 0  THEN    /*case : add 8.3 */
            ASSIGN wdetail.nproducer  = fi_producer83      
                   wdetail.nagent     = fi_agenttisco83.
        IF  index(wdetail.brand,"FORD") <> 0 THEN          /*case : Ford  */
            ASSIGN wdetail.n_branch  = ""
            wdetail.nproducer        = fi_producerford
            wdetail.nagent           = fi_agentford    .
       /*--A59-0618 --*/
        IF  index(wdetail.brand,"MAZDA") <> 0 THEN          /*case : Mazda */
            ASSIGN wdetail.n_branch  = ""
            wdetail.nproducer        = fi_producerma
            wdetail.nagent           = fi_agenttiscoma    .
        /*--A59-0618 --*/
        IF ( nv_premt3 <= 10000 ) AND (nv_premt3 > 2500 )  THEN DO: 
            ASSIGN wdetail.n_covcod  = "2"
                wdetail.n_pack       = "Y" +  wdetail.n_pack
                wdetail.n_branch     = "M".
        END.
        ELSE IF (nv_premt3 <= 2500 ) THEN DO:
            ASSIGN  wdetail.n_covcod = "3"
                wdetail.n_pack       = "R" +  wdetail.n_pack
                wdetail.n_branch     = "M".
        END.
        ELSE IF  nv_premt3  >  10000   THEN DO: 
            ASSIGN  wdetail.n_covcod = "1".
            IF (wdetail.garage = "0")  THEN DO:
                IF  index(wdetail.brand,"Ford") <> 0 THEN
                    ASSIGN wdetail.n_pack = "O" +  wdetail.n_pack.
                ELSE DO:
                    FIND LAST WComp WHERE wcomp.cartyp   = "renew"    AND
                                          wcomp.brand    = "garage"   NO-LOCK  NO-ERROR NO-WAIT.
                    IF AVAIL wcomp THEN  ASSIGN wdetail.n_pack = wcomp.package + wdetail.n_pack .
                END.
            END.
            ELSE DO:    /*�������*/
                FIND LAST WComp WHERE wcomp.cartyp   = "renew" AND
                                      wcomp.brand    = ""      NO-LOCK  NO-ERROR NO-WAIT.
                IF AVAIL wcomp THEN  ASSIGN wdetail.n_pack = wcomp.package + wdetail.n_pack .
            END.
        END.
        IF wdetail.prev_pol <> "" THEN DO:
            FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy = trim(wdetail.prev_pol) NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm100 THEN ASSIGN wdetail.n_branch  =  sicuw.uwm100.branch.
        END.
    END.
    ELSE DO:    /* ����ᴧ *//* wdetail.brand */
        ASSIGN  wdetail.n_covcod      = "" 
            wdetail.price_ford    = IF INDEX(wdetail.remark,"P.") <> 0 THEN trim(SUBSTR(wdetail.remark,INDEX(wdetail.remark,"P.") + 2 )) ELSE ""
            wdetail.price_ford    = IF wdetail.price_ford = "" THEN "" 
                                    ELSE IF INDEX(wdetail.price_ford," ") <> 0 THEN trim(SUBSTR(wdetail.price_ford,1,INDEX(wdetail.price_ford," ")))
                                    ELSE trim(wdetail.price_ford)
            wdetail.comdat        = IF wdetail.comdat = "00000000" THEN wdetail.comp_comdat ELSE wdetail.comdat
            wdetail.expdat        = IF wdetail.expdat = "00000000" THEN wdetail.comp_expdat ELSE wdetail.expdat.
        RUN proc_redbook.    /* A57-0088 */
        IF  nv_premt3 >  10000   THEN  ASSIGN  wdetail.n_covcod = "1".
        ELSE IF ( nv_premt3 <= 10000 ) AND ( nv_premt3 > 2500 )  THEN  ASSIGN wdetail.n_covcod = "2".
        ELSE ASSIGN  wdetail.n_covcod = "3" .
        ASSIGN 
            n_brand = IF INDEX(wdetail.brand," ") <> 0 THEN trim(SUBSTR(wdetail.brand,1,INDEX(wdetail.brand," ") - 1 )) ELSE trim(wdetail.brand).
        FIND LAST WComp WHERE  wcomp.cartyp  = "new" AND wcomp.brand  = trim(n_brand) NO-LOCK  NO-ERROR NO-WAIT.
        IF NOT AVAIL wcomp THEN DO:
            FIND LAST WComp WHERE  wcomp.cartyp   = "new" AND
                wcomp.brand    = "oth" NO-LOCK  NO-ERROR NO-WAIT.
            IF AVAIL wcomp THEN 
                ASSIGN wdetail.n_pack   = wcomp.package + wdetail.n_pack    wdetail.n_branch = trim(wcomp.branch) .
        END.
        ELSE ASSIGN wdetail.n_pack   = wcomp.package + wdetail.n_pack       wdetail.n_branch = trim(wcomp.branch).
        ASSIGN wdetail.n_typpol  = "NEW".
        /*IF  index(wdetail.Notify_no,"Tis") <> 0 THEN DO:    A59-0618 */
            ASSIGN  np_dealer = ""
                np_dealer = IF index(wdetail.Notify_no,",") <> 0 THEN trim(SUBSTR(wdetail.Notify_no,index(wdetail.Notify_no,",") + 1 )) ELSE ""  /*A56-0399*/
                wdetail.n_branch  = "".
            IF  index(wdetail.brand,"FORD RANGER") <> 0 THEN DO:
                ASSIGN wdetail.n_branch  = ""
                       wdetail.nproducer  = fi_producerford   
                       wdetail.nagent  = fi_agentford .
            END.
            /*-- start : A59-0618 --*/
            ELSE IF index(wdetail.brand,"FORD") <> 0 THEN DO:
                ASSIGN wdetail.n_branch  = "" 
                       wdetail.nproducer  = fi_producerford2   
                       wdetail.nagent  = fi_agentford2 . 
            END.
            ELSE IF  index(wdetail.brand,"MAZDA") <> 0 THEN DO:   /*case : Mazda */
                ASSIGN wdetail.n_branch  = ""
                wdetail.nproducer        = fi_producerma
                wdetail.nagent           = fi_agenttiscoma    .
            END.
            ELSE IF  index(wdetail.brand,"ISUZU SPARK 1.9") <> 0 THEN DO:   /*case : ISUZU */
                ASSIGN wdetail.n_branch  = ""
                wdetail.nproducer        = fi_producertisco  
                wdetail.nagent           = fi_agenttisco .   
            END.
            ELSE IF  index(wdetail.brand,"ISUZU") <> 0 THEN DO:   /*case : ISUZU */
                ASSIGN wdetail.n_branch  = ""
                wdetail.nproducer        = fi_produceris
                wdetail.nagent           = fi_agenttiscois    .
            END.
             /*-- end A59-0618 --*/
            ELSE ASSIGN wdetail.nproducer = fi_producertisco              
                wdetail.nagent            = fi_agenttisco .
            IF  np_dealer <> "" THEN DO:
                FIND FIRST stat.insure USE-INDEX insure01 WHERE 
                    stat.insure.compno = "TISCO" AND
                    stat.insure.lname  = np_dealer NO-LOCK NO-WAIT NO-ERROR.
                IF AVAIL stat.insure THEN 
                    ASSIGN  wdetail.n_branch  = trim(stat.insure.branch).
                ELSE ASSIGN  wdetail.n_branch  = "".
            END.
            ELSE DO:  /* start : A59-0618 */
                ASSIGN  wdetail.n_branch  = "".
                IF wdetail.Notify_no = "" THEN wdetail.n_branch = "".
                ELSE DO:
                    IF (index("123456789",SUBSTR(wdetail.Notify_no,1,1)) <> 0 ) AND 
                    (index("123456789",SUBSTR(wdetail.Notify_no,2,1)) <> 0 ) THEN  
                        ASSIGN wdetail.n_branch = substr(wdetail.Notify_no,1,2) .
                    ELSE DO: 
                        IF SUBSTR(wdetail.notify,1,1) <> "D" THEN
                            ASSIGN wdetail.n_branch = "" .
                        ELSE ASSIGN wdetail.n_branch = substr(wdetail.Notify_no,2,1) .
                    END.
                END.
            END. /* end A59-0618 */
    END.   /*end... ����ᴧ   */ 
    end A60-0095 ------ */
END.    
IF ra_poltyp = 2 THEN  Run  Pro_createfile.
ELSE Run  Pro_createfile_re.   /*A57-0088*/
..end A64-0271..*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Create_driver C-Win 
PROCEDURE Create_driver :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_addr     as  char  extent 4  format "X(35)".
DEF VAR nv_pol      as  char  init  "".
DEF VAR nv_row      as  int   init   0.
DEF VAR nv_cnt      as  int   init   0.
DEF VAR nv_birthdat as  date  format  "99/99/9999".
DEF VAR nv_dd       AS  INT   FORMAT "99".
DEF VAR nv_mm       AS  INT   FORMAT "99".
DEF VAR nv_yy       AS  INT   FORMAT "9999".

If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  Then
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .
ASSIGN nv_cnt   =  0
    nv_birthdat =  ?
    nv_row      =  1.
OUTPUT STREAM ns2 TO VALUE(fi_outfile).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "����ѷ�Թ�ع ����� �ӡѴ (��Ҫ�) ."  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'  nv_export  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "Processing Office " '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "Chassis No."        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' "Driver No. "        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' "Driver Name"        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' "Birth Date "        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' "Occupation "        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' "Position  "         '"' SKIP.
FOR EACH wdriver  No-lock.
    ASSIGN nv_cnt =  nv_cnt  + 1 
        nv_row    =  nv_row  + 1.
    IF wdriver.birthdate <> "" AND  wdriver.birthdate  <> "00000000" THEN 
        ASSIGN nv_yy    = INT(SUBSTR(wdriver.birthdate,1,4))
            nv_mm       = INT(SUBSTR(wdriver.birthdate,5,2))
            nv_dd       = INT(SUBSTR(wdriver.birthdate,7,2))
            nv_birthdat = DATE(nv_mm,nv_dd,nv_yy).
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' wdriver.pro_off  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' wdriver.chassis  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' wdriver.dri_no   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' wdriver.dri_name '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' nv_birthdat      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' wdriver.occupn   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' wdriver.position '"' SKIP.
END.  /* wdriver  */
nv_row  =  nv_row  + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' " Total "   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' String(nv_cnt,"99999")  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' " ��¡��  "    '"' SKIP.

PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
  THEN DELETE WIDGET C-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  DISPLAY fi_agbkcode ra_txttyp ra_poltyp fi_producerford fi_agentford 
          fi_producertisco fi_agenttisco fi_model fi_filename fi_year fi_outfile 
          fi_producer83 fi_agenttisco83 fi_produceris fi_agenttiscois 
          fi_producerford2 fi_agentford2 fi_producermpi fi_agenttiscompi 
          fi_producerCIR fi_agenttiscoCIR fi_pdbkcode fi_agtkcode fi_pdtkcode 
          fi_pdtkdesc fi_pdbkdesc fi_agtkdesc fi_agbkdesc fi_producernis 
          fi_agentnis fi_producernis2 fi_agentnis2 fi_producerford2y 
          fi_agentford2y fi_producerhaval fi_agenthaval fi_producerHi1 
          fi_agenthi1 fi_producerHi2 fi_agenthi2 fi_producerbig fi_agentbig 
          fi_proHyundai fi_agentHyundai fi_proreHyundai fi_agentreHyundai 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE br_comp fi_agbkcode ra_txttyp ra_poltyp fi_producerford fi_agentford 
         fi_producertisco fi_agenttisco fi_model fi_filename fi_year fi_outfile 
         bu_ok bu_file bu_exit fi_producer83 fi_agenttisco83 fi_produceris 
         fi_agenttiscois fi_producerford2 fi_agentford2 fi_producermpi 
         fi_agenttiscompi fi_producerCIR fi_agenttiscoCIR fi_pdbkcode 
         fi_agtkcode fi_pdtkcode fi_pdtkdesc fi_pdbkdesc fi_agtkdesc 
         fi_agbkdesc fi_producernis fi_agentnis fi_producernis2 fi_agentnis2 
         fi_producerford2y fi_agentford2y fi_producerhaval fi_agenthaval 
         fi_producerHi1 fi_agenthi1 fi_producerHi2 fi_agenthi2 fi_producerbig 
         fi_agentbig fi_proHyundai fi_agentHyundai fi_proreHyundai 
         fi_agentreHyundai RECT-76 RECT-457 RECT-459 RECT-460 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Import_driver C-Win 
PROCEDURE Import_driver :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
INPUT FROM VALUE (fi_filename) .   /*create in TEMP-TABLE wImport*/
REPEAT:    
    IMPORT UNFORMATTED nv_daily.
    If  nv_daily  <>  ""  And  substr(nv_daily,1,2)  =  "01"  Then  
        ASSIGN 
        nv_export   = DATE(INT(SUBSTR(nv_daily,84,2)),
                           INT(SUBSTR(nv_daily,86,2)),
                           INT(SUBSTR(nv_daily,80,4))).
    IF  nv_daily  <>  ""  And  Substr(nv_daily,1,2)  =  "02"  THEN DO:
        Create  wdriver.
        ASSIGN
            wdriver.recordID   = TRIM(SUBSTR(nv_daily,1,2))         
            wdriver.Pro_off    = TRIM(SUBSTR(nv_daily,3,2))  
            wdriver.chassis    = TRIM(SUBSTR(nv_daily,5,25))
            wdriver.dri_no     = TRIM(SUBSTR(nv_daily,30,2))
            wdriver.dri_name   = TRIM(SUBSTR(nv_daily,32,40))
            wdriver.birthdate  = TRIM(SUBSTR(nv_daily,72,8))                  
            wdriver.occupn     = TRIM(SUBSTR(nv_daily,80,75))                  
            wdriver.position   = TRIM(SUBSTR(nv_daily,155,40)).     
    END.
END.   /* repeat  */
Run  Create_driver.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE import_insur C-Win 
PROCEDURE import_insur :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
INPUT FROM VALUE (fi_filename) .  /*create in TEMP-TABLE wImport*/
REPEAT:    
    IMPORT UNFORMATTED nv_daily.
    If  nv_daily  <>  ""  And  substr(nv_daily,1,2)  =  "01"  Then 
        ASSIGN nv_export   = DATE(INT(SUBSTR(nv_daily,84,2)),
                                  INT(SUBSTR(nv_daily,86,2)),
                                  INT(SUBSTR(nv_daily,80,4))).
    IF  nv_daily  <>  ""  And  Substr(nv_daily,1,2)  =  "02"  THEN DO:
        nv_reccnt   =  nv_reccnt  +  1.
        CREATE  wdetail.
        ASSIGN 
        wdetail.recordID     = TRIM(SUBSTR(nv_daily,1,2))         
/*1 */  wdetail.Pro_off      = TRIM(SUBSTR(nv_daily,3,2))   
/*2 */  wdetail.cmr_code     = TRIM(SUBSTR(nv_daily,5,3))   
/*3 */  wdetail.comp_code    = TRIM(SUBSTR(nv_daily,8,3))   
/*4 */  wdetail.Notify_no    = TRIM(SUBSTR(nv_daily,11,25))  
/*5 */  wdetail.yrmanu       = TRIM(SUBSTR(nv_daily,36,4))   
/*6 */  wdetail.engine       = TRIM(SUBSTR(nv_daily,40,35))   /*A65-0356  ���� 25- 35 */
/*7 */  wdetail.chassis      = TRIM(SUBSTR(nv_daily,75,25)) 
/*8 */  wdetail.weight       = TRIM(SUBSTR(nv_daily,100,5))                   
/*9 */  wdetail.power        = TRIM(String(SUBSTR(nv_daily,105,7),"9999999")) 
/*10 */ wdetail.colorcode    = TRIM(SUBSTR(nv_daily,112,25))   /*A65-0356  ���� 10- 25*/
/*11 */ wdetail.licence      = TRIM(SUBSTR(nv_daily,137,20))   /*A65-0356  ���� 10- 20 */
/*12 */ wdetail.garage       = TRIM(SUBSTR(nv_daily,157,1))       
/*13 */ wdetail.fleetper     = TRIM(SUBSTR(nv_daily,158,5))       
/*14 */ wdetail.ncbper       = TRIM(SUBSTR(nv_daily,163,5))       
/*15 */ wdetail.othper       = TRIM(SUBSTR(nv_daily,168,5))       
/*16 */ wdetail.vehuse       = TRIM(SUBSTR(nv_daily,173,1))       
/*17 */ wdetail.comdat       = TRIM(SUBSTR(nv_daily,174,8))       
/*18 */ wdetail.ins_amt      = TRIM(SUBSTR(nv_daily,182,11))      
/*19 */ wdetail.name_insur   = TRIM(SUBSTR(nv_daily,193,15))      
/*20 */ wdetail.not_office   = TRIM(SUBSTR(nv_daily,208,75))      
/*21 */ wdetail.not_date     = TRIM(SUBSTR(nv_daily,283,8))       
/*22 */ wdetail.not_time     = TRIM(SUBSTR(nv_daily,291,6))       
/*23 */ wdetail.not_code     = TRIM(SUBSTR(nv_daily,297,4))       
/*24 */ wdetail.prem1        = TRIM(SUBSTR(nv_daily,301,11))      
/*25 */ wdetail.comp_prm     = TRIM(SUBSTR(nv_daily,312,9))       
/*26 */ wdetail.sckno        = TRIM(SUBSTR(nv_daily,321,25))      
/*27 */ wdetail.brand        = TRIM(SUBSTR(nv_daily,346,50))      
/*28 */ wdetail.pol_addr1    = TRIM(SUBSTR(nv_daily,396,50))      
/*29 */ wdetail.pol_addr2    = TRIM(SUBSTR(nv_daily,446,60))      
/*30 */ wdetail.pol_title    = TRIM(SUBSTR(nv_daily,506,30))      
/*31 */ wdetail.pol_fname    = TRIM(SUBSTR(nv_daily,536,75))      
/*32 */ wdetail.pol_lname    = TRIM(SUBSTR(nv_daily,611,45))      
/*33 */ wdetail.ben_name     = TRIM(SUBSTR(nv_daily,656,65))      
/*34 */ wdetail.remark       = TRIM(SUBSTR(nv_daily,721,150)).    
        ASSIGN 
/*35 */ wdetail.Account_no   = TRIM(SUBSTR(nv_daily,871,10))  
/*36 */ wdetail.client_no    = TRIM(SUBSTR(nv_daily,881,7))   
/*37 */ wdetail.expdat       = TRIM(SUBSTR(nv_daily,888,8))   
/*38 */ wdetail.gross_prm    = TRIM(SUBSTR(nv_daily,896,11))  
/*39 */ wdetail.province     = TRIM(SUBSTR(nv_daily,907,18))  
/*40 */ wdetail.receipt_name = TRIM(SUBSTR(nv_daily,925,50))  
/*41 */ wdetail.agent        = TRIM(SUBSTR(nv_daily,975,15))  
/*42 */ wdetail.prev_insur   = TRIM(SUBSTR(nv_daily,990,50))  
/*43 */ wdetail.prev_pol     = TRIM(SUBSTR(nv_daily,1040,25)) 
/*44 */ wdetail.deduct       = TRIM(SUBSTR(nv_daily,1065,9))   
/*45 */ wdetail.addr1_70     = TRIM(SUBSTR(nv_daily,1074,50)) 
/*46 */ wdetail.addr2_70     = TRIM(SUBSTR(nv_daily,1124,60)) 
/*47 */ wdetail.nsub_dist70  = TRIM(SUBSTR(nv_daily,1184,30)) 
/*48 */ wdetail.ndirection70 = TRIM(SUBSTR(nv_daily,1214,30)) 
/*49 */ wdetail.nprovin70    = TRIM(SUBSTR(nv_daily,1244,30)) 
/*50 */ wdetail.zipcode70    = TRIM(SUBSTR(nv_daily,1274,5))  
/*51 */ wdetail.addr1_72     = TRIM(SUBSTR(nv_daily,1279,50)) 
/*52 */ wdetail.addr2_72     = TRIM(SUBSTR(nv_daily,1329,60)) 
/*53 */ wdetail.nsub_dist72  = TRIM(SUBSTR(nv_daily,1389,30)) 
/*54 */ wdetail.ndirection72 = TRIM(SUBSTR(nv_daily,1419,30)) 
/*55 */ wdetail.nprovin72    = TRIM(SUBSTR(nv_daily,1449,30)) 
/*56 */ wdetail.zipcode72    = TRIM(SUBSTR(nv_daily,1479,5))  
/*57 */ wdetail.apptyp       = TRIM(SUBSTR(nv_daily,1484,10)) 
/*58 */ wdetail.appcode      = TRIM(SUBSTR(nv_daily,1494,2))  
/*59 */ wdetail.id_recive70  = TRIM(SUBSTR(nv_daily,1496,13))   /*��Ţ���ѵû�Шӵ�ǻ�ЪҪ�/�Ţ��˹ѧ����Թ�ҧ /�Ţ����¹�ҳԪ��*/
/*60 */ wdetail.br_recive70  = TRIM(SUBSTR(nv_daily,1509,20))   /*�ҢҢͧʶҹ��Сͺ����١���*/
/*61 */ wdetail.id_recive72  = TRIM(SUBSTR(nv_daily,1529,13))   /*��Ţ���ѵû�Шӵ�ǻ�ЪҪ�/�Ţ��˹ѧ����Թ�ҧ /�Ţ����¹�ҳԪ��*/
/*62 */ wdetail.br_recive72  = TRIM(SUBSTR(nv_daily,1542,20))   /*�ҢҢͧʶҹ��Сͺ����١���*/
/*63 */ wdetail.comp_comdat  = TRIM(SUBSTR(nv_daily,1562,8))    /*Effective Date Accidential*/ /* start : A59-0178*/ 
/*64 */ wdetail.comp_expdat  = TRIM(SUBSTR(nv_daily,1570,8))    /*Expiry Date Accidential*/     
/*65 */ wdetail.fi           = TRIM(SUBSTR(nv_daily,1578,11))   /*Coverage Amount Theft*/       
/*66 */ wdetail.class        = TRIM(SUBSTR(nv_daily,1589,3))    /*Car code*/                    
/*67 */ wdetail.usedtype     = TRIM(SUBSTR(nv_daily,1592,1))    /*Per Used*/                    
/*68 */ wdetail.driveno1     = TRIM(SUBSTR(nv_daily,1593,2))    /*Driver Seq1*/                 
/*69 */ wdetail.drivename1   = TRIM(SUBSTR(nv_daily,1595,40))   /*Driver Name1*/                
/*70 */ wdetail.bdatedriv1   = TRIM(SUBSTR(nv_daily,1635,8))    /*Birthdate Driver1*/           
/*71 */ wdetail.occupdriv1   = TRIM(SUBSTR(nv_daily,1643,75))   /*Occupation Driver1*/          
/*72 */ wdetail.positdriv1   = TRIM(SUBSTR(nv_daily,1718,40))   /*Position Driver1 */           
/*73 */ wdetail.driveno2     = TRIM(SUBSTR(nv_daily,1758,2))    /*Driver Seq2*/                 
/*74 */ wdetail.drivename2   = TRIM(SUBSTR(nv_daily,1760,40))   /*Driver Name2*/                
/*75 */ wdetail.bdatedriv2   = TRIM(SUBSTR(nv_daily,1800,8))    /*Birthdate Driver2*/           
/*76 */ wdetail.occupdriv2   = TRIM(SUBSTR(nv_daily,1808,75))   /*Occupation Driver2*/          
/*77 */ wdetail.positdriv2   = TRIM(SUBSTR(nv_daily,1883,40))   /*Position Driver2*/            
/*78 */ wdetail.driveno3     = TRIM(SUBSTR(nv_daily,1923,2))    /*Driver Seq3*/                 
/*79 */ wdetail.drivename3   = TRIM(SUBSTR(nv_daily,1925,40))   /*Driver Name3*/                
/*80 */ wdetail.bdatedriv3   = TRIM(SUBSTR(nv_daily,1965,8))    /*Birthdate Driver3*/           
/*81 */ wdetail.occupdriv3   = TRIM(SUBSTR(nv_daily,1973,75))   /*Occupation Driver3*/          
/*82 */ wdetail.positdriv3   = TRIM(SUBSTR(nv_daily,2048,40)).  /*Position Driver3*/
        ASSIGN                                                  
/*83 */ wdetail.caracc       = TRIM(SUBSTR(nv_daily,2088,1750)) /*A65-0356 Car Accessories*/    /** Car Accessories  2088 3837 1750 �ػ�ó쵡��   */  /* start : A63-0210*/ 
/*84 */ wdetail.Rec_name72   = TRIM(SUBSTR(nv_daily,3838,150))  /*Accidential Receipt name*/        
/*85 */ wdetail.Rec_add1     = TRIM(SUBSTR(nv_daily,3988,60))   /*Accidential Receipt Address 1*/   
/*86 */ wdetail.Rec_add2     = TRIM(SUBSTR(nv_daily,4048,60))   /*Accidential Receipt Address 2*/   /* end : A63-0210*/ 
/*88*/  wdetail.acctyp       = TRIM(SUBSTR(nv_daily,4108,1))    /*A65-0356 *//*A65-0356 */ /* accessories Y/N 4108 4108 1  accessories Y/N �ó��բ������ػ�ó�����ʴ���� Y /N  */
/*89*/  wdetail.acccovins    = TRIM(SUBSTR(nv_daily,4109,11))   /*A65-0356 *//* accessories coverage 4109 4119 11  �ʴ��ع��Сѹ��ǹ���� */
/*90*/  wdetail.accpremt     = TRIM(SUBSTR(nv_daily,4120,11))   /*A65-0356 *//* accessories premium 4120 4130 11   �ʴ�������»�Сѹ��ǹ���� */
/*91*/  wdetail.inspecttyp   = TRIM(SUBSTR(nv_daily,4131,1))    /*A65-0356 *//* ��Ǩ��Ҿö (Y/N) 4131 4131 1      ��Ǩ��Ҿö Y/N �óյ�Ǩ��Ҿ����ʴ���� Y �������ͧ��Ǩ��Ҿ����ʴ���� N */
/*92*/  wdetail.quotation    = TRIM(SUBSTR(nv_daily,4132,20))   /*A65-0356 *//* �Ţ�����ҧ�ԧ���������  4132 4151 20*/
/*93*/  wdetail.covcodtype   = TRIM(SUBSTR(nv_daily,4152,1)).    /*A65-0356 *//* TYPE OF INSURANCE    4152 4152 1 ��������Сѹ 1 2 3 */
        /* A67-0087 */
        ASSIGN 
        wdetail.Schanel      = trim(substr(nv_daily,4153,1))   /*��ͧ�ҧ��â��        */                                       
        wdetail.bev          = trim(substr(nv_daily,4154,1))   /*ö¹��俿�� Y/N      */                                       
        wdetail.driveno4     = trim(substr(nv_daily,4155,2))   /*�ӴѺ���Ѻ��褹��� 4*/                                       
        wdetail.drivename4   = trim(substr(nv_daily,4157,40))  /*���ͼ��Ѻ��褹��� 4 */                                       
        wdetail.bdatedriv4   = trim(substr(nv_daily,4197,8))   /*�ѹ��͹���Դ���Ѻ��褹���4 (�դ.�.��͹�ѹ �YYYYMMDD�) 4*/ 
        wdetail.occupdriv4   = trim(substr(nv_daily,4205,75))  /*�Ҫվ���Ѻ��褹��� 4       */                                
        wdetail.positdriv4   = trim(substr(nv_daily,4280,40))  /*���˹觧ҹ���Ѻ��褹��� 4  */                                
        wdetail.driveno5     = trim(substr(nv_daily,4320,2))   /*�ӴѺ���Ѻ��褹��� 5       */                                
        wdetail.drivename5   = trim(substr(nv_daily,4322,40))  /*���ͼ��Ѻ��褹��� 5        */                                
        wdetail.bdatedriv5   = trim(substr(nv_daily,4362,8))   /*�ѹ��͹���Դ���Ѻ��褹���5 (�դ.�.��͹�ѹ �YYYYMMDD�) 5*/ 
        wdetail.occupdriv5   = trim(substr(nv_daily,4370,75))  /*�Ҫվ���Ѻ��褹��� 5             */                          
        wdetail.positdriv5   = trim(substr(nv_daily,4445,40))  /*���˹觧ҹ���Ѻ��褹��� 5        */                          
        wdetail.campagin     = trim(substr(nv_daily,4485,20))  /*��໭ �� MPI, FORD ENSURE, NPP,*/                          
        wdetail.inspic       = trim(substr(nv_daily,4505,1))   /*�óյ�Ǩ��Ҿö ���ٻ᷹��õ�Ǩ��Ҿö Y/N */                  
        wdetail.engcount     = trim(substr(nv_daily,4506,2))   /*�ӹǹ����к��Ţ����ͧ */                                     
        wdetail.engno2       = trim(substr(nv_daily,4508,35))  /*�����Ţ����ͧ¹�� 2 */                                       
        wdetail.engno3       = trim(substr(nv_daily,4543,35))  /*�����Ţ����ͧ¹�� 3 */                                       
        wdetail.engno4       = trim(substr(nv_daily,4578,35))  /*�����Ţ����ͧ¹�� 4 */                                       
        wdetail.engno5       = trim(substr(nv_daily,4613,35))  /*�����Ţ����ͧ¹�� 5 */                                       
        wdetail.classcomp    = trim(substr(nv_daily,4648,5))   /*���� �.�.�.          */ 
        wdetail.carbrand     = TRIM(substr(nv_daily,4653,50))  /*������*/
            /* end : A67-0087 */
/*87*/  wdetail.nBLANK       = TRIM(SUBSTR(nv_daily,4703,28)).  /* Blank */ /* end : A59-0178*/ 
    END.
END.    /* repeat  */ 

FOR EACH wdetail.
    RUN proc_cutengno.     
    RUN proc_cutchassis.   
    RUN proc_licence.      
    RUN proc_addclass.     
    ASSIGN n_address  = "" 
           n_build    = ""      n_tambon   = ""      
           n_amper    = ""      n_country  = ""      
           n_post     = "".
          
           n_address   = trim(trim(wdetail.pol_addr1) + " " + trim(wdetail.pol_addr2)).
    IF n_address <> ""  AND index(n_address,"��Ҥ�÷����") = 0 THEN DO:
        RUN proc_chkaddr.
        ASSIGN wdetail.pol_addr1 = trim(n_build)
               wdetail.pol_addr2 = trim(n_tambon) + " " + trim(n_amper) + " " + trim(n_country) + " " + trim(n_post) .
    END.

    ASSIGN  
        n_address = ""
        n_build    = ""      n_tambon   = ""      
        n_amper    = ""      n_country  = ""      
        n_post     = ""
        n_address = trim(trim(wdetail.addr1_70) + " " + trim(wdetail.addr2_70)     + " " +
                    trim(wdetail.nsub_dist70)   + " " + trim(wdetail.ndirection70) + " " + 
                    trim(wdetail.nprovin70)     + " " + trim(wdetail.zipcode70)) .   
    IF n_address <> "" AND index(n_address,"��Ҥ�÷����") = 0 THEN DO: 
        RUN proc_chkaddr .  
        ASSIGN wdetail.addr1_70      = trim(n_build)  
              wdetail.addr2_70       = ""
              wdetail.nsub_dist70    = trim(n_tambon) 
              wdetail.ndirection70   = trim(n_amper)  
              wdetail.nprovin70      = trim(n_country)
              wdetail.zipcode70      = trim(n_post) .
    END.

    ASSIGN n_address  = ""
           n_build    = ""      n_tambon   = ""      
           n_amper    = ""      n_country  = ""      
           n_post     = ""
           n_address = trim(trim(wdetail.addr1_72) + " " + trim(wdetail.addr2_72)     + " " +
                       trim(wdetail.nsub_dist72)   + " " + trim(wdetail.ndirection72) + " " + 
                       trim(wdetail.nprovin72)     + " " + trim(wdetail.zipcode72)) .   
    IF n_address <> "" AND index(n_address,"��Ҥ�÷����") = 0 THEN DO: 
        RUN proc_chkaddr .   
        ASSIGN wdetail.addr1_72      = trim(n_build)  
              wdetail.addr2_72       = ""
              wdetail.nsub_dist72    = trim(n_tambon) 
              wdetail.ndirection72   = trim(n_amper)  
              wdetail.nprovin72      = trim(n_country)
              wdetail.zipcode72      = trim(n_post) .
    END.

    ASSIGN n_address = ""
           n_build    = ""      n_tambon   = ""      
           n_amper    = ""      n_country  = ""      
           n_post     = "" 
           n_address =  trim(trim(wdetail.Rec_add1) + " " + trim(wdetail.Rec_add2)).
    IF n_address <> "" AND index(n_address,"��Ҥ�÷����") = 0 THEN DO: 
        RUN proc_chkaddr .  
        ASSIGN wdetail.Rec_add1 = trim(n_build)
               wdetail.Rec_add2 = trim(n_tambon) + " " + trim(n_amper) + " " + trim(n_country) + " " + trim(n_post) .
    END.
    IF ra_poltyp = 1  THEN RUN proc_renew.  
    ELSE RUN proc_new.  
   
END.    
IF ra_poltyp = 2 THEN  Run  Pro_createfile.
ELSE Run  Pro_createfile_re.    

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE import_redbook C-Win 
PROCEDURE import_redbook :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
FIND LAST stat.Insure   USE-INDEX Insure01  WHERE 
    insure.compno   = fi_model     AND 
    Insure.FName    = TRIM(wdetail.brand) NO-LOCK  NO-ERROR NO-WAIT.
IF AVAIL stat.insure  THEN DO:
    ASSIGN np_brand =  Insure.text1    
        np_model    =  insure.text2  . 
    Find First stat.maktab_fil USE-INDEX maktab04    Where
        stat.maktab_fil.makdes   =    np_brand                 And                  
        index(stat.maktab_fil.moddes,np_model) <> 0            And
        stat.maktab_fil.makyea   =    Integer(wdetail.yrmanu)  AND 
        stat.maktab_fil.engine   =    Integer(wdetail.engine)   AND
        stat.maktab_fil.sclass   =    wdetail.subclass         AND
        stat.maktab_fil.si       =    deci(wdetail.price_ford) No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then  ASSIGN  wdetail.redbook =  stat.maktab_fil.modcod .
    ELSE ASSIGN  wdetail.redbook = "".
END.
ELSE ASSIGN  wdetail.redbook = "".*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_addclass C-Win 
PROCEDURE proc_addclass :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  create by A60-0095     
------------------------------------------------------------------------------*/

ASSIGN 
        wdetail.Notify_no     = REPLACE(wdetail.Notify_no,"-","")
        wdetail.Notify_no     = REPLACE(wdetail.Notify_no,"/","")
        wdetail.Notify_no     = REPLACE(wdetail.Notify_no,"\","")
        wdetail.Notify_no     = REPLACE(wdetail.Notify_no," ","")
        wdetail.price_ford    =  ""
        nv_cpamt3 = 0    nv_cpamt1 = 0    nv_cpamt2 = 0
        nv_premt1 = 0    nv_premt2 = 0    nv_premt3 = 0
        nv_cpamt1 = DECIMAL(SUBSTRING(wdetail.comp_prm,1,7)) 
        nv_premt1 = DECIMAL(SUBSTRING(wdetail.prem1,1,9)).
    IF nv_premt1 < 0 THEN nv_premt2 = (DECIMAL(SUBSTRING(wdetail.prem1,10,2)) * -1) / 100.
    ELSE  nv_premt2 = DECIMAL(SUBSTRING(wdetail.prem1,10,2)) / 100.
    nv_premt3 = nv_premt1 + nv_premt2.
    IF nv_cpamt1 < 0 THEN nv_cpamt2 = (DECIMAL(SUBSTRING(wdetail.comp_prm,8,2)) * -1) / 100.
    ELSE  nv_cpamt2 = DECIMAL(SUBSTRING(wdetail.comp_prm,8,2)) / 100.
    nv_cpamt3 = nv_cpamt1 + nv_cpamt2.
    /* A67-0087 */
    IF TRIM(wdetail.bev) = "Y" THEN DO:
        ASSIGN wdetail.n_pack  = wdetail.n_pack + wdetail.CLASS  wdetail.n_seattisco = 7 .
    END.
    /* end : A67-0087 */
    ELSE IF  nv_cpamt3 =  645.21 THEN DO:
        IF INDEX(wdetail.brand,"TRAILER") <> 0 THEN 
            ASSIGN wdetail.n_pack  = wdetail.n_pack + "520"  wdetail.n_seattisco = 0 .
        ELSE
            ASSIGN wdetail.n_pack  = wdetail.n_pack + "110"  wdetail.n_seattisco = 7 . 
    END.
    ELSE IF nv_cpamt3 = 967.28 THEN 
        ASSIGN wdetail.n_pack  = wdetail.n_pack + "320"  wdetail.n_seattisco = 3 . 
    ELSE IF nv_cpamt3 = 1310.75 THEN 
        ASSIGN wdetail.n_pack  = wdetail.n_pack + "320"  wdetail.n_seattisco = 3 . 
    ELSE IF nv_cpamt3 = 1408.12 THEN 
        ASSIGN wdetail.n_pack  = wdetail.n_pack + "320"  wdetail.n_seattisco = 3 . 
    ELSE IF nv_cpamt3 = 1826.49 THEN 
        ASSIGN wdetail.n_pack  = wdetail.n_pack + "320"  wdetail.n_seattisco = 3 . 
    ELSE IF nv_cpamt3 = 1182.35 THEN 
        ASSIGN wdetail.n_pack  = wdetail.n_pack + "210"  wdetail.n_seattisco = 12 .
    ELSE IF nv_cpamt3 = 2203.13 THEN 
        ASSIGN wdetail.n_pack  = wdetail.n_pack + "210"  wdetail.n_seattisco = 12 .
    ELSE IF nv_cpamt3 = 3437.91 THEN 
        ASSIGN wdetail.n_pack  = wdetail.n_pack + "210"  wdetail.n_seattisco = 12 .
    ELSE IF nv_cpamt3 = 4017.85 THEN 
        ASSIGN wdetail.n_pack  = wdetail.n_pack + "210"  wdetail.n_seattisco = 12 .
    ELSE IF nv_cpamt3 = 1891.76 THEN 
        ASSIGN wdetail.n_pack  = wdetail.n_pack + "320"  wdetail.n_seattisco = 3 .
    ELSE IF nv_cpamt3 = 1966.66 THEN 
        ASSIGN wdetail.n_pack  = wdetail.n_pack + "320"  wdetail.n_seattisco = 3 .
    ELSE IF nv_cpamt3 = 2127.16 THEN 
        ASSIGN wdetail.n_pack  = wdetail.n_pack + "320"  wdetail.n_seattisco = 3 .
    ELSE IF nv_cpamt3 = 2718.87 THEN 
        ASSIGN wdetail.n_pack  = wdetail.n_pack + "320"  wdetail.n_seattisco = 3 .
    ELSE IF nv_cpamt3 = 2546.60 THEN 
        ASSIGN wdetail.n_pack  = wdetail.n_pack + "420"  wdetail.n_seattisco = 3 .
    ELSE IF nv_cpamt3 = 3395.11 THEN 
        ASSIGN wdetail.n_pack  = wdetail.n_pack + "420"  wdetail.n_seattisco = 3 .
    ELSE ASSIGN  wdetail.n_pack  = wdetail.CLASS    wdetail.n_seattisco = 0 .
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkaddr C-Win 
PROCEDURE proc_chkaddr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A64-0271      
------------------------------------------------------------------------------*/
DEF VAR n_length   AS INT.
DO:
    ASSIGN
    n_build    = "" 
    n_tambon   = ""          
    n_amper    = ""          
    n_country  = ""          
    n_post     = "". 
    
    IF      INDEX(n_address,"���." ) <> 0 THEN n_address = REPLACE(n_address,"���.","���.") . /*A65-0035*/
    ELSE IF INDEX(n_address,"��." )  <> 0 THEN n_address = REPLACE(n_address,"��.","��.") .   /*A65-0035*/

    IF INDEX(n_address,"�." ) <> 0 THEN DO: 
       ASSIGN 
         n_country  =  TRIM(SUBSTR(n_address,INDEX(n_address,"�."),LENGTH(n_address)))
         n_length   =  LENGTH(n_country)
         n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
         
         n_country  =  IF index(n_country,"�. ") <> 0 THEN  trim(REPLACE(n_country,"�. ","�.")) ELSE TRIM(n_country)
         n_length   =  LENGTH(n_country)
         n_post     =  IF INDEX(n_country," ")  <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
         n_country  =  trim(SUBSTR(n_country,1,n_length - LENGTH(n_post))).
       n_country  =  trim(REPLACE(n_country,"�.","�ѧ��Ѵ")) .
    END.
    ELSE IF INDEX(n_address,"�ѧ��Ѵ" ) <> 0  AND n_country = "" THEN DO: 
        ASSIGN 
        n_country  =  trim(SUBSTR(n_address,INDEX(n_address,"�ѧ��Ѵ"),LENGTH(n_address)))
        n_length   =  LENGTH(n_country)
        n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
        n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length)  ELSE ""
        n_country  =  trim(SUBSTR(n_country,1,n_length - LENGTH(n_post))).
    END.
    ELSE IF INDEX(n_address,"���" ) <> 0 AND n_country = "" THEN DO: 
        ASSIGN 
        n_country  =  trim(SUBSTR(n_address,INDEX(n_address,"���"),LENGTH(n_address)))
        n_length   =  LENGTH(n_country)
        n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
        n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
        n_country  =  trim(SUBSTR(n_country,1,n_length - LENGTH(n_post)))
        n_country  =  "��ا෾��ҹ��".
    END.
    ELSE IF INDEX(n_address,"��ا෾" ) <> 0 AND n_country = "" THEN DO: 
        ASSIGN 
        n_country  =  trim(SUBSTR(n_address,INDEX(n_address,"��ا෾"),LENGTH(n_address)))
        n_length   =  LENGTH(n_country)
        n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
        n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
        n_country  =  trim(SUBSTR(n_country,1,n_length - LENGTH(n_post)))
        n_country  =  "��ا෾��ҹ��".
    END.
    ELSE IF INDEX(n_address," " ) <> 0 AND n_country = "" THEN DO: 
        ASSIGN 
        n_post     =  trim(SUBSTR(n_address,R-INDEX(n_address," ")))
        n_length   =  LENGTH(n_post)
        n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
        n_country  =  trim(SUBSTR(n_address,R-INDEX(n_address," ")))
        n_length   =  LENGTH(n_country)
        n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
        n_country  =  "�ѧ��Ѵ" + (n_country).
    END.
    
    IF INDEX(n_address,"�." ) <> 0 THEN DO: 
        ASSIGN 
        n_amper    =  trim(SUBSTR(n_address,R-INDEX(n_address,"�."),LENGTH(n_address)))
        n_length   =  LENGTH(n_amper)
        n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
        n_amper    =  trim(REPLACE(n_amper,"�.","�����")).
    END.
    ELSE IF INDEX(n_address,"�����" ) <> 0  AND n_amper  = "" THEN DO: 
        ASSIGN 
        n_amper    =  trim(SUBSTR(n_address,R-INDEX(n_address,"�����"),LENGTH(n_address)))
        n_length   =  LENGTH(n_amper)
        n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length)).
    END.
    ELSE IF INDEX(n_address,"ࢵ" ) <> 0  AND n_amper  = "" THEN DO: 
        ASSIGN 
        n_amper    =  trim(SUBSTR(n_address,R-INDEX(n_address,"ࢵ"),LENGTH(n_address)))
        n_length   =  LENGTH(n_amper)
        n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length)).
    END.
    ELSE IF INDEX(n_address,"�." ) <> 0 AND n_amper  = "" THEN DO: 
        ASSIGN 
        n_amper    =  trim(SUBSTR(n_address,R-INDEX(n_address,"�."),LENGTH(n_address)))
        n_length   =  LENGTH(n_amper)
        n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
        n_amper    =  trim(REPLACE(n_amper,"�.","ࢵ")).
    END.
    ELSE IF INDEX(n_address," " ) <> 0 AND n_amper  = "" THEN DO: 
        ASSIGN 
        n_amper    =  trim(SUBSTR(n_address,R-INDEX(n_address," ")))
        n_length   =  LENGTH(n_amper)
        n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
        n_amper    =  IF index(n_country,"��ا෾") <> 0 THEN  "ࢵ" + (n_amper) ELSE "�����" + trim(n_amper).
    END.

    IF INDEX(n_address,"�." ) <> 0 THEN DO: 
        ASSIGN 
        n_tambon   =  trim(SUBSTR(n_address,R-INDEX(n_address,"�."),LENGTH(n_address)))
        n_length   =  LENGTH(n_tambon)
        n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
        n_tambon   =  trim(REPLACE(n_tambon,"�.","�Ӻ�")).
    END.
    ELSE IF INDEX(n_address,"�Ӻ�" ) <> 0 AND n_tambon  =  "" THEN DO: 
        ASSIGN 
        n_tambon   =  trim(SUBSTR(n_address,R-INDEX(n_address,"�Ӻ�"),LENGTH(n_address)))
        n_length   =  LENGTH(n_tambon)
        n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length)).
    END.
    ELSE IF INDEX(n_address,"�ǧ" ) <> 0  AND n_tambon  =  "" THEN DO: 
        ASSIGN 
        n_tambon   =  trim(SUBSTR(n_address,INDEX(n_address,"�ǧ"),LENGTH(n_address)))
        n_length   =  LENGTH(n_tambon)
        n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length)).
    END.
    ELSE IF INDEX(n_address,"��." ) <> 0 AND n_tambon  =  "" THEN DO: 
        ASSIGN 
        n_tambon   =  trim(SUBSTR(n_address,INDEX(n_address,"��."),LENGTH(n_address)))
        n_length   =  LENGTH(n_tambon)
        n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
        n_tambon   =  trim(REPLACE(n_tambon,"��.","�ǧ")).
    END.
    ELSE IF INDEX(n_address," " ) <> 0  AND n_tambon  = ""  THEN DO: 
        ASSIGN 
        n_tambon   =  trim(SUBSTR(n_address,R-INDEX(n_address," ")))
        n_length   =  LENGTH(n_tambon)
        n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
        n_tambon   =  IF index(n_country,"��ا෾") <> 0 THEN  "�ǧ" + (n_tambon) ELSE "�Ӻ�" + trim(n_tambon).
    END.
    ASSIGN  n_build   = trim(n_address).

    IF INDEX(n_build,"���.") <> 0 THEN n_build = REPLACE(n_build,"���.","���.") .  /*A65-0035*/
    IF INDEX(n_build,"��.")  <> 0 THEN n_build = REPLACE(n_build,"��.","��.") .    /*A65-0035*/
    /*
    MESSAGE "n_build   "   n_build    skip
            "n_tambon  "   n_tambon   skip
            "n_amper   "   n_amper    skip
            "n_country "   n_country  skip
            "n_post    "   n_post     skip VIEW-AS ALERT-BOX. */
    
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_createcomp C-Win 
PROCEDURE proc_createcomp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wcomp.
    DELETE wcomp.
END.

FOR EACH brstat.insure USE-INDEX insure03 WHERE insure.compno = "PACK_TISCO" AND
                                                insure.insno  = "PACK_TISCO" NO-LOCK.
    CREATE wcomp.
    ASSIGN wcomp.cartyp   = brstat.insure.text2
           wcomp.brand    = brstat.insure.text1
           wcomp.package  = brstat.insure.text3
           wcomp.branch   = brstat.insure.icaddr2
           wcomp.cover    = brstat.insure.vatcode
           wcomp.BI       = brstat.insure.lname
           wcomp.PA       = brstat.insure.addr1
           wcomp.PD       = brstat.insure.addr2
           wcomp.n_class  = brstat.insure.text4
           wcomp.seat     = brstat.insure.icaddr3.
END.

/* comment by Ranu i. A60-0095....
CREATE wcomp.
ASSIGN wcomp.cartyp   = "New"
       wcomp.brand    = "Ford"
       wcomp.package  = "O"
       wcomp.branch   = "".
CREATE wcomp.
ASSIGN wcomp.cartyp   = "New"
       wcomp.brand    = "CHEVROLET"
       wcomp.package  = "Z"
       wcomp.branch   = "M".

CREATE wcomp.
ASSIGN wcomp.cartyp   = "New"
       wcomp.brand    = "Toyota"
       wcomp.package  = "X"
       wcomp.branch   = "M".
CREATE wcomp.
ASSIGN wcomp.cartyp   = "New"
       wcomp.brand    = "Oth"
       wcomp.package  = "F"
       wcomp.branch   = "M".
CREATE wcomp.
ASSIGN wcomp.cartyp   = "ReNew"
       wcomp.brand    = "garage"
       wcomp.package  = "F".
CREATE wcomp.
ASSIGN wcomp.cartyp   = "ReNew"
       wcomp.brand    = ""
       wcomp.package  = "G".
..end A60-0095....*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutchassis C-Win 
PROCEDURE proc_cutchassis :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_chanew       AS CHAR INIT "".
DEFINE VAR nv_len          AS INTE INIT 0.
DEFINE VAR nv_uwm301trareg AS CHAR INIT "".
ASSIGN nv_uwm301trareg = wdetail.chassis.
loop_chk1:
REPEAT:
    IF INDEX(nv_uwm301trareg,"-") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"-") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"-") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk1.
END.
loop_chk2:
REPEAT:
    IF INDEX(nv_uwm301trareg,"/") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"/") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"/") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk2.
END.
loop_chk3:
REPEAT:
    IF INDEX(nv_uwm301trareg,";") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,";") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,";") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk3.
END.
loop_chk4:
REPEAT:
    IF INDEX(nv_uwm301trareg,".") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,".") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,".") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk4.
END.
loop_chk5:
REPEAT:
    IF INDEX(nv_uwm301trareg,",") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,",") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,",") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk5.
END.
loop_chk6:
REPEAT:
    IF INDEX(nv_uwm301trareg," ") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg," ") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg," ") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk6.
END.
loop_chk7:
REPEAT:
    IF INDEX(nv_uwm301trareg,"\") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"\") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"\") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk7.
END.
loop_chk8:
REPEAT:
    IF INDEX(nv_uwm301trareg,":") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,":") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,":") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk8.
END.
loop_chk9:
REPEAT:
    IF INDEX(nv_uwm301trareg,"|") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"|") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"|") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk9.
END.
loop_chk10:
REPEAT:
    IF INDEX(nv_uwm301trareg,"+") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"+") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"+") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk10.
END.
loop_chk11:
REPEAT:
    IF INDEX(nv_uwm301trareg,"#") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"#") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"#") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk11.
END.
loop_chk12:
REPEAT:
    IF INDEX(nv_uwm301trareg,"[") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"[") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"[") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk12.
END.
loop_chk13:
REPEAT:
    IF INDEX(nv_uwm301trareg,"]") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"]") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"]") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk13.
END.
loop_chk14:
REPEAT:
    IF INDEX(nv_uwm301trareg,"'") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"'") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"+") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk14.
END.
loop_chk15:
REPEAT:
    IF INDEX(nv_uwm301trareg,"(") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"(") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"(") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk15.
END.
loop_chk16:
REPEAT:
    IF INDEX(nv_uwm301trareg,"_") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"_") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"_") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk16.
END.
loop_chk17:
REPEAT:
    IF INDEX(nv_uwm301trareg,"*") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"*") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"*") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk17.
END.
loop_chk18:
REPEAT:
    IF INDEX(nv_uwm301trareg,")") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,")") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,")") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk18.
END.
loop_chk19:
REPEAT:
    IF INDEX(nv_uwm301trareg,"=") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"=") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"=") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk19.
END.
ASSIGN wdetail.chassis = nv_uwm301trareg.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutengno C-Win 
PROCEDURE proc_cutengno :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_chanew       AS CHAR INIT "".
DEFINE VAR nv_len          AS INTE INIT 0.
DEFINE VAR nv_uwm301trareg AS CHAR INIT "".
ASSIGN nv_uwm301trareg = wdetail.engine.
loop_chk1:
REPEAT:
    IF INDEX(nv_uwm301trareg,"-") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"-") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"-") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk1.
END.
loop_chk2:
REPEAT:
    IF INDEX(nv_uwm301trareg,"/") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"/") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"/") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk2.
END.
loop_chk3:
REPEAT:
    IF INDEX(nv_uwm301trareg,";") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,";") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,";") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk3.
END.
loop_chk4:
REPEAT:
    IF INDEX(nv_uwm301trareg,".") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,".") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,".") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk4.
END.
loop_chk5:
REPEAT:
    IF INDEX(nv_uwm301trareg,",") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,",") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,",") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk5.
END.
loop_chk6:
REPEAT:
    IF INDEX(nv_uwm301trareg," ") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg," ") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg," ") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk6.
END.
loop_chk7:
REPEAT:
    IF INDEX(nv_uwm301trareg,"\") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"\") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"\") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk7.
END.
loop_chk8:
REPEAT:
    IF INDEX(nv_uwm301trareg,":") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,":") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,":") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk8.
END.
loop_chk9:
REPEAT:
    IF INDEX(nv_uwm301trareg,"|") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"|") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"|") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk9.
END.
loop_chk10:
REPEAT:
    IF INDEX(nv_uwm301trareg,"+") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"+") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"+") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk10.
END.
loop_chk11:
REPEAT:
    IF INDEX(nv_uwm301trareg,"#") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"#") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"#") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk11.
END.
loop_chk12:
REPEAT:
    IF INDEX(nv_uwm301trareg,"[") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"[") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"[") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk12.
END.
loop_chk13:
REPEAT:
    IF INDEX(nv_uwm301trareg,"]") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"]") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"]") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk13.
END.
loop_chk14:
REPEAT:
    IF INDEX(nv_uwm301trareg,"'") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"'") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"+") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk14.
END.
loop_chk15:
REPEAT:
    IF INDEX(nv_uwm301trareg,"(") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"(") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"(") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk15.
END.
loop_chk16:
REPEAT:
    IF INDEX(nv_uwm301trareg,"_") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"_") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"_") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk16.
END.
loop_chk17:
REPEAT:
    IF INDEX(nv_uwm301trareg,"*") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"*") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"*") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk17.
END.
loop_chk18:
REPEAT:
    IF INDEX(nv_uwm301trareg,")") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,")") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,")") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk18.
END.
loop_chk19:
REPEAT:
    IF INDEX(nv_uwm301trareg,"=") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"=") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"=") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk19.
END.
ASSIGN wdetail.engine = nv_uwm301trareg.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_licence C-Win 
PROCEDURE proc_licence :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  create by A60-0095     
------------------------------------------------------------------------------*/
DEF VAR nv_num AS CHAR INIT "".
DEF VAR nv_lengt AS INT INIT 0.

IF wdetail.licence  <> "" THEN DO:
    ASSIGN nv_num = ""  
           nv_lengt = 0.

    IF INDEX(wdetail.licence,"-") <> 0 THEN DO:
        ASSIGN wdetail.licence = REPLACE(wdetail.licence,"-"," ") .
    END.
    ELSE IF INDEX(wdetail.licence,"����ᴧ") <> 0 THEN ASSIGN wdetail.licence = "����ᴧ".
    ELSE DO:
        IF INDEX(wdetail.licence,"  ") <> 0  THEN ASSIGN wdetail.licence = REPLACE(wdetail.licence,"  ","") .
        IF INDEX(wdetail.licence," ")  <> 0  THEN ASSIGN wdetail.licence = REPLACE(wdetail.licence," ","") .
        nv_num = SUBSTR(wdetail.licence,1,1).
        IF index("0123475689",nv_num) <> 0 THEN DO:
           ASSIGN wdetail.licence = trim(SUBSTR(wdetail.licence,1,3)) + " " + 
                                    trim(SUBSTR(wdetail.licence,4,LENGTH(wdetail.licence))).
        END.
        ELSE DO:
            ASSIGN wdetail.licence = trim(SUBSTR(wdetail.licence,1,2)) + " " + 
                                    trim(SUBSTR(wdetail.licence,3,LENGTH(wdetail.licence))).
        END.
    END.
    RUN proc_province.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_new C-Win 
PROCEDURE proc_new :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF ra_poltyp = 2  THEN DO:      /* ����ᴧ */
    ASSIGN  wdetail.n_covcod      = "" 
            wdetail.price_ford    = IF INDEX(wdetail.remark,"P.") <> 0 THEN trim(SUBSTR(wdetail.remark,INDEX(wdetail.remark,"P.") + 2 )) ELSE ""
            wdetail.price_ford    = IF wdetail.price_ford = "" THEN "" 
                                    ELSE IF INDEX(wdetail.price_ford," ") <> 0 THEN trim(SUBSTR(wdetail.price_ford,1,INDEX(wdetail.price_ford," ")))
                                    ELSE trim(wdetail.price_ford)
            wdetail.comdat        = IF wdetail.comdat = "00000000" THEN wdetail.comp_comdat ELSE wdetail.comdat
            wdetail.expdat        = IF wdetail.expdat = "00000000" THEN wdetail.comp_expdat ELSE wdetail.expdat.
        RUN proc_redbook.    /* A57-0088 */
        /* comment by : A67-0114..
        /*-- create by : Ranu I. A60-0095 ---*/
        IF nv_premt3 = 0 THEN DO:               /*A61-0045*/ 
            ASSIGN wdetail.n_covcod  = "T".     /*A61-0045*/ 
        END.                                    /*A61-0045*/ 
        ELSE IF nv_premt3 = 7500.70 OR nv_premt3 = 8500.08 OR nv_premt3 = 9500.53 THEN DO:
            ASSIGN wdetail.n_covcod  = "2.2".
        END.
        ELSE IF nv_premt3 = 6300 OR nv_premt3 = 7300 OR nv_premt3 = 7500 OR nv_premt3 = 8300 OR
              THEN DO:
            ASSIGN  wdetail.n_covcod = "3.2".
        END.
        ELSE IF ( nv_premt3 <= 10000 ) AND (nv_premt3 > 3500 )  THEN DO: 
            ASSIGN wdetail.n_covcod  = "2".
        END.
        /*ELSE IF (nv_premt3 <= 3000 ) THEN DO:*/  /*A67-0114 */
        ELSE IF (nv_premt3 <= 3500 ) THEN DO:  /*A67-0114 */
            ASSIGN  wdetail.n_covcod = "3".
        END.
        ELSE IF (nv_premt3 > 10000 ) THEN DO:
            ASSIGN  wdetail.n_covcod = "1".
        END.
        /*-- end : A60-0095 ---*/
        ...end A67-0114*/
        RUN proc_new_chkcover . /* A67-0114*/
        ASSIGN 
            n_brand = IF INDEX(wdetail.brand," ") <> 0 THEN trim(SUBSTR(wdetail.brand,1,INDEX(wdetail.brand," ") - 1 )) ELSE trim(wdetail.brand).
        IF n_brand = "ISUZU" THEN DO:
           IF      nv_premt3 = 17355.40 THEN ASSIGN wdetail.n_pack = "110" .
           ELSE IF nv_premt3 = 17033.33 THEN ASSIGN wdetail.n_pack = "210" . 
           ELSE IF nv_premt3 = 20855.37 THEN ASSIGN wdetail.n_pack = "110" .
           ELSE IF nv_premt3 = 21566.22 THEN ASSIGN wdetail.n_pack = "110" .
           IF      wdetail.n_pack = "110" THEN ASSIGN wdetail.n_seattisc = 7.
           ELSE IF wdetail.n_pack = "210" THEN ASSIGN wdetail.n_seattisc = 5.
           ELSE ASSIGN wdetail.n_seattisc = 3.
        END.
        /*-----------A60-0225-------------*/
        IF ((n_brand = "Mazda" ) AND (nv_premt3 = 17148.89 OR nv_premt3 = 18986.08 OR
           nv_premt3 = 16536.85  OR   nv_premt3 = 17760.93 OR nv_premt3 = 46546.07 OR
           nv_premt3 = 51445.60 )) THEN DO:
            FIND LAST WComp WHERE wcomp.cartyp = "MPI" AND wcomp.brand  = trim(n_brand) NO-LOCK  NO-ERROR NO-WAIT.
                        IF AVAIL wcomp THEN 
                            ASSIGN wdetail.n_pack   = wcomp.package + wdetail.n_pack
                                   wdetail.n_branch =  "" .
                        IF wdetail.n_pack = "M110" THEN ASSIGN wdetail.n_seattisc = 7.
                        IF wdetail.n_pack = "M320" THEN ASSIGN wdetail.n_seattisc = 5.
        END.
        ELSE DO:
        /*-------- end : A60-0225 ------*/
            FIND LAST WComp WHERE  wcomp.cartyp = "new" AND wcomp.brand  = trim(n_brand) NO-LOCK  NO-ERROR NO-WAIT.
                IF NOT AVAIL wcomp THEN DO:
                    FIND LAST WComp WHERE  wcomp.cartyp  = "new" AND wcomp.brand   = "OTHER" AND
                                           wcomp.cover   = "1" NO-LOCK  NO-ERROR NO-WAIT.
                            IF AVAIL wcomp THEN 
                                ASSIGN wdetail.n_pack   = wcomp.package + wdetail.n_pack
                                       wdetail.n_branch = trim(wcomp.branch) 
                                       wdetail.bi       = TRIM(wcomp.bi)  
                                       wdetail.pa       = TRIM(wcomp.pa)  
                                       wdetail.pd       = TRIM(wcomp.pd) . 
                END.
                ELSE ASSIGN wdetail.n_pack   = wcomp.package + wdetail.n_pack
                            wdetail.n_branch = trim(wcomp.branch).
                IF wdetail.n_pack = "O320"  THEN ASSIGN wdetail.n_seattisc = 5.
        END.
        /*-- A60-0095--*/
        IF wdetail.n_covcod = "1" THEN DO: /*A60-0095*/
            IF n_brand = "CHEVROLET" THEN DO:
               FIND LAST wcomp WHERE wcomp.brand = trim(n_brand) AND wcomp.n_class = substr(wdetail.n_pack,2,3) NO-LOCK NO-ERROR .
                   IF AVAIL wcomp THEN
                        ASSIGN wdetail.n_branch = trim(wcomp.branch)
                               wdetail.bi       = TRIM(wcomp.bi)
                               wdetail.pa       = TRIM(wcomp.pa)
                               wdetail.pd       = TRIM(wcomp.pd)
                               wdetail.n_seattisco = INT(wcomp.seat).
            END.
            ELSE IF n_brand = "ISUZU" THEN DO:
               FIND LAST wcomp WHERE wcomp.brand = trim(n_brand) NO-LOCK NO-ERROR .
                   IF AVAIL wcomp THEN
                       ASSIGN wdetail.bi   = TRIM(wcomp.bi)
                          wdetail.pa       = TRIM(wcomp.pa)
                          wdetail.pd       = TRIM(wcomp.pd).
            END. /*-- end:A60-0095--*/
            /*--A60-0225--*/
            ELSE IF n_brand = "MAZDA" AND wdetail.n_pack = "M320" OR wdetail.n_pack = "M110" THEN DO:
                FIND LAST wcomp WHERE wcomp.brand = trim(n_brand) NO-LOCK NO-ERROR .
                   IF AVAIL wcomp THEN
                       ASSIGN wdetail.bi   = TRIM(wcomp.bi)
                              wdetail.pa   = TRIM(wcomp.pa)
                              wdetail.pd   = TRIM(wcomp.pd).
            END.
            /*-- end : A60-0225--*/
            ELSE IF n_brand = "HYUNDAI" THEN DO:
               FIND LAST wcomp WHERE wcomp.brand = trim(n_brand) NO-LOCK NO-ERROR .
                   IF AVAIL wcomp THEN
                       ASSIGN wdetail.bi   = TRIM(wcomp.bi)
                          wdetail.pa       = TRIM(wcomp.pa)
                          wdetail.pd       = TRIM(wcomp.pd).
            END.
            ELSE DO: 
                /* Add by : A67-0087 */
                IF wdetail.bev = "Y" THEN DO:
                    FIND LAST wcomp WHERE wcomp.brand = trim(n_brand) NO-LOCK NO-ERROR .
                       IF AVAIL wcomp THEN
                           ASSIGN wdetail.bi   = TRIM(wcomp.bi)
                              wdetail.pa       = TRIM(wcomp.pa)
                              wdetail.pd       = TRIM(wcomp.pd).
                END.
                ELSE DO:
                   FIND LAST wcomp WHERE wcomp.brand = trim(n_brand) AND wcomp.cover = TRIM(wdetail.n_covcod) NO-LOCK NO-ERROR .
                       IF AVAIL wcomp THEN
                           ASSIGN wdetail.n_pack   = wcomp.package + substr(wdetail.n_pack,2,LENGTH(wdetail.n_pack))
                              wdetail.bi       = TRIM(wcomp.bi)
                              wdetail.pa       = TRIM(wcomp.pa)
                              wdetail.pd       = TRIM(wcomp.pd).
                       ELSE ASSIGN wdetail.bi  = ""
                                  wdetail.pa   = ""
                                  wdetail.pd   = "".
                END.
                /* end : A67-0087 */
            END.
        END. /* end �.1 */
        ELSE IF wdetail.n_covcod = "2" OR wdetail.n_covcod = "3" THEN DO:
            FIND LAST WComp WHERE  wcomp.cover = "2-3" NO-LOCK  NO-ERROR NO-WAIT.
               IF AVAIL wcomp THEN 
                   ASSIGN wdetail.n_branch = trim(wcomp.branch) 
                          wdetail.bi       = TRIM(wcomp.bi)
                          wdetail.pa       = TRIM(wcomp.pa)
                          wdetail.pd       = TRIM(wcomp.pd)
                          wdetail.n_pack   = IF wdetail.n_covcod = "2" THEN "Y" + SUBSTR(wdetail.n_pack,2,3) 
                                             ELSE  "R" + SUBSTR(wdetail.n_pack,2,3).
        END.
        /*--A60-0095--*/
        ELSE DO:
            FIND LAST wcomp WHERE wcomp.cover = wdetail.n_covcod NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL wcomp THEN
                 ASSIGN wdetail.n_pack   = IF LENGTH(wdetail.n_pack) <> 4 THEN  wcomp.package + wdetail.n_pack 
                                           ELSE wcomp.package + SUBSTR(wdetail.n_pack,2,3)
                        wdetail.n_branch = trim(wcomp.branch)
                        wdetail.bi       = TRIM(wcomp.bi)
                        wdetail.pa       = TRIM(wcomp.pa)
                        wdetail.pd       = TRIM(wcomp.pd).
            ELSE ASSIGN wdetail.n_pack   = IF LENGTH(wdetail.n_pack) <> 4 THEN  "C" + wdetail.n_pack 
                                           ELSE "C" + SUBSTR(wdetail.n_pack,2,3)
                        wdetail.n_branch = "" .
        END.
        /*-- end:A60-0095--*/
        ASSIGN wdetail.n_typpol  = "NEW".
        ASSIGN  np_dealer = ""
            np_dealer = IF index(wdetail.Notify_no,",") <> 0 THEN trim(SUBSTR(wdetail.Notify_no,index(wdetail.Notify_no,",") + 1 )) ELSE ""  /*A56-0399*/
            wdetail.n_branch  = "".
        IF  index(wdetail.brand,"FORD") <> 0 THEN DO:
            ASSIGN wdetail.n_branch  = ""
                   wdetail.nproducer = fi_producerford   
                   wdetail.nagent    = fi_agentford .
            IF INDEX(wdetail.remark,"_2Y") <> 0  THEN DO:
                ASSIGN wdetail.n_branch  = ""
                   wdetail.nproducer = fi_producerford2y  
                   wdetail.nagent    = fi_agentford2y . 
            END.
            /*A67-0114*/
            ELSE IF index(wdetail.agent,"HI-WAY") <> 0 THEN DO:
                ASSIGN  wdetail.nproducer = "B3M0033" 
                        wdetail.nagent    = "B3M0054" .
            END. 
            ELSE IF TRIM(wdetail.licence) <> "" THEN DO:
                ASSIGN  wdetail.nproducer = "B3M0033" 
                        wdetail.nagent    = "B3M0002" .
            END. /* end :A67-0114*/
        END.
        /* Add by : A67-0087 */
        ELSE IF  index(wdetail.brand,"HAVAL") <> 0 OR index(wdetail.brand,"TANK") <> 0  OR (index(wdetail.brand,"ORA") <> 0 AND wdetail.carbrand = "ORA" ) THEN DO:
            RUN proc_new_producer. /*A67-0114*/
        END.
        ELSE IF  index(wdetail.brand,"HYUNDAI") <> 0 THEN DO:     /*Kridtiya i. A67-0036*/
           IF nv_premt3 = 0  THEN DO:
                ASSIGN wdetail.n_branch  = ""
                   wdetail.nproducer = fi_proHyundai  
                   wdetail.nagent    = fi_proHyundai  . /*cmi*/
            END.
            ELSE ASSIGN wdetail.n_branch  = ""
                    wdetail.nproducer = fi_proHyundai  
                    wdetail.nagent    = fi_agentHyundai.   
        END.          /*Kridtiya i. A67-0036*/
        /* A67-0114*/
        ELSE IF index(wdetail.brand,"NISSAN") <> 0 THEN DO:
            ASSIGN  wdetail.nproducer =  "B3DM000003" 
                    wdetail.nagent    =  "B3M0002" . 
        END.
        ELSE IF index(wdetail.agent,"HI-WAY") <> 0  THEN DO: 
            IF  index(wdetail.brand,"WHEELS") <> 0 OR index(wdetail.brand,"TRAILER") <> 0  OR 
                index(wdetail.brand,"TRUCK")  <> 0 OR index(wdetail.brand,"SEMI")    <> 0  THEN DO:
                ASSIGN wdetail.nproducer = "B3MLTIS302"  
                       wdetail.nagent    = "B3MLTIS300" .  
            END.
            ELSE DO: 
                ASSIGN  wdetail.nproducer = "B3MLTIS301"
                        wdetail.nagent    = "B3MLTIS300" . 
            END.
        END. /* end A67-0114*/
        ELSE DO:
            IF index(wdetail.brand,"ISUZU") <> 0 THEN DO:   /*case : ISUZU */
                /* A64-0092  ö��÷ء */
                IF index(wdetail.brand,"Wheels") <> 0 OR index(wdetail.brand,"Trailer") <> 0 
                OR index(wdetail.brand,"TRUCK")  <> 0 /* A64-0431*/ THEN DO: 
                     ASSIGN wdetail.nproducer = fi_pdtkcode   
                            wdetail.nagent    = fi_agtkcode .
                END. 
                /* end A64-0092*/
                /*--A60-0225---*/
                ELSE IF INDEX(wdetail.not_office,"CIN(FEET)") <> 0 THEN DO:
                    ASSIGN wdetail.nproducer = fi_producercir   
                           wdetail.nagent    = fi_agenttiscocir .
                END.
                /*-- end : A60-0225---*/
                /* A64-0092 ö��硻���ᴧ */
                ELSE IF wdetail.yrmanu = trim(fi_year) THEN DO: 
                    ASSIGN wdetail.n_branch  = ""
                           wdetail.nproducer = fi_produceris
                           wdetail.nagent    = fi_agenttiscois.
                END.
                /* end : A64-0092 */
                ELSE ASSIGN wdetail.nproducer = fi_producertisco              
                           wdetail.nagent    = fi_agenttisco .
            END.
            /* A64-0092 */
            ELSE IF index(wdetail.brand,"HINO")  <> 0 OR index(wdetail.brand,"Trailer") <> 0 OR index(wdetail.brand,"TRUCK") <> 0 /* A64-0431*/ THEN DO: /*ö��÷ء */
                ASSIGN wdetail.nproducer = fi_pdtkcode   
                       wdetail.nagent    = fi_agtkcode .
            END.
            ELSE IF index(wdetail.brand,"YAMAHA") <> 0 OR index(wdetail.brand,"TRIUMPH") <> 0 OR index(wdetail.brand,"KAWASAKI") <> 0 THEN DO:  /* bigbike*/
                    ASSIGN wdetail.nproducer = fi_pdbkcode   
                           wdetail.nagent    = fi_agbkcode .
            END.
            ELSE IF (index(wdetail.brand,"SUZUKI") <> 0 AND  DECI(wdetail.power) < 1000 ) OR
                    (index(wdetail.brand,"HONDA")  <> 0 AND DECI(wdetail.power) < 1000 ) AND
                    (index(wdetail.remark,"Deduct") <> 0 OR index(wdetail.remark,"DD") <> 0 ) THEN DO: /* bigbike*/
                    ASSIGN wdetail.nproducer = fi_pdbkcode   
                           wdetail.nagent    = fi_agbkcode .
            END.
            /* end A64-0092 */
            /*--A60-0225---*/
            ELSE IF INDEX(wdetail.not_office,"CIN(FEET)") <> 0 THEN DO:
                ASSIGN wdetail.nproducer = fi_producercir   
                       wdetail.nagent    = fi_agenttiscocir .
            END.
            /*-- end : A60-0225---*/
            ELSE ASSIGN wdetail.nproducer = fi_producertisco              
                        wdetail.nagent    = fi_agenttisco .
            /*-- end A59-0618 --*/
            /*-- A60-0095 --*/
            IF wdetail.n_covcod  <> "1" AND index(wdetail.Notify_no,"TISTY") <> 0  THEN DO:
                /*--A60-0225---*/
                IF INDEX(wdetail.not_office,"CIN(FEET)") <> 0 THEN DO:
                    ASSIGN wdetail.nproducer = fi_producercir   
                           wdetail.nagent    = fi_agenttiscocir .
                END.
                /*-- end : A60-0225---*/
                /* A64-0092 */
                ELSE IF index(wdetail.brand,"HINO") <> 0 OR index(wdetail.brand,"Trailer") <> 0 THEN DO: /*ö��÷ء */
                    ASSIGN wdetail.nproducer = fi_pdtkcode   
                           wdetail.nagent    = fi_agtkcode .
                END.
                ELSE IF index(wdetail.brand,"YAMAHA") <> 0 OR index(wdetail.brand,"TRIUMPH") <> 0 OR index(wdetail.brand,"KAWASAKI") <> 0 THEN DO:  /* bigbike*/
                        ASSIGN wdetail.nproducer = fi_pdbkcode   
                               wdetail.nagent    = fi_agbkcode .
                END.
                ELSE IF (index(wdetail.brand,"SUZUKI") <> 0 AND  DECI(wdetail.power) < 1000 ) OR
                         (index(wdetail.brand,"HONDA")  <> 0 AND DECI(wdetail.power) < 1000 ) AND
                         (index(wdetail.remark,"Deduct") <> 0 OR index(wdetail.remark,"DD") <> 0 ) THEN DO: /* bigbike*/
                        ASSIGN wdetail.nproducer = fi_pdbkcode   
                               wdetail.nagent    = fi_agbkcode .
                END.
                /* end A64-0092 */
                ELSE IF wdetail.Pro_off <> "17" THEN DO:
                    ASSIGN wdetail.n_branch  = "M"
                           wdetail.nproducer = "B3MLTIS103"  /*A64-0092*/ 
                           wdetail.nagent    = "B3MLTIS100". /*A64-0092*/ 
                END.
                ELSE 
                    ASSIGN wdetail.n_branch  = "U"
                           wdetail.nproducer = "B3MLTIS201"  /*A64-0092*/  
                           wdetail.nagent    = "B3MLTIS200". /*A64-0092*/  
            END.
        END. /* A64-0271 */
        /* A67-0114 �ú.����� */
        IF (INDEX(fi_filename,"Solution_") <> 0)  OR (wdetail.n_covcod  = "T" )  THEN DO:
            ASSIGN wdetail.nproducer = "B3MLTIS104"
                   wdetail.nagent    = "B3MLTIS100" .
        END.
        /* end A67-0114*/
        IF  np_dealer <> "" THEN DO:
            FIND FIRST stat.insure USE-INDEX insure01 WHERE 
                stat.insure.compno = "TISCO" AND stat.insure.lname  = np_dealer NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL stat.insure THEN ASSIGN  wdetail.n_branch  = trim(stat.insure.branch).
            ELSE DO: 
                /* A65-0035 */
                FIND FIRST stat.insure USE-INDEX insure01 WHERE 
                stat.insure.compno = "GWM" AND stat.insure.lname  = np_dealer NO-LOCK NO-WAIT NO-ERROR.
                IF AVAIL stat.insure THEN ASSIGN  wdetail.n_branch  = trim(stat.insure.branch).
                ELSE DO: 
                    FIND FIRST stat.insure USE-INDEX insure01 WHERE 
                        stat.insure.compno = "HYUNDAI" AND stat.insure.lname  = np_dealer NO-LOCK NO-WAIT NO-ERROR.    /*Kridtiya i. A67-0036*/
                    IF AVAIL stat.insure THEN ASSIGN  wdetail.n_branch  = trim(stat.insure.branch).
                    ELSE ASSIGN  wdetail.n_branch  = "" .
                END.
            END.
        END.
        ELSE DO:  /* start : A59-0618 */
            ASSIGN  wdetail.n_branch  = "".
            IF wdetail.Notify_no = "" THEN wdetail.n_branch = "".
            ELSE DO:
                IF (index("123456789",SUBSTR(wdetail.Notify_no,1,1)) <> 0 ) AND 
                (index("123456789",SUBSTR(wdetail.Notify_no,2,1)) <> 0 ) THEN  
                    ASSIGN wdetail.n_branch = substr(wdetail.Notify_no,1,2) .
                ELSE DO: 
                    IF SUBSTR(wdetail.notify,1,1) <> "D" THEN ASSIGN wdetail.n_branch = "" .
                    ELSE ASSIGN wdetail.n_branch = substr(wdetail.Notify_no,2,1) .
                END.
            END.
        END. /* end A59-0618 */
       IF INDEX(wdetail.n_pack,"O") <> 0  THEN DO:
            FIND LAST WComp WHERE trim(wcomp.package) = "O" NO-LOCK  NO-ERROR NO-WAIT.
                IF AVAIL wcomp THEN DO:
                  ASSIGN wdetail.bi   = TRIM(wcomp.bi)
                         wdetail.pa   = TRIM(wcomp.pa)
                         wdetail.pd   = TRIM(wcomp.pd).
                END.
        END.
        IF INDEX(wdetail.n_pack,"F") <> 0 THEN ASSIGN wdetail.n_pack = TRIM(REPLACE(wdetail.n_pack,"F","T")) . /*A67-0114*/
        IF LENGTH(wdetail.n_pack) < 4     THEN ASSIGN wdetail.n_pack = "T" + TRIM(wdetail.n_pack) . /*A67-0114*/
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_new_chkcover C-Win 
PROCEDURE proc_new_chkcover :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by  /*A67-0114 */      
------------------------------------------------------------------------------*/
IF nv_premt3 = 0 THEN DO:               
    ASSIGN wdetail.n_covcod  = "T".     
END.                                    
ELSE IF nv_premt3 = 7500.70 OR nv_premt3 = 8500.08 OR nv_premt3 = 9500.53 OR 
    index(wdetail.remark,"�.2+")  <> 0  OR index(wdetail.remark,"�2+") <> 0 OR 
    index(wdetail.remark,"2PLUS") <> 0  OR index(wdetail.remark,"2 PLUS") <> 0 OR 
    index(wdetail.remark,"2 �ǡ") <> 0  OR index(wdetail.remark,"2+") <> 0 OR 
    (index(wdetail.remark,"FE2+") <> 0  AND wdetail.garage = "0") THEN DO:
    ASSIGN wdetail.n_covcod  = "2.2".
END.
ELSE IF nv_premt3 = 6300 OR nv_premt3 = 7300 OR nv_premt3 = 7500 OR nv_premt3 = 8300 OR 
    index(wdetail.remark,"�.3+")  <> 0  OR index(wdetail.remark,"�3+") <> 0 OR
    index(wdetail.remark,"3PLUS") <> 0  OR index(wdetail.remark,"3 PLUS") <> 0 OR 
    index(wdetail.remark,"3 �ǡ") <> 0  OR index(wdetail.remark,"3+") <> 0  THEN DO:
    ASSIGN  wdetail.n_covcod = "3.2".
END.
ELSE IF ( nv_premt3 <= 10000 ) AND (nv_premt3 > 3500 )  THEN DO: 
    ASSIGN wdetail.n_covcod  = "2".
END.
ELSE IF (nv_premt3 <= 3500 ) THEN DO: 
    ASSIGN  wdetail.n_covcod = "3".
END.
ELSE IF (nv_premt3 > 10000 ) THEN DO:
    ASSIGN  wdetail.n_covcod = "1".
END.

IF  index(wdetail.brand,"WHEELS") <> 0 THEN ASSIGN wdetail.n_pack = "320".  
ELSE IF index(wdetail.brand,"TRUCK")  <> 0 THEN ASSIGN wdetail.n_pack = "420". 
     
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_new_producer C-Win 
PROCEDURE proc_new_producer :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:

    IF INDEX(wdetail.remark,"CPO_2Y") <> 0 OR INDEX(wdetail.remark,"CPO_3Y") <> 0 THEN DO:
        ASSIGN wdetail.n_branch  = ""
           wdetail.nproducer = "B3DM000004"  
           wdetail.nagent    = "B3M0002" .  
    END.
    ELSE IF INDEX(wdetail.remark,"_2Y") <> 0  THEN DO:
        ASSIGN wdetail.n_branch  = ""
           wdetail.nproducer = "B3DM000008"  
           wdetail.nagent    = "B3M0002" .  
    END.
    ELSE IF INDEX(wdetail.remark,"Demo") <> 0 OR  INDEX(wdetail.remark,"���ͧ�Ѻ") <> 0 OR INDEX(wdetail.remark,"ö������������") <> 0 THEN DO:
        ASSIGN wdetail.n_branch  = ""
           wdetail.n_pack    = IF wdetail.bev = "Y" THEN "E12" ELSE "120"
           wdetail.nproducer = "B3DM000005"  
           wdetail.nagent    = "B3M0002" .  
    END.
    ELSE IF INDEX(wdetail.remark,"CPO") <> 0 THEN DO:
        ASSIGN wdetail.n_branch  = ""
           wdetail.nproducer = "B3DM000007"  
           wdetail.nagent    = "B3M0002" .  
    END.
    ELSE IF INTE(wdetail.yrmanu) = YEAR(TODAY) THEN DO:
        ASSIGN wdetail.n_branch  = ""
           wdetail.nproducer = "B3DM000006"  
           wdetail.nagent    = "B3M0002" .  
    END.
    ELSE 
         ASSIGN wdetail.n_branch  = ""
           wdetail.nproducer = "B3DM000007"  
           wdetail.nagent    = "B3M0002" . 

END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_province C-Win 
PROCEDURE proc_province :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
        IF INDEX(wdetail.province,".") <> 0 THEN REPLACE(wdetail.province,".","").
/*1*/        IF wdetail.province = "ANG THONG"          THEN wdetail.province = "ͷ".
        ELSE IF wdetail.province = "ANGTHONG"           THEN wdetail.province = "ͷ".
        ELSE IF wdetail.province = "ANG-THONG"          THEN wdetail.province = "ͷ".
/*2*/   ELSE IF wdetail.province = "AYUTTHAYA"          THEN wdetail.province = "��".
/*3*/   ELSE IF wdetail.province = "BKK"                THEN wdetail.province = "��". /*-A59-0503-*/ /* open A60-0095*/
/*3*/   ELSE IF wdetail.province = "BANGKOK"            THEN wdetail.province = "��".
/*4*/   ELSE IF wdetail.province = "BURIRAM"            THEN wdetail.province = "��".
/*5*/   ELSE IF wdetail.province = "CHAI NAT"           THEN wdetail.province = "��".
        ELSE IF wdetail.province = "CHAI-NAT"           THEN wdetail.province = "��".
/*6*/   ELSE IF wdetail.province = "CHANTHABURI"        THEN wdetail.province = "��".
/*7*/   ELSE IF wdetail.province = "CHIANG MAI"         THEN wdetail.province = "��".
        ELSE IF wdetail.province = "CHIANGMAI"          THEN wdetail.province = "��".
/*8*/   ELSE IF wdetail.province = "CHONBURI"           THEN wdetail.province = "��".
/*9*/   ELSE IF wdetail.province = "KALASIN"            THEN wdetail.province = "��".
/*10*/  ELSE IF wdetail.province = "KANCHANABURI"       THEN wdetail.province = "��".
/*11*/  ELSE IF wdetail.province = "KHON KAEN"          THEN wdetail.province = "��".
        ELSE IF wdetail.province = "KHONKAEN"           THEN wdetail.province = "��".
/*12*/  ELSE IF wdetail.province = "KRABI"              THEN wdetail.province = "��".
/*13*/  ELSE IF wdetail.province = "LOPBURI"            THEN wdetail.province = "ź".
/*14*/  ELSE IF wdetail.province = "NAKHON NAYOK"       THEN wdetail.province = "��".
        ELSE IF wdetail.province = "NAKHONNAYOK"        THEN wdetail.province = "��".
/*15*/  ELSE IF wdetail.province = "NAKHON PATHOM"      THEN wdetail.province = "��".
        ELSE IF wdetail.province = "NAKHONPATHOM"       THEN wdetail.province = "��".
/*16*/  ELSE IF wdetail.province = "NAKHON RATCHASIMA"  THEN wdetail.province = "��".
        ELSE IF wdetail.province = "NAKHONRATCHASIMA"   THEN wdetail.province = "��".
/*17*/  ELSE IF wdetail.province = "NAKHON SITHAMMARAT" THEN wdetail.province = "��".
        ELSE IF wdetail.province = "NAKHONSITHAMMARAT"  THEN wdetail.province = "��".
/*18*/  ELSE IF wdetail.province = "NONTHABURI"         THEN wdetail.province = "��".
/*19*/  ELSE IF wdetail.province = "PHETCHABURI"        THEN wdetail.province = "��".
/*20*/  ELSE IF wdetail.province = "PHUKET"             THEN wdetail.province = "��".
/*21*/  ELSE IF wdetail.province = "PHITSANULOK"        THEN wdetail.province = "��".
/*22*/  ELSE IF wdetail.province = "PRACHINBURI"        THEN wdetail.province = "��".
/*23*/  ELSE IF wdetail.province = "RATCHABURI"         THEN wdetail.province = "ú".
/*24*/  ELSE IF wdetail.province = "RAYONG"             THEN wdetail.province = "��".
/*25*/  ELSE IF wdetail.province = "ROI ET"             THEN wdetail.province = "��".
        ELSE IF wdetail.province = "ROI-ET"             THEN wdetail.province = "��".
        ELSE IF wdetail.province = "ROIET"              THEN wdetail.province = "��".
/*26*/  ELSE IF wdetail.province = "SARABURI"           THEN wdetail.province = "ʺ".
/*27*/  ELSE IF wdetail.province = "SRISAKET"           THEN wdetail.province = "ȡ".
/*28*/  ELSE IF wdetail.province = "SONGKHLA"           THEN wdetail.province = "ʢ".
/*29*/  ELSE IF wdetail.province = "SA KAEO"            THEN wdetail.province = "ʡ".
        ELSE IF wdetail.province = "SAKAEO"             THEN wdetail.province = "ʡ".
/*30*/  ELSE IF wdetail.province = "SUPHANBURI"         THEN wdetail.province = "ʾ".
/*/*31*/  ELSE IF wdetail.province = "SURAT THANI"        THEN wdetail.province = "ʯ". /*A63-0210*/
        ELSE IF wdetail.province = "SURATTHANI"         THEN wdetail.province = "ʯ".*/
/*31*/  ELSE IF wdetail.province = "SURAT THANI"        THEN wdetail.province = "ʮ".
        ELSE IF wdetail.province = "SURATTHANI"         THEN wdetail.province = "ʮ".   /*A63-0210*/
/*32*/  ELSE IF wdetail.province = "TRANG"              THEN wdetail.province = "��".
/*33*/  ELSE IF wdetail.province = "UBON RATCHATHANI"   THEN wdetail.province = "ͺ".
        ELSE IF wdetail.province = "UBONRATCHATHANI"    THEN wdetail.province = "ͺ".
/*34*/  ELSE IF wdetail.province = "UDON THANI"         THEN wdetail.province = "ʹ".
        ELSE IF wdetail.province = "UDONTHANI"          THEN wdetail.province = "ʹ".
/*35*/  ELSE IF wdetail.province = "AMNAT CHAROEN"      THEN wdetail.province = "ͨ".
        ELSE IF wdetail.province = "AMNATCHAROEN"       THEN wdetail.province = "ͨ".
/*36*/  ELSE IF wdetail.province = "CHAIYAPHUM"         THEN wdetail.province = "��".
/*37*/  ELSE IF wdetail.province = "CHIANG RAI"         THEN wdetail.province = "��".
        ELSE IF wdetail.province = "CHIANGRAI"          THEN wdetail.province = "��".
/*38*/  ELSE IF wdetail.province = "CHUMPHON"           THEN wdetail.province = "��".
/*39*/  ELSE IF wdetail.province = "KAMPHAENG PHET"     THEN wdetail.province = "��".
        ELSE IF wdetail.province = "KAMPHAENGPHET"      THEN wdetail.province = "��".
/*40*/  ELSE IF wdetail.province = "LAMPANG"            THEN wdetail.province = "Ż".
/*41*/  ELSE IF wdetail.province = "LAMPHUN"            THEN wdetail.province = "ž".
/*42*/  ELSE IF wdetail.province = "NAKHON SAWAN"       THEN wdetail.province = "��".
        ELSE IF wdetail.province = "NAKHONSAWAN"        THEN wdetail.province = "��".
/*43*/  ELSE IF wdetail.province = "NONG KHAI"          THEN wdetail.province = "��".
        ELSE IF wdetail.province = "NONGKHAI"           THEN wdetail.province = "��".
/*44*/  ELSE IF wdetail.province = "PATHUM THANI"       THEN wdetail.province = "��".
        ELSE IF wdetail.province = "PATHUMTHANI"        THEN wdetail.province = "��".
/*45*/  ELSE IF wdetail.province = "PATTANI"            THEN wdetail.province = "��".
/*46*/  ELSE IF wdetail.province = "PHATTHALUNG"        THEN wdetail.province = "��".
/*47*/  ELSE IF wdetail.province = "PHETCHABUN"         THEN wdetail.province = "��".
/*48*/  ELSE IF wdetail.province = "SAKON NAKHON"       THEN wdetail.province = "ʹ".
/*49*/  ELSE IF wdetail.province = "SING BURI"          THEN wdetail.province = "��".
        ELSE IF wdetail.province = "SINGBURI"           THEN wdetail.province = "��".
/*50*/  ELSE IF wdetail.province = "SURIN"              THEN wdetail.province = "��".
/*51*/  ELSE IF wdetail.province = "YASOTHON"           THEN wdetail.province = "��".
/*52*/  ELSE IF wdetail.province = "YALA"               THEN wdetail.province = "��".
/*53*/  ELSE IF wdetail.province = "BAYTONG"            THEN wdetail.province = "��".
/*54*/  ELSE IF wdetail.province = "CHACHOENGSAO"       THEN wdetail.province = "��".
/*55*/  ELSE IF wdetail.province = "LOEI"               THEN wdetail.province = "��".
/*56*/  ELSE IF wdetail.province = "MAE HONG SON"       THEN wdetail.province = "��".
        ELSE IF wdetail.province = "MAEHONGSON"         THEN wdetail.province = "��".
/*57*/  ELSE IF wdetail.province = "MAHA SARAKHAM"      THEN wdetail.province = "��".
        ELSE IF wdetail.province = "MAHASARAKHAM"       THEN wdetail.province = "��".
/*58*/  ELSE IF wdetail.province = "MUKDAHAN"           THEN wdetail.province = "��".
/*59*/  ELSE IF wdetail.province = "NAN"                THEN wdetail.province = "��".
/*60*/  ELSE IF wdetail.province = "NARATHIWAT"         THEN wdetail.province = "��".
/*61*/  ELSE IF wdetail.province = "NONG BUA LAMPHU"    THEN wdetail.province = "��".
        ELSE IF wdetail.province = "NONGBUALAMPHU"      THEN wdetail.province = "��".
/*62*/  ELSE IF wdetail.province = "PHAYAO"             THEN wdetail.province = "��".  
/*63*/  ELSE IF wdetail.province = "PHANG NGA"          THEN wdetail.province = "��".
        ELSE IF wdetail.province = "PHANGNGA"           THEN wdetail.province = "��".
/*64*/  ELSE IF wdetail.province = "PHRAE"              THEN wdetail.province = "��".
/*65*/  ELSE IF wdetail.province = "PHICHIT"            THEN wdetail.province = "��".
/*66*/  ELSE IF wdetail.province = "PRACHUAP KHIRIKHAN" THEN wdetail.province = "��".
        ELSE IF wdetail.province = "PRACHUAPKHIRIKHAN"  THEN wdetail.province = "��".
/*67*/  ELSE IF wdetail.province = "RANONG"             THEN wdetail.province = "ù".
/*68*/  ELSE IF wdetail.province = "SAMUT PRAKAN"       THEN wdetail.province = "ʻ".
/*69*/  ELSE IF wdetail.province = "SAMUT SAKHON"       THEN wdetail.province = "ʤ". 
/*70*/  ELSE IF wdetail.province = "SAMUT SONGKHRAM"    THEN wdetail.province = "��".
        ELSE IF wdetail.province = "SAMUTPRAKAN"        THEN wdetail.province = "ʻ".  
        ELSE IF wdetail.province = "SAMUTSAKHON"        THEN wdetail.province = "ʤ".  
        ELSE IF wdetail.province = "SAMUTSONGKHRAM"     THEN wdetail.province = "��".  
/*71*/  ELSE IF wdetail.province = "SATUN"              THEN wdetail.province = "ʵ".
/*72*/  ELSE IF wdetail.province = "SUKHOTHAI"          THEN wdetail.province = "ʷ".
/*73*/  ELSE IF wdetail.province = "TAK"                THEN wdetail.province = "��".
/*74*/  ELSE IF wdetail.province = "TRAT"               THEN wdetail.province = "��".
/*75*/  ELSE IF wdetail.province = "UTHAI THANI"        THEN wdetail.province = "͹".
        ELSE IF wdetail.province = "UTHAITHANI"         THEN wdetail.province = "͹".
/*76*/  ELSE IF wdetail.province = "UTTARADIT"          THEN wdetail.province = "͵".
/*77*/  ELSE IF wdetail.province = "NAKHON PHANOM"      THEN wdetail.province = "��". 
        ELSE IF wdetail.province = "NAKHONPHANOM"       THEN wdetail.province = "��". 
/*78*/  ELSE IF wdetail.province = "BUENG KAN"          THEN wdetail.province = "��".
        ELSE IF wdetail.province = "BUENGKAN"           THEN wdetail.province = "��". 
        ELSE IF wdetail.province = "���"                THEN wdetail.province = "��".  /*a60-0095*/
        ELSE IF wdetail.province = "��ا෾�"           THEN wdetail.province = "��".  /*a67-0114*/
        ELSE DO:
           FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
                brstat.insure.compno = "999" AND 
                brstat.insure.FName  = TRIM(wdetail.province) NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL brstat.insure THEN   
                ASSIGN wdetail.province = Insure.LName.
       END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reciept72 C-Win 
PROCEDURE proc_reciept72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A60-0095      
------------------------------------------------------------------------------*/

 IF INDEX(wdetail.remark,"�����������") <> 0   THEN                           /* �������� */
    nv_72Reciept =  SUBSTR(wdetail.remark,R-INDEX(wdetail.remark,"/") + 1 ,R-Index(wdetail.remark,"/")).
 ELSE IF INDEX(wdetail.remark,"���������� �") <> 0 THEN                           /* �������� */
    nv_72Reciept =  SUBSTR(wdetail.remark,R-INDEX(wdetail.remark,"/") + 1 ,R-Index(wdetail.remark,"/")).
 ELSE IF INDEX(wdetail.remark,"�������� ���") <> 0 THEN                           /* �������� */
    nv_72Reciept =  SUBSTR(wdetail.remark,R-INDEX(wdetail.remark,"/") + 1 ,R-Index(wdetail.remark,"/")).
 ELSE IF INDEX(wdetail.remark,"�������� �� �") <> 0 THEN                           /* �������� */
    nv_72Reciept =  SUBSTR(wdetail.remark,R-INDEX(wdetail.remark,"/") + 1 ,R-Index(wdetail.remark,"/")).

 ELSE IF INDEX(wdetail.remark,"�����������") <> 0 THEN               /* �������� ����/�.�.�. */
    nv_72Reciept =  wdetail.receipt_name.
 
 ELSE IF INDEX(wdetail.remark,"����������������о") <> 0 THEN               /* �������� ����/�.�.�. */
    nv_72Reciept =  wdetail.receipt_name.
 ELSE IF INDEX(wdetail.remark,"����������������� �") <> 0 THEN               /* �������� ����/�.�.�. */
    nv_72Reciept =  wdetail.receipt_name.
 ELSE IF INDEX(wdetail.remark,"�������������� ��о") <> 0 THEN               /* �������� ����/�.�.�. */
    nv_72Reciept =  wdetail.receipt_name.
 ELSE IF INDEX(wdetail.remark,"�������� ��������о") <> 0 THEN               /* �������� ����/�.�.�. */
    nv_72Reciept =  wdetail.receipt_name.
 ELSE IF INDEX(wdetail.remark,"�������� ������ ��о") <> 0 THEN               /* �������� ����/�.�.�. */
    nv_72Reciept =  wdetail.receipt_name.
 ELSE IF INDEX(wdetail.remark,"�������� ��������� �") <> 0 THEN               /* �������� ����/�.�.�. */
    nv_72Reciept =  wdetail.receipt_name.
 
 ELSE IF INDEX(wdetail.remark,"��Сѹ���") <> 0 THEN                        /* ��Сѹ */
    nv_72Reciept =  wdetail.pol_title + " " + wdetail.pol_fname + " " + wdetail.pol_lname.    /*�����١���*/ 
 ELSE IF INDEX(wdetail.remark,"��Сѹ ���") <> 0 THEN                        /* ��Сѹ */
    nv_72Reciept =  wdetail.pol_title + " " + wdetail.pol_fname + " " + wdetail.pol_lname.    /*�����١���*/ 
 ELSE IF INDEX(wdetail.remark,"��Сѹ�� �") <> 0 THEN                        /* ��Сѹ */
    nv_72Reciept =  wdetail.pol_title + " " + wdetail.pol_fname + " " + wdetail.pol_lname.    /*�����١���*/ 

 ELSE IF INDEX(wdetail.remark,"��Сѹ��������о") <> 0 THEN                /* ��Сѹ */
    nv_72Reciept =  wdetail.pol_title + " " + wdetail.pol_fname + " " + wdetail.pol_lname.    /*�����١���*/  
 ELSE IF INDEX(wdetail.remark,"��Сѹ������ ��о") <> 0 THEN                /* ��Сѹ */
    nv_72Reciept =  wdetail.pol_title + " " + wdetail.pol_fname + " " + wdetail.pol_lname.    /*�����١���*/
 ELSE IF INDEX(wdetail.remark,"��Сѹ��������� �") <> 0 THEN                /* ��Сѹ */
    nv_72Reciept =  wdetail.pol_title + " " + wdetail.pol_fname + " " + wdetail.pol_lname.    /*�����١���*/  
 ELSE IF INDEX(wdetail.remark,"��Сѹ ��������о") <> 0 THEN                /* ��Сѹ */
    nv_72Reciept =  wdetail.pol_title + " " + wdetail.pol_fname + " " + wdetail.pol_lname.    /*�����١���*/ 
 ELSE IF INDEX(wdetail.remark,"��Сѹ ������ ��о") <> 0 THEN                /* ��Сѹ */
    nv_72Reciept =  wdetail.pol_title + " " + wdetail.pol_fname + " " + wdetail.pol_lname.    /*�����١���*/  
 ELSE IF INDEX(wdetail.remark,"�.��Сѹ ��������о") <> 0 THEN                /* ��Сѹ */
    nv_72Reciept =  wdetail.pol_title + " " + wdetail.pol_fname + " " + wdetail.pol_lname.    /*�����١���*/  
 
 ELSE IF INDEX(wdetail.remark,"�.�.�.�١��Ҩ���") <> 0 THEN                       /* �١��� */
    nv_72Reciept =  wdetail.pol_title + " " + wdetail.pol_fname + " " + wdetail.pol_lname.
 ELSE IF INDEX(wdetail.remark,"�.�.�. �١��Ҩ���") <> 0 THEN                       /* �١��� */
    nv_72Reciept =  wdetail.pol_title + " " + wdetail.pol_fname + " " + wdetail.pol_lname.
 ELSE IF INDEX(wdetail.remark,"�١��Ҩ��¾.�.�.") <> 0 THEN                       /* �١��� */
    nv_72Reciept =  wdetail.pol_title + " " + wdetail.pol_fname + " " + wdetail.pol_lname.

ELSE IF INDEX(wdetail.remark,"�١��Ҩ���������о") <> 0 THEN               /* �١��� ����/�.�.�. */
    nv_72Reciept =  wdetail.receipt_name.
ELSE IF INDEX(wdetail.remark,"�١��� ����������о") <> 0 THEN               /* �١��� ����/�.�.�. */
    nv_72Reciept =  wdetail.receipt_name.
ELSE IF INDEX(wdetail.remark,"�١��� ����������� �") <> 0 THEN               /* �١��� ����/�.�.�. */
    nv_72Reciept =  wdetail.receipt_name.
ELSE IF INDEX(wdetail.remark,"�١��� �������� ��о") <> 0 THEN               /* �١��� ����/�.�.�. */
    nv_72Reciept =  wdetail.receipt_name.

ELSE IF INDEX(wdetail.remark,"�������������о") <> 0 THEN                /* ����� ����/�.�.�.  */
    nv_72Reciept =  wdetail.receipt_name.
ELSE IF INDEX(wdetail.remark,"����� ��������о") <> 0 THEN                /* ����� ����/�.�.�.  */
    nv_72Reciept =  wdetail.receipt_name.
ELSE IF INDEX(wdetail.remark,"����������� ��о") <> 0 THEN                /* ����� ����/�.�.�.  */
    nv_72Reciept =  wdetail.receipt_name.
ELSE IF INDEX(wdetail.remark,"�������������� �") <> 0 THEN                /* ����� ����/�.�.�.  */
    nv_72Reciept =  wdetail.receipt_name.
ELSE IF INDEX(wdetail.remark,"��������") <> 0 THEN                /* ����� ����/�.�.�.  */
    nv_72Reciept =  wdetail.receipt_name.
ELSE IF INDEX(wdetail.remark,"��������.1+�ú") <> 0  THEN
    nv_72Reciept =  wdetail.receipt_name.
ELSE IF INDEX(wdetail.remark,"�����������+�ú") <> 0  THEN
    nv_72Reciept =  wdetail.receipt_name.
ELSE nv_72Reciept = " ".

/*- start A64-0406-*/
IF INDEX(nv_72Reciept,"ͻ�.") <> 0 THEN
    nv_72Reciept = SUBSTR(nv_72Reciept,1,INDEX(nv_72Reciept,"ͻ�.") - 1).

IF INDEX(wdetail.remark,"ͻ�.") <> 0 THEN DO:
    nv_caracc      = SUBSTR(wdetail.remark,INDEX(wdetail.remark,"ͻ�.")).
    wdetail.caracc = wdetail.caracc + " " + nv_caracc.
END.
/*- end A64-0406-*/
/* add by : A67-0087 */
IF wdetail.bdatedriv4 <>  ""  AND  wdetail.bdatedriv4  <> "00000000" THEN 
    ASSIGN nv_yy      = INT(SUBSTR(wdetail.bdatedriv4,1,4))
        nv_mm      = INT(SUBSTR(wdetail.bdatedriv4,5,2))
        nv_dd      = INT(SUBSTR(wdetail.bdatedriv4,7,2))
        nv_bdatdriv4  = DATE(nv_mm,nv_dd,nv_yy).
IF wdetail.bdatedriv5 <>  ""  AND  wdetail.bdatedriv5  <> "00000000" THEN 
    ASSIGN nv_yy      = INT(SUBSTR(wdetail.bdatedriv5,1,4))
      nv_mm      = INT(SUBSTR(wdetail.bdatedriv5,5,2))
      nv_dd      = INT(SUBSTR(wdetail.bdatedriv5,7,2))
      nv_bdatdriv5  = DATE(nv_mm,nv_dd,nv_yy).
/* end : A67-0087 */
 END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_redbook C-Win 
PROCEDURE proc_redbook :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF (deci(wdetail.price_ford)  <> 0 ) AND (wdetail.price_ford <> "")   THEN DO:
    FIND FIRST stat.insure USE-INDEX insure01 WHERE 
        stat.insure.compno = fi_model          AND
        stat.insure.fname  = wdetail.brand     AND
        deci(stat.insure.lname)  = DECI(deci(wdetail.price_ford)) NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.insure THEN  
        ASSIGN 
        wdetail.n_pack    = insure.text5 
        wdetail.redbook   = insure.text3 
        np_class = "" 
        np_brand = ""
        np_model = ""
        np_class =  insure.text5 
        np_brand =  Insure.text1    
        np_model =  insure.text2  . 
    ELSE ASSIGN wdetail.redbook = ""  .
    IF wdetail.redbook = ""    THEN DO:
        FIND FIRST stat.insure USE-INDEX insure01 WHERE 
            stat.insure.compno = fi_model             AND
            stat.insure.fname  = wdetail.brand        NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.insure THEN DO:  
            Find First stat.maktab_fil USE-INDEX maktab04    Where
                stat.maktab_fil.makdes   =   Insure.text1              And                  
                index(stat.maktab_fil.moddes,insure.text2) <> 0        And
                stat.maktab_fil.makyea   =    Integer(wdetail.yrmanu)  AND 
                stat.maktab_fil.engine   =    Integer(wdetail.power)   AND  
                stat.maktab_fil.sclass   =    trim(insure.text5)       AND
                /*stat.maktab_fil.seat   =    wdetail.n_seattisco      AND*/
                stat.maktab_fil.si       =    deci(wdetail.price_ford) No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then  ASSIGN  wdetail.redbook =  stat.maktab_fil.modcod .
            ELSE ASSIGN  wdetail.redbook = "".
        END.
    END.
END.
ELSE DO:
    FIND FIRST stat.insure USE-INDEX insure01 WHERE 
            stat.insure.compno = fi_model          AND
            stat.insure.fname  = wdetail.brand     NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.insure THEN  
            ASSIGN 
            wdetail.n_pack  = insure.text5 
            np_class = "" 
            np_brand = ""
            np_model = ""
            np_class =  insure.text5 
            np_brand =  Insure.text1    
            np_model =  insure.text2   
            wdetail.redbook = "".
END.
IF      wdetail.n_pack = "110" THEN ASSIGN wdetail.n_seattisco = 7 .   /*A57-0017*/
ELSE IF wdetail.n_pack = "320" THEN ASSIGN wdetail.n_seattisco = 3 .   /*A57-0017*/
ELSE IF wdetail.n_pack = "320" THEN ASSIGN wdetail.n_seattisco = 3 .   /*A57-0017*/
ELSE IF wdetail.n_pack = "320" THEN ASSIGN wdetail.n_seattisco = 3 .   /*A57-0017*/
ELSE IF wdetail.n_pack = "320" THEN ASSIGN wdetail.n_seattisco = 3 .   /*A57-0017*/
ELSE IF wdetail.n_pack = "210" THEN ASSIGN wdetail.n_seattisco = 12 .  /*A57-0017*/
ELSE IF wdetail.n_pack = "210" THEN ASSIGN wdetail.n_seattisco = 12 .  /*A57-0017*/
ELSE IF wdetail.n_pack = "210" THEN ASSIGN wdetail.n_seattisco = 12 .  /*A57-0017*/
ELSE IF wdetail.n_pack = "210" THEN ASSIGN wdetail.n_seattisco = 12 .  /*A57-0017*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_renew C-Win 
PROCEDURE proc_renew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF ra_poltyp = 1  THEN DO:      /* ������� */
    FIND FIRST stat.insure USE-INDEX insure01 WHERE 
        stat.insure.compno = fi_model          AND
        stat.insure.fname  = wdetail.brand     NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.insure THEN DO: 
        ASSIGN 
            wdetail.n_pack = trim(stat.insure.text5)       
            np_class = ""       np_brand = ""
            np_model = ""       np_class =  trim(stat.insure.text5)    
            np_brand =  Insure.text1    
            np_model =  insure.text2  .
        IF      wdetail.n_pack = "110" THEN ASSIGN wdetail.n_seattisco = 7 . 
        ELSE IF wdetail.n_pack = "320" THEN ASSIGN wdetail.n_seattisco = 3 . 
        ELSE IF wdetail.n_pack = "210" THEN ASSIGN wdetail.n_seattisco = 12 .
    END.
    ELSE DO: 
        ASSIGN  n_brand = IF INDEX(wdetail.brand," ") <> 0 THEN trim(SUBSTR(wdetail.brand,1,INDEX(wdetail.brand," ") - 1 )) 
                          ELSE trim(wdetail.brand).
        IF n_brand = "ISUZU" THEN
            ASSIGN wdetail.n_seattisco = IF wdetail.n_pack = "110" THEN 7 ELSE IF wdetail.n_pack = "210" THEN 5 ELSE 3.  
        ELSE DO: 
            IF      wdetail.n_pack = "110" THEN ASSIGN wdetail.n_seattisco = 7  .   
            ELSE IF wdetail.n_pack = "320" THEN ASSIGN wdetail.n_seattisco = 3  .   
            ELSE IF wdetail.n_pack = "210" THEN ASSIGN wdetail.n_seattisco = 12 .  
            ELSE ASSIGN wdetail.n_seattisco = 0 .   
        END.
    END.
    ASSIGN  wdetail.n_covcod    = ""
    wdetail.n_typpol    = "RENEW"              
    wdetail.nproducer   = fi_producertisco    
    wdetail.nagent      = fi_agenttisco     
    wdetail.n_branch    = "M"
    wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"*","")
    wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"-","")
    wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"/","")
    wdetail.prev_pol    = REPLACE(wdetail.prev_pol,"\","")
    wdetail.prev_pol    = REPLACE(wdetail.prev_pol,".",""). 
    RUN proc_new_chkcover . /*A67-0114*/
    /* a67-0114..
    IF nv_premt3 = 0 THEN DO:            
        ASSIGN wdetail.n_covcod  = "T".  
    END.
    ELSE IF nv_premt3 = 7500.70 OR nv_premt3 = 8500.08 OR nv_premt3 = 9500.53  THEN DO:
        ASSIGN wdetail.n_covcod  = "2.2"
            wdetail.n_pack       = "C" +  trim(wdetail.n_pack).
    END.
    ELSE IF nv_premt3 = 6300 OR nv_premt3 = 7300 OR nv_premt3 = 7500 OR nv_premt3 = 8300  THEN DO:
        ASSIGN  wdetail.n_covcod = "3.2"
            wdetail.n_pack       = "C" +  trim(wdetail.n_pack).
    END.
    ELSE IF ( nv_premt3 <= 10000 ) AND (nv_premt3 > 2500 )  THEN DO: 
        ASSIGN wdetail.n_covcod  = "2"
            wdetail.n_pack       = "Y" +  trim(wdetail.n_pack).
    END.
    ELSE IF (nv_premt3 < 2500 )THEN DO:
        ASSIGN  wdetail.n_covcod = "3"
            wdetail.n_pack       = "R" +  trim(wdetail.n_pack).
        IF wdetail.n_pack = "R110" THEN ASSIGN wdetail.n_seattisco = 7. 
    END.
    ELSE 
    ..end A67-0114...*/
    IF  nv_premt3  >  10000   THEN DO: 
        ASSIGN  wdetail.n_covcod = "1".
        IF (wdetail.garage = "0")  THEN DO:
            IF  index(wdetail.brand,"Ford") <> 0 AND 
                index(wdetail.remark,"FORD ENSURE") <> 0 OR    
                INDEX(wdetail.remark,"FD")          <> 0 OR    
                SUBSTRING(wdetail.prev_pol,7,1)     = "F" THEN DO: 
                ASSIGN wdetail.n_pack = "O" +  trim(wdetail.n_pack).
                IF wdetail.n_pack = "O320" THEN ASSIGN wdetail.n_seattisco = 5.
            END.
            ELSE IF  index(wdetail.brand,"MAZDA")    <> 0   AND 
                     /*SUBSTRING(wdetail.prev_pol,7,2) = "MI" OR *//*A62-0386*/
                     index(wdetail.remark,"MPI")     <> 0   THEN DO:  
                     ASSIGN wdetail.n_pack = "M" +  trim(wdetail.n_pack).
                     IF wdetail.n_pack = "M110" THEN ASSIGN wdetail.n_seattisco = 7.
                     IF wdetail.n_pack = "M320" THEN ASSIGN wdetail.n_seattisco = 5.
            END.
            ELSE DO:
                FIND LAST WComp WHERE wcomp.cartyp   = "renew"    AND
                                      wcomp.brand    = "garage"   NO-LOCK  NO-ERROR NO-WAIT.
                IF AVAIL wcomp THEN  ASSIGN wdetail.n_pack = trim(wcomp.package) + trim(wdetail.n_pack).
            END.
        END.
        ELSE DO:    /*�������*/
            FIND LAST WComp WHERE wcomp.cartyp   = "renew" AND
                                  wcomp.brand    = ""      NO-LOCK  NO-ERROR NO-WAIT.
            IF AVAIL wcomp THEN  ASSIGN wdetail.n_pack = trim(wcomp.package) + trim(wdetail.n_pack) .
        END.
    END.
    /* FORD */
    IF  index(wdetail.brand,"FORD")  <> 0 THEN DO:  /* Ford       */
        ASSIGN wdetail.nproducer = fi_producerford  /* "B3M0033"  */ 
               wdetail.nagent    = fi_agentford .   /* "B3M0035"  */ 

        IF ((YEAR(TODAY) - INT(wdetail.yrmanu) <= 7 )  AND (nv_premt1 = 8300.00  OR nv_premt1 = 9500.00  OR 
            nv_premt1 = 10400.00 OR nv_premt1 = 12300.00 OR nv_premt1 = 14100.00 )) OR 
            (index(wdetail.remark,"FE2+") <> 0 AND TRIM(wdetail.garage) = "0" ) /*A67-0114*/ THEN DO:
            ASSIGN 
               /* wdetail.n_covcod = "" wdetail.garage = "" wdetail.nproducer = ""  wdetail.remark = "" 
                wdetail.n_pack   = "" wdetail.bi     = "" wdetail.pa        = ""  wdetail.pd     = ""*/
                wdetail.n_covcod  = "2.2"
                wdetail.garage    = "0"
                /*wdetail.remark    = "FE2+*/ /*A67-0114*/
                wdetail.remark    = "FE2+ (������ͧ��Сѹ����á��� 20,000 �ҷ, ������ͧ��¹�ӷ��� ����ع��Сѹ)" /*A67-0114*/
                wdetail.bi        = "500000"
                wdetail.pa        = "10000000"
                wdetail.pd        = "2500000".
            IF      wdetail.n_seattisco = 7 THEN wdetail.n_pack = "U110".
            ELSE IF wdetail.n_seattisco = 3 THEN ASSIGN wdetail.n_pack = "U320"      wdetail.n_seattisco = 5.
        END.
        /* A67-0114 */
        IF INDEX(wdetail.remark,"���ͻ���Ե�") <> 0  THEN DO:
            ASSIGN wdetail.nproducer = "B3MLTIS102"
                   wdetail.nagent    = "B3MLTIS100" .
        END.
        ELSE DO:
             Find LAST sicuw.uwm100 Use-index uwm10001       Where
                 sicuw.uwm100.policy = trim(wdetail.prev_pol) AND
                 sicuw.uwm100.poltyp = "V70"  No-lock no-error no-wait.
             If avail sicuw.uwm100 Then DO:
                 IF index(sicuw.uwm100.name1,"��͵�� �ù��-��-����") <> 0 THEN DO:
                     ASSIGN wdetail.n_branch  =  "ML" 
                            wdetail.nproducer = "B3MLTIS102"
                            wdetail.nagent    = "B3MLTIS100".
                 END.
             END.          
        END.
        /* end A67-0114 */
    END.
    ELSE IF index(wdetail.bran,"Nissan") <> 0 THEN DO:   /* Nissan */
        IF INDEX(wdetail.prev_insur,"SAFETY INSURANCE") <> 0 THEN DO:
            ASSIGN                 
                wdetail.nproducer = fi_producernis    /*"B3DM000002" */
                wdetail.nagent    = fi_agentnis     . /*"B3M0035"    */

            FIND LAST sicuw.uwm301 Use-index uwm30121 Where 
                sicuw.uwm301.cha_no      = trim(wdetail.chassis)  AND 
                substr(sicuw.uwm301.policy,3,2) = "70"  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm301 THEN DO:
                ASSIGN wdetail.nproducer =  fi_producernis     /*"B3DM000002" */ 
                       wdetail.nagent    =  fi_agentnis .      /*"B3M0035"    */ 

                IF trim(wdetail.polold) = "" THEN wdetail.polold = sicuw.uwm301.policy .
                Find LAST sicuw.uwm100 Use-index uwm10001       Where
                    sicuw.uwm100.policy = sicuw.uwm301.policy   and
                    sicuw.uwm100.rencnt = sicuw.uwm301.rencnt   and 
                    sicuw.uwm100.poltyp = "V70"  No-lock no-error no-wait.
                If avail sicuw.uwm100 Then DO:
                    ASSIGN wdetail.n_branch  =  sicuw.uwm100.branch .
                           /*wdetail.n_branch  =  IF sicuw.uwm100.acno1 = "B3W0020" OR sicuw.uwm100.acno1 = "B3W0016" THEN "W" ELSE "MF" */ /*A67-0114*/
                    IF sicuw.uwm100.acno1 = "B3W0020" OR sicuw.uwm100.acno1 = "B3W0016" THEN ASSIGN wdetail.n_branch  =  "W" .              /*A67-0114*/
                    IF sicuw.uwm100.acno1 = "B3DM000003" THEN DO:
                      IF (sicuw.uwm100.branch = "W") OR (sicuw.uwm100.branch = "MF") THEN DO:  /*A67-0114*/
                        ASSIGN wdetail.nproducer =  fi_producernis    /*"B3DM000002" */  
                               wdetail.nagent    =  fi_agentnis .     /*"B3M0035"    */  
                      END.
                      /* add : A67-0114*/
                      ELSE DO:
                        ASSIGN wdetail.nproducer =  fi_producernis2   /*"B3DM000003" */
                               wdetail.nagent    =  fi_agentnis2 .    /*"B3M0035"    */
                      END. /* end A67-0114*/
                    END.
                    ELSE IF sicuw.uwm100.branch <> "W" AND sicuw.uwm100.branch <> "MF" THEN DO:
                        /* add : A67-0114 */
                        IF index(wdetail.remark,"���ͻ���Ե�") = 0 AND index(wdetail.agent,"HI WAY") = 0 THEN DO:
                            ASSIGN wdetail.nproducer = fi_producernis2  /*"B3DM000003"*/
                                   wdetail.nagent    = fi_agentnis2 .   /*"B3M0035"   */
                        END.
                        ELSE IF index(wdetail.remark,"���ͻ���Ե�") <> 0 AND index(wdetail.agent,"HI WAY") <> 0  THEN DO:
                            ASSIGN wdetail.nproducer = "B3MLTIS102"  
                                   wdetail.nagent    = "B3MLTIS300" .
                        END.
                        ELSE IF index(wdetail.remark,"���ͻ���Ե�") <> 0 THEN DO:
                            ASSIGN wdetail.nproducer = "B3MLTIS102"  
                                   wdetail.nagent    = "B3MLTIS100" .
                        END.
                        ELSE IF index(wdetail.agent,"HI WAY") <> 0 THEN DO:
                            ASSIGN wdetail.nproducer = "B3DM000003"  
                                   wdetail.nagent    = "B3M0054" .
                        END.
                        /* end A67-0114 */
                        /* comment by:A67-0114..
                        /*IF  INDEX(wdetail.ben_name,"����к� 8.3") <> 0 THEN */ /* A67-0114*/
                        ELSE IF  (INDEX(wdetail.ben_name,"����к� 8.3") <> 0) OR (INDEX(wdetail.ben_name,"���Դ 8.3") <> 0) THEN DO:  /* A67-0114*/
                            ASSIGN wdetail.nproducer =  fi_producertisco    /* "B3MLTIS101" */
                                   wdetail.nagent    =  fi_agenttisco  .    /* "B3MLTIS100" */
                        END.
                        /*ELSE IF INDEX(wdetail.ben_name,"�к� 8.3") <> 0   THEN*/ /* A67-0114*/
                        ELSE IF INDEX(wdetail.ben_name,"�к� 8.3") <> 0 OR (INDEX(wdetail.ben_name,"�Դ 8.3") <> 0)  THEN DO: /* A67-0114*/
                            ASSIGN                  
                            wdetail.nproducer =  fi_producer83     /* "B3MLTIS104"  */ /*A65-0361*/
                            wdetail.nagent    =  fi_agenttisco83.  /* "B3MLTIS100". */ /*A65-0361*/
                        END.
                        ..end A67-0114 */
                    END.
                END.
            END.
            ELSE ASSIGN wdetail.n_branch  = "M" /* A67-0114*/
                        wdetail.nproducer = fi_producernis2  /*"B3DM000003"*/
                        wdetail.nagent    = fi_agentnis2 .   /*"B3M0035"   */
        END.                                                 
        ELSE ASSIGN wdetail.n_branch  = "M" /* A67-0114*/
                    wdetail.nproducer = fi_producernis2      /*"B3DM000003"*/  
                    wdetail.nagent    = fi_agentnis2 .       /*"B3M0035"   */  
    END.
    ELSE DO:
        RUN proc_renew_producer.
    END.
    IF wdetail.prev_pol <> "" THEN DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy = trim(wdetail.prev_pol) NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN ASSIGN wdetail.n_branch  =  sicuw.uwm100.branch.
    END.
    /* Add by : A67-0114 */
    IF wdetail.bev = "Y" THEN DO:
       FIND LAST wcomp WHERE wcomp.brand = trim(n_brand) NO-LOCK NO-ERROR .
          IF AVAIL wcomp THEN
              ASSIGN wdetail.n_pack   = wcomp.package + substr(wdetail.n_pack,2,LENGTH(wdetail.n_pack))
                 wdetail.bi  = TRIM(wcomp.bi)
                 wdetail.pa  = TRIM(wcomp.pa)
                 wdetail.pd  = TRIM(wcomp.pd).
    END.
    /* end : A67-0114 */
     
    IF INDEX(wdetail.n_pack,"O") <> 0  THEN DO:
        FIND LAST WComp WHERE trim(wcomp.package) = "O" NO-LOCK  NO-ERROR NO-WAIT.
            IF AVAIL wcomp THEN DO:
              ASSIGN wdetail.bi   = TRIM(wcomp.bi)
                     wdetail.pa   = TRIM(wcomp.pa)
                     wdetail.pd   = TRIM(wcomp.pd).
            END.
    END. 
    
   IF INDEX(wdetail.n_pack,"F") <> 0 THEN ASSIGN wdetail.n_pack = TRIM(REPLACE(wdetail.n_pack,"F","T")). /* A67-0114*/ 

   IF      index(wdetail.brand,"WHEELS") <> 0 THEN ASSIGN wdetail.n_pack = trim(wdetail.n_pack) + "320".  
   ELSE IF index(wdetail.brand,"TRUCK")  <> 0 THEN ASSIGN wdetail.n_pack = trim(wdetail.n_pack) + "420". 

   IF LENGTH(wdetail.n_pack) < 4   THEN ASSIGN wdetail.n_pack = "T" + TRIM(wdetail.n_pack) . /*A67-0114*/

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_renew_producer C-Win 
PROCEDURE proc_renew_producer :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    IF  index(wdetail.brand,"HAVAL") <> 0  OR (index(wdetail.brand,"ORA") <> 0 AND wdetail.carbrand = "ORA" ) OR index(wdetail.brand,"TANK") <> 0 THEN DO: /*A67-0087*/
        ASSIGN 
            wdetail.nproducer = fi_producerhaval   /*A65-0361*/
            wdetail.nagent    = fi_agenthaval   .  /*A65-0361*/
        /* A67-0087*/
        IF INDEX(wdetail.prev_insur,"SAFETY INSURANCE") <> 0 THEN DO:
           FIND LAST sicuw.uwm301 Use-index uwm30121 Where 
                sicuw.uwm301.cha_no      = trim(wdetail.chassis)  AND 
                substr(sicuw.uwm301.policy,3,2) = "70"  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm301 THEN DO:
                IF trim(wdetail.polold) = "" THEN wdetail.polold = sicuw.uwm301.policy .
                Find LAST sicuw.uwm100 Use-index uwm10001       Where
                    sicuw.uwm100.policy = sicuw.uwm301.policy   and
                    sicuw.uwm100.rencnt = sicuw.uwm301.rencnt   and 
                    sicuw.uwm100.poltyp = "V70"  No-lock no-error no-wait.
                If avail sicuw.uwm100 Then DO:
                    IF sicuw.uwm100.acno1 = "B3DM000005" THEN DO:
                       ASSIGN wdetail.n_branch  =  sicuw.uwm100.branch 
                              wdetail.n_pack    = IF wdetail.bev = "Y" THEN "TE12" ELSE "T120"
                              wdetail.nproducer =  "B3DM000005" 
                              wdetail.nagent    =  "B3M0035" .
                    END.
                END.
            END.
        END.
        ELSE IF INDEX(wdetail.remark,"Demo") <> 0 OR  INDEX(wdetail.remark,"���ͧ�Ѻ") <> 0 OR INDEX(wdetail.remark,"ö������������") <> 0 OR
           INDEX(wdetail.remark,"�����ҧ����") <> 0  OR INDEX(wdetail.remark,"TEST DRIVE") <> 0 THEN DO:
            ASSIGN wdetail.n_branch  = ""
                   wdetail.n_pack    = IF wdetail.bev = "Y" THEN "TE12" ELSE "T120"
                   wdetail.nproducer = "B3DM000005"  
                   wdetail.nagent    = "B3M0035" .  
        END.
        /* end : A67-0087 */
    END.
    ELSE IF  index(wdetail.brand,"Hyundai") <> 0 THEN DO:
        ASSIGN                  
           wdetail.nproducer =  fi_proreHyundai      /*"B3MF000005"*/ 
           wdetail.nagent    =  fi_agentreHyundai  . /*"B3MF000005"*/ 
        /* add by : A67-0114 */
        IF INDEX(wdetail.prev_insur,"SAFETY INSURANCE") <> 0 THEN DO:
            FIND LAST sicuw.uwm301 Use-index uwm30121 Where 
                sicuw.uwm301.cha_no      = trim(wdetail.chassis)  AND 
                substr(sicuw.uwm301.policy,3,2) = "70"  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm301 THEN DO:
                ASSIGN wdetail.nproducer =  "B3MF000007" 
                       wdetail.nagent    =  "B3MF000008" .

                IF trim(wdetail.polold) = "" THEN wdetail.polold = sicuw.uwm301.policy .
                Find LAST sicuw.uwm100 Use-index uwm10001       Where
                    sicuw.uwm100.policy = sicuw.uwm301.policy   and
                    sicuw.uwm100.rencnt = sicuw.uwm301.rencnt   and 
                    sicuw.uwm100.poltyp = "V70"  No-lock no-error no-wait.
                If avail sicuw.uwm100 Then DO:
                    ASSIGN wdetail.n_branch  =  sicuw.uwm100.branch .
                    IF sicuw.uwm100.branch = "M4" AND index(sicuw.uwm100.name1,"�ع� �����Ե��") <> 0 THEN ASSIGN wdetail.n_branch = "MF" .
                END.
                IF sicuw.uwm100.branch = "ML" THEN DO:
                    IF (INDEX(wdetail.ben_name,"����к� 8.3") <> 0 ) OR (INDEX(wdetail.ben_name,"���Դ 8.3") <> 0 ) THEN 
                        ASSIGN 
                        wdetail.nproducer =  fi_producertisco    /* "B3MLTIS101" */
                        wdetail.nagent    =  fi_agenttisco  .    /* "B3MLTIS100" */
                    ELSE IF (INDEX(wdetail.ben_name,"�к� 8.3") <> 0 ) OR (INDEX(wdetail.ben_name,"�Դ 8.3") <> 0 )   THEN 
                        ASSIGN                  
                        wdetail.nproducer =  fi_producer83     /* "B3MLTIS104"  */ /*A65-0361*/
                        wdetail.nagent    =  fi_agenttisco83.  /* "B3MLTIS100". */ /*A65-0361*/
                END.
            END.
            ELSE DO:
               IF index(wdetail.agent,"HI-WAY") <> 0  THEN DO:
                 IF wdetail.n_covcod = "2.2"  THEN DO:
                     ASSIGN  wdetail.n_branch = "ML" 
                        wdetail.nproducer = "B3MLTIS103"
                        wdetail.nagent    = "B3MLTIS300" . 
                 END.
                 ELSE DO:
                     ASSIGN  wdetail.n_branch = "ML" 
                        wdetail.nproducer = "B3MLTIS301"
                        wdetail.nagent    = "B3MLTIS300" . 
                 END.
               END. /*Kridtiya i. A67-0036*/
               ELSE DO: 
                 ASSIGN wdetail.n_branch  = "MF"
                        wdetail.nproducer =  "B3MF000008" 
                        wdetail.nagent    =  "B3MF000008" .
               END.
            END.
        END.
        ELSE DO:
          IF index(wdetail.agent,"HI-WAY") <> 0  THEN DO:
            IF wdetail.n_covcod = "2.2"  THEN DO:
                ASSIGN  wdetail.n_branch = "ML" 
                   wdetail.nproducer = "B3MLTIS103"
                   wdetail.nagent    = "B3MLTIS300" . 
            END.
            ELSE DO:
                ASSIGN  wdetail.n_branch = "ML" 
                   wdetail.nproducer = "B3MLTIS301"
                   wdetail.nagent    = "B3MLTIS300" . 
            END.
          END. /*Kridtiya i. A67-0036*/
          ELSE DO: 
            ASSIGN wdetail.n_branch  = "MF"
                  wdetail.nproducer =  "B3MF000008" 
                  wdetail.nagent    =  "B3MF000008" .
          END.
        END.
    END.
    ELSE IF index(wdetail.agent,"HI-WAY") <> 0  THEN DO: 
        IF  wdetail.n_covcod = "1" THEN DO: 
            IF  index(wdetail.brand,"WHEELS") <> 0 OR index(wdetail.brand,"TRAILER") <> 0  OR 
                index(wdetail.brand,"TRUCK")  <> 0 OR index(wdetail.brand,"SEMI")    <> 0  THEN
                ASSIGN wdetail.n_branch = "ML"
                wdetail.nproducer = fi_producerHi2  /*fi_producerHi2     = "B3MLTIS302"*/
                wdetail.nagent    = fi_agenthi2 .   /*fi_agenthi2        = "B3MLTIS300"*/
            ELSE ASSIGN wdetail.n_branch = "ML"
                wdetail.nproducer = fi_producerHi1  /*fi_producerHi1     = "B3MLTIS301" */
                wdetail.nagent    = fi_agenthi1 .   /*fi_agenthi1        = "B3MLTIS300" */
        END.
        ELSE ASSIGN wdetail.n_branch = "ML"
                wdetail.nproducer = "B3MLTIS103" 
                wdetail.nagent    = "B3MLTIS300" .
    END.
    ELSE IF index(wdetail.brand,"WHEELS") <> 0 OR index(wdetail.brand,"TRAILER") <> 0  OR 
            index(wdetail.brand,"TRUCK")  <> 0 OR index(wdetail.brand,"SEMI")    <> 0  THEN DO:
                ASSIGN 
                wdetail.nproducer = fi_producerbig      /* "B3MLTIS105"  */ 
                wdetail.nagent    = fi_agentbig  .      /* "B3MLTIS100". */ 
    END.
    ELSE IF INDEX(wdetail.prev_insur,"SAFETY INSURANCE") <> 0 THEN DO:  /* ������� STY */
        IF  INDEX(wdetail.not_office,"CIR(RETAIL)") <> 0 OR INDEX(wdetail.not_office,"CIR(FLEET)") <> 0 OR 
            INDEX(wdetail.remark,"L/CI/CODE")       <> 0 OR INDEX(wdetail.remark,"C CI") <> 0           OR 
            INDEX(wdetail.remark,"L/CI")            <> 0 OR INDEX(wdetail.remark,"J CI") <> 0           OR 
            INDEX(wdetail.remark,"P CI")            <> 0 OR INDEX(wdetail.remark,"L/CI") <> 0    OR 
            index(wdetail.remark,"���ͻ���Ե�") <> 0 THEN DO: /* A67-0114*/
            ASSIGN wdetail.nproducer =   fi_producercir     /*= "B3MLTIS102"  */
                   wdetail.nagent    =   fi_agenttiscocir .  /*= "B3MLTIS100"  */
        END.
        ELSE IF INDEX(wdetail.ben_name,"����к� 8.3") <> 0 OR INDEX(wdetail.ben_name,"���Դ 8.3") <> 0 THEN DO:
            ASSIGN 
            wdetail.nproducer =  fi_producertisco    /* "B3MLTIS101" */
            wdetail.nagent    =  fi_agenttisco  .    /* "B3MLTIS100" */
        END.
        ELSE IF INDEX(wdetail.ben_name,"�к� 8.3") <> 0  OR  INDEX(wdetail.ben_name,"�Դ 8.3") <> 0 THEN DO:
            ASSIGN                  
            wdetail.nproducer =  fi_producer83     /* "B3MLTIS104"  */ /*A65-0361*/
            wdetail.nagent    =  fi_agenttisco83.  /* "B3MLTIS100". */ /*A65-0361*/
        END.
    END.
    ELSE DO:  /* �ҹ�͹����  */
        IF index(wdetail.brand,"WHEELS") <> 0 OR index(wdetail.brand,"TRAILER") <> 0  OR 
           index(wdetail.brand,"TRUCK")  <> 0 OR index(wdetail.brand,"SEMI")    <> 0  THEN DO:
            ASSIGN 
            wdetail.nproducer = fi_producerbig      /* "B3MLTIS105"  */ 
            wdetail.nagent    = fi_agentbig  .      /* "B3MLTIS100". */ 
        END.
        ELSE IF  wdetail.n_covcod = "1" THEN DO:
            IF  INDEX(wdetail.not_office,"CIR(RETAIL)") <> 0 OR INDEX(wdetail.not_office,"CIR(FLEET)") <> 0 OR 
                INDEX(wdetail.remark,"L/CI/CODE")       <> 0 OR INDEX(wdetail.remark,"C CI") <> 0           OR 
                INDEX(wdetail.remark,"L/CI")            <> 0 OR INDEX(wdetail.remark,"J CI") <> 0           OR 
                INDEX(wdetail.remark,"P CI")            <> 0 OR INDEX(wdetail.remark,"L/CI") <> 0 OR
                INDEX(wdetail.remark,"���ͻ���Ե�") <> 0 THEN DO:
                /*IF   index(wdetail.brand,"WHEELS") <> 0 OR index(wdetail.brand,"TRAILER") <> 0  OR 
                     index(wdetail.brand,"TRUCK")  <> 0 OR index(wdetail.brand,"SEMI")    <> 0  THEN
                     ASSIGN 
                     wdetail.nproducer = fi_producerbig      /* "B3MLTIS105"  */ 
                     wdetail.nagent    = fi_agentbig  .      /* "B3MLTIS100". */ 
                ELSE*/
                 ASSIGN              
                     wdetail.nproducer = fi_producercir      /*= "B3MLTIS102"  */
                     wdetail.nagent    = fi_agenttiscocir .  /*= "B3MLTIS100"  */
            END.
            ELSE IF (INDEX(wdetail.ben_name,"����к� 8.3") <> 0 ) OR (INDEX(wdetail.ben_name,"���Դ 8.3") <> 0 ) THEN DO:
                ASSIGN 
                wdetail.nproducer =  fi_producertisco    /* "B3MLTIS101" */
                wdetail.nagent    =  fi_agenttisco  .    /* "B3MLTIS100" */
            END.
            ELSE IF (INDEX(wdetail.ben_name,"�к� 8.3") <> 0 ) OR (INDEX(wdetail.ben_name,"�Դ 8.3") <> 0 ) THEN DO:
                ASSIGN                  
                wdetail.nproducer =  fi_producer83     /* "B3MLTIS104"  */ /*A65-0361*/
                wdetail.nagent    =  fi_agenttisco83.  /* "B3MLTIS100". */ /*A65-0361*/
            END.
        END.
        ELSE  IF (wdetail.n_covcod <> "1") THEN DO:  /* ����� �.1 �ҹ�͹���� */
            /* comment by : A67-0114..
            IF INDEX(wdetail.not_office,"CIR(RETAIL)") <> 0 OR INDEX(wdetail.not_office,"CIR(FLEET)") <> 0 OR
                INDEX(wdetail.remark,"L/CI/CODE")      <> 0 OR INDEX(wdetail.remark,"C CI")           <> 0 OR 
                INDEX(wdetail.remark,"L/CI")           <> 0 OR INDEX(wdetail.remark,"J CI") <> 0           OR 
                INDEX(wdetail.remark,"P CI")           <> 0 OR INDEX(wdetail.remark,"L/CI") <> 0  /* A65-0035*/
                THEN DO:
                ASSIGN wdetail.n_branch  = "ML"
                    wdetail.nproducer = fi_pdtkcode    /* fi_producercir   = "B3MLTIS103"  */
                    wdetail.nagent    = fi_agtkcode  . /* fi_agenttiscocir = "B3MLTIS100"  */
               
            END.
            ELSE ASSIGN  wdetail.n_branch  = "ML"
               wdetail.nproducer = fi_pdbkcode   /* B3MLTIS103" */  /*A63-00472*/  
               wdetail.nagent    = fi_agbkcode . /* B3MLTIS100".*/  /*A63-00472*/ 
            ..end A67-0114...*/
            IF INDEX(wdetail.agent,"HI WAY") <> 0 THEN DO:
               ASSIGN  wdetail.n_branch  = "ML"
               wdetail.nproducer = "B3MLTIS103"
               wdetail.nagent    = "B3MLTIS300".
            END.
            ELSE DO:
                ASSIGN  wdetail.n_branch  = "ML"
               wdetail.nproducer = "B3MLTIS103"
               wdetail.nagent    = "B3MLTIS100".
            END.
     
           FIND LAST wcomp WHERE wcomp.cover = wdetail.n_covcod NO-LOCK NO-ERROR.
           IF AVAIL wcomp THEN DO:
               ASSIGN wdetail.bi       = TRIM(wcomp.bi)
                      wdetail.pa       = TRIM(wcomp.pa)
                      wdetail.pd       = TRIM(wcomp.pd).
           END.
           ELSE DO:
               FIND LAST WComp WHERE  wcomp.cover = "2-3" NO-LOCK  NO-ERROR NO-WAIT.
               IF AVAIL wcomp THEN 
                   ASSIGN wdetail.bi       = TRIM(wcomp.bi)
                          wdetail.pa       = TRIM(wcomp.pa)
                          wdetail.pd       = TRIM(wcomp.pd).
           END.
           IF index(wdetail.bran,"Nissan") = 0 AND  index(wdetail.bran,"Ford") = 0 THEN  /*A65-0361*/
               ASSIGN 
                      wdetail.nproducer =  "B3MLTIS103"   /*A65-0361*/
                      wdetail.nagent    =  "B3MLTIS100".  /*A65-0361*/

        END.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile C-Win 
PROCEDURE Pro_createfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN fi_outfile  =  Trim(fi_outfile) + ".slk"  .
ASSIGN  nv_cnt  =  0
        nv_row  =  1.
OUTPUT STREAM ns2 TO VALUE(fi_outfile).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "����ѷ�Թ�ع ����� �ӡѴ (��Ҫ�) ."  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' nv_export  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "Processing Office"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "CMR  code"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "Insur.comp"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "notify number"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "Car year"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "engine"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "chassis"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "weight"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "power"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "color"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "licence no"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "Garage"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "fleet disc."               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "ncb disc."                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "other disc."               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "vehuse"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "Comdat"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "�ع��Сѹ"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "�������˹�ҷ���駻�Сѹ" '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "�������˹�ҷ���Сѹ "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "�ѹ����駻�Сѹ  "        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "�����駻�Сѹ "           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "�����駧ҹ"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "prem.1"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "comp.prm"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "sticker"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "brand"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "address1"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "address2"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "title name"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "first name"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "last name"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "beneficiary"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "remark."                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' "account no."               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' "client No."                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' "expiry date "              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' "insurance amt."            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' "province"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' "receipt name"              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' "agent code"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' "����ѷ��Сѹ������"       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' "old policy"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' "deduct disc."              '"' SKIP.   /*Add kridtiya i. A54-0062 ...*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' "�������˹�ҵ��ҧ70"        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' "�������˹�ҵ��ҧ70�ó�����¡�������" '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"' "�Ӻ�"                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"' "�����"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"' "�ѧ��Ѵ"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"' "������ɳ���"              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"' "�������˹�ҵ��ҧ72"        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"' "�������˹�ҵ��ҧ72�ó�����¡�������" '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"' "�Ӻ�"                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"' "�����"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"' "�ѧ��Ѵ"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"' "������ɳ���"              '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"' "Applicationtype"           '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"' "Applicationcode"           '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"' "Blank"                     '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"' "package"                   '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"' "Seat/�ӹǹ�����"         '"' SKIP.   /*add A57-0017 */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"' "TPBI/Person"               '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"' "TPBI/Per Acciden"          '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"' "TPPD/Per Acciden"          '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"' "covcod"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"' "Producer"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"' "Agent"                     '"' SKIP.  /*Add kridtiya i. A54-0062 ...*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"' "Branch"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"' "NEW/RENEW"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"' "Redbook"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"' "Price_Ford"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"' "Year"                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"' "Brand_Model"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x74;K"  '"' "Receipt ID. Number "         '"' SKIP.             /*  60  Receipt ID. Number   */                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x75;K"  '"' "Receipt Branch NAME"         '"' SKIP.             /*  61  Receipt Branch NAME  */                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x76;K"  '"' "Receipt Compulsory ID. Number"  '"' SKIP.  /*  62  Receipt Compulsory ID. Number  */  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x77;K"  '"' "Receipt Compulsory Branch Name" '"' SKIP.  /*  63  Receipt Compulsory Branch Name */  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"  '"' "�ѹ��������ͧ �ú. "            '"' SKIP.   /*64*/   /*Effective Date Accidential*/ /* A59-0178*/             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K"  '"' "�ѹ�������ش����������ͧ �ú."  '"' SKIP.   /*65*/   /*Expiry Date Accidential*/    /* A59-0178*/                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K"  '"' "�ع�٭�����������"              '"' SKIP.   /*66*/   /*Coverage Amount Theft*/      /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K"  '"' "����ö"                          '"' SKIP.   /*67*/   /*Car code*/                   /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K"  '"' "�ѡɳС����ö"                  '"' SKIP.   /*68*/   /*Per Used*/                   /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K"  '"' "�ӴѺ���Ѻ��褹��� 1"           '"' SKIP.   /*69*/   /*Driver Seq1*/                /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K"  '"' "���ͼ��Ѻ��褹��� 1"            '"' SKIP.   /*70*/   /*Driver Name1*/               /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K"  '"' "�ѹ��͹���Դ���Ѻ��褹��� 1"  '"' SKIP.   /*71*/   /*Birthdate Driver1*/          /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K"  '"' "�Ҫվ���Ѻ��褹��� 1"           '"' SKIP.   /*72*/   /*Occupation Driver1*/         /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K"  '"' "���˹觧ҹ���Ѻ��褹��� 1 "     '"' SKIP.   /*73*/   /*Position Driver1 */          /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K"  '"' "�ӴѺ���Ѻ��褹��� 2"           '"' SKIP.   /*74*/   /*Driver Seq2*/                /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K"  '"' "���ͼ��Ѻ��褹��� 2"            '"' SKIP.   /*75*/   /*Driver Name2*/               /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K"  '"' "�ѹ��͹���Դ���Ѻ��褹��� 2"  '"' SKIP.   /*76*/   /*Birthdate Driver2*/          /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K"  '"' "�Ҫվ���Ѻ��褹��� 2"           '"' SKIP.   /*77*/   /*Occupation Driver2*/         /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K"  '"' "���˹觧ҹ���Ѻ��褹��� 2 "     '"' SKIP.   /*78*/   /*Position Driver2*/           /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K"  '"' "�ӴѺ���Ѻ��褹��� 3"           '"' SKIP.   /*79*/   /*Driver Seq3*/                /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K"  '"' "���ͼ��Ѻ��褹��� 3"            '"' SKIP.   /*80*/   /*Driver Name3*/               /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X95;K"  '"' "�ѹ��͹���Դ���Ѻ��褹��� 3"  '"' SKIP.   /*81*/   /*Birthdate Driver3*/          /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X96;K"  '"' "�Ҫվ���Ѻ��褹��� 3"           '"' SKIP.   /*82*/   /*Occupation Driver3*/         /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X97;K"  '"' "���˹觧ҹ���Ѻ��褹��� 3 "     '"' SKIP.   /*83*/   /*Position Driver3*/           /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x98;K"  '"' "BLANK" '"' SKIP.  /*  84  Blank */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x99;K"  '"' "72Receipt Name" '"' SKIP.  /*  85  72Rec */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x100;K" '"' "�ػ�ó쵡��"                 '"' SKIP.  /*Car Accessories*/                 /* start : A63-0210*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x101;K" '"' "���ͷ���麹�����(�ú.)"     '"' SKIP.  /*Accidential Receipt name*/                              
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x102;K" '"' "����������麹�����(�ú.)1" '"' SKIP.  /*Accidential Receipt Address 1*/                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x103;K" '"' "����������麹�����(�ú.)2" '"' SKIP.  /*Accidential Receipt Address 2*/   /* end : A63-0210*/   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x104;K" '"' "accessories Y/N"               '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x105;K" '"' "accessories coverage"          '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x106;K" '"' "accessories premium"           '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x107;K" '"' "��Ǩ��Ҿö(Y/N)"               '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x108;K" '"' "�Ţ�����ҧ�ԧ���������"     '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x109;K" '"' "TYPE OF INSURANCE"             '"' SKIP. 
 /* A67-0087 */                                                                  
 PUT STREAM ns2 "C;Y" string(nv_row) ";x110;K" '"' "��ͧ�ҧ��â��    "              '"' skip.  
 PUT STREAM ns2 "C;Y" string(nv_row) ";x111;K" '"' "ö¹��俿�� Y/N  "              '"' skip.  
 PUT STREAM ns2 "C;Y" string(nv_row) ";x112;K" '"' "�ӴѺ���Ѻ��褹��� 4"          '"' skip.  
 PUT STREAM ns2 "C;Y" string(nv_row) ";x113;K" '"' "���ͼ��Ѻ��褹��� 4 "          '"' skip.  
 PUT STREAM ns2 "C;Y" string(nv_row) ";x114;K" '"' "�ѹ��͹���Դ���Ѻ��褹���4 " '"' skip.  
 PUT STREAM ns2 "C;Y" string(nv_row) ";x115;K" '"' "�Ҫվ���Ѻ��褹��� 4  "        '"' skip.  
 PUT STREAM ns2 "C;Y" string(nv_row) ";x116;K" '"' "���˹觧ҹ���Ѻ��褹��� 4 "    '"' skip.  
 PUT STREAM ns2 "C;Y" string(nv_row) ";x117;K" '"' "�ӴѺ���Ѻ��褹��� 5  "        '"' skip.  
 PUT STREAM ns2 "C;Y" string(nv_row) ";x118;K" '"' "���ͼ��Ѻ��褹��� 5   "        '"' skip.  
 PUT STREAM ns2 "C;Y" string(nv_row) ";x119;K" '"' "�ѹ��͹���Դ���Ѻ��褹���5 " '"' skip.  
 PUT STREAM ns2 "C;Y" string(nv_row) ";x120;K" '"' "�Ҫվ���Ѻ��褹��� 5  "        '"' skip.  
 PUT STREAM ns2 "C;Y" string(nv_row) ";x121;K" '"' "���˹觧ҹ���Ѻ��褹��� 5 "    '"' skip.  
 PUT STREAM ns2 "C;Y" string(nv_row) ";x122;K" '"' "��໭                 "        '"' skip.  
 PUT STREAM ns2 "C;Y" string(nv_row) ";x123;K" '"' "���ٻ᷹��õ�Ǩ��Ҿö Y/N "    '"' skip.  
 PUT STREAM ns2 "C;Y" string(nv_row) ";x124;K" '"' "�ӹǹ�Ţ����ͧ      "          '"' skip.  
 PUT STREAM ns2 "C;Y" string(nv_row) ";x125;K" '"' "�����Ţ����ͧ¹�� 2 "          '"' skip.  
 PUT STREAM ns2 "C;Y" string(nv_row) ";x126;K" '"' "�����Ţ����ͧ¹�� 3 "          '"' skip.  
 PUT STREAM ns2 "C;Y" string(nv_row) ";x127;K" '"' "�����Ţ����ͧ¹�� 4 "          '"' skip.  
 PUT STREAM ns2 "C;Y" string(nv_row) ";x128;K" '"' "�����Ţ����ͧ¹�� 5 "          '"' skip.  
 PUT STREAM ns2 "C;Y" string(nv_row) ";x129;K" '"' "���� �.�.�. "                   '"' skip.
 PUT STREAM ns2 "C;Y" string(nv_row) ";x130;K" '"' "������ö "                   '"' skip. 
 /* end : A67-0087 */                                                                                            

RUN Pro_createfile_data.                                             
OUTPUT STREAM ns2 CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile_data C-Win 
PROCEDURE Pro_createfile_data :
/*-------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail  no-lock.  
  ASSIGN nv_cnt  = nv_cnt  + 1   nv_row     = nv_row  + 1     
  nv_pol     = ""  nv_oldpol  = "" nv_comdat  = ?   
  nv_expdat  = ?   nv_accdat  = ?     
  nv_comchr  = ""  nv_addr    = ""  nv_name1   = ""
  nv_ntitle  = ""  nv_titleno = 0   nv_policy  = ""
  nv_dd      = 0   nv_mm      = 0   nv_yy      = 0
  nv_cpamt1  = 0   nv_cpamt2  = 0   nv_cpamt3  = 0
  nv_coamt1  = 0   nv_coamt2  = 0   nv_coamt3  = 0         
  nv_insamt1 = 0   nv_insamt2 = 0   nv_insamt3 = 0
  nv_premt1  = 0   nv_premt2  = 0   nv_premt3  = 0
  nv_ncb1    = 0   nv_ncb2    = 0   nv_ncb3    = 0
  nv_fleet1  = 0   nv_fleet2  = 0   nv_fleet3  = 0
  nv_oth1    = 0   nv_oth2    = 0   nv_oth3    = 0
  nv_deduct1 = 0   nv_deduct2 = 0   nv_deduct3 = 0
  nv_power1  = 0   nv_power2  = 0   nv_power3  = 0
  nv_sumfi1   = 0  nv_sumfi2   = 0  nv_sumfi3   = 0
  nv_compcomdat = ? nv_compexpdat = ? nv_bdatdriv1  = ? 
  nv_bdatdriv2  = ? nv_bdatdriv3  = ? nv_72Reciept = ""  nv_bdatdriv4  = ? nv_bdatdriv5  = ?. /*A67-0087*/                 
  IF wdetail.not_date  <> "" AND  wdetail.not_date   <> "00000000" THEN 
    ASSIGN nv_yy      = INT(SUBSTR(wdetail.not_date,1,4))
    nv_mm      = INT(SUBSTR(wdetail.not_date,5,2))
    nv_dd      = INT(SUBSTR(wdetail.not_date,7,2))
    nv_notdat  = DATE(nv_mm,nv_dd,nv_yy) .
  IF wdetail.comdat <>  ""  AND  wdetail.comdat   <> "00000000" THEN 
    ASSIGN nv_yy  = INT(SUBSTR(wdetail.comdat,1,4))
    nv_mm  = INT(SUBSTR(wdetail.comdat,5,2))
    nv_dd  = INT(SUBSTR(wdetail.comdat,7,2))
    nv_comdat  = DATE(nv_mm,nv_dd,nv_yy).  
  IF wdetail.expdat <>  ""  AND  wdetail.expdat   <> "00000000" THEN 
    ASSIGN nv_yy      = INT(SUBSTR(wdetail.expdat,1,4))
    nv_mm      = INT(SUBSTR(wdetail.expdat,5,2))
    nv_dd      = INT(SUBSTR(wdetail.expdat,7,2))
    nv_expdat  = DATE(nv_mm,nv_dd,nv_yy).
  If  wdetail.not_time  <>   ""   AND  wdetail.not_time  <>  "000000" THEN
    ASSIGN nv_nottim  = substr(wdetail.not_time,1,2) + ":"  + substr(wdetail.not_time,3,2) +  ":" + substr(wdetail.not_time,5,2).  /*--A59-0178--*/
  IF wdetail.comp_comdat <> "" AND  wdetail.comp_comdat  <> "00000000" THEN 
    ASSIGN nv_yy  = INT(SUBSTR(wdetail.comp_comdat,1,4))  /*A65-0035 */
       nv_mm = INT(SUBSTR(wdetail.comp_comdat,5,2))  /*A65-0035 */
       nv_dd = INT(SUBSTR(wdetail.comp_comdat,7,2))  /*A65-0035 */
       nv_compcomdat  = DATE(nv_mm,nv_dd,nv_yy) .
  IF nv_comdat = ? THEN nv_comdat = nv_compcomdat.
  IF wdetail.comp_expdat <>  ""  AND  wdetail.comp_expdat <> "00000000" THEN 
    ASSIGN nv_yy  = INT(SUBSTR(wdetail.comp_expdat,1,4)) /*A65-0035*/        
    nv_mm  = INT(SUBSTR(wdetail.comp_expdat,5,2)) /*A65-0035*/
    nv_dd  = INT(SUBSTR(wdetail.comp_expdat,7,2)) /*A65-0035*/
    nv_compexpdat = DATE(nv_mm,nv_dd,nv_yy). 
  IF nv_expdat = ?THEN nv_expdat = nv_compexpdat.
  IF wdetail.bdatedriv1 <>  ""  AND  wdetail.bdatedriv1  <> "00000000" THEN 
    ASSIGN nv_yy  = INT(SUBSTR(wdetail.bdatedriv1,1,4))
    nv_mm  = INT(SUBSTR(wdetail.bdatedriv1,5,2))
    nv_dd  = INT(SUBSTR(wdetail.bdatedriv1,7,2))
    nv_bdatdriv1  = DATE(nv_mm,nv_dd,nv_yy).
  IF wdetail.bdatedriv2 <>  ""  AND  wdetail.bdatedriv2  <> "00000000" THEN 
    ASSIGN nv_yy  = INT(SUBSTR(wdetail.bdatedriv2,1,4))
      nv_mm  = INT(SUBSTR(wdetail.bdatedriv2,5,2))
      nv_dd  = INT(SUBSTR(wdetail.bdatedriv2,7,2))
      nv_bdatdriv2  = DATE(nv_mm,nv_dd,nv_yy).
  IF wdetail.bdatedriv3 <>  ""  AND  wdetail.bdatedriv3  <> "00000000" THEN 
    ASSIGN nv_yy   = INT(SUBSTR(wdetail.bdatedriv3,1,4))
      nv_mm = INT(SUBSTR(wdetail.bdatedriv3,5,2))
      nv_dd = INT(SUBSTR(wdetail.bdatedriv3,7,2))
      nv_bdatdriv3  = DATE(nv_mm,nv_dd,nv_yy).
  RUN proc_reciept72. /*A60-0095*/
  /* --------------------------------------------- INS_AMT  CHR(12) �ع��Сѹö¹�� --- */
  nv_insamt1 = DECIMAL(SUBSTRING(wdetail.ins_amt,1,9)).
  IF  nv_insamt1 < 0 THEN nv_insamt2 = (DECIMAL(SUBSTRING(wdetail.ins_amt,10,2)) * -1) / 100.
  ELSE nv_insamt2 = DECIMAL(SUBSTRING(wdetail.ins_amt,10,2)) / 100.
  nv_insamt3 = nv_insamt1 + nv_insamt2.
  /* -------------------------- PREM1CHR(11)   �����Ҥ��Ѥ�㨺ǡ���պǡ�ҡ� --- */
  nv_premt1 = DECIMAL(SUBSTRING(wdetail.prem1,1,9)).
  IF nv_premt1 < 0 THEN nv_premt2 = (DECIMAL(SUBSTRING(wdetail.prem1,10,2)) * -1) / 100.
  ELSE  nv_premt2 = DECIMAL(SUBSTRING(wdetail.prem1,10,2)) / 100.
  nv_premt3 = nv_premt1 + nv_premt2.
  /* --------------------------------------------- comp_prm CHR(09)  ���¾ú. ���--- */
  nv_cpamt1 = DECIMAL(SUBSTRING(wdetail.comp_prm,1,7)).
  IF nv_cpamt1 < 0 THEN nv_cpamt2 = (DECIMAL(SUBSTRING(wdetail.comp_prm,8,2)) * -1) / 100.
  ELSE  nv_cpamt2 = DECIMAL(SUBSTRING(wdetail.comp_prm,8,2)) / 100.
  nv_cpamt3 = nv_cpamt1 + nv_cpamt2. 
  /* -------------------------- GROSS_prm  CHR(11)   ��������Ҥ��Ѥ�㨺ǡ������� �ú. --- */
  nv_coamt1 = DECIMAL(SUBSTRING(wdetail.gross_prm,1,9)).
  IF nv_coamt1 < 0 THEN nv_coamt2 = (DECIMAL(SUBSTRING(wdetail.gross_prm,10,2)) * -1) / 100.
  ELSE nv_coamt2 = DECIMAL(SUBSTRING(wdetail.gross_prm,10,2)) / 100.
  nv_coamt3 = nv_coamt1 + nv_coamt2.
  /* ----------------------FLEET_DISC. ��ǹŴ�����  / �����繵� --- */
  nv_fleet1 = DECIMAL(SUBSTRING(wdetail.fleetper,1,3)).
  IF nv_fleet1 < 0 THEN  nv_fleet2 = (DECIMAL(SUBSTRING(wdetail.fleetper,4,2)) * -1) / 100.
  ELSE  nv_fleet2 = DECIMAL(SUBSTRING(wdetail.fleetper,4,2)) / 100.
  nv_fleet3 = nv_fleet1 + nv_fleet2.
  /* ----------------------NCB_DISC. ��ǹŴ����ѵԴ�  / �����繵� --- */
  nv_ncb1 = DECIMAL(SUBSTRING(wdetail.ncbper,1,3)).
  IF nv_ncb1 < 0 THEN
  nv_ncb2 = (DECIMAL(SUBSTRING(wdetail.ncbper,4,2)) * -1) / 100.
  ELSE  nv_ncb2 = DECIMAL(SUBSTRING(wdetail.ncbper,4,2)) / 100.
  nv_ncb3 = nv_ncb1 + nv_ncb2.
  /* ----------------------OTH_DISC. ��ǹŴ��� �  / �����繵� --- */
  nv_oth1 = DECIMAL(SUBSTRING(wdetail.othper,1,3)).
  IF nv_oth1 < 0 THEN
  nv_oth2 = (DECIMAL(SUBSTRING(wdetail.othper,4,2)) * -1) / 100.
  ELSE nv_oth2 = DECIMAL(SUBSTRING(wdetail.othper,4,2)) / 100.
  nv_oth3 = nv_oth1 + nv_oth2.
  /* ----------------------Deduct  �������������ǹ�á  --------------- */
  nv_deduct1 = DECIMAL(SUBSTRING(wdetail.othper,1,7)).
  IF nv_deduct1 < 0 THEN  nv_deduct2 = (DECIMAL(SUBSTRING(wdetail.deduct,8,2)) * -1) / 100.
  ELSE  nv_deduct2 = DECIMAL(SUBSTRING(wdetail.deduct,8,2)) / 100.
  nv_deduct3 = nv_deduct1 + nv_deduct2.         
  nv_power1 = DECIMAL(SUBSTRING(wdetail.power,1,5)).  /* ----Power  ���ѧ����ͧ¹��------ */
  IF nv_power1 < 0 THEN  nv_power2 = (DECIMAL(SUBSTRING(wdetail.power,6,2)) * -1) / 100.
  ELSE  nv_power2 = DECIMAL(SUBSTRING(wdetail.power,6,2)) / 100.
  nv_power3 = nv_power1 + nv_power2.  
  /* --------------------------------------------- SUM_FI  CHR(12) �ع�٭��� ����� --- */
  nv_sumfi1 = DECIMAL(SUBSTRING(wdetail.fi,1,9)).
  IF  nv_sumfi1 < 0 THEN nv_sumfi2 = (DECIMAL(SUBSTRING(wdetail.fi,10,2)) * -1) / 100.
  ELSE nv_sumfi2 = DECIMAL(SUBSTRING(wdetail.fi,10,2)) / 100.
  nv_sumfi3 = nv_sumfi1 + nv_sumfi2.
  IF ra_poltyp = 1  THEN DO: 
  IF wdetail.prev_pol = "" THEN n_prepol    = "".
  ELSE ASSIGN n_prepol    = ""
      n_prepol = REPLACE(wdetail.prev_pol," ","")
      n_prepol = REPLACE(wdetail.prev_pol,"*","")
      n_prepol = REPLACE(wdetail.prev_pol,"-","")
      n_prepol = REPLACE(wdetail.prev_pol,"/","")
      n_prepol = REPLACE(wdetail.prev_pol,"\","")
      n_prepol = REPLACE(wdetail.prev_pol,"#","")
      wdetail.prev_pol = trim(n_prepol).
  END.
  ELSE ASSIGN n_typpol = "NEW".
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' wdetail.pro_off   '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' wdetail.cmr_code  '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' wdetail.comp_code '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' wdetail.notify_no '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' wdetail.yrmanu    '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' wdetail.engine    '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' wdetail.chassis   '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' wdetail.weight    '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' nv_power3         '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' wdetail.colorcode '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' wdetail.licence   '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' wdetail.garage    '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' nv_fleet3         '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' nv_ncb3           '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' nv_oth3           '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' wdetail.vehuse    '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' nv_comdat         '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' nv_insamt3        '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' wdetail.name_insur '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' wdetail.not_office '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' nv_notdat          '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' nv_nottim          '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' wdetail.not_code   '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' nv_premt3          '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' nv_cpamt3          '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' wdetail.sckno      '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' wdetail.brand      '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' wdetail.pol_addr1  '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' wdetail.pol_addr2  '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' wdetail.pol_title  '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' wdetail.pol_fname  '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' wdetail.pol_lname  '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' wdetail.ben_name   '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' wdetail.remark     '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' wdetail.account_no FORMAT "x(10)"  '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' wdetail.client_no  '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' nv_expdat          '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' nv_coamt3          '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' wdetail.province   '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' wdetail.receipt_name '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' wdetail.agent        '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' wdetail.prev_insur   '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' wdetail.prev_pol     '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' nv_deduct3           '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' wdetail.addr1_70     '"' SKIP.  /*Add kridtiya i. A54-0062 ...*/
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"' wdetail.addr2_70     '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"' wdetail.nsub_dist70  '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"' wdetail.ndirection70 '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"' wdetail.nprovin70    '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"' wdetail.zipcode70    '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"' wdetail.addr1_72     '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"' wdetail.addr2_72     '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"' wdetail.nsub_dist72  '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"' wdetail.ndirection72 '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"' wdetail.nprovin72 '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"' wdetail.zipcode72 '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"' wdetail.apptyp    '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"' wdetail.appcode   '"' SKIP. 
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"' wdetail.caracc    '"' SKIP.         /*A63-0210*/
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"' wdetail.n_pack    '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"' wdetail.n_seattisco  '"' SKIP.   /*Add A57-0017*/
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"' wdetail.bi '"' skip. /*a60-0095*/
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"' wdetail.pa '"' skip. /*a60-0095*/
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"' wdetail.pd '"' skip. /*a60-0095*/
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"' wdetail.n_covcod  '"' SKIP.  
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"' wdetail.nproducer '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"' wdetail.nagent    '"' SKIP.  /*Add kridtiya i. A54-0062 ...*/
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"' wdetail.n_branch  '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"' wdetail.n_typpol  '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x70;K" '"' wdetail.redbook   '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x71;K" '"' wdetail.price_ford '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x72;K" '"' wdetail.yrmanu     '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x73;K" '"' wdetail.brand      '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x74;K" '"' wdetail.id_recive70  '"' SKIP.  /*A57-0262*/ 
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x75;K" '"' wdetail.br_recive70  '"' SKIP.  /*A57-0262*/  
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x76;K" '"' wdetail.id_recive72  '"' SKIP.  /*A57-0262*/   
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x77;K" '"' wdetail.br_recive72  '"' SKIP.  /*A57-0262*/  
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K" '"' nv_compcomdat   '"' SKIP.    /* A59-0178*/             
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K" '"' nv_compexpdat   '"' SKIP.    /* A59-0178*/                 
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K" '"' nv_sumfi3       '"' SKIP.    /* A59-0178*/                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K" '"' wdetail.class   '"' SKIP.    /* A59-0178*/                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K" '"' wdetail.usedtype '"' SKIP.    /* A59-0178*/                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K" '"' wdetail.driveno1 '"' SKIP.    /* A59-0178*/                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K" '"' wdetail.drivename1 '"' SKIP.    /* A59-0178*/                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K" '"' nv_bdatdriv1    '"'SKIP.    /* A59-0178*/                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K" '"' wdetail.occupdriv1 '"' SKIP.    /* A59-0178*/                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K" '"' wdetail.positdriv1 '"' SKIP.    /* A59-0178*/                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K" '"' wdetail.driveno2   '"' SKIP.    /* A59-0178*/                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K" '"' wdetail.drivename2 '"' SKIP.    /* A59-0178*/                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K" '"' nv_bdatdriv2    '"'SKIP.    /* A59-0178*/                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K" '"' wdetail.occupdriv2 '"' SKIP.    /* A59-0178*/                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K" '"' wdetail.positdriv2 '"' SKIP.    /* A59-0178*/                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K" '"' wdetail.driveno3   '"' SKIP.    /* A59-0178*/                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K" '"' wdetail.drivename3 '"' SKIP.    /* A59-0178*/                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X95;K" '"' nv_bdatdriv3    '"' SKIP.    /* A59-0178*/                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X96;K" '"' wdetail.occupdriv3 '"' SKIP.    /* A59-0178*/                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X97;K" '"' wdetail.positdriv3 '"' SKIP.    /* A59-0178*/                
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x98;K" '"' wdetail.nBLANK     '"' SKIP.  /*  84  Blank */ 
  /*PUT STREAM ns2 "C;Y" STRING(nv_row) ";x99;K"  '"' nv_72Reciept  '"' SKIP.  /* 85 72Reciept */ A67-0114 */
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x99;K"  '"' wdetail.Rec_name72 '"' SKIP.  /* A67-0114*/ 
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x100;K" '"' wdetail.caracc     '"' SKIP.  /* A63-0210*/
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x101;K" '"' wdetail.Rec_name72 '"' SKIP.  /* A63-0210*/ 
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x102;K" '"' wdetail.Rec_add1   '"' SKIP.  /* A63-0210*/ 
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x103;K" '"' wdetail.Rec_add2   '"' SKIP.  /* A63-0210*/
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x104;K" '"' wdetail.acctyp     '"' SKIP.    
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x105;K" '"' wdetail.acccovins  '"' SKIP. 
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x106;K" '"' wdetail.accpremt   '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x107;K" '"' wdetail.inspecttyp '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x108;K" '"' wdetail.quotation  '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x109;K" '"' wdetail.covcodtype '"' SKIP.
  /* A67-0087 */
  PUT STREAM ns2 "C;Y" string(nv_row) ";x110;K" '"' wdetail.Schanel    '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x111;K" '"' wdetail.bev        '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x112;K" '"' wdetail.driveno4   '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x113;K" '"' wdetail.drivename4 '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x114;K" '"' nv_bdatdriv4      '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x115;K" '"' wdetail.occupdriv4 '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x116;K" '"' wdetail.positdriv4 '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x117;K" '"' wdetail.driveno5   '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x118;K" '"' wdetail.drivename5 '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x119;K" '"' nv_bdatdriv5 '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x120;K" '"' wdetail.occupdriv5 '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x121;K" '"' wdetail.positdriv5 '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x122;K" '"' wdetail.campagin   '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x123;K" '"' wdetail.inspic     '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x124;K" '"' wdetail.engcount   '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x125;K" '"' wdetail.engno2     '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x126;K" '"' wdetail.engno3     '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x127;K" '"' wdetail.engno4     '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x128;K" '"' wdetail.engno5     '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x129;K" '"' wdetail.classcomp  '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x130;K" '"' wdetail.carbrand  '"' skip.  /* end : A67-0087 */
End.   /*  end  wdetail  */
nv_row  =  nv_row  + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' " Total "   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' String(nv_cnt,"99999")    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' " ��¡��  " '"' SKIP.
PUT STREAM ns2 "E".
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile_re C-Win 
PROCEDURE Pro_createfile_re :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN fi_outfile  =  Trim(fi_outfile) + ".slk"  .
ASSIGN  nv_cnt  =  0
        nv_row  =  1.
OUTPUT STREAM ns2 TO VALUE(fi_outfile).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "����ѷ�Թ�ع ����� �ӡѴ (��Ҫ�) ."  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' nv_export  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "Processing Office"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "CMR  code"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "Insur.comp"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "notify number"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "Car year"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "engine"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "chassis"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "weight"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "power"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "color"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "licence no"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "Garage"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "fleet disc."               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "ncb disc."                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "other disc."               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "vehuse"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "Comdat"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "�ع��Сѹ"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "�������˹�ҷ���駻�Сѹ" '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "�������˹�ҷ���Сѹ "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "�ѹ����駻�Сѹ  "        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "�����駻�Сѹ "           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "�����駧ҹ"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "prem.1"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "comp.prm"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "sticker"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "brand"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "address1"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "address2"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "title name"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "first name"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "last name"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "beneficiary"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "remark."                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' "account no."               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' "client No."                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' "expiry date "              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' "insurance amt."            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' "province"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' "receipt name"              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' "agent code"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' "����ѷ��Сѹ������"       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' "old policy"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' "deduct disc."              '"' SKIP.   /*Add kridtiya i. A54-0062 ...*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' "�������˹�ҵ��ҧ70"        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' "�������˹�ҵ��ҧ70�ó�����¡�������" '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"' "�Ӻ�"                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"' "�����"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"' "�ѧ��Ѵ"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"' "������ɳ���"              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"' "�������˹�ҵ��ҧ72"        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"' "�������˹�ҵ��ҧ72�ó�����¡�������" '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"' "�Ӻ�"                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"' "�����"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"' "�ѧ��Ѵ"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"' "������ɳ���"              '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"' "Applicationtype"           '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"' "Applicationcode"           '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"' "Blank"                     '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"' "package"                   '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"' "Seat/�ӹǹ�����"         '"' SKIP.   /*add A57-0017 */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"' "TPBI/Person"               '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"' "TPBI/Per Acciden"          '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"' "TPPD/Per Acciden"          '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"' "covcod"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"' "Producer"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"' "Agent"                     '"' SKIP.  /*Add kridtiya i. A54-0062 ...*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"' "Branch"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"' "NEW/RENEW"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"' "Redbook"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"' "Price_Ford"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"' "Year"                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"' "Brand_Model"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x74;K"  '"' "Receipt ID. Number " '"' SKIP.             /*  60  Receipt ID. Number   */                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x75;K"  '"' "Receipt Branch NAME" '"' SKIP.             /*  61  Receipt Branch NAME  */                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x76;K"  '"' "Receipt Compulsory ID. Number"  '"' SKIP.  /*  62  Receipt Compulsory ID. Number  */  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x77;K"  '"' "Receipt Compulsory Branch Name" '"' SKIP.  /*  63  Receipt Compulsory Branch Name */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"  '"' "�ѹ��������ͧ �ú. "            '"' SKIP.   /*64*/   /*Effective Date Accidential*/ /* A59-0178*/             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K"  '"' "�ѹ�������ش����������ͧ �ú."  '"' SKIP.   /*65*/   /*Expiry Date Accidential*/    /* A59-0178*/                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K"  '"' "�ع�٭�����������"              '"' SKIP.   /*66*/   /*Coverage Amount Theft*/      /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K"  '"' "����ö"                          '"' SKIP.   /*67*/   /*Car code*/                   /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K"  '"' "�ѡɳС����ö"                  '"' SKIP.   /*68*/   /*Per Used*/                   /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K"  '"' "�ӴѺ���Ѻ��褹��� 1"           '"' SKIP.   /*69*/   /*Driver Seq1*/                /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K"  '"' "���ͼ��Ѻ��褹��� 1"            '"' SKIP.   /*70*/   /*Driver Name1*/               /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K"  '"' "�ѹ��͹���Դ���Ѻ��褹��� 1"  '"' SKIP.   /*71*/   /*Birthdate Driver1*/          /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K"  '"' "�Ҫվ���Ѻ��褹��� 1"           '"' SKIP.   /*72*/   /*Occupation Driver1*/         /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K"  '"' "���˹觧ҹ���Ѻ��褹��� 1 "     '"' SKIP.   /*73*/   /*Position Driver1 */          /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K"  '"' "�ӴѺ���Ѻ��褹��� 2"           '"' SKIP.   /*74*/   /*Driver Seq2*/                /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K"  '"' "���ͼ��Ѻ��褹��� 2"            '"' SKIP.   /*75*/   /*Driver Name2*/               /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K"  '"' "�ѹ��͹���Դ���Ѻ��褹��� 2"  '"' SKIP.   /*76*/   /*Birthdate Driver2*/          /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K"  '"' "�Ҫվ���Ѻ��褹��� 2"           '"' SKIP.   /*77*/   /*Occupation Driver2*/         /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K"  '"' "���˹觧ҹ���Ѻ��褹��� 2 "     '"' SKIP.   /*78*/   /*Position Driver2*/           /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K"  '"' "�ӴѺ���Ѻ��褹��� 3"           '"' SKIP.   /*79*/   /*Driver Seq3*/                /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K"  '"' "���ͼ��Ѻ��褹��� 3"            '"' SKIP.   /*80*/   /*Driver Name3*/               /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X95;K"  '"' "�ѹ��͹���Դ���Ѻ��褹��� 3"  '"' SKIP.   /*81*/   /*Birthdate Driver3*/          /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X96;K"  '"' "�Ҫվ���Ѻ��褹��� 3"           '"' SKIP.   /*82*/   /*Occupation Driver3*/         /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X97;K"  '"' "���˹觧ҹ���Ѻ��褹��� 3 "     '"' SKIP.   /*83*/   /*Position Driver3*/           /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x98;K"  '"' "BLANK" '"' SKIP.  /*  84  Blank */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x99;K"  '"' "72Reciept Name" '"' SKIP.  /*  84  Blank */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x100;K" '"' "�ػ�ó쵡��"                 '"' SKIP.  /*Car Accessories*/                 /* start : A63-0210*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x101;K" '"' "���ͷ���麹�����(�ú.)"     '"' SKIP.  /*Accidential Receipt name*/                              
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x102;K" '"' "����������麹�����(�ú.)1" '"' SKIP.  /*Accidential Receipt Address 1*/                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x103;K" '"' "����������麹�����(�ú.)2" '"' SKIP.  /*Accidential Receipt Address 2*/   /* end : A63-0210*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x104;K" '"' "��.��� Nissan "   '"' SKIP .             /* Ranu : A65-0035 */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x105;K" '"' "accessories Y/N"               '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x106;K" '"' "accessories coverage"          '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x107;K" '"' "accessories premium"           '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x108;K" '"' "��Ǩ��Ҿö(Y/N)"               '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x109;K" '"' "�Ţ�����ҧ�ԧ���������"     '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x110;K" '"' "TYPE OF INSURANCE"             '"' SKIP.  
/* A67-0087 */                                                                  
PUT STREAM ns2 "C;Y" string(nv_row) ";x111;K" '"' "��ͧ�ҧ��â��    "              '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x112;K" '"' "ö¹��俿�� Y/N  "              '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x113;K" '"' "�ӴѺ���Ѻ��褹��� 4"          '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x114;K" '"' "���ͼ��Ѻ��褹��� 4 "          '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x115;K" '"' "�ѹ��͹���Դ���Ѻ��褹���4 " '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x116;K" '"' "�Ҫվ���Ѻ��褹��� 4  "        '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x117;K" '"' "���˹觧ҹ���Ѻ��褹��� 4 "    '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x118;K" '"' "�ӴѺ���Ѻ��褹��� 5  "        '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x119;K" '"' "���ͼ��Ѻ��褹��� 5   "        '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x120;K" '"' "�ѹ��͹���Դ���Ѻ��褹���5 " '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x121;K" '"' "�Ҫվ���Ѻ��褹��� 5  "        '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x122;K" '"' "���˹觧ҹ���Ѻ��褹��� 5 "    '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x123;K" '"' "��໭                 "        '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x124;K" '"' "���ٻ᷹��õ�Ǩ��Ҿö Y/N "    '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x125;K" '"' "�ӹǹ�Ţ����ͧ      "          '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x126;K" '"' "�����Ţ����ͧ¹�� 2 "          '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x127;K" '"' "�����Ţ����ͧ¹�� 3 "          '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x128;K" '"' "�����Ţ����ͧ¹�� 4 "          '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x129;K" '"' "�����Ţ����ͧ¹�� 5 "          '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x130;K" '"' "���� �.�.�. "                   '"' skip.
PUT STREAM ns2 "C;Y" string(nv_row) ";x131;K" '"' "������ö "                   '"' skip. 
/* end : A67-0087 */

RUN Pro_createfile_re1.
OUTPUT STREAM ns2 CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile_re1 C-Win 
PROCEDURE Pro_createfile_re1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail  no-lock.  
  ASSIGN nv_cnt  = nv_cnt  + 1   nv_row  = nv_row  + 1     
  nv_pol     = ""  nv_oldpol  = ""                    nv_dd      = 0   nv_mm      = 0   nv_yy      = 0 
  nv_comdat  = ?   nv_expdat  = ?   nv_accdat  = ?    nv_cpamt1  = 0   nv_cpamt2  = 0   nv_cpamt3  = 0 
  nv_comchr  = ""  nv_addr    = ""  nv_name1   = ""   nv_coamt1  = 0   nv_coamt2  = 0   nv_coamt3  = 0 
  nv_ntitle  = ""  nv_titleno = 0   nv_policy  = ""   nv_insamt1 = 0   nv_insamt2 = 0   nv_insamt3 = 0 
  nv_premt1  = 0   nv_premt2  = 0   nv_premt3  = 0    nv_oth1    = 0   nv_oth2    = 0   nv_oth3    = 0  
  nv_ncb1    = 0   nv_ncb2    = 0   nv_ncb3    = 0    nv_deduct1 = 0   nv_deduct2 = 0   nv_deduct3 = 0  
  nv_fleet1  = 0   nv_fleet2  = 0   nv_fleet3  = 0    nv_power1  = 0   nv_power2  = 0   nv_power3  = 0  
  nv_sumfi1   = 0  nv_sumfi2   = 0  nv_sumfi3   = 0   nv_compcomdat = ? nv_compexpdat = ? nv_bdatdriv1  = ? /*A59-0178*/
  nv_bdatdriv2  = ? nv_bdatdriv3  = ?  nv_bdatdriv4  = ? nv_bdatdriv5  = ?. /*A67-0087*/                  
  IF wdetail.not_date  <> "" AND  wdetail.not_date   <> "00000000" THEN 
    ASSIGN nv_yy      = INT(SUBSTR(wdetail.not_date,1,4))
    nv_mm = INT(SUBSTR(wdetail.not_date,5,2))
    nv_dd = INT(SUBSTR(wdetail.not_date,7,2))
    nv_notdat  = DATE(nv_mm,nv_dd,nv_yy) .
  IF wdetail.comdat <>  ""  AND  wdetail.comdat   <> "00000000" THEN 
    ASSIGN nv_yy      = INT(SUBSTR(wdetail.comdat,1,4))
    nv_mm = INT(SUBSTR(wdetail.comdat,5,2))
    nv_dd = INT(SUBSTR(wdetail.comdat,7,2))
    nv_comdat  = DATE(nv_mm,nv_dd,nv_yy).  
  IF wdetail.expdat <>  ""  AND  wdetail.expdat   <> "00000000" THEN 
    ASSIGN nv_yy      = INT(SUBSTR(wdetail.expdat,1,4))
    nv_mm = INT(SUBSTR(wdetail.expdat,5,2))
    nv_dd = INT(SUBSTR(wdetail.expdat,7,2))
    nv_expdat  = DATE(nv_mm,nv_dd,nv_yy).
  If  wdetail.not_time  <>   ""   AND  wdetail.not_time  <>  "000000" THEN
    ASSIGN nv_nottim  = substr(wdetail.not_time,1,2) + ":" + substr(wdetail.not_time,3,2) +  ":" + substr(wdetail.not_time,5,2).  /*--A59-0178--*/
  IF wdetail.comp_comdat <> "" AND  wdetail.comp_comdat  <> "00000000" THEN 
    ASSIGN nv_yy      = INT(SUBSTR(wdetail.comp_comdat,1,4))
    nv_mm = INT(SUBSTR(wdetail.comp_comdat,5,2))
    nv_dd = INT(SUBSTR(wdetail.comp_comdat,7,2))
    nv_compcomdat  = DATE(nv_mm,nv_dd,nv_yy) .
  IF nv_comdat = ? THEN nv_comdat = nv_compcomdat.
  IF wdetail.comp_expdat <>  ""  AND  wdetail.comp_expdat <> "00000000" THEN 
  ASSIGN nv_yy    = INT(SUBSTR(wdetail.comp_expdat,1,4))
  nv_mm    = INT(SUBSTR(wdetail.comp_expdat,5,2))
  nv_dd    = INT(SUBSTR(wdetail.comp_expdat,7,2))
  nv_compexpdat  = DATE(nv_mm,nv_dd,nv_yy).  
  IF nv_expdat = ? THEN nv_expdat = nv_compexpdat.
  /* driver name */
  IF wdetail.bdatedriv1 <>  ""  AND  wdetail.bdatedriv1  <> "00000000" THEN 
  ASSIGN nv_yy  = INT(SUBSTR(wdetail.bdatedriv1,1,4))  nv_mm  = INT(SUBSTR(wdetail.bdatedriv1,5,2))  nv_dd = INT(SUBSTR(wdetail.bdatedriv1,7,2))
  nv_bdatdriv1  = DATE(nv_mm,nv_dd,nv_yy).
  IF wdetail.bdatedriv2 <>  ""  AND  wdetail.bdatedriv2  <> "00000000" THEN 
  ASSIGN nv_yy  = INT(SUBSTR(wdetail.bdatedriv2,1,4))  nv_mm  = INT(SUBSTR(wdetail.bdatedriv2,5,2))  nv_dd = INT(SUBSTR(wdetail.bdatedriv2,7,2))
  nv_bdatdriv2  = DATE(nv_mm,nv_dd,nv_yy).
  IF wdetail.bdatedriv3 <>  ""  AND  wdetail.bdatedriv3  <> "00000000" THEN 
  ASSIGN nv_yy  = INT(SUBSTR(wdetail.bdatedriv3,1,4))   nv_mm = INT(SUBSTR(wdetail.bdatedriv3,5,2))  nv_dd = INT(SUBSTR(wdetail.bdatedriv3,7,2))
  nv_bdatdriv3  = DATE(nv_mm,nv_dd,nv_yy).
  /* add by : A67-0087 */
  IF wdetail.bdatedriv4 <>  ""  AND  wdetail.bdatedriv4  <> "00000000" THEN 
  ASSIGN nv_yy  = INT(SUBSTR(wdetail.bdatedriv4,1,4))  nv_mm  = INT(SUBSTR(wdetail.bdatedriv4,5,2))  nv_dd = INT(SUBSTR(wdetail.bdatedriv4,7,2))
  nv_bdatdriv4  = DATE(nv_mm,nv_dd,nv_yy).
  IF wdetail.bdatedriv5 <>  ""  AND  wdetail.bdatedriv5  <> "00000000" THEN 
  ASSIGN nv_yy  = INT(SUBSTR(wdetail.bdatedriv5,1,4))   nv_mm = INT(SUBSTR(wdetail.bdatedriv5,5,2))  nv_dd = INT(SUBSTR(wdetail.bdatedriv5,7,2))
  nv_bdatdriv5  = DATE(nv_mm,nv_dd,nv_yy).
  /* end : A67-0087 */
  /* --------------------------------------------- INS_AMT  CHR(12) �ع��Сѹö¹�� --- */
  nv_insamt1 = DECIMAL(SUBSTRING(wdetail.ins_amt,1,9)).
  IF  nv_insamt1 < 0 THEN nv_insamt2 = (DECIMAL(SUBSTRING(wdetail.ins_amt,10,2)) * -1) / 100.
  ELSE nv_insamt2 = DECIMAL(SUBSTRING(wdetail.ins_amt,10,2)) / 100.
       nv_insamt3 = nv_insamt1 + nv_insamt2.
  /* -------------------------- PREM1CHR(11)   �����Ҥ��Ѥ�㨺ǡ���պǡ�ҡ� --- */
  nv_premt1 = DECIMAL(SUBSTRING(wdetail.prem1,1,9)).
  IF nv_premt1 < 0 THEN nv_premt2 = (DECIMAL(SUBSTRING(wdetail.prem1,10,2)) * -1) / 100.
  ELSE  nv_premt2 = DECIMAL(SUBSTRING(wdetail.prem1,10,2)) / 100.
  nv_premt3 = nv_premt1 + nv_premt2.
  /* --------------------------------------------- comp_prm CHR(09)  ���¾ú. ���--- */
  nv_cpamt1 = DECIMAL(SUBSTRING(wdetail.comp_prm,1,7)).
  IF nv_cpamt1 < 0 THEN nv_cpamt2 = (DECIMAL(SUBSTRING(wdetail.comp_prm,8,2)) * -1) / 100.
  ELSE  nv_cpamt2 = DECIMAL(SUBSTRING(wdetail.comp_prm,8,2)) / 100.
  nv_cpamt3 = nv_cpamt1 + nv_cpamt2. 
  /* -------------------------- GROSS_prm  CHR(11)   ��������Ҥ��Ѥ�㨺ǡ������� �ú. --- */
  nv_coamt1 = DECIMAL(SUBSTRING(wdetail.gross_prm,1,9)).
  IF nv_coamt1 < 0 THEN nv_coamt2 = (DECIMAL(SUBSTRING(wdetail.gross_prm,10,2)) * -1) / 100.
  ELSE nv_coamt2 = DECIMAL(SUBSTRING(wdetail.gross_prm,10,2)) / 100.
  nv_coamt3 = nv_coamt1 + nv_coamt2.
  /* ----------------------FLEET_DISC. ��ǹŴ�����  / �����繵� --- */
  nv_fleet1 = DECIMAL(SUBSTRING(wdetail.fleetper,1,3)).
  IF nv_fleet1 < 0 THEN  nv_fleet2 = (DECIMAL(SUBSTRING(wdetail.fleetper,4,2)) * -1) / 100.
  ELSE  nv_fleet2 = DECIMAL(SUBSTRING(wdetail.fleetper,4,2)) / 100.
  nv_fleet3 = nv_fleet1 + nv_fleet2.
  /* ----------------------NCB_DISC. ��ǹŴ����ѵԴ�  / �����繵� --- */
  nv_ncb1 = DECIMAL(SUBSTRING(wdetail.ncbper,1,3)).
  IF nv_ncb1 < 0 THEN
    nv_ncb2 = (DECIMAL(SUBSTRING(wdetail.ncbper,4,2)) * -1) / 100.
  ELSE  nv_ncb2 = DECIMAL(SUBSTRING(wdetail.ncbper,4,2)) / 100.
  nv_ncb3 = nv_ncb1 + nv_ncb2.
  /* ----------------------OTH_DISC. ��ǹŴ��� �  / �����繵� --- */
  nv_oth1 = DECIMAL(SUBSTRING(wdetail.othper,1,3)).
  IF nv_oth1 < 0 THEN
    nv_oth2 = (DECIMAL(SUBSTRING(wdetail.othper,4,2)) * -1) / 100.
  ELSE nv_oth2 = DECIMAL(SUBSTRING(wdetail.othper,4,2)) / 100.
  nv_oth3 = nv_oth1 + nv_oth2.
  /* ----------------------Deduct  �������������ǹ�á  --------------- */
  nv_deduct1 = DECIMAL(SUBSTRING(wdetail.othper,1,7)).
  IF nv_deduct1 < 0 THEN  nv_deduct2 = (DECIMAL(SUBSTRING(wdetail.deduct,8,2)) * -1) / 100.
  ELSE  nv_deduct2 = DECIMAL(SUBSTRING(wdetail.deduct,8,2)) / 100.
  nv_deduct3 = nv_deduct1 + nv_deduct2.         
  nv_power1 = DECIMAL(SUBSTRING(wdetail.power,1,5)).  /* ----Power  ���ѧ����ͧ¹��------ */
  IF nv_power1 < 0 THEN  nv_power2 = (DECIMAL(SUBSTRING(wdetail.power,6,2)) * -1) / 100.
  ELSE  nv_power2 = DECIMAL(SUBSTRING(wdetail.power,6,2)) / 100.
  nv_power3 = nv_power1 + nv_power2.  /*A67-0114*/
  /* --------------------------------------------- SUM_FI  CHR(12) �ع�٭��� ����� --- */
  nv_sumfi1 = DECIMAL(SUBSTRING(wdetail.fi,1,9)).
  IF  nv_sumfi1 < 0 THEN nv_sumfi2 = (DECIMAL(SUBSTRING(wdetail.fi,10,2)) * -1) / 100.
  ELSE nv_sumfi2 = DECIMAL(SUBSTRING(wdetail.fi,10,2)) / 100.
       nv_sumfi3 = nv_sumfi1 + nv_sumfi2.
  IF ra_poltyp = 1  THEN DO: 
    IF wdetail.prev_pol = "" THEN n_prepol    = "".
    ELSE ASSIGN n_prepol    = ""
    n_prepol = REPLACE(wdetail.prev_pol," ","")
    n_prepol = REPLACE(wdetail.prev_pol,"*","")
    n_prepol = REPLACE(wdetail.prev_pol,"-","")
    n_prepol = REPLACE(wdetail.prev_pol,"/","")
    n_prepol = REPLACE(wdetail.prev_pol,"\","")
    n_prepol = REPLACE(wdetail.prev_pol,"#","")
    wdetail.prev_pol = trim(n_prepol).
  END.
  ELSE ASSIGN n_typpol = "RENEW".
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' wdetail.pro_off   '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' wdetail.cmr_code  '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' wdetail.comp_code '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' wdetail.notify_no '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' wdetail.yrmanu    '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' wdetail.engine    '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' wdetail.chassis   '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' wdetail.weight    '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' nv_power3         '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' wdetail.colorcode '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' wdetail.licence   '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' wdetail.garage    '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' nv_fleet3         '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' nv_ncb3           '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' nv_oth3           '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' wdetail.vehuse    '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' nv_comdat         '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' nv_insamt3        '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' wdetail.name_insur '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' wdetail.not_office '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' nv_notdat          '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' nv_nottim          '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' wdetail.not_code   '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' nv_premt3          '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' nv_cpamt3          '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' wdetail.sckno      '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' wdetail.brand      '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' wdetail.pol_addr1  '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' wdetail.pol_addr2  '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' wdetail.pol_title  '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' wdetail.pol_fname  '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' wdetail.pol_lname  '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' wdetail.ben_name   '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' wdetail.remark     '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' deci(wdetail.account_no) FORMAT ">>>>>>>>>>>-"  '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' wdetail.client_no  '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' nv_expdat          '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' nv_coamt3          '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' wdetail.province   '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' wdetail.receipt_name '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' wdetail.agent        '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' wdetail.prev_insur   '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' wdetail.prev_pol     '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' nv_deduct3           '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' wdetail.addr1_70     '"' SKIP.  /*Add kridtiya i. A54-0062 ...*/
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' wdetail.addr2_70     '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"' wdetail.nsub_dist70  '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"' wdetail.ndirection70 '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"' wdetail.nprovin70    '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"' wdetail.zipcode70    '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"' wdetail.addr1_72     '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"' wdetail.addr2_72     '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"' wdetail.nsub_dist72  '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"' wdetail.ndirection72 '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"' wdetail.nprovin72    '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"' wdetail.zipcode72    '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"' wdetail.apptyp       '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"' wdetail.appcode      '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"' wdetail.caracc   '"' SKIP.       /*A63-0210*/ 
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"' wdetail.n_pack   '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"' wdetail.n_seattisco  '"' SKIP.   /*Add A57-0017*/
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"' wdetail.bi       '"' SKIP. 
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"' wdetail.pa       '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"' wdetail.pd       '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"' wdetail.n_covcod '"' SKIP.  
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"' wdetail.nproducer '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"' wdetail.nagent   '"' SKIP.  /*Add kridtiya i. A54-0062 ...*/
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"' wdetail.n_branch '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"' wdetail.n_typpol '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x70;K"  '"' "" '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x71;K"  '"' "" '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x72;K"  '"' "" '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x73;K"  '"' "" '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x74;K"  '"' wdetail.id_recive70  '"' SKIP.  
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x75;K"  '"' wdetail.br_recive70  '"' SKIP.  
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x76;K"  '"' wdetail.id_recive72  '"' SKIP.  
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x77;K"  '"' wdetail.br_recive72  '"' SKIP.  
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"  '"' nv_compcomdat   '"' SKIP.       
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K"  '"' nv_compexpdat   '"' SKIP.         
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K"  '"' nv_sumfi3          '"' SKIP.     
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K"  '"' wdetail.class      '"' SKIP.     
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K"  '"' wdetail.usedtype   '"' SKIP.     
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K"  '"' wdetail.driveno1   '"' SKIP.     
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K"  '"' wdetail.drivename1 '"' SKIP.     
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K"  '"' nv_bdatdriv1       '"' SKIP.     
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K"  '"' wdetail.occupdriv1 '"' SKIP.     
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K"  '"' wdetail.positdriv1 '"' SKIP.     
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K"  '"' wdetail.driveno2   '"' SKIP.     
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K"  '"' wdetail.drivename2 '"' SKIP.     
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K"  '"' nv_bdatdriv2    '"'SKIP.          
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K"  '"' wdetail.occupdriv2 '"' SKIP.     
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K"  '"' wdetail.positdriv2 '"' SKIP.     
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K"  '"' wdetail.driveno3   '"' SKIP.     
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K"  '"' wdetail.drivename3 '"' SKIP.     
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X95;K"  '"' nv_bdatdriv3    '"'SKIP.          
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X96;K"  '"' wdetail.occupdriv3 '"' SKIP.     
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X97;K"  '"' wdetail.positdriv3 '"' SKIP. 
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";X98;K"  '"' wdetail.nBLANK     '"' SKIP. 
  /*PUT STREAM ns2 "C;Y" STRING(nv_row) ";X99;K"  '"' nv_72Reciept     '"' SKIP. */ /*A67-0114*/
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x99;K" '"' wdetail.Rec_name72 '"' SKIP.   /*A67-0114*/
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x100;K" '"' wdetail.caracc    '"' SKIP. 
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x101;K" '"' wdetail.Rec_name72 '"' SKIP. 
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x102;K" '"' wdetail.Rec_add1  '"' SKIP. 
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x103;K" '"' wdetail.Rec_add2  '"' SKIP. 
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x104;K" '"' wdetail.polold    '"' SKIP .
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x105;K" '"' wdetail.acctyp     '"' SKIP.    
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x106;K" '"' wdetail.acccovins  '"' SKIP. 
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x107;K" '"' wdetail.accpremt   '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x108;K" '"' wdetail.inspecttyp '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x109;K" '"' wdetail.quotation  '"' SKIP.
  PUT STREAM ns2 "C;Y" STRING(nv_row) ";x110;K" '"' wdetail.covcodtype '"' SKIP.
  /* A67-0087 */
  PUT STREAM ns2 "C;Y" string(nv_row) ";x111;K" '"' wdetail.Schanel    '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x112;K" '"' wdetail.bev        '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x113;K" '"' wdetail.driveno4   '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x114;K" '"' wdetail.drivename4 '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x115;K" '"' nv_bdatdriv4 '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x116;K" '"' wdetail.occupdriv4 '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x117;K" '"' wdetail.positdriv4 '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x118;K" '"' wdetail.driveno5   '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x119;K" '"' wdetail.drivename5 '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x120;K" '"' nv_bdatdriv5 '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x121;K" '"' wdetail.occupdriv5 '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x122;K" '"' wdetail.positdriv5 '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x123;K" '"' wdetail.campagin   '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x124;K" '"' wdetail.inspic     '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x125;K" '"' wdetail.engcount   '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x126;K" '"' wdetail.engno2     '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x127;K" '"' wdetail.engno3     '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x128;K" '"' wdetail.engno4     '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x129;K" '"' wdetail.engno5     '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x130;K" '"' wdetail.classcomp  '"' skip.
  PUT STREAM ns2 "C;Y" string(nv_row) ";x131;K" '"' wdetail.carbrand  '"' skip.
  /* end : A67-0087 */
End.   /*  end  wdetail  */
nv_row  =  nv_row  + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' " Total "             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' String(nv_cnt,"99999")'"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' " ��¡��  "           '"' SKIP.
PUT STREAM ns2 "E".
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

