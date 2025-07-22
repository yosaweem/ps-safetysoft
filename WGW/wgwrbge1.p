
/*programid   : wgwrbgen.w                                              */  
/*programname : Load Text & Generate text file Rabbit                   */  
/*Copyright   : Safety Insurance Public Company Limited                 */  
/*              ����ѷ ��Сѹ������� �ӡѴ (��Ҫ�)                      */  
/*create by   : Kridtiya i. A64-0325 date. 21/08/2021                  
                �ŧ������ �ӹ�   */ 
/************************************************************************/
DEF INPUT         PARAMETER nv_nametext AS CHAR.
DEF INPUT-OUTPUT  PARAMETER nv_titlenam AS CHAR.
DEF INPUT-OUTPUT  PARAMETER nv_fname    AS CHAR.
DEF INPUT-OUTPUT  PARAMETER nv_lname    AS CHAR.
ASSIGN nv_titlenam = ""
       nv_fname    = ""
       nv_lname    = "".
IF      INDEX(nv_nametext,"�س")               <> 0 THEN ASSIGN nv_titlenam = "�س"               nv_nametext = trim(REPLACE(nv_nametext,"�س","")).
ELSE IF INDEX(nv_nametext,"���")               <> 0 THEN ASSIGN nv_titlenam = "���"               nv_nametext = trim(REPLACE(nv_nametext,"���","")).
ELSE IF INDEX(nv_nametext,"�ҧ���")            <> 0 THEN ASSIGN nv_titlenam = "�ҧ���"            nv_nametext = trim(REPLACE(nv_nametext,"�ҧ���","")).   
ELSE IF INDEX(nv_nametext,"�.�.")              <> 0 THEN ASSIGN nv_titlenam = "�.�."              nv_nametext = trim(REPLACE(nv_nametext,"�.�.","")).   
ELSE IF INDEX(nv_nametext,"�ҧ")               <> 0 THEN ASSIGN nv_titlenam = "�ҧ"               nv_nametext = trim(REPLACE(nv_nametext,"�ҧ","")).   
ELSE IF INDEX(nv_nametext,"MR")                <> 0 THEN ASSIGN nv_titlenam = "MR"                nv_nametext = trim(REPLACE(nv_nametext,"MR","")).   
ELSE IF INDEX(nv_nametext,"MRS")               <> 0 THEN ASSIGN nv_titlenam = "MRS"               nv_nametext = trim(REPLACE(nv_nametext,"MRS","")).   
ELSE IF INDEX(nv_nametext,"MISS")              <> 0 THEN ASSIGN nv_titlenam = "MISS"              nv_nametext = trim(REPLACE(nv_nametext,"MISS","")). 
ELSE IF INDEX(nv_nametext,"����ѷ")            <> 0 THEN ASSIGN nv_titlenam = "����ѷ"            nv_nametext = trim(REPLACE(nv_nametext,"����ѷ","")).           
ELSE IF INDEX(nv_nametext,"�.")                <> 0 THEN ASSIGN nv_titlenam = "�."                nv_nametext = trim(REPLACE(nv_nametext,"�.","")).               
ELSE IF INDEX(nv_nametext,"���.")              <> 0 THEN ASSIGN nv_titlenam = "���."              nv_nametext = trim(REPLACE(nv_nametext,"���.","")).             
ELSE IF INDEX(nv_nametext,"˨�.")              <> 0 THEN ASSIGN nv_titlenam = "˨�."              nv_nametext = trim(REPLACE(nv_nametext,"˨�.","")).             
ELSE IF INDEX(nv_nametext,"�ʹ.")              <> 0 THEN ASSIGN nv_titlenam = "�ʹ."              nv_nametext = trim(REPLACE(nv_nametext,"�ʹ.","")).             
ELSE IF INDEX(nv_nametext,"����ѷ")            <> 0 THEN ASSIGN nv_titlenam = "����ѷ"            nv_nametext = trim(REPLACE(nv_nametext,"����ѷ","")).           
ELSE IF INDEX(nv_nametext,"��ŹԸ�")           <> 0 THEN ASSIGN nv_titlenam = "��ŹԸ�"           nv_nametext = trim(REPLACE(nv_nametext,"��ŹԸ�","")).          
ELSE IF INDEX(nv_nametext,"��ҧ�����ǹ�ӡѴ") <> 0 THEN ASSIGN nv_titlenam = "��ҧ�����ǹ�ӡѴ" nv_nametext = trim(REPLACE(nv_nametext,"��ҧ�����ǹ�ӡѴ","")).
ELSE IF INDEX(nv_nametext,"��ҧ�����ǹ")      <> 0 THEN ASSIGN nv_titlenam = "��ҧ�����ǹ"      nv_nametext = trim(REPLACE(nv_nametext,"��ҧ�����ǹ","")).     
ELSE IF INDEX(nv_nametext,"��ҧ")              <> 0 THEN ASSIGN nv_titlenam = "��ҧ"              nv_nametext = trim(REPLACE(nv_nametext,"��ҧ","")).             
ELSE IF INDEX(nv_nametext,"�.�.")              <> 0 THEN ASSIGN nv_titlenam = "�.�."              nv_nametext = trim(REPLACE(nv_nametext,"�.�.","")).             
ELSE IF INDEX(nv_nametext,"�.�.")              <> 0 THEN ASSIGN nv_titlenam = "�.�."              nv_nametext = trim(REPLACE(nv_nametext,"�.�.","")).             
ELSE IF INDEX(nv_nametext,"�.�.�.")            <> 0 THEN ASSIGN nv_titlenam = "�.�.�."            nv_nametext = trim(REPLACE(nv_nametext,"�.�.�.","")).           
ELSE IF INDEX(nv_nametext,"�.�.�.")            <> 0 THEN ASSIGN nv_titlenam = "�.�.�."            nv_nametext = trim(REPLACE(nv_nametext,"�.�.�.","")).           
ELSE IF INDEX(nv_nametext,"�.�.�.")            <> 0 THEN ASSIGN nv_titlenam = "�.�.�."            nv_nametext = trim(REPLACE(nv_nametext,"�.�.�.","")).           
ELSE IF INDEX(nv_nametext,"�.�.")              <> 0 THEN ASSIGN nv_titlenam = "�.�."              nv_nametext = trim(REPLACE(nv_nametext,"�.�.","")).             
ELSE IF INDEX(nv_nametext,"��ҵ��")            <> 0 THEN ASSIGN nv_titlenam = "��ҵ��"            nv_nametext = trim(REPLACE(nv_nametext,"��ҵ��","")).           
ELSE IF INDEX(nv_nametext,"����")             <> 0 THEN ASSIGN nv_titlenam = "����"             nv_nametext = trim(REPLACE(nv_nametext,"����","")).            
ELSE IF INDEX(nv_nametext,"����Ժ���")         <> 0 THEN ASSIGN nv_titlenam = "����Ժ���"         nv_nametext = trim(REPLACE(nv_nametext,"����Ժ���","")).        
ELSE IF INDEX(nv_nametext,"����Ժ���Ǩ")       <> 0 THEN ASSIGN nv_titlenam = "����Ժ���Ǩ"       nv_nametext = trim(REPLACE(nv_nametext,"����Ժ���Ǩ","")).      
ELSE IF INDEX(nv_nametext,"����Ժ�")          <> 0 THEN ASSIGN nv_titlenam = "����Ժ�"          nv_nametext = trim(REPLACE(nv_nametext,"����Ժ�","")).         
ELSE IF INDEX(nv_nametext,"����Ժ�͡")         <> 0 THEN ASSIGN nv_titlenam = "����Ժ�͡"         nv_nametext = trim(REPLACE(nv_nametext,"����Ժ�͡","")).        
ELSE IF INDEX(nv_nametext,"����ҡ�ȵ��")       <> 0 THEN ASSIGN nv_titlenam = "����ҡ�ȵ��"       nv_nametext = trim(REPLACE(nv_nametext,"����ҡ�ȵ��","")).      
ELSE IF INDEX(nv_nametext,"����ҡ���")        <> 0 THEN ASSIGN nv_titlenam = "����ҡ���"        nv_nametext = trim(REPLACE(nv_nametext,"����ҡ���","")).       
ELSE IF INDEX(nv_nametext,"����ҡ���͡")       <> 0 THEN ASSIGN nv_titlenam = "����ҡ���͡"       nv_nametext = trim(REPLACE(nv_nametext,"����ҡ���͡","")).      
ELSE IF INDEX(nv_nametext,"����͡")            <> 0 THEN ASSIGN nv_titlenam = "����͡"            nv_nametext = trim(REPLACE(nv_nametext,"����͡","")).           
ELSE IF INDEX(nv_nametext,"�.�.")              <> 0 THEN ASSIGN nv_titlenam = "�.�."              nv_nametext = trim(REPLACE(nv_nametext,"�.�.","")).             
ELSE IF INDEX(nv_nametext,"���Ǩ")             <> 0 THEN ASSIGN nv_titlenam = "���Ǩ"             nv_nametext = trim(REPLACE(nv_nametext,"���Ǩ","")).            
ELSE IF INDEX(nv_nametext,"��������")          <> 0 THEN ASSIGN nv_titlenam = "��������"          nv_nametext = trim(REPLACE(nv_nametext,"��������","")).         
ELSE IF INDEX(nv_nametext,"�����ҡ��")         <> 0 THEN ASSIGN nv_titlenam = "�����ҡ��"         nv_nametext = trim(REPLACE(nv_nametext,"�����ҡ��","")).        
ELSE IF INDEX(nv_nametext,"�.�.")              <> 0 THEN ASSIGN nv_titlenam = "�.�."              nv_nametext = trim(REPLACE(nv_nametext,"�.�.","")).             
ELSE IF INDEX(nv_nametext,"�.�.")              <> 0 THEN ASSIGN nv_titlenam = "�.�."              nv_nametext = trim(REPLACE(nv_nametext,"�.�.","")).             
ELSE IF INDEX(nv_nametext,"�.�.")              <> 0 THEN ASSIGN nv_titlenam = "�.�."              nv_nametext = trim(REPLACE(nv_nametext,"�.�.","")).             
ELSE IF INDEX(nv_nametext,"��´Һ���Ǩ")       <> 0 THEN ASSIGN nv_titlenam = "��´Һ���Ǩ"       nv_nametext = trim(REPLACE(nv_nametext,"��´Һ���Ǩ","")).      
ELSE IF INDEX(nv_nametext,"���ҵ��")           <> 0 THEN ASSIGN nv_titlenam = "���ҵ��"           nv_nametext = trim(REPLACE(nv_nametext,"���ҵ��","")).          
ELSE IF INDEX(nv_nametext,"�����")            <> 0 THEN ASSIGN nv_titlenam = "�����"            nv_nametext = trim(REPLACE(nv_nametext,"�����","")).           
ELSE IF INDEX(nv_nametext,"�����ҡ�ȵ��")      <> 0 THEN ASSIGN nv_titlenam = "�����ҡ�ȵ��"      nv_nametext = trim(REPLACE(nv_nametext,"�����ҡ�ȵ��","")).     
ELSE IF INDEX(nv_nametext,"�����ҡ���")       <> 0 THEN ASSIGN nv_titlenam = "�����ҡ���"       nv_nametext = trim(REPLACE(nv_nametext,"�����ҡ���","")).      
ELSE IF INDEX(nv_nametext,"�����ҡ���͡")      <> 0 THEN ASSIGN nv_titlenam = "�����ҡ���͡"      nv_nametext = trim(REPLACE(nv_nametext,"�����ҡ���͡","")).     
ELSE IF INDEX(nv_nametext,"�����͡")           <> 0 THEN ASSIGN nv_titlenam = "�����͡"           nv_nametext = trim(REPLACE(nv_nametext,"�����͡","")).          
ELSE IF INDEX(nv_nametext,"�.�.�.")            <> 0 THEN ASSIGN nv_titlenam = "�.�.�."            nv_nametext = trim(REPLACE(nv_nametext,"�.�.�.","")).           
ELSE IF INDEX(nv_nametext,"�.�.�.")            <> 0 THEN ASSIGN nv_titlenam = "�.�.�."            nv_nametext = trim(REPLACE(nv_nametext,"�.�.�.","")).           
ELSE IF INDEX(nv_nametext,"�.�.�.")            <> 0 THEN ASSIGN nv_titlenam = "�.�.�."            nv_nametext = trim(REPLACE(nv_nametext,"�.�.�.","")).           
ELSE IF INDEX(nv_nametext,"�.�.")              <> 0 THEN ASSIGN nv_titlenam = "�.�."              nv_nametext = trim(REPLACE(nv_nametext,"�.�.","")).             
ELSE IF INDEX(nv_nametext,"�.�.�.")            <> 0 THEN ASSIGN nv_titlenam = "�.�.�."            nv_nametext = trim(REPLACE(nv_nametext,"�.�.�.","")).           
ELSE IF INDEX(nv_nametext,"�.�.�.")            <> 0 THEN ASSIGN nv_titlenam = "�.�.�."            nv_nametext = trim(REPLACE(nv_nametext,"�.�.�.","")).           
ELSE IF INDEX(nv_nametext,"�.�.�.")            <> 0 THEN ASSIGN nv_titlenam = "�.�.�."            nv_nametext = trim(REPLACE(nv_nametext,"�.�.�.","")).           
ELSE IF INDEX(nv_nametext,"�.�.")              <> 0 THEN ASSIGN nv_titlenam = "�.�."              nv_nametext = trim(REPLACE(nv_nametext,"�.�.","")).             
ELSE IF INDEX(nv_nametext,"���")               <> 0 THEN ASSIGN nv_titlenam = "���"               nv_nametext = trim(REPLACE(nv_nametext,"���","")).              
ELSE IF INDEX(nv_nametext,"��.�.")             <> 0 THEN ASSIGN nv_titlenam = "��.�."             nv_nametext = trim(REPLACE(nv_nametext,"��.�.","")).            
ELSE IF INDEX(nv_nametext,"��.�.�.")           <> 0 THEN ASSIGN nv_titlenam = "��.�.�."           nv_nametext = trim(REPLACE(nv_nametext,"��.�.�.","")).          
ELSE IF INDEX(nv_nametext,"��.�.�.")           <> 0 THEN ASSIGN nv_titlenam = "��.�.�."           nv_nametext = trim(REPLACE(nv_nametext,"��.�.�.","")).          
ELSE IF INDEX(nv_nametext,"�ŵ��")             <> 0 THEN ASSIGN nv_titlenam = "�ŵ��"             nv_nametext = trim(REPLACE(nv_nametext,"�ŵ��","")).            
ELSE IF INDEX(nv_nametext,"��.�.�.")           <> 0 THEN ASSIGN nv_titlenam = "��.�.�."           nv_nametext = trim(REPLACE(nv_nametext,"��.�.�.","")).          
ELSE IF INDEX(nv_nametext,"�ŵ��Ǩ")           <> 0 THEN ASSIGN nv_titlenam = "�ŵ��Ǩ"           nv_nametext = trim(REPLACE(nv_nametext,"�ŵ��Ǩ","")).          
ELSE IF INDEX(nv_nametext,"�ŵ��Ǩ���")        <> 0 THEN ASSIGN nv_titlenam = "�ŵ��Ǩ���"        nv_nametext = trim(REPLACE(nv_nametext,"�ŵ��Ǩ���","")).       
ELSE IF INDEX(nv_nametext,"�ŵ��Ǩ�")         <> 0 THEN ASSIGN nv_titlenam = "�ŵ��Ǩ�"         nv_nametext = trim(REPLACE(nv_nametext,"�ŵ��Ǩ�","")).        
ELSE IF INDEX(nv_nametext,"�ŵ��Ǩ�͡")        <> 0 THEN ASSIGN nv_titlenam = "�ŵ��Ǩ�͡"        nv_nametext = trim(REPLACE(nv_nametext,"�ŵ��Ǩ�͡","")).       
ELSE IF INDEX(nv_nametext,"��.�.")             <> 0 THEN ASSIGN nv_titlenam = "��.�."             nv_nametext = trim(REPLACE(nv_nametext,"��.�.","")).            
ELSE IF INDEX(nv_nametext,"�ŷ���")            <> 0 THEN ASSIGN nv_titlenam = "�ŷ���"            nv_nametext = trim(REPLACE(nv_nametext,"�ŷ���","")).           
ELSE IF INDEX(nv_nametext,"���")              <> 0 THEN ASSIGN nv_titlenam = "���"              nv_nametext = trim(REPLACE(nv_nametext,"���","")).             
ELSE IF INDEX(nv_nametext,"��.�.�.")           <> 0 THEN ASSIGN nv_titlenam = "��.�.�."           nv_nametext = trim(REPLACE(nv_nametext,"��.�.�.","")).          
ELSE IF INDEX(nv_nametext,"��.�.�.")           <> 0 THEN ASSIGN nv_titlenam = "��.�.�."           nv_nametext = trim(REPLACE(nv_nametext,"��.�.�.","")).          
ELSE IF INDEX(nv_nametext,"��.�.�.")           <> 0 THEN ASSIGN nv_titlenam = "��.�.�."           nv_nametext = trim(REPLACE(nv_nametext,"��.�.�.","")).          
ELSE IF INDEX(nv_nametext,"�����͵��")         <> 0 THEN ASSIGN nv_titlenam = "�����͵��"         nv_nametext = trim(REPLACE(nv_nametext,"�����͵��","")).        
ELSE IF INDEX(nv_nametext,"�������")          <> 0 THEN ASSIGN nv_titlenam = "�������"          nv_nametext = trim(REPLACE(nv_nametext,"�������","")).         
ELSE IF INDEX(nv_nametext,"�������͡")         <> 0 THEN ASSIGN nv_titlenam = "�������͡"         nv_nametext = trim(REPLACE(nv_nametext,"�������͡","")).        
ELSE IF INDEX(nv_nametext,"��.�.")             <> 0 THEN ASSIGN nv_titlenam = "��.�."             nv_nametext = trim(REPLACE(nv_nametext,"��.�.","")).            
ELSE IF INDEX(nv_nametext,"��.�.�.")           <> 0 THEN ASSIGN nv_titlenam = "��.�.�."           nv_nametext = trim(REPLACE(nv_nametext,"��.�.�.","")).          
ELSE IF INDEX(nv_nametext,"��.�.�.")           <> 0 THEN ASSIGN nv_titlenam = "��.�.�."           nv_nametext = trim(REPLACE(nv_nametext,"��.�.�.","")).          
ELSE IF INDEX(nv_nametext,"��.�.�.")           <> 0 THEN ASSIGN nv_titlenam = "��.�.�."           nv_nametext = trim(REPLACE(nv_nametext,"��.�.�.","")).          
ELSE IF INDEX(nv_nametext,"���ҡ�ȵ��")        <> 0 THEN ASSIGN nv_titlenam = "���ҡ�ȵ��"        nv_nametext = trim(REPLACE(nv_nametext,"���ҡ�ȵ��","")).       
ELSE IF INDEX(nv_nametext,"���ҡ���")         <> 0 THEN ASSIGN nv_titlenam = "���ҡ���"         nv_nametext = trim(REPLACE(nv_nametext,"���ҡ���","")).        
ELSE IF INDEX(nv_nametext,"���ҡ���͡")        <> 0 THEN ASSIGN nv_titlenam = "���ҡ���͡"        nv_nametext = trim(REPLACE(nv_nametext,"���ҡ���͡","")).       
ELSE IF INDEX(nv_nametext,"���͡")             <> 0 THEN ASSIGN nv_titlenam = "���͡"             nv_nametext = trim(REPLACE(nv_nametext,"���͡","")).            
ELSE IF INDEX(nv_nametext,"�.�.")              <> 0 THEN ASSIGN nv_titlenam = "�.�."              nv_nametext = trim(REPLACE(nv_nametext,"�.�.","")).             
ELSE IF INDEX(nv_nametext,"�.�.�.")            <> 0 THEN ASSIGN nv_titlenam = "�.�.�."            nv_nametext = trim(REPLACE(nv_nametext,"�.�.�.","")).           
ELSE IF INDEX(nv_nametext,"�.�.�.")            <> 0 THEN ASSIGN nv_titlenam = "�.�.�."            nv_nametext = trim(REPLACE(nv_nametext,"�.�.�.","")).           
ELSE IF INDEX(nv_nametext,"�.�.�.")            <> 0 THEN ASSIGN nv_titlenam = "�.�.�."            nv_nametext = trim(REPLACE(nv_nametext,"�.�.�.","")).           
ELSE IF INDEX(nv_nametext,"�ѹ��ҵ��")         <> 0 THEN ASSIGN nv_titlenam = "�ѹ��ҵ��"         nv_nametext = trim(REPLACE(nv_nametext,"�ѹ��ҵ��","")).        
ELSE IF INDEX(nv_nametext,"�ѹ����")          <> 0 THEN ASSIGN nv_titlenam = "�ѹ����"          nv_nametext = trim(REPLACE(nv_nametext,"�ѹ����","")).         
ELSE IF INDEX(nv_nametext,"�ѹ����ҡ�ȵ��")    <> 0 THEN ASSIGN nv_titlenam = "�ѹ����ҡ�ȵ��"    nv_nametext = trim(REPLACE(nv_nametext,"�ѹ����ҡ�ȵ��","")).   
ELSE IF INDEX(nv_nametext,"�ѹ����ҡ���")     <> 0 THEN ASSIGN nv_titlenam = "�ѹ����ҡ���"     nv_nametext = trim(REPLACE(nv_nametext,"�ѹ����ҡ���","")).    
ELSE IF INDEX(nv_nametext,"�ѹ����ҡ���͡")    <> 0 THEN ASSIGN nv_titlenam = "�ѹ����ҡ���͡"    nv_nametext = trim(REPLACE(nv_nametext,"�ѹ����ҡ���͡","")).   
ELSE IF INDEX(nv_nametext,"�ѹ����͡")         <> 0 THEN ASSIGN nv_titlenam = "�ѹ����͡"         nv_nametext = trim(REPLACE(nv_nametext,"�ѹ����͡","")).        
ELSE IF INDEX(nv_nametext,"�ѹ���")            <> 0 THEN ASSIGN nv_titlenam = "�ѹ���"            nv_nametext = trim(REPLACE(nv_nametext,"�ѹ���","")).           
ELSE IF INDEX(nv_nametext,"�ѹ���Ǩ���")       <> 0 THEN ASSIGN nv_titlenam = "�ѹ���Ǩ���"       nv_nametext = trim(REPLACE(nv_nametext,"�ѹ���Ǩ���","")).      
ELSE IF INDEX(nv_nametext,"�ѹ���Ǩ�")        <> 0 THEN ASSIGN nv_titlenam = "�ѹ���Ǩ�"        nv_nametext = trim(REPLACE(nv_nametext,"�ѹ���Ǩ�","")).       
ELSE IF INDEX(nv_nametext,"�ѹ���Ǩ�͡")       <> 0 THEN ASSIGN nv_titlenam = "�ѹ���Ǩ�͡"       nv_nametext = trim(REPLACE(nv_nametext,"�ѹ���Ǩ�͡","")).      
ELSE IF INDEX(nv_nametext,"�ѹ�")             <> 0 THEN ASSIGN nv_titlenam = "�ѹ�"             nv_nametext = trim(REPLACE(nv_nametext,"�ѹ�","")).            
ELSE IF INDEX(nv_nametext,"�ѹ�͡")            <> 0 THEN ASSIGN nv_titlenam = "�ѹ�͡"            nv_nametext = trim(REPLACE(nv_nametext,"�ѹ�͡","")).           
ELSE IF INDEX(nv_nametext,"�.�.�.")            <> 0 THEN ASSIGN nv_titlenam = "�.�.�."            nv_nametext = trim(REPLACE(nv_nametext,"�.�.�.","")).           
ELSE IF INDEX(nv_nametext,"�.�.")              <> 0 THEN ASSIGN nv_titlenam = "�.�."              nv_nametext = trim(REPLACE(nv_nametext,"�.�.","")).             
ELSE IF INDEX(nv_nametext,"�.�.")              <> 0 THEN ASSIGN nv_titlenam = "�.�."              nv_nametext = trim(REPLACE(nv_nametext,"�.�.","")).             
ELSE IF INDEX(nv_nametext,"�.�.�.")            <> 0 THEN ASSIGN nv_titlenam = "�.�.�."            nv_nametext = trim(REPLACE(nv_nametext,"�.�.�.","")).           
ELSE IF INDEX(nv_nametext,"�.�.�.")            <> 0 THEN ASSIGN nv_titlenam = "�.�.�."            nv_nametext = trim(REPLACE(nv_nametext,"�.�.�.","")).           
ELSE IF INDEX(nv_nametext,"�.�.�.")            <> 0 THEN ASSIGN nv_titlenam = "�.�.�."            nv_nametext = trim(REPLACE(nv_nametext,"�.�.�.","")).           
ELSE IF INDEX(nv_nametext,"�.�.")              <> 0 THEN ASSIGN nv_titlenam = "�.�."              nv_nametext = trim(REPLACE(nv_nametext,"�.�.","")).             
ELSE IF INDEX(nv_nametext,"�.�.")              <> 0 THEN ASSIGN nv_titlenam = "�.�."              nv_nametext = trim(REPLACE(nv_nametext,"�.�.","")).             
ELSE IF INDEX(nv_nametext,"�.�.")              <> 0 THEN ASSIGN nv_titlenam = "�.�."              nv_nametext = trim(REPLACE(nv_nametext,"�.�.","")).             
ELSE IF INDEX(nv_nametext,"���µ��")           <> 0 THEN ASSIGN nv_titlenam = "���µ��"           nv_nametext = trim(REPLACE(nv_nametext,"���µ��","")).          
ELSE IF INDEX(nv_nametext,"���µ��Ǩ���")      <> 0 THEN ASSIGN nv_titlenam = "���µ��Ǩ���"      nv_nametext = trim(REPLACE(nv_nametext,"���µ��Ǩ���","")).     
ELSE IF INDEX(nv_nametext,"���µ��Ǩ�")       <> 0 THEN ASSIGN nv_titlenam = "���µ��Ǩ�"       nv_nametext = trim(REPLACE(nv_nametext,"���µ��Ǩ�","")).      
ELSE IF INDEX(nv_nametext,"���µ��Ǩ�͡")      <> 0 THEN ASSIGN nv_titlenam = "���µ��Ǩ�͡"      nv_nametext = trim(REPLACE(nv_nametext,"���µ��Ǩ�͡","")).     
ELSE IF INDEX(nv_nametext,"�����")            <> 0 THEN ASSIGN nv_titlenam = "�����"            nv_nametext = trim(REPLACE(nv_nametext,"�����","")).           
ELSE IF INDEX(nv_nametext,"�����͡")           <> 0 THEN ASSIGN nv_titlenam = "�����͡"           nv_nametext = trim(REPLACE(nv_nametext,"�����͡","")).          
ELSE IF INDEX(nv_nametext,"���͵��")           <> 0 THEN ASSIGN nv_titlenam = "���͵��"           nv_nametext = trim(REPLACE(nv_nametext,"���͵��","")).          
ELSE IF INDEX(nv_nametext,"�����")            <> 0 THEN ASSIGN nv_titlenam = "�����"            nv_nametext = trim(REPLACE(nv_nametext,"�����","")).           
ELSE IF INDEX(nv_nametext,"�����ҡ�ȵ��")      <> 0 THEN ASSIGN nv_titlenam = "�����ҡ�ȵ��"      nv_nametext = trim(REPLACE(nv_nametext,"�����ҡ�ȵ��","")).     
ELSE IF INDEX(nv_nametext,"�����ҡ���")       <> 0 THEN ASSIGN nv_titlenam = "�����ҡ���"       nv_nametext = trim(REPLACE(nv_nametext,"�����ҡ���","")).      
ELSE IF INDEX(nv_nametext,"�����ҡ���͡")      <> 0 THEN ASSIGN nv_titlenam = "�����ҡ���͡"      nv_nametext = trim(REPLACE(nv_nametext,"�����ҡ���͡","")).     
ELSE IF INDEX(nv_nametext,"�����͡")           <> 0 THEN ASSIGN nv_titlenam = "�����͡"           nv_nametext = trim(REPLACE(nv_nametext,"�����͡","")).          
ELSE IF INDEX(nv_nametext,"�.�.")              <> 0 THEN ASSIGN nv_titlenam = "�.�."              nv_nametext = trim(REPLACE(nv_nametext,"�.�.","")).             
ELSE IF INDEX(nv_nametext,"�.�.�.")            <> 0 THEN ASSIGN nv_titlenam = "�.�.�."            nv_nametext = trim(REPLACE(nv_nametext,"�.�.�.","")).           
ELSE IF INDEX(nv_nametext,"�.�.�.")            <> 0 THEN ASSIGN nv_titlenam = "�.�.�."            nv_nametext = trim(REPLACE(nv_nametext,"�.�.�.","")).           
ELSE IF INDEX(nv_nametext,"�.�.�.")            <> 0 THEN ASSIGN nv_titlenam = "�.�.�."            nv_nametext = trim(REPLACE(nv_nametext,"�.�.�.","")).           
ELSE IF INDEX(nv_nametext,"�.�.")              <> 0 THEN ASSIGN nv_titlenam = "�.�."              nv_nametext = trim(REPLACE(nv_nametext,"�.�.","")).             
ELSE IF INDEX(nv_nametext,"�.�.")              <> 0 THEN ASSIGN nv_titlenam = "�.�."              nv_nametext = trim(REPLACE(nv_nametext,"�.�.","")).             
ELSE IF INDEX(nv_nametext,"�Ժ���")            <> 0 THEN ASSIGN nv_titlenam = "�Ժ���"            nv_nametext = trim(REPLACE(nv_nametext,"�Ժ���","")).           
ELSE IF INDEX(nv_nametext,"�Ժ���Ǩ���")       <> 0 THEN ASSIGN nv_titlenam = "�Ժ���Ǩ���"       nv_nametext = trim(REPLACE(nv_nametext,"�Ժ���Ǩ���","")).      
ELSE IF INDEX(nv_nametext,"�Ժ���Ǩ�")        <> 0 THEN ASSIGN nv_titlenam = "�Ժ���Ǩ�"        nv_nametext = trim(REPLACE(nv_nametext,"�Ժ���Ǩ�","")).       
ELSE IF INDEX(nv_nametext,"�Ժ���Ǩ�͡")       <> 0 THEN ASSIGN nv_titlenam = "�Ժ���Ǩ�͡"       nv_nametext = trim(REPLACE(nv_nametext,"�Ժ���Ǩ�͡","")).      
ELSE IF INDEX(nv_nametext,"�Ժ�")             <> 0 THEN ASSIGN nv_titlenam = "�Ժ�"             nv_nametext = trim(REPLACE(nv_nametext,"�Ժ�","")).            
ELSE IF INDEX(nv_nametext,"�Ժ�͡")            <> 0 THEN ASSIGN nv_titlenam = "�Ժ�͡"            nv_nametext = trim(REPLACE(nv_nametext,"�Ժ�͡","")).           
ELSE IF INDEX(nv_nametext,"������Ҫǧ��")      <> 0 THEN ASSIGN nv_titlenam = "������Ҫǧ��"      nv_nametext = trim(REPLACE(nv_nametext,"������Ҫǧ��","")).     
ELSE IF INDEX(nv_nametext,"�������ǧ")         <> 0 THEN ASSIGN nv_titlenam = "�������ǧ"         nv_nametext = trim(REPLACE(nv_nametext,"�������ǧ","")).   
IF INDEX(nv_nametext," ") <> 0 THEN 
    ASSIGN 
    nv_lname = trim(SUBSTR(nv_nametext,R-INDEX(nv_nametext," ")))
    nv_fname = trim(SUBSTR(nv_nametext,1,R-INDEX(nv_nametext," "))).
/*
MESSAGE "nv_titlenam:" nv_titlenam  skip
        "nv_fname   :" nv_fname     skip
        "nv_lname   :" nv_lname     skip
    nv_nametext
    VIEW-AS ALERT-BOX.*/
