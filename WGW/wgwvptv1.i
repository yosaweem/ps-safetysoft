/************************************************************************/
/* wgwvptv1.i    Transfer log web to Premium &  Release 				    */
/* Copyright	: Tokio Marine Safety Insurance (Thailand) PCL.         */
/*			  บริษัท คุ้มภัยโตเกียวมารีนประกันภัย (ประเทศไทย)			*/
/*Create by : Chaiying w. A66-0116 08/09/2023                           */
/*          : add Transfer                                              */
/*Modify By : Chaiyong W. F67-0001 08/10/2024                           */
/*            Correct Speed Program                                     */
/************************************************************************/
//FIND FIRST stat.vat104 USE-INDEX vat10401 Comment by Chaiyong W. F67-0001 08/10/2024
FIND stat.vat104 USE-INDEX vat10401 /*--Add by Chaiyong W. F67-0001 08/10/2024*/
   WHERE stat.vat104.invtyp  = brstat.vat100.invtyp 
     AND stat.vat104.invoice = brstat.vat100.invoice    NO-LOCK NO-ERROR.
IF NOT AVAIL stat.vat104 THEN DO:
    CREATE stat.vat104.
    ASSIGN
        stat.vat104.invtyp            = brstat.vat100.invtyp           
        stat.vat104.buytyp            = brstat.vat100.buytyp           
        stat.vat104.invoice           = brstat.vat100.invoice          
        stat.vat104.invdat            = brstat.vat100.invdat           
        stat.vat104.poltyp            = brstat.vat100.poltyp           
        stat.vat104.policy            = brstat.vat100.policy           
        stat.vat104.rencnt            = brstat.vat100.rencnt           
        stat.vat104.endcnt            = brstat.vat100.endcnt           
        stat.vat104.branch            = brstat.vat100.branch           
        stat.vat104.invbrn            = brstat.vat100.invbrn           
        stat.vat104.acno              = brstat.vat100.acno             
        stat.vat104.agent             = brstat.vat100.agent            
        stat.vat104.pvrvjv            = brstat.vat100.pvrvjv           
        stat.vat104.trnty1            = brstat.vat100.trnty1           
        stat.vat104.refno             = brstat.vat100.refno            
        stat.vat104.ratevat           = brstat.vat100.ratevat          
        stat.vat104.oldamt            = brstat.vat100.oldamt           
        stat.vat104.amount            = brstat.vat100.amount           
        stat.vat104.discamt           = brstat.vat100.discamt          
        stat.vat104.totamt            = brstat.vat100.totamt           
        stat.vat104.vatamt            = brstat.vat100.vatamt           
        stat.vat104.grandamt          = brstat.vat100.grandamt         
        stat.vat104.insref            = brstat.vat100.insref           
        stat.vat104.name              = brstat.vat100.name             
        stat.vat104.add1              = brstat.vat100.add1             
        stat.vat104.add2              = brstat.vat100.add2             
        stat.vat104.taxno             = brstat.vat100.taxno            
        stat.vat104.desci             = brstat.vat100.desci            
        stat.vat104.descdis           = brstat.vat100.descdis          
        stat.vat104.entdat            = brstat.vat100.entdat           
        stat.vat104.enttime           = brstat.vat100.enttime          
        stat.vat104.usrid             = brstat.vat100.usrid            
        stat.vat104.remark1           = brstat.vat100.remark1          
        stat.vat104.remark2           = brstat.vat100.remark2          
        stat.vat104.cancel            = brstat.vat100.cancel           
        stat.vat104.print             = brstat.vat100.print            
        stat.vat104.program           = brstat.vat100.program          
        stat.vat104.remcan            = brstat.vat100.remcan           
        stat.vat104.INVOLD            = brstat.vat100.INVOLD           
        stat.vat104.olddat            = brstat.vat100.olddat           
        stat.vat104.taxmont           = brstat.vat100.taxmont          
        stat.vat104.taxyear           = brstat.vat100.taxyear          
        stat.vat104.taxrepm           = brstat.vat100.taxrepm          
        stat.vat104.crevat            = brstat.vat100.crevat           
        stat.vat104.crevat_p          = brstat.vat100.crevat_p         
        stat.vat104.datafr            = brstat.vat100.datafr           
        stat.vat104.endno             = brstat.vat100.endno            
        stat.vat104.comdat            = brstat.vat100.comdat           
        stat.vat104.expdat            = brstat.vat100.expdat           
        stat.vat104.accdat            = brstat.vat100.accdat           
        stat.vat104.brnins            = brstat.vat100.brnins           
        stat.vat104.ag_name           = brstat.vat100.ag_name          
        stat.vat104.ac_name           = brstat.vat100.ac_name          
        stat.vat104.class             = brstat.vat100.class            
        stat.vat104.occupn            = brstat.vat100.occupn           
        stat.vat104.proginv           = brstat.vat100.proginv          
        stat.vat104.addr3             = brstat.vat100.addr3            
        stat.vat104.addr4             = brstat.vat100.addr4            
        stat.vat104.vehuse            = brstat.vat100.vehuse           
        stat.vat104.model             = brstat.vat100.model            
        stat.vat104.vehreg            = brstat.vat100.vehreg           
        stat.vat104.chas_no           = brstat.vat100.chas_no          
        stat.vat104.eng_no            = brstat.vat100.eng_no           
        stat.vat104.tons              = brstat.vat100.tons             
        stat.vat104.engine            = brstat.vat100.engine           
        stat.vat104.siprem            = brstat.vat100.siprem           
        stat.vat104.acctext           = brstat.vat100.acctext          
        stat.vat104.accdeci           = brstat.vat100.accdeci          
        stat.vat104.drivnam1          = brstat.vat100.drivnam1         
        stat.vat104.drivnam2          = brstat.vat100.drivnam2         
        stat.vat104.drivdate1         = brstat.vat100.drivdate1        
        stat.vat104.drivdate2         = brstat.vat100.drivdate2        
        stat.vat104.occdriv1          = brstat.vat100.occdriv1         
        stat.vat104.occdriv2          = brstat.vat100.occdriv2         
        stat.vat104.idno_driv1        = brstat.vat100.idno_driv1       
        stat.vat104.idno_driv2        = brstat.vat100.idno_driv2       
        stat.vat104.seat              = brstat.vat100.seat             
        stat.vat104.vat_dat1          = brstat.vat100.vat_dat1         
        stat.vat104.vat_dat2          = brstat.vat100.vat_dat2         
        stat.vat104.vat_dat3          = brstat.vat100.vat_dat3         
        stat.vat104.vat_dat4          = brstat.vat100.vat_dat4         
        stat.vat104.vatchar1          = brstat.vat100.vatchar1         
        stat.vat104.vatchar2          = brstat.vat100.vatchar2         
        stat.vat104.vatchar3          = brstat.vat100.vatchar3         
        stat.vat104.vatchar4          = brstat.vat100.vatchar4         
        stat.vat104.vatchar5          = brstat.vat100.vatchar5         
        stat.vat104.vatchar6          = brstat.vat100.vatchar6         
        stat.vat104.vatchar7          = brstat.vat100.vatchar7         
        stat.vat104.vatchar8          = brstat.vat100.vatchar8         
        stat.vat104.vatchar9          = brstat.vat100.vatchar9         
        stat.vat104.vatchar10         = brstat.vat100.vatchar10        
        stat.vat104.vdeci1            = brstat.vat100.vdeci1           
        stat.vat104.vdeci2            = brstat.vat100.vdeci2           
        stat.vat104.vdeci3            = brstat.vat100.vdeci3           
        stat.vat104.vdeci4            = brstat.vat100.vdeci4           
        stat.vat104.vdeci5            = brstat.vat100.vdeci5           
        stat.vat104.prndat            = brstat.vat100.prndat           
        stat.vat104.brncod            = brstat.vat100.brncod           
        stat.vat104.brnadd1           = brstat.vat100.brnadd1          
        stat.vat104.brnadd2           = brstat.vat100.brnadd2          
        stat.vat104.postcode          = brstat.vat100.postcode         
        stat.vat104.firstname         = brstat.vat100.firstname        
        stat.vat104.lastname          = brstat.vat100.lastname         
        stat.vat104.ntitle            = brstat.vat100.ntitle    .

END.
