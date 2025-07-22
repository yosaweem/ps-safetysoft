/************************************************************************/
/* wgweispno.p   Webservice Check Renew Afther Ciam     		           */
/* Create By   : Songkran P. Date 01/06/2022 A65-0141                  */
/*---------------------------------------------------------------------*/

DEFINE input  parameter nv_policy AS CHARACTER NO-UNDO.
DEFINE input  parameter nv_vehreg AS CHARACTER NO-UNDO.
DEFINE input  parameter nv_cha_no AS CHARACTER NO-UNDO. 
DEFINE output parameter RsStatus  AS CHARACTER NO-UNDO.
DEFINE output parameter RsMessage AS CHARACTER NO-UNDO.

DEFINE VARIABLE hWebService AS HANDLE NO-UNDO.
DEFINE VARIABLE hSendCkClmExpTESTObj AS HANDLE NO-UNDO.
DEFINE VARIABLE IStatus1 AS LOGICAL NO-UNDO.
DEFINE VARIABLE nv_NewInput       AS CHARACTER NO-UNDO.
DEFINE VARIABLE nv_outp           AS CHARACTER NO-UNDO.
DEFINE VARIABLE result AS CHARACTER NO-UNDO.

nv_NewInput = STRING(YEAR(TODAY),"9999")
            + STRING(MONTH(TODAY),"99")
            + STRING(DAY(TODAY),"99")
            + SUBSTR(STRING(DATETIME(TODAY, MTIME)),12,12).
nv_outp = STRING(YEAR(TODAY),"9999") + STRING(MONTH(TODAY),"99") + "_wgwckclrw.txt".


CREATE SERVER hWebService.
//IStatus1 = hWebService:CONNECT("-WSDL 'http://TMWSLIAPIP01:8080/srvbugw/BUCMIPolicy/wsdl?targetURI=urn:WSA-Safety:SendCkClmExpTEST'") NO-ERROR. /*test*/
IStatus1 = hWebService:CONNECT("-WSDL 'http://TMSSAPIP11:8080/srvwebos/WebOS/wsdl?targetURI=urn:spsty:SendCkClmExp'") NO-ERROR. // prd 
IF ERROR-STATUS:ERROR  THEN DO:
    RUN pd_log("Not Found The Statement").
    hWebService:DISCONNECT()     NO-ERROR.  
    DELETE OBJECT hWebService    NO-ERROR.
    RETURN.
END.

RUN SendCkClmExpTESTObj SET hSendCkClmExpTESTObj ON hWebService  NO-ERROR.

IF ERROR-STATUS:ERROR  THEN DO:
    RUN pd_log("(RUN application call data) Can not found.") .
END.

RUN SendCkClmExpTEST IN hSendCkClmExpTESTObj
    (INPUT  nv_policy
    ,INPUT  nv_vehreg
    ,INPUT  nv_cha_no
    ,OUTPUT result
    ,OUTPUT RsStatus
    ,OUTPUT RsMessage)
    NO-ERROR.

IF ERROR-STATUS:ERROR  THEN DO:
    RUN pd_log("Not Found The Statement").
END.

DELETE OBJECT hWebService NO-ERROR.
DELETE OBJECT hSendCkClmExpTESTObj NO-ERROR.

PROCEDURE pd_log.
    DEF INPUT PARAMETER n_char AS CHAR INIT "".
    OUTPUT TO VALUE(nv_outp) APPEND.
    PUT "------------Start----------------------"  SKIP
        TODAY    FORMAT "99/99/9999"  " " STRING(TIME,"HH:MM:SS") "." SUBSTR(STRING(MTIME,">>>>99999999"),10,3) SKIP
        "Input Key :" nv_NewInput           FORMAT "X(28)"   SKIP 
        "Policy    :" nv_policy             format "x(20)"   SKIP
        "result    :" result                format "x(50)"   SKIP
        "RsStatus  :" RsStatus              format "x(100)"   SKIP
        "nv_error1 :" RsMessage             format "x(100)"   SKIP
        "nv_error2 :" ERROR-STATUS:GET-MESSAGE(1) + "," + ERROR-STATUS:GET-MESSAGE(2) + "," + ERROR-STATUS:GET-MESSAGE(3) format "x(200)" SKIP
        "------------End------------------------" SKIP.
    OUTPUT CLOSE.
END PROCEDURE.
