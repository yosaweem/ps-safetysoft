/*------------------------------------------------------------------------*/
/*programid   : wgwtnce2.i                                               */
/*programname : Match File Thanachat                                    */
/* Copyright  : Safety Insurance Public Company Limited 			     */
/*			    ����ѷ ��Сѹ������� �ӡѴ (��Ҫ�)				         */
/*create by   : Ranu I. A61-0512 date 31/10/2018           
                �纵���âͧ����� Match File comfirm ���ҵ            */
/*Modify by   : Kridtiya i. A60-0160 Date. 15/08/2023 nCOLOR mobile  receipaddr  sendaddr  notifycode salenotify */     
                                                    
/*************************************************************************/
 
 DEFINE NEW SHARED TEMP-TABLE wrec NO-UNDO
     FIELD not_date      AS CHAR FORMAT "X(15)"  INIT ""    /*�ѹ����Ѻ��           */
     FIELD Notify_no     AS CHAR FORMAT "X(18)"  INIT ""    /*�Ţ����Ѻ��           */
     FIELD Account_no    AS CHAR FORMAT "X(20)"  INIT ""    /*�Ң� � �Ţ����ѭ�� */  
     FIELD not_office    AS CHAR FORMAT "X(35)"  INIT ""    /*���ͻ�Сѹ���         *//*���ͼ����һ�Сѹ���*/    
     FIELD ctype         AS CHAR FORMAT "X(15)"  INIT ""    /*��Ѥ��/�ú.            */
     FIELD comdat        AS CHAR FORMAT "X(15)"  INIT ""    /*�ѹ��������������ͧ*/      
     FIELD expdat        AS CHAR FORMAT "X(15)"  INIT ""    /*�ѹ�������ش           */
     FIELD prem          AS CHAR FORMAT "X(15)"  INIT ""    /*������»�Сѹ������*/     
     FIELD paydate       AS CHAR FORMAT "X(15)"  INIT ""    /*�ѹ����١��Ҫ������¤����ش����*/
     FIELD prevpol       AS CHAR FORMAT "x(15)"  INIT ""    /*A60-0383*/
     FIELD loss          AS CHAR FORMAT "x(10)"  INIT ""    /*A60-0383*/
     FIELD remark        AS CHAR FORMAT "X(15)"  INIT ""
     field company       as char format "x(100)" INIT ""     /*����ѷ��Сѹ���        */       
     field ben_name      as char format "x(60)"  INIT ""            /*����Ѻ�Ż���ª��        */       
     field licence       as char format "x(13)"  init ""      /*�Ţ����¹              */       
     field province      as char format "x(25)"  init ""      /*�ѧ��Ѵ                 */       
     field ins_amt       as char format "x(15)"  init ""      /*�ع��Сѹ               */       
     field prem1         as char format "x(15)"  init ""      /*���»�Сѹ�ط��        */       
     field not_name      as char format "x(75)"  init ""      /*���ͻ�Сѹ���           */       
     field brand         as char format "x(35)"  init ""      /*������                  */       
     field Brand_Model   as char format "x(60)"  init ""      /*���                    */       
     field yrmanu        as char format "x(4)"  init ""      /*��                      */       
     field weight        as char format "x(6)"  init ""      /*��Ҵ����ͧ             */       
     field engine        as char format "x(50)"  init ""      /*�Ţ����ͧ              */       
     field chassis       as char format "x(50)"  init ""      /*�Ţ�ѧ                  */       
     field pattern       as char format "x(100)"  init ""      /*Pattern Rate            */       
     field covcod        as char format "x(3)"  init ""      /*��������Сѹ            */       
     field vehuse        as char format "x(50)"  init ""      /*������ö                */       
     field sclass        as char format "x(5)"  init ""      /*����ö                  */       
     field garage        as char format "x(10)"  init ""      /*ʶҹ������             */       
     field drivename1    as char format "x(100)"  init ""      /*�кؼ��Ѻ���1          */       
     field driveid1      as char format "x(13)"  init ""      /*�Ţ���㺢Ѻ���1         */       
     field driveic1      as char format "x(13)"  init ""      /*�Ţ���ѵû�ЪҪ�1      */       
     field drivedate1    as char format "x(15)"  init ""      /*�ѹ��͹���Դ1         */       
     field drivname2     as char format "x(100)"  init ""      /*�кؼ��Ѻ���2          */       
     field driveid2      as char format "x(13)"  init ""      /*�Ţ���㺢Ѻ���2         */       
     field driveic2      as char format "x(13)"  init ""      /*�Ţ���ѵû�ЪҪ�2      */       
     field drivedate2    as char format "x(15)"  init ""      /*�ѹ��͹���Դ2         */       
     field cl            as char format "x(10)"  init ""      /*��ǹŴ����ѵ�����       */       
     field fleetper      as char format "x(10)"  init ""      /*��ǹŴ�����             */       
     field ncbper        as char format "x(10)"  init ""      /*����ѵԴ�               */       
     field othper        as char format "x(10)"  init ""      /*��� �                  */       
     field pol_addr1     as char format "x(150)"  init ""      /*��������١���           */       
     field icno          as char format "x(13)"  init ""      /*IDCARD                  */       
     field icno_st       as char format "x(15)"  init ""      /*DateCARD_S              */       
     field icno_ex       as char format "x(15)"  init ""      /*DateCARD_E              */       
     field bdate         as char format "x(15)"  init ""      /*Birth Date              */       
     field paidtyp       as char format "x(25)"  init ""      /*Type_Paid_1             */       
     field paid          as char format "x(15)"  init ""      /*Paid_Amount             */       
     field prndate       as char format "x(15)"  init ""      /*�ѹ������� �ú.        */       
     field sckno         as char format "x(35)"  init ""       /*�Ţʵԡ���� / �Ţ ��.  */
     field nCOLOR        as char format "x(50)"   init ""    /*A66-0160*/
     field mobile        as char format "x(50)"   init ""    /*A66-0160*/
     field receipaddr    as char format "x(150)"  init ""    /*A66-0160*/
     field sendaddr      as char format "x(150)"  init ""    /*A66-0160*/
     field notifycode    as char format "x(50)"   init ""    /*A66-0160*/
     field salenotify    as char format "x(150)"  init ""   /*A66-0160*/
     field ACCESSORY     as char format "x(250)"  init "".   /*A66-0160*/
