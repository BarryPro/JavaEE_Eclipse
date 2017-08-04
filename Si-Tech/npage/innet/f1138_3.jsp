<%
/********************
 version v2.0
开发商: si-tech
********************/
%>

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>



<%
/*
输入参数：
	开户流水
	工号归属
 输出参数： 
	错误代码                          
	错误信息                          
	操作时间                          
	操作名称                          
	业务类型名称                      
	客户名称                          
	客户住址                          
	证件类型                          
	证件号码                          
	手机号码                          
	手续费                            
	选号费                            
	SIM卡费                           
	机器费                            
	入网费                            
	预存款                            
	现金交款                          
	支票交款                          
	付款方式 1-现金 2-支票 3-现金+支票
	操作备注                           
*/

        //得到输入参数 
       // Logger logger = Logger.getLogger("f1138_3.jsp");
        String sIn_Login_no = (String)session.getAttribute("workNo");
        String sIn_Org_code = (String)session.getAttribute("orgCode");
        String regionCode= (String)session.getAttribute("regCode");

	    String retType = request.getParameter("retType");
	    String opAccept = request.getParameter("opAccept");
		String opCode = "1138";
	    
         String err_code  = "";
         String err_message  = "";
 		 String Op_time = "";       
         String Function_name = "";
		 String Sm_Name = "";  
		 String Cust_name = "";     
		 String Cust_address = ""; 
 		 String Id_name = "";       
		 String Id_iccid = ""; 
 		 String Phone_no = "";      
		 String Hand_Fee = "";
 		 String Choice_Fee = "";    
		 String Sim_Fee = "";  
 		 String Machine_Fee = "";
 		 String Innet_Fee = "";     
		 String PrePay_Fee = "";    
		 String Cash_pay = "";      
		 String Check_pay = "";     
		 String payMode="";
		 String Op_note = "";
		 String vLogin_no = "";

		 String paraAray[] = new String[4];
		 paraAray[0] = opAccept;
		 paraAray[1] = sIn_Org_code;
		 paraAray[2] = sIn_Login_no;
		 paraAray[3] = opCode;

        try
        {
%>
     <wtc:service name="s1138Init" routerKey="region" routerValue="<%=regionCode%>" retcode="s1223CfmCode" retmsg="s1223CfmMsg" outnum="21" >               
        <wtc:param value="<%=paraAray[0]%>"/>
        <wtc:param value="<%=paraAray[1]%>"/>
        <wtc:param value="<%=paraAray[2]%>"/>
        <wtc:param value="<%=paraAray[3]%>"/>
    </wtc:service>

    <wtc:array id="result" scope="end" />
<%			
			 err_code  = result[0][0];
             err_message  = result[0][1];
            
		 	 Op_time = result[0][2];
		 	 Function_name = result[0][3];       
		 	 Sm_Name = result[0][4];       
		 	 Cust_name = result[0][5];   
		 	 Cust_address = result[0][6];      
		 	 Id_name = result[0][7];       
		 	 Id_iccid = result[0][8];      
		 	 Phone_no = result[0][9];       
		 	 Hand_Fee = result[0][10];      
		 	 Choice_Fee = result[0][11];     
		 	 Sim_Fee = result[0][12];  
		 	 Machine_Fee = result[0][13];      
		 	 Innet_Fee = result[0][14];     
		 	 PrePay_Fee = result[0][15];       
		 	 Cash_pay = result[0][16];   
		 	 Check_pay = result[0][17];     
		 	 payMode = result[0][18];    
		 	 Op_note = result[0][19]; 
			 vLogin_no = result[0][20];
         }catch(Exception e){
           // logger.error("Call sunView(s1138Init) is Failed!");
        }
		
%>


var retType = "";
var retCode = "";
var retMessage = "";
var Op_time = "";
var Function_name = "";       
var Sm_Name = "";       
var Cust_name = "";   
var Cust_address = "";      
var Id_name = "";       
var Id_iccid = "";      
var Phone_no = "";       
var Hand_Fee = "";      
var Choice_Fee = "";     
var Sim_Fee = "";  
var Machine_Fee = "";      
var Innet_Fee = "";     
var PrePay_Fee = "";       
var Cash_pay = "";   
var Check_pay = "";     
var payMode = ""; 
var Op_note = "";
var vLogin_no = "";
 
retType = "<%=retType%>";
retCode = "<%=err_code%>";
retMessage = "<%=err_message%>";
Op_time = "<%=Op_time%>";
Function_name = "<%=Function_name%>";
Sm_Name = "<%=Sm_Name%>";
Cust_name = "<%=Cust_name%>";
Cust_address = "<%=Cust_address%>";
Id_name = "<%=Id_name%>";
Id_iccid = "<%=Id_iccid%>";
Phone_no = "<%=Phone_no%>";
Hand_Fee = "<%=Hand_Fee%>";
Choice_Fee = "<%=Choice_Fee%>";
Sim_Fee = "<%=Sim_Fee%>";
Machine_Fee = "<%=Machine_Fee%>";
Innet_Fee = "<%=Innet_Fee%>";
PrePay_Fee = "<%=PrePay_Fee%>";
Cash_pay = "<%=Cash_pay%>";
Check_pay = "<%=Check_pay%>";
payMode = "<%=payMode%>";
Op_note = "<%=Op_note%>";
vLogin_no = "<%=vLogin_no%>";

var response = new AJAXPacket();
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("Op_time",Op_time);
response.data.add("Function_name",Function_name);
response.data.add("Sm_Name",Sm_Name);
response.data.add("Cust_name",Cust_name);
response.data.add("Cust_address",Cust_address);
response.data.add("Id_name",Id_name);
response.data.add("Id_iccid",Id_iccid);
response.data.add("Phone_no",Phone_no);
response.data.add("Hand_Fee",Hand_Fee);
response.data.add("Choice_Fee",Choice_Fee);
response.data.add("Sim_Fee",Sim_Fee);
response.data.add("Machine_Fee",Machine_Fee);
response.data.add("Innet_Fee",Innet_Fee);
response.data.add("PrePay_Fee",PrePay_Fee);
response.data.add("Cash_pay",Cash_pay);
response.data.add("Check_pay",Check_pay);
response.data.add("payMode",payMode);
response.data.add("Op_note",Op_note);
response.data.add("vLogin_no",vLogin_no);

core.ajax.receivePacket(response);