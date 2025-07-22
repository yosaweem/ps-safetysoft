/*  program Id : wgwchkpadd.p                                              */
/*  create by  : Ranu I. A64-0328 date. 28/08/2021                         */
/*  Descreption : เช็คการคำนวณเบี้ย รย. ของแคมเปญงานโหลดเกินพิกัดหรือไม่   */ 
/*  modify by : Ranu I. A64-0344 date.20/10/2021 ยกเลิกเงื่อนไขการเช็ค รย. เกินเรท */
/*-------------------------------------------------------------------------*/
DEF input parameter        nv_comdat    AS DATE.
DEF input parameter        nv_expdat    AS DATE.
DEF input parameter        nv_class     AS CHAR .
DEF input parameter        nv_411       as deci .
DEF input parameter        nv_412       as deci .
DEF input parameter        nv_42        as deci .
DEF input parameter        nv_43        as deci .
DEF INPUT PARAMETER        nv_seat41    AS INT .
DEF input parameter        nv_411t      as deci .   /* เบี้ย รย. จากงานโหลด */
DEF input parameter        nv_412t      as deci .   /* เบี้ย รย. จากงานโหลด */
DEF input parameter        nv_42t       as deci .   /* เบี้ย รย. จากงานโหลด */
DEF input parameter        nv_43t       as deci .   /* เบี้ย รย. จากงานโหลด */
DEF INPUT PARAMETER        nv_polmaster AS CHAR.
DEF INPUT PARAMETER        nv_campcode  AS CHAR.
DEF INPUT-OUTPUT PARAMETER nv_comment   AS CHAR FORMAT "x(250)" .
DEF INPUT-OUTPUT PARAMETER nv_warning   AS CHAR FORMAT "x(250)" .
DEF INPUT-OUTPUT PARAMETER nv_pass      AS CHAR .
DEF VAR nv_mv411   as deci .   
DEF VAR nv_mv412   as deci .   
DEF VAR nv_mv42    as deci .   
DEF VAR nv_mv43    as deci .
DEF VAR nv_prm4t    AS DECI FORMAT ">>>>>>>>>9.99-" .
DEF VAR nv_mv4t     AS DECI FORMAT ">>>>>>>>>9.99-" .
DEF VAR nv_polday   AS INT INIT 0.
DO:
    ASSIGN nv_mv411  = 0
           nv_mv412  = 0
           nv_mv42   = 0
           nv_mv43   = 0
           nv_prm4t  = 0
           nv_mv4t   = 0 
           nv_comment = ""
           nv_warning = ""
           nv_pass    = "Y"
           nv_polday = 0
           nv_polday = (nv_expdat - nv_comdat).

    RUN wus/wusppadd (INPUT nv_class , /*110 ,210,320 */
                      INPUT nv_411  ,
                      INPUT nv_412  ,
                      INPUT nv_42   ,
                      INPUT nv_43   ,
                      INPUT nv_seat41 ,
                      INPUT-OUTPUT  nv_mv411,
                      INPUT-OUTPUT  nv_mv412,
                      INPUT-OUTPUT  nv_mv42 ,
                      INPUT-OUTPUT  nv_mv43 ) .

    IF nv_polday < 365 THEN DO:
        ASSIGN nv_mv411  = IF nv_mv411 > 0 then (nv_mv411 / 365) * nv_polday  else nv_mv411
               nv_mv412  = IF nv_mv412 > 0 then (nv_mv412 / 365) * nv_polday  else nv_mv412
               nv_mv42   = IF nv_mv42  > 0 then (nv_mv42 / 365) * nv_polday   else nv_mv42 
               nv_mv43   = IF nv_mv43  > 0 then (nv_mv43 / 365) * nv_polday   else nv_mv43 .
    END.

    IF nv_411 <> 0 THEN DO: 
        /*IF nv_411t < 0 OR nv_411t > nv_mv411 THEN */ /* ranu : A64-0344 20/10/2021 */
        IF nv_411t < 0 THEN  /* ranu : A64-0344 20/10/2021 */
            ASSIGN
                nv_comment  = nv_comment + "| Campaign code/Polmaster : " + nv_campcode + "/" + nv_polmaster + " เบี้ย รย.411 = " + STRING(nv_411t,"->>>,>>9.99") + " ไม่ถูกต้อง "
                nv_warning  = nv_warning + "|เบี้ย รย.411 = " + STRING(nv_411t,"->>>,>>9.99") + " ไม่ถูกต้อง " 
                nv_pass     = "N".
    END.
    IF nv_412 <> 0 THEN DO: 
        /*IF nv_412t < 0 OR nv_412t > nv_mv412 THEN */ /* ranu : A64-0344 20/10/2021 */
        IF nv_412t < 0 THEN /* ranu : A64-0344 20/10/2021 */
            ASSIGN
                nv_comment  = nv_comment + "| Campaign code/Polmaster : " + nv_campcode + "/" + nv_polmaster + " เบี้ย รย.412 = " + STRING(nv_412t,"->>>,>>9.99") + " ไม่ถูกต้อง "
                nv_warning  = nv_warning + "เบี้ย รย.412 = " + STRING(nv_412t,"->>>,>>9.99") + " ไม่ถูกต้อง " 
                nv_pass     = "N" .
    END.
    IF nv_42  <> 0 THEN DO: 
        /*IF nv_42t < 0 OR nv_42t > nv_mv42 THEN */ /* ranu : A64-0344 20/10/2021 */
        IF nv_42t < 0  THEN  /* ranu : A64-0344 20/10/2021 */
            ASSIGN
                nv_comment  = nv_comment + "| Campaign code/Polmaster : " + nv_campcode + "/" + nv_polmaster + " เบี้ย รย.42 = " + STRING(nv_42t,"->>>,>>9.99") + " ไม่ถูกต้อง "
                nv_warning  = nv_warning + "เบี้ย รย.42 = " + STRING(nv_42t,"->>>,>>9.99") + " ไม่ถูกต้อง " 
                nv_pass     = "N" .
    END.
    IF nv_43  <> 0 THEN DO: 
        /*IF nv_43t < 0 OR nv_43t > nv_mv43 THEN */ /* ranu : A64-0344 20/10/2021 */
        IF nv_43t < 0 THEN   /* ranu : A64-0344 20/10/2021 */
            ASSIGN
                nv_comment  = nv_comment + "| Campaign code/Polmaster : " + nv_campcode + "/" + nv_polmaster + " เบี้ย รย.43 = " + STRING(nv_43t,"->>>,>>9.99") + " ไม่ถูกต้อง "
                nv_warning  = nv_warning + "เบี้ย รย.43  = " + STRING(nv_43t,"->>>,>>9.99") + " ไม่ถูกต้อง " 
                nv_pass     = "N"   .
    END.

    ASSIGN nv_prm4t = nv_411t + nv_412t + nv_42t + nv_43t .
    IF nv_prm4t <= 0 THEN DO:
        ASSIGN
                nv_comment  = nv_comment + "| Campaign code/Polmaster : " + nv_campcode + "/" + nv_polmaster + " เบี้ยรวม รย. = " + STRING(nv_prm4t,"->>>,>>9.99") + " ไม่ถูกต้อง "
                nv_warning  = nv_warning + "เบี้ยรวม รย. = " + STRING(nv_prm4t,"->>>,>>9.99") + " ไม่ถูกต้อง " 
                nv_pass     = "N"  .
    END.
    

END.

