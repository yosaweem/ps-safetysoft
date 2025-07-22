/************************************************************************/
/* wgweispno.p   Webservice create inspection box      		           */
/* Create By   : Songkran P. Date 01/06/2022 A65-0141                  */
/*---------------------------------------------------------------------*/

DEFINE VARIABLE hWebService       AS HANDLE NO-UNDO.
DEFINE VARIABLE hcreateInspection AS HANDLE NO-UNDO.
DEFINE VARIABLE cBody             AS LONGCHAR NO-UNDO.
DEFINE VARIABLE IStatus1          AS LOGICAL INIT NO.
DEFINE VARIABLE nv_urlinp         AS CHAR INIT "".
DEFINE VARIABLE nv_NewInput       AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_outp           AS CHARACTER NO-UNDO.
DEFINE TEMP-TABLE REQUESTWS NO-UNDO 
	FIELD REQTYPESUB  AS CHAR
	FIELD CREATEDBY   AS CHAR
	FIELD BRANCHREQ   AS CHAR
	FIELD DATES       AS CHAR
	FIELD DATEE       AS CHAR
	FIELD TNAME       AS CHAR
	FIELD FNAME       AS CHAR
	FIELD LNAME       AS CHAR
	FIELD PHONE       AS CHAR
	FIELD POLICYNO    AS CHAR
	FIELD AGENTCODE   AS CHAR
	FIELD AGENTNAME   AS CHAR
	FIELD PREMIUM     AS CHAR
	FIELD LICENSETYPE AS CHAR
	FIELD LICENSENO_1 AS CHAR
	FIELD LICENSENO_2 AS CHAR
	FIELD YEAR        AS CHAR
	FIELD MODEL       AS CHAR
	FIELD MODELCODE   AS CHAR
	FIELD SENDTO      AS CHAR
	FIELD SENDCC      AS CHAR
	FIELD SENDCLOSE   AS CHAR
	FIELD CREATEDON   AS CHAR
    FIELD CARCC       AS CHAR
    FIELD GARAGE      AS CHAR
    . 
DEFINE DATASET REQUESTWSDset NAMESPACE-URI "urn:DefaultNamespace" 
	XML-NODE-TYPE "HIDDEN" 
	FOR REQUESTWS.
DEFINE TEMP-TABLE CREATEDOCUMENTReturn NO-UNDO
	FIELD DOCNO      AS CHARACTER 
	FIELD CODESTATUS AS CHARACTER 
	FIELD CODEDETAIL AS CHARACTER .

DEFINE DATASET CREATEDOCUMENTReturnDset NAMESPACE-URI "urn:DefaultNamespace" 
    XML-NODE-TYPE "HIDDEN" 
    FOR CREATEDOCUMENTReturn.

DEFINE INPUT PARAMETER nv_ispce AS CHAR INIT "".
DEFINE INPUT PARAMETER TABLE FOR REQUESTWS.
DEFINE OUTPUT PARAMETER TABLE FOR CREATEDOCUMENTReturn.

nv_NewInput = STRING(YEAR(TODAY),"9999")
            + STRING(MONTH(TODAY),"99")
            + STRING(DAY(TODAY),"99")
            + SUBSTR(STRING(DATETIME(TODAY, MTIME)),12,12).
nv_outp = STRING(YEAR(TODAY),"9999") + STRING(MONTH(TODAY),"99") + "_wgweispws.txt".

FIND FIRST REQUESTWS NO-ERROR.

