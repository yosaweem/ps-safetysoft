/* program ID : wgwchkaddr.p  */
/* Description : Chek Code Province , code district and Sub district */
/* create by  : Ranu I. a63-0449 20/11/2020                           */
/* Modify by  : Ranu I. A65-0035 02/02/2022 
                ��䢡���礢����šѺ����������                        */
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

        IF INDEX(n_address,"���.") <> 0 THEN ASSIGN  n_address  =  REPLACE(n_address,"���.","���.") . /*A64-0035*/

        IF INDEX(n_address,"�." ) <> 0 THEN DO: 
            ASSIGN 
            n_country  =  trim(SUBSTR(n_address,R-INDEX(n_address,"�.")))
            n_length   =  LENGTH(n_country)
            n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
            n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
            n_country  =  trim(SUBSTR(n_country,1,n_length - LENGTH(n_post))).
    
            IF INDEX(n_country,"�." ) <> 0 THEN n_country  = trim(REPLACE(n_country,"�.","")) . /*A64-0035*/
        END.
        ELSE IF INDEX(n_address,"�ѧ��Ѵ" ) <> 0 THEN DO: 
            ASSIGN 
            n_country  =  trim(SUBSTR(n_address,INDEX(n_address,"�ѧ��Ѵ"),LENGTH(n_address)))
            n_length   =  LENGTH(n_country)
            n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
            n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length)  ELSE ""
            n_country  =  trim(SUBSTR(n_country,1,n_length - LENGTH(n_post))).
    
            IF INDEX(n_country,"�ѧ��Ѵ" ) <> 0 THEN n_country  = trim(REPLACE(n_country,"�ѧ��Ѵ","")) . /*A64-0035*/
        END.
        ELSE IF INDEX(n_address,"���" ) <> 0 THEN DO: 
            ASSIGN 
            n_country  =  trim(SUBSTR(n_address,INDEX(n_address,"���"),LENGTH(n_address)))
            n_length   =  LENGTH(n_country)
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length)
            n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
            n_country  =  trim(SUBSTR(n_country,1,n_length - LENGTH(n_post))).
        END.
        ELSE IF INDEX(n_address,"��ا෾" ) <> 0 THEN DO: 
            ASSIGN 
            n_country  =  trim(SUBSTR(n_address,INDEX(n_address,"��ا෾"),LENGTH(n_address)))
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
        
        IF INDEX(n_address,"�.") <> 0 THEN DO: 
            ASSIGN 
            n_amper    =  trim(SUBSTR(n_address,INDEX(n_address,"�."),LENGTH(n_address)))
            n_length   =  LENGTH(n_amper)
            n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length)) .
    
            IF INDEX(n_amper,"�." ) <> 0 THEN n_amper  = trim(REPLACE(n_amper,"�.","")) . /*A64-0035*/
        END.
        ELSE IF INDEX(n_address,"�����" ) <> 0 THEN DO: 
            ASSIGN 
            n_amper    =  trim(SUBSTR(n_address,INDEX(n_address,"�����"),LENGTH(n_address)))
            n_length   =  LENGTH(n_amper) 
            n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length)).
    
            IF INDEX(n_amper,"�����" ) <> 0 THEN n_amper  = trim(REPLACE(n_amper,"�����","")) . /*A64-0035*/
        END.
        ELSE IF INDEX(n_address,"ࢵ" ) <> 0 THEN DO: 
            ASSIGN 
            n_amper    =  trim(SUBSTR(n_address,INDEX(n_address,"ࢵ"),LENGTH(n_address)))
            n_length   =  LENGTH(n_amper) 
            n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length)).
    
            IF INDEX(n_amper,"ࢵ" ) <> 0 THEN n_amper  = trim(REPLACE(n_amper,"ࢵ","")) . /*A64-0035*/
    
        END.
        
        IF INDEX(n_address,"�.") <> 0 THEN DO: 
            ASSIGN 
            n_tambon  =  trim(SUBSTR(n_address,INDEX(n_address,"�."),LENGTH(n_address)))
            n_length  =  LENGTH(n_tambon) 
            n_address =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
    
            IF INDEX(n_tambon,"�." ) <> 0 THEN n_tambon  = trim(REPLACE(n_tambon,"�.","")) . /*A64-0035*/
    
        END.
        ELSE IF INDEX(n_address,"�Ӻ�" ) <> 0 THEN DO: 
            ASSIGN 
            n_tambon  =  TRIM(SUBSTR(n_address,INDEX(n_address,"�Ӻ�"),LENGTH(n_address)))
            n_length   = LENGTH(n_tambon)
            n_address  = SUBSTR(n_address,1,LENGTH(n_address) - n_length).
    
            IF INDEX(n_tambon,"�Ӻ�" ) <> 0 THEN n_tambon  = trim(REPLACE(n_tambon,"�Ӻ�","")) . /*A64-0035*/
    
        END.
        ELSE IF INDEX(n_address,"�ǧ" ) <> 0 THEN DO: 
            ASSIGN 
            n_tambon   =  trim(SUBSTR(n_address,INDEX(n_address,"�ǧ"),LENGTH(n_address)))
            n_length   =  LENGTH(n_tambon)  
            n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
    
            IF INDEX(n_tambon,"�ǧ" ) <> 0 THEN n_tambon  = trim(REPLACE(n_tambon,"�ǧ","")) . /*A64-0035*/
        END.
    
        IF      index(n_country,"��ا෾")   <> 0 THEN n_country = "��ا෾��ҹ��".
        ELSE IF INDEX(n_country,"���")       <> 0 THEN n_country = "��ا෾��ҹ��".
        ELSE IF INDEX(n_country,"�غ��")     <> 0 THEN n_country = "�غ��Ҫ�ҹ�".
        ELSE IF INDEX(n_country,"�ش��")     <> 0 THEN n_country = "�شøҹ�".
        ELSE IF INDEX(n_country,"��ШǺ�")   <> 0 THEN n_country = "��ШǺ���բѹ��".
        ELSE IF INDEX(n_country,"������")    <> 0 THEN n_country = "����ɮ��ҹ�".
        ELSE IF INDEX(n_country,"�������")   <> 0 THEN n_country = "�����ո����Ҫ".
        ELSE IF INDEX(n_country,"��ظ��")    <> 0 THEN n_country = "��й�������ظ��".
    
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
                ELSE ASSIGN nv_chkerror = nv_chkerror + "|��辺���ʵӺ� " + n_tambon.
            END.
            ELSE ASSIGN nv_chkerror = nv_chkerror + "|��辺��������� " + n_amper.
        END.
        ELSE ASSIGN nv_chkerror = nv_chkerror + "|��辺���ʨѧ��Ѵ " + n_country.
END.

/*
DISP n_addrcod1  n_country  format "x(50) "  skip
     n_addrcod2  n_amper    format "x(50) " skip
     n_addrcod3  n_tambon   format "x(50) "  skip
     nv_chkerror FORMAT "x(70)" .*/
