/* program ID : wgwchkaddr.p  */
/* Description : Chek Code Province , code district and Sub district */
/* create by  : Ranu I. a63-0449 20/11/2020                           */
/* Modify by  : Ranu I. A65-0035 02/02/2022 
                แก้ไขการเช็คข้อมูลกับพารามิเตอร์                        */
/*---------------------------------------------------------------------*/                   
DEF INPUT  PARAMETER n_addr     AS char format "x(350)" .
DEF OUTPUT PARAMETER n_addrcod1 AS char format "x(2)" .
DEF OUTPUT PARAMETER n_addrcod2 AS char format "x(2)" .
DEF OUTPUT PARAMETER n_addrcod3 AS char format "x(2)" .
DEF OUTPUT PARAMETER nv_chkerror AS CHAR FORMAT "x(150)" .

def var n_address  as char format "x(350)" init "" .
def var n_tambon   as char format "x(50)"  init "" .
def var n_amper    as char format "x(50)"  init "" .
def var n_country  as char format "x(50)"  init "" .
def var n_post     as char format "x(5)"  init "" .
DEF VAR n_length   AS INT INIT 0.
/* test 
DEF VAR n_addr AS CHAR FORMAT "x(350)" INIT "" .  
def var n_addrcod1 AS char format "x(2)" .
def var n_addrcod2 AS char format "x(2)" .
def var n_addrcod3 AS char format "x(2)" .
DEF VAR nv_chkerror AS CHAR FORMAT "x(150)" .*/