cBody = '<ns0:REQUESTWS xmlns:ns0="urn:DefaultNamespace">
          <REQTYPESUB>' + REQTYPESUB + '</REQTYPESUB>
          <CREATEDBY>' + CREATEDBY + '</CREATEDBY>
          <BRANCHREQ>' + BRANCHREQ + '</BRANCHREQ>
          <DATES>' + DATES + '</DATES>
          <DATEE>' + DATEE + '</DATEE>
          <TNAME>' + TNAME + '</TNAME>
          <FNAME>' + FNAME + '</FNAME>
          <LNAME>' + LNAME + '</LNAME>
          <PHONE>' + PHONE + '</PHONE>
          <POLICYNO>' + POLICYNO + '</POLICYNO>
          <AGENTCODE>' + AGENTCODE + '</AGENTCODE>
          <AGENTNAME>' + AGENTNAME + '</AGENTNAME>
          <PREMIUM>' + PREMIUM + '</PREMIUM>
          <LICENSETYPE>' + LICENSETYPE + '</LICENSETYPE>
          <LICENSENO_1>' + LICENSENO_1 + '</LICENSENO_1>
          <LICENSENO_2>' + LICENSENO_2 + '</LICENSENO_2>
          <YEAR>' + YEAR + '</YEAR>
          <MODEL>' + MODEL + '</MODEL>
          <MODELCODE>' + MODELCODE + '</MODELCODE>
          <SENDTO>' + SENDTO + '</SENDTO>
          <SENDCC>' + SENDCC + '</SENDCC>
          <SENDCLOSE>' + SENDCLOSE + '</SENDCLOSE>
          <CREATEDON>' + CREATEDON + '</CREATEDON>
          <CARCC>' + CARCC + '</CARCC>
          <GARAGE>' + GARAGE + '</GARAGE>
        </ns0:REQUESTWS>'.


/*
IF nv_ispce = "1" THEN nv_urlinp = "-WSDL 'http://10.35.1.200/web/ws_ins.nsf/CreateInspection(Test)?WSDL'".
ELSE IF nv_ispce = "2" THEN nv_urlinp = "-WSDL 'http://10.35.1.200/web/ws_ins.nsf/CreateInspectionNormal(Test)?WSDL'".
*/

IF nv_ispce = "1" THEN nv_urlinp = "-WSDL 'http://10.35.1.200/web/ws_ins.nsf/CreateInspection?WSDL'".
ELSE IF nv_ispce = "2" THEN nv_urlinp = "-WSDL 'http://10.35.1.200/web/ws_ins.nsf/CreateInspectionNormal?WSDL'".


CREATE SERVER hWebService.
IStatus1 = hWebService:CONNECT(nv_urlinp) NO-ERROR.


IF ERROR-STATUS:ERROR  THEN DO:
    RUN pd_log("Not Found The Statement").
    hWebService:DISCONNECT()     NO-ERROR.  
    DELETE OBJECT hWebService    NO-ERROR.
    RETURN.
END.

IF nv_ispce = "1"THEN RUN createInspection SET hcreateInspection ON hWebService NO-ERROR.
ELSE IF nv_ispce = "2" THEN  RUN createInspectionnormal SET hcreateInspection ON hWebService NO-ERROR.

RUN CREATEDOCUMENT IN hcreateInspection(INPUT cBody , OUTPUT DATASET CREATEDOCUMENTReturnDset) NO-ERROR.

IF ERROR-STATUS:ERROR  THEN DO:
    RUN pd_log("(RUN application call data) Can not found.") .
END.

DELETE OBJECT hWebService NO-ERROR.
DELETE OBJECT hcreateInspection NO-ERROR.

PROCEDURE pd_log.
    DEF INPUT PARAMETER n_char AS CHAR INIT "".
    OUTPUT TO VALUE(nv_outp) APPEND.
    PUT "------------Start----------------------"  SKIP
        TODAY    FORMAT "99/99/9999"  " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3) SKIP
        "Input Key :" nv_NewInput           FORMAT "X(28)"   SKIP 
        "Policy    :" REQUESTWS.POLICYNO    format "x(20)"   SKIP
        "nv_usrid  :" CREATEDBY             format "x(50)"   SKIP
        "URL       :" nv_urlinp             format "x(100)"   SKIP
        "nv_error1 :" n_char                format "x(100)"   SKIP
        "nv_error2 :" ERROR-STATUS:GET-MESSAGE(1) + "," + ERROR-STATUS:GET-MESSAGE(2) + "," + ERROR-STATUS:GET-MESSAGE(3) format "x(200)" SKIP
        "------------End------------------------" SKIP.
    OUTPUT CLOSE.
END PROCEDURE.
