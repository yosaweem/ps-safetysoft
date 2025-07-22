/************************************************************************/
/* WUWPCPA1.I   Program Calaulate Additional Prrmium                    */
/* Copyright Tokio Marine Safety Insurance (Thailand) PCL.              */
/* Create By : Porntiwa T. 20/06/2023  A65-0149                         */
/************************************************************************/

/* Calculate Additional Premium */
ASSIGN
    nv_flagpa = ""
    nv_spa411 = ""
    nv_spa412 = ""
    nv_spa413 = ""
    nv_spa414 = ""
    nv_spa42  = ""
    nv_spa43  = "".

IF nv_411si > 0 THEN DO:
    ASSIGN
        nv_bencod = "411"
        nv_key_b  = 0
        nv_prem   = 0.
    
    RUN WGW\WGWMX022.P(INPUT nv_tariff,
                             nv_bencod,
                             nv_class,
                             nv_key_b,
                             nv_effdat,
                             nv_seat41,
                             nv_411si,
                      OUTPUT nv_prem,
                      OUTPUT nv_message).

    nv_411prm = ROUND(nv_prem,0).
END.
ELSE DO:
    IF nv_411prm <> 0 THEN DO:
        nv_message = "ไม่มีทุนความคุ้มครอง รย. (411)".
    END.

    nv_411prm = 0.
END.

IF nv_412si > 0 THEN DO:
    ASSIGN
        nv_bencod = "412"
        nv_key_b  = 0
        nv_prem   = 0.
    
    RUN WGW\WGWMX022.P(INPUT nv_tariff,
                             nv_bencod,
                             nv_class,
                             nv_key_b,
                             nv_effdat,
                             nv_seat41,
                             nv_412si,
                      OUTPUT nv_prem,
                      OUTPUT nv_message). 

    nv_412prm = ROUND(nv_prem,0).
END.
ELSE DO:
    IF nv_412prm <> 0 THEN DO:
        nv_message = "ไม่มีทุนความคุ้มครอง รย. (412)".
    END.

    nv_412prm = 0.
END.

IF nv_413si > 0 THEN DO:
    ASSIGN
        nv_bencod = "413"
        nv_key_b  = 0
        nv_prem   = 0.
    
    RUN WGW\WGWMX022.P(INPUT nv_tariff,
                             nv_bencod,
                             nv_class,
                             nv_key_b,
                             nv_effdat,
                             nv_seat41,
                             nv_413si,
                      OUTPUT nv_prem,
                      OUTPUT nv_message). 

    nv_413prm = ROUND(nv_prem,0).
END.
ELSE DO:
    IF nv_413prm <> 0 THEN DO:
        nv_message = "ไม่มีทุนความคุ้มครอง รย. (413)".
    END.

    nv_413prm = 0.
END.

IF nv_414si > 0 THEN DO:
    ASSIGN
        nv_bencod = "414"
        nv_key_b  = 0
        nv_prem   = 0.
    
    RUN WGW\WGWMX022.P(INPUT nv_tariff,
                             nv_bencod,
                             nv_class,
                             nv_key_b,
                             nv_effdat,
                             nv_seat41,
                             nv_414si,
                      OUTPUT nv_prem,
                      OUTPUT nv_message). 

    nv_414prm = ROUND(nv_prem,0).
END.
ELSE DO:
    IF nv_414prm <> 0 THEN DO:
        nv_message = "ไม่มีทุนความคุ้มครอง รย. (414)".
    END.

    nv_414prm = 0.
END.

IF nv_42si > 0 THEN DO:
    ASSIGN
        nv_bencod = "42"
        nv_prem   = 0.
    
    RUN WGW\WGWMX023.P(INPUT nv_tariff,
                             nv_bencod,
                             nv_class,
                             nv_42si,
                             nv_effdat,
                             nv_seat41,
                      OUTPUT nv_prem,
                      OUTPUT nv_message).
   
    nv_42prm = ROUND(nv_prem,0).
END.
ELSE DO:
    IF nv_42prm <> 0 THEN DO:
        nv_message = "ไม่มีทุนความคุ้มครอง รย. (42)".
    END.

    nv_42prm = 0.
END.

IF nv_43si > 0 THEN DO:
    ASSIGN
        nv_bencod = "43"
        nv_key_b  = 0 
        nv_prem   = 0.
    
    RUN WGW\WGWMX022.P(INPUT nv_tariff,
                                 nv_bencod,
                                 nv_class,
                                 nv_key_b,
                                 nv_effdat,
                                 nv_seat41,
                                 nv_43si,
                          OUTPUT nv_prem,
                          OUTPUT nv_message).
    nv_43prm = ROUND(nv_prem,0).
END.
ELSE DO:
    IF nv_43prm <> 0 THEN DO:
        nv_message = "ไม่มีทุนความคุ้มครอง รย. (43)".
    END.

    nv_43prm = 0.
END.

nv_addprem = nv_411prm + nv_412prm + nv_413prm + 
             nv_414prm + nv_42prm  + nv_43prm.

nv_41prmt = nv_411prmt + nv_412prmt + nv_413prmt + 
            nv_414prmt + nv_42prmt  + nv_43prmt.

/*IF nv_41prmt <> 0 THEN DO:*//*Comment A65-0232*/
IF nv_adjpaprm = YES THEN DO:
    IF nv_41prmt <> nv_addprem THEN DO:  /* ใช้ Premium ตามไฟล์หากมีการ Adjust */
        ASSIGN
            nv_411prm  = nv_411prmt
            nv_412prm  = nv_412prmt
            nv_413prm  = nv_413prmt
            nv_414prm  = nv_414prmt
            nv_42prm   = nv_42prmt
            nv_43prm   = nv_43prmt
            nv_addprem = nv_41prmt
            nv_flagpa  = "E".
    END.
END.
ELSE DO:
    IF nv_411si = 0 THEN nv_411prm = 0.
    ELSE DO: 
        nv_411prm = nv_411prm.
    END.

    IF nv_412si = 0 THEN nv_412prm = 0.
    ELSE DO: 
        nv_412prm = nv_412prm.
    END.

    IF nv_413si = 0 THEN nv_413prm = 0.
    ELSE DO: 
        nv_413prm = nv_413prm.
    END.

    IF nv_414si = 0 THEN nv_414prm = 0.
    ELSE DO: 
        nv_414prm = nv_414prm.
    END.

    IF nv_42si  = 0 THEN nv_42prm  = 0.
    ELSE DO: 
        nv_42prm = nv_42prm.
    END.

    IF nv_43si  = 0 THEN nv_43prm  = 0.
    ELSE DO: 
        nv_43prm = nv_43prm.
    END.
END.

nv_addprem = nv_411prm + nv_412prm + nv_413prm + 
             nv_414prm + nv_42prm  + nv_43prm.







