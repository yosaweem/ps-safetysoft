/* create by : Ranu I. A65-0288 เก็บค่าตัวแปรของถังพัก KK */
/*Modify by : Ranu I. A67-0076 เพิ่มเงื่อนไขการเก็บข้อมูลรถไฟฟ้า */
/*---------------------------------------------------------*/
DEFINE NEW SHARED TEMP-TABLE wcancel NO-UNDO
  FIELD   num               as char init ""         
  FIELD   Cdate             as char init ""   
  FIELD   ProductSub        as char init ""   
  FIELD   ProductCode       as char init ""   
  FIELD   PackageCode       as char init ""   
  FIELD   PackageName       as char init ""   
  FIELD   Insurer           as char init ""   
  FIELD   KKApp             as char init ""   
  FIELD   KKQuo             as char init ""   
  FIELD   RiderNo           as char init ""   
  FIELD   InsurerApp        as char init ""   
  FIELD   LoanContract      as char init ""   
  FIELD   Notified          as char init ""   
  FIELD   Policy            as char init ""   
  FIELD   PolType           as char init ""   
  FIELD   AppDate           as char init ""   
  FIELD   PolAppDate        as char init ""    
  FIELD   EffDate           as char init ""     
  FIELD   ExpDate           as char init ""     
  FIELD   Rencnt            as char init ""   
  FIELD   polstatus         as char init ""   
  FIELD   YR                as char init ""   
  FIELD   SI                as char init ""   
  FIELD   NetPrem           as char init ""   
  FIELD   Stamp             as char init ""   
  FIELD   VAT               as char init ""   
  FIELD   Grossprm          as char init ""   
  FIELD   Wht               as char init ""   
  FIELD   PremAmt           as char init ""   
  FIELD   DiscountAmt       as char init ""   
  FIELD   ActualPrm         AS char init ""   
  FIELD   PayInsAmt         AS char init ""  
  FIELD   PrmReceiveTyp     as char init ""  
  FIELD   Creason           as char init ""   
  FIELD   CreasonDesc       as char init ""   
  FIELD   Remark            as char init ""   
  FIELD   BRCode            as char init ""   
  FIELD   BRName            as char init ""   
  FIELD   BU                as char init ""   
  FIELD   KKFlag            AS CHAR INIT ""   
  FIELD   InsCardType       AS CHAR INIT "" 
  FIELD   InsCardNo         as char init ""   
  FIELD   InsType           as char init ""   
  FIELD   InsTitleName      as char init ""   
  FIELD   InsName           as char init ""   
  FIELD   LicenseNo         as char init ""   
  FIELD   LicenseIssue      as char init ""   
  FIELD   Chassis           as char init ""   
  FIELD   AgentTName        AS CHAR INIT ""   
  FIELD   AgentName         AS CHAR INIT "" 
  FIELD   sts               AS CHAR INIT "" 
  FIELD   polno             AS CHAR INIT ""
  FIELD   releas            AS CHAR INIT "" .

DEFINE NEW SHARED TEMP-TABLE wpol NO-UNDO
  FIELD   Num                     as char init ""         
  FIELD   DueDate                 as char init ""   
  FIELD   AgingIssue              as char init ""   
  FIELD   BRCode                  as char init ""   
  FIELD   BRName                  as char init ""   
  FIELD   BU                      as char init ""   
  FIELD   Insurer                 as char init ""   
  FIELD   PD_SubGroup             as char init ""   
  FIELD   PD_Code                 as char init ""   
  FIELD   Pack_Code               as char init ""   
  FIELD   Pack_Name               as char init ""   
  FIELD   AppDate                 as char init ""   
  FIELD   EffDate                 as char init ""   
  FIELD   ExpDate                 as char init ""   
  FIELD   KKApp                   as char init ""   
  FIELD   KKQuo                   as char init ""   
  FIELD   SourceID                as char init ""    
  FIELD   InsAppNo                as char init ""     
  FIELD   LoanNo                  as char init ""     
  FIELD   notifyno                as char init ""   
  FIELD   NotifiedDate            as char init ""   
  FIELD   PayTName                as char init ""   
  FIELD   PayName                 as char init ""   
  FIELD   InsTName                as char init ""   
  FIELD   InsName                 as char init ""   
  FIELD   SumInsure               as char init ""   
  FIELD   NetPremium              as char init ""   
  FIELD   Stamp                   as char init ""   
  FIELD   VAT                     as char init ""   
  FIELD   GrossPremium            as char init ""   
  FIELD   PaymentPeriod           AS char init ""   
  FIELD   PolicyStatus            AS char init ""  
  FIELD   chassis                 as char init ""  
  FIELD   KKOfferFlag             as char init ""   
  FIELD   LicenseNo               as char init ""   
  FIELD   LicenseProv             as char init ""
  FIELD   policy                  as char init "" 
  FIELD   Remark                  as char init "" 
  FIELD   inspRemark              as char init "" 
  FIELD   Hproblem                as char init "" 
  FIELD   Hclaim                  as char init "" 
  FIELD   PolStatus               AS CHAR INIT "" 
  FIELD   premiumpol              AS CHAR INIT ""     .


