/***************************************
wac01102.i  -  DR & CR Matching   ใช้ใน wace1002.w - Debit Note & Credit Note Matching Entry
MODI BY :  Kanchana C.        A46-0478 
    - create data  in workfile   เพื่อเก็บ record trnty = "R"

FROM
    /**  ACO01102.I  **/
    /**  Programmer : SM  **/
***************************************/

STATUS INPUT OFF.
s_fptr02 = 1.
/** STATUS DEFAULT "{&status_i}". **/
CREATE w_acd002.

w_acd002.w_trnty1  = CAPS(acm001.trnty1).
w_acd002.w_docno   = acm001.docno.
w_acd002.w_ctrty1  = CAPS(s_trnty1).
w_acd002.w_cdocno  = s_docno.
w_acd002.w_cjodat  = s_mchdat.
w_acd002.w_netamt  = n_match.
s_mchtot           = s_mchtot + n_match.

PAUSE 0.
acm001.bal   = n_aftnet.
n_exrate     = s_netloc / s_netamt.
acm001.baloc = acm001.baloc - (n_match * n_exrate).

