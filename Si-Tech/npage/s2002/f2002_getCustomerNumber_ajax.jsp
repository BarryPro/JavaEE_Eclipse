<%@ page contentType= "text/html;charset=GBK" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
    String workName = (String)session.getAttribute("workName");
    String ipAddr = (String)session.getAttribute("ipAddr");
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
    String sCustomerProvinceNumber = request.getParameter("sCustomerProvinceNumber");
    String retFlag = "0";
    String ParentCustomerNumber  ="";//0�ϼ����ſͻ�����    
    String CompanyID             ="";//1���ſͻ�����ʡ����   
    String CustomerProvinceNumber="";//2���ſͻ�����ʡ����   
    String CustomerNumber        ="";//3EC���ſͻ�����       
    String CustomerName          ="";//4���ſͻ�����         
    String CustomerClassID       ="";//5�ͻ������ʶ         
    String CreditLevelID         ="";//6���õȼ����         
    String CustomerRankID        ="";//7�ͻ���Ҫ����         
    String LoyaltyLevelID        ="";//8�ͻ��ҳ϶�                                
    String NationID              ="";//9����ID���绰���ţ�       
    String TaxNum                ="";//10˰��/Ӫҵִ�պ���       
    String Corporation           ="";//11���˴���                 
    String LoginFinancing        ="";//12ע���ʽ�                                                           
    String IndustryID            ="";//13��ҵ���                                               
    String OrganizationTypeID    ="";//14��ҵ����/��˾����                                                  
    String EmployeeAmountId      ="";//15��ҵ��ģ                                                           
    String MemberCount           ="";//16��ҵԱ����                                                         
    String Location              ="";//17����ʡ/����                                                        
    String PostCode              ="";//18�ʱ�                     
    String AddressFullName       ="";//19��ַ                     
    String Homepage              ="";//20��˾��ҳ                 
    String Background            ="";//21ҵ��ʹ�����/��˾����    
    String OrgCustID             ="";//22ʡBOSS�ڼ��ſͻ�����     
    String Description           ="";//23��ע��Ϣ              
    String StaffNumber           ="";//24�ͻ�������         
    String StaffName             ="";//25����                 
    String ContactPhone          ="";//26��ϵ�绰             
    String MobilePhone           ="";//27�ֻ�                 
    String ContactFax            ="";//28����                 
    String E_mail                ="";//29�����ʼ�             
    String LeaderName            ="";//30�ͻ������ϼ��쵼���� 
    String LeaderTel             ="";//31�ͻ������ϼ��쵼�绰 
    String CustomerServLevel     ="";//32�ͻ�����ȼ�
    
    String groupYearPay          ="";//33������Ӫҵ��
    String unitCustLevel          ="";//34���ſͻ�����2016�꣩
    
    String old_custIdScrenFile = "";
    String old_sel_idType      = "";

%>  
<wtc:service name="s9101Qry" routerKey="region" routerValue="<%=regionCode%>" outnum="39">
       <wtc:param value="0"/>
       <wtc:param value="<%=sCustomerProvinceNumber%>"/>
</wtc:service>
<%       
       if(retCode.equals("000000")){       
%>  
<wtc:array id="rows"  start="2" length="37" scope="end" />
<%
System.out.println("====wanghfa==== rows.length = " + rows.length);
		     if(rows.length==1){
		         ParentCustomerNumber  =rows[0][0] ;//�ϼ����ſͻ�����     
		         CompanyID             =rows[0][1] ;//���ſͻ�����ʡ���� 
		         System.out.println("r_CustomerProvinceNumber:"+rows[0][2]);  
		         CustomerProvinceNumber=rows[0][2] ;//���ſͻ�����ʡ����   
		         CustomerNumber        =rows[0][3] ;//EC���ſͻ�����       
		         CustomerName          =rows[0][4] ;//���ſͻ�����         
		         CustomerClassID       =rows[0][5] ;//�ͻ������ʶ         
		         CreditLevelID         =rows[0][6] ;//���õȼ����         
		         CustomerRankID        =rows[0][7] ;//�ͻ���Ҫ����         
		         LoyaltyLevelID        =rows[0][8] ;//�ͻ��ҳ϶�           
		         NationID              =rows[0][9] ;//����ID���绰���ţ�   
		         TaxNum                =rows[0][10];//˰��/Ӫҵִ�պ���    
		         Corporation           =rows[0][11];//���˴���             
		         LoginFinancing        =rows[0][12];//ע���ʽ�             
		         IndustryID            =rows[0][13];//��ҵ���
		         OrganizationTypeID    =rows[0][14];//��ҵ����/��˾����   
		         EmployeeAmountId      =rows[0][15];//��ҵ��ģ            
		         MemberCount           =rows[0][16];//��ҵԱ����          
		         Location              =rows[0][17];//����ʡ/����         
		         PostCode              =rows[0][18];//�ʱ�                
		         AddressFullName       =rows[0][19];//��ַ                
		         Homepage              =rows[0][20];//��˾��ҳ            
		         Background            =rows[0][21];//ҵ��ʹ�����/��˾����
		         OrgCustID             =rows[0][22];//ʡBOSS�ڼ��ſͻ�����
		         Description           =rows[0][23];//��ע��Ϣ            
		         StaffNumber           =rows[0][24];//�ͻ�������        
		         StaffName             =rows[0][25];//����                
		         ContactPhone          =rows[0][26];//��ϵ�绰            
		         MobilePhone           =rows[0][27];//�ֻ�                
		         ContactFax            =rows[0][28];//����                
		         E_mail                =rows[0][29];//�����ʼ�            
		         LeaderName            =rows[0][30];//�ͻ������ϼ��쵼����
		         LeaderTel             =rows[0][31];//�ͻ������ϼ��쵼�绰
		         CustomerServLevel     =rows[0][32];//�ͻ������ϼ��쵼�绰
		         
		         groupYearPay     =rows[0][33];//33������Ӫҵ��
		         unitCustLevel     =rows[0][34];//34���ſͻ�����2016�꣩
		         
		         old_custIdScrenFile = rows[0][35];
		         old_sel_idType      = rows[0][36];
		         
		         System.out.println("-------hejwa----------------old_custIdScrenFile--------->"+old_custIdScrenFile);
		         System.out.println("-------hejwa----------------old_sel_idType-------------->"+old_sel_idType);
		         
		     }else if(rows.length==0){                                                
		     	 System.out.println("rows.length1:"+rows.length);           
         	 retFlag = "1";	 
         }else{
         	 System.out.println("rows.length2:"+rows.length);
		   		 retFlag = "2";
		     }        
       }
   
    //System.out.println("end..........................");