Def  Var chNotesSession  As Com-Handle.
Def  Var chNotesDataBase As Com-Handle.
Def  Var chDocument      As Com-Handle.
Def  Var chNotesView     As Com-Handle .
Def  Var chNavView       As Com-Handle .
Def  Var chViewEntry     As Com-Handle .
Def  Var chItem          As Com-Handle .
Def  Var chData          As Com-Handle .
Def  Var nv_server       As Char.
Def  Var nv_tmp          As char .
def  var nv_extref       as char.
DEF VAR nv_nameT         AS CHAR FORMAT "X(50)".
DEF VAR nv_agentname     AS CHAR FORMAT "X(60)".
DEF VAR nv_brand         AS CHAR FORMAT "X(50)". 
DEF VAR nv_model         AS CHAR FORMAT "X(50)". 
DEF VAR nv_licentyp      AS CHAR FORMAT "X(50)".
DEF VAR nv_licen         AS CHAR FORMAT "X(20)". 
DEF VAR nv_pattern1      AS CHAR FORMAT "X(20)".  
DEF VAR nv_pattern4      AS CHAR FORMAT "X(20)".  
DEF VAR nv_today         AS CHAR init "" .
DEF VAR nv_time          AS CHAR init "" .
DEF VAR nv_docno         AS CHAR FORMAT "x(25)".
DEF VAR nv_survey        AS CHAR FORMAT "x(25)".
DEF VAR nv_detail        AS CHAR FORMAT "x(30)".
DEF VAR nv_remark1       AS CHAR FORMAT "x(250)".
DEF VAR nv_remark2       AS CHAR FORMAT "x(250)".
DEF VAR nv_remark3       AS CHAR FORMAT "x(250)".
DEF VAR nv_remark4       AS CHAR FORMAT "x(250)".
DEF VAR nv_damlist       AS CHAR FORMAT "x(150)" INIT "" .
DEF VAR nv_damage        AS CHAR FORMAT "x(250)" INIT "" .
DEF VAR nv_totaldam      AS CHAR FORMAT "X(150)" .
DEF VAR nv_attfile       AS CHAR FORMAT "x(100)" INIT "" .
DEF VAR nv_device        AS CHAR FORMAT "x(500)" INIT "".
Def var nv_acc1          as char format "x(50)".   
Def var nv_acc2          as char format "x(50)".   
Def var nv_acc3          as char format "x(50)".   
Def var nv_acc4          as char format "x(50)".   
Def var nv_acc5          as char format "x(50)".   
Def var nv_acc6          as char format "x(50)".   
Def var nv_acc7          as char format "x(50)".   
Def var nv_acc8          as char format "x(50)".   
Def var nv_acc9          as char format "x(50)".   
Def var nv_acc10         as char format "x(50)".   
Def var nv_acc11         as char format "x(50)".   
Def var nv_acc12         as char format "x(50)".   
Def var nv_acctotal      as char format "x(100)".   
DEF VAR nv_surdata       AS CHAR FORMAT "x(250)".  
DEF VAR nv_date          AS CHAR FORMAT "x(15)" .
DEF VAR nv_damdetail     AS LONGCHAR .

def var nv_price1     as char init "" .
def var nv_price2     as char init "" .
def var nv_price3     as char init "" .
def var nv_price4     as char init "" .
def var nv_price5     as char init "" .
def var nv_price6     as char init "" .
def var nv_price7     as char init "" .
def var nv_price8     as char init "" .
def var nv_price9     as char init "" .
def var nv_price10    as char init "" .
def var nv_price11    as char init "" .
def var nv_price12    as char init "" .
DEF VAR nv_fname  AS CHAR INIT "".
DEF VAR nv_lname  AS CHAR INIT "". 

/* add by : A67-0076 */
def var nv_drioccup1    as char init "" no-undo.     
def var nv_driToccup1   as char init "" no-undo.     
def var nv_driTicono1   as char init "" no-undo.     
def var nv_driICNo1     as char init "" no-undo. 
def var nv_drioccup2    as char init "" no-undo.     
def var nv_driToccup2   as char init "" no-undo.     
def var nv_driTicono2   as char init "" no-undo.     
def var nv_driICNo2     as char init "" no-undo.     
def var nv_drioccup3    as char init "" no-undo.     
def var nv_driToccup3   as char init "" no-undo.     
def var nv_driTicono3   as char init "" no-undo.     
def var nv_driICNo3     as char init "" no-undo.    
def var nv_drioccup4    as char init "" no-undo.     
def var nv_driToccup4   as char init "" no-undo.     
def var nv_driTicono4   as char init "" no-undo.     
def var nv_driICNo4     as char init "" no-undo.     
def var nv_drioccup5    as char init "" no-undo.     
def var nv_driToccup5   as char init "" no-undo.     
def var nv_driTicono5   as char init "" no-undo.     
def var nv_driICNo5     as char init "" no-undo. 
/* end : A67-0076 */
