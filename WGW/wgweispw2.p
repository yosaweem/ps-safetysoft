/************************************************************************/
/* wgweispno.p   Webservice create inspection box      		           */
/* Create By   : Songkran P. Date 06/01/2023 A66-0004                  */
/*---------------------------------------------------------------------*/

DEFINE VARIABLE hWebService AS HANDLE NO-UNDO.
DEFINE VARIABLE hCreateInspectionSSW AS HANDLE NO-UNDO.
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


DEFINE TEMP-TABLE createdocumentReturn NO-UNDO
	FIELD DOCNO      AS CHARACTER 
	FIELD CODESTATUS AS CHARACTER 
	FIELD CODEDETAIL AS CHARACTER .

DEFINE DATASET createdocumentReturnDset NAMESPACE-URI "urn:model.tmith" 
    XML-NODE-TYPE "HIDDEN" 
    FOR createdocumentReturn.


DEFINE INPUT PARAMETER nv_pathFile AS CHAR INIT "".
DEFINE INPUT PARAMETER TABLE FOR REQUESTWS.
DEFINE OUTPUT PARAMETER TABLE FOR CREATEDOCUMENTReturn.

nv_NewInput = STRING(YEAR(TODAY),"9999")
            + STRING(MONTH(TODAY),"99")
            + STRING(DAY(TODAY),"99")
            + SUBSTR(STRING(DATETIME(TODAY, MTIME)),12,12).
nv_outp = STRING(YEAR(TODAY),"9999") + STRING(MONTH(TODAY),"99") + "_wgweispw2.txt".

FIND FIRST REQUESTWS NO-ERROR.

cBody = '<ns0:req xmlns:ns0="urn:DefaultNamespace">
          <reqtypesub>' + REQTYPESUB + '</reqtypesub>
          <createdBy>' + CREATEDBY + '</createdBy>
          <dateS>' + DATES + '</dateS>
          <dateE>' + DATEE + '</dateE>
          <phone>' + PHONE + '</phone>
          <agentCode>' + AGENTCODE + '</agentCode>
          <agentName>' + AGENTNAME + '</agentName>
          <model>' + MODEL + '</model>
          <modelCode>' + MODELCODE + '</modelCode>
          <carCC>' + CARCC + '</carCC>
          <branchReq>' + BRANCHREQ + '</branchReq>
          <createdOn>' + CREATEDON + '</createdOn>
          <fname>' + FNAME + '</fname>
          <garage>' + GARAGE + '</garage>
          <licenseNo_1>' + LICENSENO_1 + '</licenseNo_1>
          <licenseNo_2>' + LICENSENO_2 + '</licenseNo_2>
          <licenseType>' + LICENSETYPE + '</licenseType>
          <lname>' + LNAME + '</lname>
          <pathFile>' + nv_pathFile + '</pathFile>
          <policyNo>' + POLICYNO + '</policyNo>
          <premium>' + PREMIUM + '</premium>
          <sendCC>' + SENDCC + '</sendCC>
          <sendClose>' + SENDCLOSE + '</sendClose>
          <sendTo>' + SENDTO + '</sendTo>
          <tname>' + TNAME + '</tname>
          <year>' + YEAR + '</year>
        </ns0:req>'.

   
nv_urlinp = "-WSDL 'http://10.35.1.200/web/ws_ins.nsf/CreateInspectionSSW?WSDL'".



CREATE SERVER hWebService.
IStatus1 = hWebService:CONNECT(nv_urlinp) NO-ERROR.

RUN CreateInspectionSSW SET hCreateInspectionSSW ON hWebService NO-ERROR.

IF ERROR-STATUS:ERROR  THEN DO:
    RUN pd_log("Not Found The Statement").
    hWebService:DISCONNECT()     NO-ERROR.  
    DELETE OBJECT hWebService    NO-ERROR.
    RETURN.
END.

RUN createdocument IN hCreateInspectionSSW(INPUT cBody , OUTPUT DATASET createdocumentReturnDset) NO-ERROR.

IF ERROR-STATUS:ERROR  THEN DO:
    RUN pd_log("(RUN application call data) Can not found.") .
END.

DELETE OBJECT hWebService NO-ERROR.
DELETE OBJECT hCreateInspectionSSW NO-ERROR.

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
