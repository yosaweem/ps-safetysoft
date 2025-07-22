/*  wgwqsym120.w - Set class to D\R                                      */
/* Copyright    : Tokio Marine Safety Insurance (Thailand) PCL.          */
/*                        บริษัท คุ้มภัยโตเกียวมารีนประกันภัย (ประเทศไทย)*/
/* CREATE BY    : Chaiyong W.   ASSIGN A65-0329  DATE 09/11/2022         */  
DEF VAR nv_tabcod AS CHAR INIT "U120".
DEF VAR s_prog AS CHAR INIT "wgwqsy120.p".
DEF VAR gv_prog AS CHAR INIT "Parameter Check Class to D\R Risk".
RUN wgw\wgwque072(INPUT nv_tabcod,
                        s_prog   ,
                        gv_prog  ).
