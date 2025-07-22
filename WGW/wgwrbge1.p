
/*programid   : wgwrbgen.w                                              */  
/*programname : Load Text & Generate text file Rabbit                   */  
/*Copyright   : Safety Insurance Public Company Limited                 */  
/*              บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                      */  
/*create by   : Kridtiya i. A64-0325 date. 21/08/2021                  
                แปลงข้อมูล คำนำ   */ 
/************************************************************************/
DEF INPUT         PARAMETER nv_nametext AS CHAR.
DEF INPUT-OUTPUT  PARAMETER nv_titlenam AS CHAR.
DEF INPUT-OUTPUT  PARAMETER nv_fname    AS CHAR.
DEF INPUT-OUTPUT  PARAMETER nv_lname    AS CHAR.
ASSIGN nv_titlenam = ""
       nv_fname    = ""
       nv_lname    = "".
IF      INDEX(nv_nametext,"คุณ")               <> 0 THEN ASSIGN nv_titlenam = "คุณ"               nv_nametext = trim(REPLACE(nv_nametext,"คุณ","")).
ELSE IF INDEX(nv_nametext,"นาย")               <> 0 THEN ASSIGN nv_titlenam = "นาย"               nv_nametext = trim(REPLACE(nv_nametext,"นาย","")).
ELSE IF INDEX(nv_nametext,"นางสาว")            <> 0 THEN ASSIGN nv_titlenam = "นางสาว"            nv_nametext = trim(REPLACE(nv_nametext,"นางสาว","")).   
ELSE IF INDEX(nv_nametext,"น.ส.")              <> 0 THEN ASSIGN nv_titlenam = "น.ส."              nv_nametext = trim(REPLACE(nv_nametext,"น.ส.","")).   
ELSE IF INDEX(nv_nametext,"นาง")               <> 0 THEN ASSIGN nv_titlenam = "นาง"               nv_nametext = trim(REPLACE(nv_nametext,"นาง","")).   
ELSE IF INDEX(nv_nametext,"MR")                <> 0 THEN ASSIGN nv_titlenam = "MR"                nv_nametext = trim(REPLACE(nv_nametext,"MR","")).   
ELSE IF INDEX(nv_nametext,"MRS")               <> 0 THEN ASSIGN nv_titlenam = "MRS"               nv_nametext = trim(REPLACE(nv_nametext,"MRS","")).   
ELSE IF INDEX(nv_nametext,"MISS")              <> 0 THEN ASSIGN nv_titlenam = "MISS"              nv_nametext = trim(REPLACE(nv_nametext,"MISS","")). 
ELSE IF INDEX(nv_nametext,"บริษัท")            <> 0 THEN ASSIGN nv_titlenam = "บริษัท"            nv_nametext = trim(REPLACE(nv_nametext,"บริษัท","")).           
ELSE IF INDEX(nv_nametext,"บ.")                <> 0 THEN ASSIGN nv_titlenam = "บ."                nv_nametext = trim(REPLACE(nv_nametext,"บ.","")).               
ELSE IF INDEX(nv_nametext,"บจก.")              <> 0 THEN ASSIGN nv_titlenam = "บจก."              nv_nametext = trim(REPLACE(nv_nametext,"บจก.","")).             
ELSE IF INDEX(nv_nametext,"หจก.")              <> 0 THEN ASSIGN nv_titlenam = "หจก."              nv_nametext = trim(REPLACE(nv_nametext,"หจก.","")).             
ELSE IF INDEX(nv_nametext,"หสน.")              <> 0 THEN ASSIGN nv_titlenam = "หสน."              nv_nametext = trim(REPLACE(nv_nametext,"หสน.","")).             
ELSE IF INDEX(nv_nametext,"บรรษัท")            <> 0 THEN ASSIGN nv_titlenam = "บรรษัท"            nv_nametext = trim(REPLACE(nv_nametext,"บรรษัท","")).           
ELSE IF INDEX(nv_nametext,"มูลนิธิ")           <> 0 THEN ASSIGN nv_titlenam = "มูลนิธิ"           nv_nametext = trim(REPLACE(nv_nametext,"มูลนิธิ","")).          
ELSE IF INDEX(nv_nametext,"ห้างหุ้นส่วนจำกัด") <> 0 THEN ASSIGN nv_titlenam = "ห้างหุ้นส่วนจำกัด" nv_nametext = trim(REPLACE(nv_nametext,"ห้างหุ้นส่วนจำกัด","")).
ELSE IF INDEX(nv_nametext,"ห้างหุ้นส่วน")      <> 0 THEN ASSIGN nv_titlenam = "ห้างหุ้นส่วน"      nv_nametext = trim(REPLACE(nv_nametext,"ห้างหุ้นส่วน","")).     
ELSE IF INDEX(nv_nametext,"ห้าง")              <> 0 THEN ASSIGN nv_titlenam = "ห้าง"              nv_nametext = trim(REPLACE(nv_nametext,"ห้าง","")).             
ELSE IF INDEX(nv_nametext,"จ.ต.")              <> 0 THEN ASSIGN nv_titlenam = "จ.ต."              nv_nametext = trim(REPLACE(nv_nametext,"จ.ต.","")).             
ELSE IF INDEX(nv_nametext,"จ.ท.")              <> 0 THEN ASSIGN nv_titlenam = "จ.ท."              nv_nametext = trim(REPLACE(nv_nametext,"จ.ท.","")).             
ELSE IF INDEX(nv_nametext,"จ.ส.ต.")            <> 0 THEN ASSIGN nv_titlenam = "จ.ส.ต."            nv_nametext = trim(REPLACE(nv_nametext,"จ.ส.ต.","")).           
ELSE IF INDEX(nv_nametext,"จ.ส.ท.")            <> 0 THEN ASSIGN nv_titlenam = "จ.ส.ท."            nv_nametext = trim(REPLACE(nv_nametext,"จ.ส.ท.","")).           
ELSE IF INDEX(nv_nametext,"จ.ส.อ.")            <> 0 THEN ASSIGN nv_titlenam = "จ.ส.อ."            nv_nametext = trim(REPLACE(nv_nametext,"จ.ส.อ.","")).           
ELSE IF INDEX(nv_nametext,"จ.อ.")              <> 0 THEN ASSIGN nv_titlenam = "จ.อ."              nv_nametext = trim(REPLACE(nv_nametext,"จ.อ.","")).             
ELSE IF INDEX(nv_nametext,"จ่าตรี")            <> 0 THEN ASSIGN nv_titlenam = "จ่าตรี"            nv_nametext = trim(REPLACE(nv_nametext,"จ่าตรี","")).           
ELSE IF INDEX(nv_nametext,"จ่าโท")             <> 0 THEN ASSIGN nv_titlenam = "จ่าโท"             nv_nametext = trim(REPLACE(nv_nametext,"จ่าโท","")).            
ELSE IF INDEX(nv_nametext,"จ่าสิบตรี")         <> 0 THEN ASSIGN nv_titlenam = "จ่าสิบตรี"         nv_nametext = trim(REPLACE(nv_nametext,"จ่าสิบตรี","")).        
ELSE IF INDEX(nv_nametext,"จ่าสิบตำรวจ")       <> 0 THEN ASSIGN nv_titlenam = "จ่าสิบตำรวจ"       nv_nametext = trim(REPLACE(nv_nametext,"จ่าสิบตำรวจ","")).      
ELSE IF INDEX(nv_nametext,"จ่าสิบโท")          <> 0 THEN ASSIGN nv_titlenam = "จ่าสิบโท"          nv_nametext = trim(REPLACE(nv_nametext,"จ่าสิบโท","")).         
ELSE IF INDEX(nv_nametext,"จ่าสิบเอก")         <> 0 THEN ASSIGN nv_titlenam = "จ่าสิบเอก"         nv_nametext = trim(REPLACE(nv_nametext,"จ่าสิบเอก","")).        
ELSE IF INDEX(nv_nametext,"จ่าอากาศตรี")       <> 0 THEN ASSIGN nv_titlenam = "จ่าอากาศตรี"       nv_nametext = trim(REPLACE(nv_nametext,"จ่าอากาศตรี","")).      
ELSE IF INDEX(nv_nametext,"จ่าอากาศโท")        <> 0 THEN ASSIGN nv_titlenam = "จ่าอากาศโท"        nv_nametext = trim(REPLACE(nv_nametext,"จ่าอากาศโท","")).       
ELSE IF INDEX(nv_nametext,"จ่าอากาศเอก")       <> 0 THEN ASSIGN nv_titlenam = "จ่าอากาศเอก"       nv_nametext = trim(REPLACE(nv_nametext,"จ่าอากาศเอก","")).      
ELSE IF INDEX(nv_nametext,"จ่าเอก")            <> 0 THEN ASSIGN nv_titlenam = "จ่าเอก"            nv_nametext = trim(REPLACE(nv_nametext,"จ่าเอก","")).           
ELSE IF INDEX(nv_nametext,"ด.ต.")              <> 0 THEN ASSIGN nv_titlenam = "ด.ต."              nv_nametext = trim(REPLACE(nv_nametext,"ด.ต.","")).             
ELSE IF INDEX(nv_nametext,"ตำรวจ")             <> 0 THEN ASSIGN nv_titlenam = "ตำรวจ"             nv_nametext = trim(REPLACE(nv_nametext,"ตำรวจ","")).            
ELSE IF INDEX(nv_nametext,"ทหารเรือ")          <> 0 THEN ASSIGN nv_titlenam = "ทหารเรือ"          nv_nametext = trim(REPLACE(nv_nametext,"ทหารเรือ","")).         
ELSE IF INDEX(nv_nametext,"ทหารอากาศ")         <> 0 THEN ASSIGN nv_titlenam = "ทหารอากาศ"         nv_nametext = trim(REPLACE(nv_nametext,"ทหารอากาศ","")).        
ELSE IF INDEX(nv_nametext,"น.ต.")              <> 0 THEN ASSIGN nv_titlenam = "น.ต."              nv_nametext = trim(REPLACE(nv_nametext,"น.ต.","")).             
ELSE IF INDEX(nv_nametext,"น.ท.")              <> 0 THEN ASSIGN nv_titlenam = "น.ท."              nv_nametext = trim(REPLACE(nv_nametext,"น.ท.","")).             
ELSE IF INDEX(nv_nametext,"น.อ.")              <> 0 THEN ASSIGN nv_titlenam = "น.อ."              nv_nametext = trim(REPLACE(nv_nametext,"น.อ.","")).             
ELSE IF INDEX(nv_nametext,"นายดาบตำรวจ")       <> 0 THEN ASSIGN nv_titlenam = "นายดาบตำรวจ"       nv_nametext = trim(REPLACE(nv_nametext,"นายดาบตำรวจ","")).      
ELSE IF INDEX(nv_nametext,"นาวาตรี")           <> 0 THEN ASSIGN nv_titlenam = "นาวาตรี"           nv_nametext = trim(REPLACE(nv_nametext,"นาวาตรี","")).          
ELSE IF INDEX(nv_nametext,"นาวาโท")            <> 0 THEN ASSIGN nv_titlenam = "นาวาโท"            nv_nametext = trim(REPLACE(nv_nametext,"นาวาโท","")).           
ELSE IF INDEX(nv_nametext,"นาวาอากาศตรี")      <> 0 THEN ASSIGN nv_titlenam = "นาวาอากาศตรี"      nv_nametext = trim(REPLACE(nv_nametext,"นาวาอากาศตรี","")).     
ELSE IF INDEX(nv_nametext,"นาวาอากาศโท")       <> 0 THEN ASSIGN nv_titlenam = "นาวาอากาศโท"       nv_nametext = trim(REPLACE(nv_nametext,"นาวาอากาศโท","")).      
ELSE IF INDEX(nv_nametext,"นาวาอากาศเอก")      <> 0 THEN ASSIGN nv_titlenam = "นาวาอากาศเอก"      nv_nametext = trim(REPLACE(nv_nametext,"นาวาอากาศเอก","")).     
ELSE IF INDEX(nv_nametext,"นาวาเอก")           <> 0 THEN ASSIGN nv_titlenam = "นาวาเอก"           nv_nametext = trim(REPLACE(nv_nametext,"นาวาเอก","")).          
ELSE IF INDEX(nv_nametext,"พ.จ.ต.")            <> 0 THEN ASSIGN nv_titlenam = "พ.จ.ต."            nv_nametext = trim(REPLACE(nv_nametext,"พ.จ.ต.","")).           
ELSE IF INDEX(nv_nametext,"พ.จ.ท.")            <> 0 THEN ASSIGN nv_titlenam = "พ.จ.ท."            nv_nametext = trim(REPLACE(nv_nametext,"พ.จ.ท.","")).           
ELSE IF INDEX(nv_nametext,"พ.จ.อ.")            <> 0 THEN ASSIGN nv_titlenam = "พ.จ.อ."            nv_nametext = trim(REPLACE(nv_nametext,"พ.จ.อ.","")).           
ELSE IF INDEX(nv_nametext,"พ.ต.")              <> 0 THEN ASSIGN nv_titlenam = "พ.ต."              nv_nametext = trim(REPLACE(nv_nametext,"พ.ต.","")).             
ELSE IF INDEX(nv_nametext,"พ.ต.ต.")            <> 0 THEN ASSIGN nv_titlenam = "พ.ต.ต."            nv_nametext = trim(REPLACE(nv_nametext,"พ.ต.ต.","")).           
ELSE IF INDEX(nv_nametext,"พ.ต.ท.")            <> 0 THEN ASSIGN nv_titlenam = "พ.ต.ท."            nv_nametext = trim(REPLACE(nv_nametext,"พ.ต.ท.","")).           
ELSE IF INDEX(nv_nametext,"พ.ต.อ.")            <> 0 THEN ASSIGN nv_titlenam = "พ.ต.อ."            nv_nametext = trim(REPLACE(nv_nametext,"พ.ต.อ.","")).           
ELSE IF INDEX(nv_nametext,"พ.ท.")              <> 0 THEN ASSIGN nv_titlenam = "พ.ท."              nv_nametext = trim(REPLACE(nv_nametext,"พ.ท.","")).             
ELSE IF INDEX(nv_nametext,"พลฯ")               <> 0 THEN ASSIGN nv_titlenam = "พลฯ"               nv_nametext = trim(REPLACE(nv_nametext,"พลฯ","")).              
ELSE IF INDEX(nv_nametext,"พล.ต.")             <> 0 THEN ASSIGN nv_titlenam = "พล.ต."             nv_nametext = trim(REPLACE(nv_nametext,"พล.ต.","")).            
ELSE IF INDEX(nv_nametext,"พล.ต.ต.")           <> 0 THEN ASSIGN nv_titlenam = "พล.ต.ต."           nv_nametext = trim(REPLACE(nv_nametext,"พล.ต.ต.","")).          
ELSE IF INDEX(nv_nametext,"พล.ต.ท.")           <> 0 THEN ASSIGN nv_titlenam = "พล.ต.ท."           nv_nametext = trim(REPLACE(nv_nametext,"พล.ต.ท.","")).          
ELSE IF INDEX(nv_nametext,"พลตรี")             <> 0 THEN ASSIGN nv_titlenam = "พลตรี"             nv_nametext = trim(REPLACE(nv_nametext,"พลตรี","")).            
ELSE IF INDEX(nv_nametext,"พล.ต.อ.")           <> 0 THEN ASSIGN nv_titlenam = "พล.ต.อ."           nv_nametext = trim(REPLACE(nv_nametext,"พล.ต.อ.","")).          
ELSE IF INDEX(nv_nametext,"พลตำรวจ")           <> 0 THEN ASSIGN nv_titlenam = "พลตำรวจ"           nv_nametext = trim(REPLACE(nv_nametext,"พลตำรวจ","")).          
ELSE IF INDEX(nv_nametext,"พลตำรวจตรี")        <> 0 THEN ASSIGN nv_titlenam = "พลตำรวจตรี"        nv_nametext = trim(REPLACE(nv_nametext,"พลตำรวจตรี","")).       
ELSE IF INDEX(nv_nametext,"พลตำรวจโท")         <> 0 THEN ASSIGN nv_titlenam = "พลตำรวจโท"         nv_nametext = trim(REPLACE(nv_nametext,"พลตำรวจโท","")).        
ELSE IF INDEX(nv_nametext,"พลตำรวจเอก")        <> 0 THEN ASSIGN nv_titlenam = "พลตำรวจเอก"        nv_nametext = trim(REPLACE(nv_nametext,"พลตำรวจเอก","")).       
ELSE IF INDEX(nv_nametext,"พล.ท.")             <> 0 THEN ASSIGN nv_titlenam = "พล.ท."             nv_nametext = trim(REPLACE(nv_nametext,"พล.ท.","")).            
ELSE IF INDEX(nv_nametext,"พลทหาร")            <> 0 THEN ASSIGN nv_titlenam = "พลทหาร"            nv_nametext = trim(REPLACE(nv_nametext,"พลทหาร","")).           
ELSE IF INDEX(nv_nametext,"พลโท")              <> 0 THEN ASSIGN nv_titlenam = "พลโท"              nv_nametext = trim(REPLACE(nv_nametext,"พลโท","")).             
ELSE IF INDEX(nv_nametext,"พล.ร.ต.")           <> 0 THEN ASSIGN nv_titlenam = "พล.ร.ต."           nv_nametext = trim(REPLACE(nv_nametext,"พล.ร.ต.","")).          
ELSE IF INDEX(nv_nametext,"พล.ร.ท.")           <> 0 THEN ASSIGN nv_titlenam = "พล.ร.ท."           nv_nametext = trim(REPLACE(nv_nametext,"พล.ร.ท.","")).          
ELSE IF INDEX(nv_nametext,"พล.ร.อ.")           <> 0 THEN ASSIGN nv_titlenam = "พล.ร.อ."           nv_nametext = trim(REPLACE(nv_nametext,"พล.ร.อ.","")).          
ELSE IF INDEX(nv_nametext,"พลเรือตรี")         <> 0 THEN ASSIGN nv_titlenam = "พลเรือตรี"         nv_nametext = trim(REPLACE(nv_nametext,"พลเรือตรี","")).        
ELSE IF INDEX(nv_nametext,"พลเรือโท")          <> 0 THEN ASSIGN nv_titlenam = "พลเรือโท"          nv_nametext = trim(REPLACE(nv_nametext,"พลเรือโท","")).         
ELSE IF INDEX(nv_nametext,"พลเรือเอก")         <> 0 THEN ASSIGN nv_titlenam = "พลเรือเอก"         nv_nametext = trim(REPLACE(nv_nametext,"พลเรือเอก","")).        
ELSE IF INDEX(nv_nametext,"พล.อ.")             <> 0 THEN ASSIGN nv_titlenam = "พล.อ."             nv_nametext = trim(REPLACE(nv_nametext,"พล.อ.","")).            
ELSE IF INDEX(nv_nametext,"พล.อ.ต.")           <> 0 THEN ASSIGN nv_titlenam = "พล.อ.ต."           nv_nametext = trim(REPLACE(nv_nametext,"พล.อ.ต.","")).          
ELSE IF INDEX(nv_nametext,"พล.อ.ท.")           <> 0 THEN ASSIGN nv_titlenam = "พล.อ.ท."           nv_nametext = trim(REPLACE(nv_nametext,"พล.อ.ท.","")).          
ELSE IF INDEX(nv_nametext,"พล.อ.อ.")           <> 0 THEN ASSIGN nv_titlenam = "พล.อ.อ."           nv_nametext = trim(REPLACE(nv_nametext,"พล.อ.อ.","")).          
ELSE IF INDEX(nv_nametext,"พลอากาศตรี")        <> 0 THEN ASSIGN nv_titlenam = "พลอากาศตรี"        nv_nametext = trim(REPLACE(nv_nametext,"พลอากาศตรี","")).       
ELSE IF INDEX(nv_nametext,"พลอากาศโท")         <> 0 THEN ASSIGN nv_titlenam = "พลอากาศโท"         nv_nametext = trim(REPLACE(nv_nametext,"พลอากาศโท","")).        
ELSE IF INDEX(nv_nametext,"พลอากาศเอก")        <> 0 THEN ASSIGN nv_titlenam = "พลอากาศเอก"        nv_nametext = trim(REPLACE(nv_nametext,"พลอากาศเอก","")).       
ELSE IF INDEX(nv_nametext,"พลเอก")             <> 0 THEN ASSIGN nv_titlenam = "พลเอก"             nv_nametext = trim(REPLACE(nv_nametext,"พลเอก","")).            
ELSE IF INDEX(nv_nametext,"พ.อ.")              <> 0 THEN ASSIGN nv_titlenam = "พ.อ."              nv_nametext = trim(REPLACE(nv_nametext,"พ.อ.","")).             
ELSE IF INDEX(nv_nametext,"พ.อ.ต.")            <> 0 THEN ASSIGN nv_titlenam = "พ.อ.ต."            nv_nametext = trim(REPLACE(nv_nametext,"พ.อ.ต.","")).           
ELSE IF INDEX(nv_nametext,"พ.อ.ท.")            <> 0 THEN ASSIGN nv_titlenam = "พ.อ.ท."            nv_nametext = trim(REPLACE(nv_nametext,"พ.อ.ท.","")).           
ELSE IF INDEX(nv_nametext,"พ.อ.อ.")            <> 0 THEN ASSIGN nv_titlenam = "พ.อ.อ."            nv_nametext = trim(REPLACE(nv_nametext,"พ.อ.อ.","")).           
ELSE IF INDEX(nv_nametext,"พันจ่าตรี")         <> 0 THEN ASSIGN nv_titlenam = "พันจ่าตรี"         nv_nametext = trim(REPLACE(nv_nametext,"พันจ่าตรี","")).        
ELSE IF INDEX(nv_nametext,"พันจ่าโท")          <> 0 THEN ASSIGN nv_titlenam = "พันจ่าโท"          nv_nametext = trim(REPLACE(nv_nametext,"พันจ่าโท","")).         
ELSE IF INDEX(nv_nametext,"พันจ่าอากาศตรี")    <> 0 THEN ASSIGN nv_titlenam = "พันจ่าอากาศตรี"    nv_nametext = trim(REPLACE(nv_nametext,"พันจ่าอากาศตรี","")).   
ELSE IF INDEX(nv_nametext,"พันจ่าอากาศโท")     <> 0 THEN ASSIGN nv_titlenam = "พันจ่าอากาศโท"     nv_nametext = trim(REPLACE(nv_nametext,"พันจ่าอากาศโท","")).    
ELSE IF INDEX(nv_nametext,"พันจ่าอากาศเอก")    <> 0 THEN ASSIGN nv_titlenam = "พันจ่าอากาศเอก"    nv_nametext = trim(REPLACE(nv_nametext,"พันจ่าอากาศเอก","")).   
ELSE IF INDEX(nv_nametext,"พันจ่าเอก")         <> 0 THEN ASSIGN nv_titlenam = "พันจ่าเอก"         nv_nametext = trim(REPLACE(nv_nametext,"พันจ่าเอก","")).        
ELSE IF INDEX(nv_nametext,"พันตรี")            <> 0 THEN ASSIGN nv_titlenam = "พันตรี"            nv_nametext = trim(REPLACE(nv_nametext,"พันตรี","")).           
ELSE IF INDEX(nv_nametext,"พันตำรวจตรี")       <> 0 THEN ASSIGN nv_titlenam = "พันตำรวจตรี"       nv_nametext = trim(REPLACE(nv_nametext,"พันตำรวจตรี","")).      
ELSE IF INDEX(nv_nametext,"พันตำรวจโท")        <> 0 THEN ASSIGN nv_titlenam = "พันตำรวจโท"        nv_nametext = trim(REPLACE(nv_nametext,"พันตำรวจโท","")).       
ELSE IF INDEX(nv_nametext,"พันตำรวจเอก")       <> 0 THEN ASSIGN nv_titlenam = "พันตำรวจเอก"       nv_nametext = trim(REPLACE(nv_nametext,"พันตำรวจเอก","")).      
ELSE IF INDEX(nv_nametext,"พันโท")             <> 0 THEN ASSIGN nv_titlenam = "พันโท"             nv_nametext = trim(REPLACE(nv_nametext,"พันโท","")).            
ELSE IF INDEX(nv_nametext,"พันเอก")            <> 0 THEN ASSIGN nv_titlenam = "พันเอก"            nv_nametext = trim(REPLACE(nv_nametext,"พันเอก","")).           
ELSE IF INDEX(nv_nametext,"ม.ร.ว.")            <> 0 THEN ASSIGN nv_titlenam = "ม.ร.ว."            nv_nametext = trim(REPLACE(nv_nametext,"ม.ร.ว.","")).           
ELSE IF INDEX(nv_nametext,"ม.ล.")              <> 0 THEN ASSIGN nv_titlenam = "ม.ล."              nv_nametext = trim(REPLACE(nv_nametext,"ม.ล.","")).             
ELSE IF INDEX(nv_nametext,"ร.ต.")              <> 0 THEN ASSIGN nv_titlenam = "ร.ต."              nv_nametext = trim(REPLACE(nv_nametext,"ร.ต.","")).             
ELSE IF INDEX(nv_nametext,"ร.ต.ต.")            <> 0 THEN ASSIGN nv_titlenam = "ร.ต.ต."            nv_nametext = trim(REPLACE(nv_nametext,"ร.ต.ต.","")).           
ELSE IF INDEX(nv_nametext,"ร.ต.ท.")            <> 0 THEN ASSIGN nv_titlenam = "ร.ต.ท."            nv_nametext = trim(REPLACE(nv_nametext,"ร.ต.ท.","")).           
ELSE IF INDEX(nv_nametext,"ร.ต.อ.")            <> 0 THEN ASSIGN nv_titlenam = "ร.ต.อ."            nv_nametext = trim(REPLACE(nv_nametext,"ร.ต.อ.","")).           
ELSE IF INDEX(nv_nametext,"ร.ท.")              <> 0 THEN ASSIGN nv_titlenam = "ร.ท."              nv_nametext = trim(REPLACE(nv_nametext,"ร.ท.","")).             
ELSE IF INDEX(nv_nametext,"ร.ท.")              <> 0 THEN ASSIGN nv_titlenam = "ร.ท."              nv_nametext = trim(REPLACE(nv_nametext,"ร.ท.","")).             
ELSE IF INDEX(nv_nametext,"ร.อ.")              <> 0 THEN ASSIGN nv_titlenam = "ร.อ."              nv_nametext = trim(REPLACE(nv_nametext,"ร.อ.","")).             
ELSE IF INDEX(nv_nametext,"ร้อยตรี")           <> 0 THEN ASSIGN nv_titlenam = "ร้อยตรี"           nv_nametext = trim(REPLACE(nv_nametext,"ร้อยตรี","")).          
ELSE IF INDEX(nv_nametext,"ร้อยตำรวจตรี")      <> 0 THEN ASSIGN nv_titlenam = "ร้อยตำรวจตรี"      nv_nametext = trim(REPLACE(nv_nametext,"ร้อยตำรวจตรี","")).     
ELSE IF INDEX(nv_nametext,"ร้อยตำรวจโท")       <> 0 THEN ASSIGN nv_titlenam = "ร้อยตำรวจโท"       nv_nametext = trim(REPLACE(nv_nametext,"ร้อยตำรวจโท","")).      
ELSE IF INDEX(nv_nametext,"ร้อยตำรวจเอก")      <> 0 THEN ASSIGN nv_titlenam = "ร้อยตำรวจเอก"      nv_nametext = trim(REPLACE(nv_nametext,"ร้อยตำรวจเอก","")).     
ELSE IF INDEX(nv_nametext,"ร้อยโท")            <> 0 THEN ASSIGN nv_titlenam = "ร้อยโท"            nv_nametext = trim(REPLACE(nv_nametext,"ร้อยโท","")).           
ELSE IF INDEX(nv_nametext,"ร้อยเอก")           <> 0 THEN ASSIGN nv_titlenam = "ร้อยเอก"           nv_nametext = trim(REPLACE(nv_nametext,"ร้อยเอก","")).          
ELSE IF INDEX(nv_nametext,"เรือตรี")           <> 0 THEN ASSIGN nv_titlenam = "เรือตรี"           nv_nametext = trim(REPLACE(nv_nametext,"เรือตรี","")).          
ELSE IF INDEX(nv_nametext,"เรือโท")            <> 0 THEN ASSIGN nv_titlenam = "เรือโท"            nv_nametext = trim(REPLACE(nv_nametext,"เรือโท","")).           
ELSE IF INDEX(nv_nametext,"เรืออากาศตรี")      <> 0 THEN ASSIGN nv_titlenam = "เรืออากาศตรี"      nv_nametext = trim(REPLACE(nv_nametext,"เรืออากาศตรี","")).     
ELSE IF INDEX(nv_nametext,"เรืออากาศโท")       <> 0 THEN ASSIGN nv_titlenam = "เรืออากาศโท"       nv_nametext = trim(REPLACE(nv_nametext,"เรืออากาศโท","")).      
ELSE IF INDEX(nv_nametext,"เรืออากาศเอก")      <> 0 THEN ASSIGN nv_titlenam = "เรืออากาศเอก"      nv_nametext = trim(REPLACE(nv_nametext,"เรืออากาศเอก","")).     
ELSE IF INDEX(nv_nametext,"เรือเอก")           <> 0 THEN ASSIGN nv_titlenam = "เรือเอก"           nv_nametext = trim(REPLACE(nv_nametext,"เรือเอก","")).          
ELSE IF INDEX(nv_nametext,"ส.ต.")              <> 0 THEN ASSIGN nv_titlenam = "ส.ต."              nv_nametext = trim(REPLACE(nv_nametext,"ส.ต.","")).             
ELSE IF INDEX(nv_nametext,"ส.ต.ต.")            <> 0 THEN ASSIGN nv_titlenam = "ส.ต.ต."            nv_nametext = trim(REPLACE(nv_nametext,"ส.ต.ต.","")).           
ELSE IF INDEX(nv_nametext,"ส.ต.ท.")            <> 0 THEN ASSIGN nv_titlenam = "ส.ต.ท."            nv_nametext = trim(REPLACE(nv_nametext,"ส.ต.ท.","")).           
ELSE IF INDEX(nv_nametext,"ส.ต.อ.")            <> 0 THEN ASSIGN nv_titlenam = "ส.ต.อ."            nv_nametext = trim(REPLACE(nv_nametext,"ส.ต.อ.","")).           
ELSE IF INDEX(nv_nametext,"ส.ท.")              <> 0 THEN ASSIGN nv_titlenam = "ส.ท."              nv_nametext = trim(REPLACE(nv_nametext,"ส.ท.","")).             
ELSE IF INDEX(nv_nametext,"ส.อ.")              <> 0 THEN ASSIGN nv_titlenam = "ส.อ."              nv_nametext = trim(REPLACE(nv_nametext,"ส.อ.","")).             
ELSE IF INDEX(nv_nametext,"สิบตรี")            <> 0 THEN ASSIGN nv_titlenam = "สิบตรี"            nv_nametext = trim(REPLACE(nv_nametext,"สิบตรี","")).           
ELSE IF INDEX(nv_nametext,"สิบตำรวจตรี")       <> 0 THEN ASSIGN nv_titlenam = "สิบตำรวจตรี"       nv_nametext = trim(REPLACE(nv_nametext,"สิบตำรวจตรี","")).      
ELSE IF INDEX(nv_nametext,"สิบตำรวจโท")        <> 0 THEN ASSIGN nv_titlenam = "สิบตำรวจโท"        nv_nametext = trim(REPLACE(nv_nametext,"สิบตำรวจโท","")).       
ELSE IF INDEX(nv_nametext,"สิบตำรวจเอก")       <> 0 THEN ASSIGN nv_titlenam = "สิบตำรวจเอก"       nv_nametext = trim(REPLACE(nv_nametext,"สิบตำรวจเอก","")).      
ELSE IF INDEX(nv_nametext,"สิบโท")             <> 0 THEN ASSIGN nv_titlenam = "สิบโท"             nv_nametext = trim(REPLACE(nv_nametext,"สิบโท","")).            
ELSE IF INDEX(nv_nametext,"สิบเอก")            <> 0 THEN ASSIGN nv_titlenam = "สิบเอก"            nv_nametext = trim(REPLACE(nv_nametext,"สิบเอก","")).           
ELSE IF INDEX(nv_nametext,"หม่อมราชวงศ์")      <> 0 THEN ASSIGN nv_titlenam = "หม่อมราชวงศ์"      nv_nametext = trim(REPLACE(nv_nametext,"หม่อมราชวงศ์","")).     
ELSE IF INDEX(nv_nametext,"หม่อมหลวง")         <> 0 THEN ASSIGN nv_titlenam = "หม่อมหลวง"         nv_nametext = trim(REPLACE(nv_nametext,"หม่อมหลวง","")).   
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
