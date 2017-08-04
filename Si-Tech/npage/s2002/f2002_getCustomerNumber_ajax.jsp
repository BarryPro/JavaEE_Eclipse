<%@ page contentType= "text/html;charset=GBK" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
    String workName = (String)session.getAttribute("workName");
    String ipAddr = (String)session.getAttribute("ipAddr");
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
    String sCustomerProvinceNumber = request.getParameter("sCustomerProvinceNumber");
    String retFlag = "0";
    String ParentCustomerNumber  ="";//0上级集团客户编码    
    String CompanyID             ="";//1集团客户归属省代码   
    String CustomerProvinceNumber="";//2集团客户归属省编码   
    String CustomerNumber        ="";//3EC集团客户编码       
    String CustomerName          ="";//4集团客户名称         
    String CustomerClassID       ="";//5客户分类标识         
    String CreditLevelID         ="";//6信用等级编号         
    String CustomerRankID        ="";//7客户重要级别         
    String LoyaltyLevelID        ="";//8客户忠诚度                                
    String NationID              ="";//9国家ID（电话区号）       
    String TaxNum                ="";//10税号/营业执照号码       
    String Corporation           ="";//11法人代表                 
    String LoginFinancing        ="";//12注册资金                                                           
    String IndustryID            ="";//13行业类别                                               
    String OrganizationTypeID    ="";//14企业类型/公司性质                                                  
    String EmployeeAmountId      ="";//15企业规模                                                           
    String MemberCount           ="";//16企业员工数                                                         
    String Location              ="";//17所在省/地市                                                        
    String PostCode              ="";//18邮编                     
    String AddressFullName       ="";//19地址                     
    String Homepage              ="";//20公司主页                 
    String Background            ="";//21业务使用情况/公司背景    
    String OrgCustID             ="";//22省BOSS内集团客户编码     
    String Description           ="";//23备注信息              
    String StaffNumber           ="";//24客户经理工号         
    String StaffName             ="";//25姓名                 
    String ContactPhone          ="";//26联系电话             
    String MobilePhone           ="";//27手机                 
    String ContactFax            ="";//28传真                 
    String E_mail                ="";//29电子邮件             
    String LeaderName            ="";//30客户经理上级领导姓名 
    String LeaderTel             ="";//31客户经理上级领导电话 
    String CustomerServLevel     ="";//32客户服务等级
    
    String groupYearPay          ="";//33集团年营业额
    String unitCustLevel          ="";//34集团客户级别（2016年）
    
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
		         ParentCustomerNumber  =rows[0][0] ;//上级集团客户编码     
		         CompanyID             =rows[0][1] ;//集团客户归属省代码 
		         System.out.println("r_CustomerProvinceNumber:"+rows[0][2]);  
		         CustomerProvinceNumber=rows[0][2] ;//集团客户归属省编码   
		         CustomerNumber        =rows[0][3] ;//EC集团客户编码       
		         CustomerName          =rows[0][4] ;//集团客户名称         
		         CustomerClassID       =rows[0][5] ;//客户分类标识         
		         CreditLevelID         =rows[0][6] ;//信用等级编号         
		         CustomerRankID        =rows[0][7] ;//客户重要级别         
		         LoyaltyLevelID        =rows[0][8] ;//客户忠诚度           
		         NationID              =rows[0][9] ;//国家ID（电话区号）   
		         TaxNum                =rows[0][10];//税号/营业执照号码    
		         Corporation           =rows[0][11];//法人代表             
		         LoginFinancing        =rows[0][12];//注册资金             
		         IndustryID            =rows[0][13];//行业类别
		         OrganizationTypeID    =rows[0][14];//企业类型/公司性质   
		         EmployeeAmountId      =rows[0][15];//企业规模            
		         MemberCount           =rows[0][16];//企业员工数          
		         Location              =rows[0][17];//所在省/地市         
		         PostCode              =rows[0][18];//邮编                
		         AddressFullName       =rows[0][19];//地址                
		         Homepage              =rows[0][20];//公司主页            
		         Background            =rows[0][21];//业务使用情况/公司背景
		         OrgCustID             =rows[0][22];//省BOSS内集团客户编码
		         Description           =rows[0][23];//备注信息            
		         StaffNumber           =rows[0][24];//客户经理工号        
		         StaffName             =rows[0][25];//姓名                
		         ContactPhone          =rows[0][26];//联系电话            
		         MobilePhone           =rows[0][27];//手机                
		         ContactFax            =rows[0][28];//传真                
		         E_mail                =rows[0][29];//电子邮件            
		         LeaderName            =rows[0][30];//客户经理上级领导姓名
		         LeaderTel             =rows[0][31];//客户经理上级领导电话
		         CustomerServLevel     =rows[0][32];//客户经理上级领导电话
		         
		         groupYearPay     =rows[0][33];//33集团年营业额
		         unitCustLevel     =rows[0][34];//34集团客户级别（2016年）
		         
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