%>
var response = new AJAXPacket();
response.data.add("retFlag",                 "<%=retFlag.trim()%>");  
response.data.add("r_ParentCustomerNumber",  "<%=ParentCustomerNumber.trim()%>");
response.data.add("r_CompanyID",             "<%=CompanyID.trim()%>");
response.data.add("r_CustomerProvinceNumber","<%=CustomerProvinceNumber.trim()%>");
response.data.add("r_CustomerNumber",        "<%=CustomerNumber.trim()%>");
response.data.add("r_CustomerName",          "<%=CustomerName.trim()%>");
response.data.add("r_CustomerClassID",       "<%=CustomerClassID.trim()%>");
response.data.add("r_CreditLevelID",         "<%=CreditLevelID.trim()%>");
response.data.add("r_CustomerRankID",        "<%=CustomerRankID.trim()%>");
response.data.add("r_LoyaltyLevelID",        "<%=LoyaltyLevelID.trim()%>");
response.data.add("r_NationID",              "<%=NationID.trim()%>");
response.data.add("r_TaxNum",                "<%=TaxNum.trim()%>");
response.data.add("r_Corporation",           "<%=Corporation.trim()%>");
response.data.add("r_LoginFinancing",        "<%=LoginFinancing.trim()%>");
response.data.add("r_IndustryID",            "<%=IndustryID.trim()%>");
response.data.add("r_OrganizationTypeID",    "<%=OrganizationTypeID.trim()%>");
response.data.add("r_EmployeeAmountId",      "<%=EmployeeAmountId.trim()%>");
response.data.add("r_MemberCount",           "<%=MemberCount.trim()%>");
response.data.add("r_Location",              "<%=Location.trim()%>");
response.data.add("r_PostCode",              "<%=PostCode.trim()%>");
response.data.add("r_AddressFullName",       "<%=AddressFullName.trim()%>");
response.data.add("r_Homepage",              "<%=Homepage.trim()%>");
response.data.add("r_Background",            "<%=Background.trim()%>");
response.data.add("r_OrgCustID",             "<%=OrgCustID.trim()%>");
response.data.add("r_Description",           "<%=Description.trim()%>");
response.data.add("r_StaffNumber",           "<%=StaffNumber.trim()%>");
response.data.add("r_StaffName",             "<%=StaffName.trim()%>");
response.data.add("r_ContactPhone",          "<%=ContactPhone.trim()%>");
response.data.add("r_MobilePhone",           "<%=MobilePhone.trim()%>");
response.data.add("r_ContactFax",            "<%=ContactFax.trim()%>");
response.data.add("r_E_mail",                "<%=E_mail.trim()%>");
response.data.add("r_LeaderName",            "<%=LeaderName.trim()%>");
response.data.add("r_LeaderTel",             "<%=LeaderTel.trim()%>");
response.data.add("r_CustomerServLevel",     "<%=CustomerServLevel.trim()%>");

response.data.add("r_groupYearPay",     "<%=groupYearPay.trim()%>");
response.data.add("r_unitCustLevel",     "<%=unitCustLevel.trim()%>");

response.data.add("old_custIdScrenFile",     "<%=old_custIdScrenFile.trim()%>");
response.data.add("old_sel_idType",     "<%=old_sel_idType.trim()%>");

core.ajax.receivePacket(response);