DO:
    ASSIGN
            n_address  = trim(n_addr) 
            n_tambon   = ""         
            n_amper    = ""         
            n_country  = ""         
            n_post     = ""
            nv_chkerror = "".  

        IF INDEX(n_address,"บมจ.") <> 0 THEN ASSIGN  n_address  =  REPLACE(n_address,"บมจ.","บมก.") . /*A64-0035*/

        IF INDEX(n_address,"จ." ) <> 0 THEN DO: 
            ASSIGN 
            n_country  =  trim(SUBSTR(n_address,R-INDEX(n_address,"จ.")))
            n_length   =  LENGTH(n_country)
            n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
            n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
            n_country  =  trim(SUBSTR(n_country,1,n_length - LENGTH(n_post))).
    
            IF INDEX(n_country,"จ." ) <> 0 THEN n_country  = trim(REPLACE(n_country,"จ.","")) . /*A64-0035*/
        END.
        ELSE IF INDEX(n_address,"จังหวัด" ) <> 0 THEN DO: 
            ASSIGN 
            n_country  =  trim(SUBSTR(n_address,INDEX(n_address,"จังหวัด"),LENGTH(n_address)))
            n_length   =  LENGTH(n_country)
            n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
            n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length)  ELSE ""
            n_country  =  trim(SUBSTR(n_country,1,n_length - LENGTH(n_post))).
    
            IF INDEX(n_country,"จังหวัด" ) <> 0 THEN n_country  = trim(REPLACE(n_country,"จังหวัด","")) . /*A64-0035*/
        END.
        ELSE IF INDEX(n_address,"กทม" ) <> 0 THEN DO: 
            ASSIGN 
            n_country  =  trim(SUBSTR(n_address,INDEX(n_address,"กทม"),LENGTH(n_address)))
            n_length   =  LENGTH(n_country)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length)
            n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
            n_country  =  trim(SUBSTR(n_country,1,n_length - LENGTH(n_post))).
        END.
        ELSE IF INDEX(n_address,"กรุงเทพ" ) <> 0 THEN DO: 
            ASSIGN 
            n_country  =  trim(SUBSTR(n_address,INDEX(n_address,"กรุงเทพ"),LENGTH(n_address)))
            n_length   =  LENGTH(n_country) 
            n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
            n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
            n_country  =  trim(SUBSTR(n_country,1,n_length - LENGTH(n_post))).
        END.
        ELSE DO:
            ASSIGN 
            n_country  =  TRIM(SUBSTR(n_address,R-INDEX(n_address," "),LENGTH(n_address)))
            n_length   =  LENGTH(n_country)
            n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length)).
        END.
        
        IF INDEX(n_address,"อ.") <> 0 THEN DO: 
            ASSIGN 
            n_amper    =  trim(SUBSTR(n_address,INDEX(n_address,"อ."),LENGTH(n_address)))
            n_length   =  LENGTH(n_amper)
            n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length)) .
    
            IF INDEX(n_amper,"อ." ) <> 0 THEN n_amper  = trim(REPLACE(n_amper,"อ.","")) . /*A64-0035*/
        END.
        ELSE IF INDEX(n_address,"อำเภอ" ) <> 0 THEN DO: 
            ASSIGN 
            n_amper    =  trim(SUBSTR(n_address,INDEX(n_address,"อำเภอ"),LENGTH(n_address)))
            n_length   =  LENGTH(n_amper) 
            n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length)).
    
            IF INDEX(n_amper,"อำเภอ" ) <> 0 THEN n_amper  = trim(REPLACE(n_amper,"อำเภอ","")) . /*A64-0035*/
        END.
        ELSE IF INDEX(n_address,"เขต" ) <> 0 THEN DO: 
            ASSIGN 
            n_amper    =  trim(SUBSTR(n_address,INDEX(n_address,"เขต"),LENGTH(n_address)))
            n_length   =  LENGTH(n_amper) 
            n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length)).
    
            IF INDEX(n_amper,"เขต" ) <> 0 THEN n_amper  = trim(REPLACE(n_amper,"เขต","")) . /*A64-0035*/
    
        END.
        
        IF INDEX(n_address,"ต.") <> 0 THEN DO: 
            ASSIGN 
            n_tambon  =  trim(SUBSTR(n_address,INDEX(n_address,"ต."),LENGTH(n_address)))
            n_length  =  LENGTH(n_tambon) 
            n_address =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
    
            IF INDEX(n_tambon,"ต." ) <> 0 THEN n_tambon  = trim(REPLACE(n_tambon,"ต.","")) . /*A64-0035*/
    
        END.
        ELSE IF INDEX(n_address,"ตำบล" ) <> 0 THEN DO: 
            ASSIGN 
            n_tambon  =  TRIM(SUBSTR(n_address,INDEX(n_address,"ตำบล"),LENGTH(n_address)))
            n_length   = LENGTH(n_tambon)
            n_address  = SUBSTR(n_address,1,LENGTH(n_address) - n_length).
    
            IF INDEX(n_tambon,"ตำบล" ) <> 0 THEN n_tambon  = trim(REPLACE(n_tambon,"ตำบล","")) . /*A64-0035*/
    
        END.
        ELSE IF INDEX(n_address,"แขวง" ) <> 0 THEN DO: 
            ASSIGN 
            n_tambon   =  trim(SUBSTR(n_address,INDEX(n_address,"แขวง"),LENGTH(n_address)))
            n_length   =  LENGTH(n_tambon)  
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
    
            IF INDEX(n_tambon,"แขวง" ) <> 0 THEN n_tambon  = trim(REPLACE(n_tambon,"แขวง","")) . /*A64-0035*/
        END.
    
        IF      index(n_country,"กรุงเทพ")   <> 0 THEN n_country = "กรุงเทพมหานคร".
        ELSE IF INDEX(n_country,"กทม")       <> 0 THEN n_country = "กรุงเทพมหานคร".
        ELSE IF INDEX(n_country,"อุบลฯ")     <> 0 THEN n_country = "อุบลราชธานี".
        ELSE IF INDEX(n_country,"อุดรฯ")     <> 0 THEN n_country = "อุดรธานี".
        ELSE IF INDEX(n_country,"ประจวบฯ")   <> 0 THEN n_country = "ประจวบคีรีขันธ์".
        ELSE IF INDEX(n_country,"สุราษฯ")    <> 0 THEN n_country = "สุราษฎร์ธานี".
        ELSE IF INDEX(n_country,"นครศรีฯ")   <> 0 THEN n_country = "นครศรีธรรมราช".
        ELSE IF INDEX(n_country,"อยุธยา")    <> 0 THEN n_country = "พระนครศรีอยุธยา".
    
        FIND LAST sicuw.uwm500 USE-INDEX uwm50002 WHERE 
            INDEX(sicuw.uwm500.prov_d,n_country) <> 0  OR /*A64-0035*/
            index(n_country,sicuw.uwm500.prov_d) <> 0  NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm500 THEN DO: 
            ASSIGN n_addrcod1 = trim(sicuw.uwm500.prov_n) .
            FIND LAST sicuw.uwm501 USE-INDEX uwm50102 WHERE 
                      sicuw.uwm501.prov_n = sicuw.uwm500.prov_n AND 
                      (INDEX(sicuw.uwm501.dist_d,n_amper) <> 0  OR /*A65-0035*/
                       INDEX(n_amper,sicuw.uwm501.dist_d) <> 0  )  NO-LOCK NO-ERROR.
            IF AVAIL sicuw.uwm501 THEN DO: 
                ASSIGN n_addrcod2 = trim(sicuw.uwm501.dist_n) .
                FIND LAST sicuw.uwm506 USE-INDEX uwm50601 WHERE 
                          uwm506.prov_n = uwm500.prov_n AND
                          uwm506.dist_n = uwm501.dist_n AND 
                          (INDEX(trim(uwm506.sdist_d),n_tambon) <> 0  OR  /*A65-0035*/
                           INDEX(n_tambon,trim(uwm506.sdist_d)) <> 0  ) NO-LOCK NO-ERROR.
                IF AVAIL uwm506 THEN ASSIGN n_addrcod3 = uwm506.sdist_n .
                ELSE ASSIGN nv_chkerror = nv_chkerror + "|ไม่พบรหัสตำบล " + n_tambon.
            END.
            ELSE ASSIGN nv_chkerror = nv_chkerror + "|ไม่พบรหัสอำเภอ " + n_amper.
        END.
        ELSE ASSIGN nv_chkerror = nv_chkerror + "|ไม่พบรหัสจังหวัด " + n_country.
END.

/*
DISP n_addrcod1  n_country  format "x(50) "  skip
     n_addrcod2  n_amper    format "x(50) " skip
     n_addrcod3  n_tambon   format "x(50) "  skip
     nv_chkerror FORMAT "x(70)" .*/
