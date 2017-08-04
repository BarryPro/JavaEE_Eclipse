<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-18
********************/
%>
 
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	
<%@ page contentType= "text/html;charset=gb2312" %>

var response = new AJAXPacket();

<%

	//公用sql类
	String result[][] = new String[][]{};
	int recordNum = 0;
	int countNum = 0;
	String sqlStr = "";
	
	String	retCode="0";
	String 	retMsg="";
	String  op_code = "4400";
	
	//定义返回参数
	String cust_name        = "";	//客户名称
	String cust_passwd      = "";	//用户密码
	String run_code         = "";	//用户ID
	String run_name         = "";	//大客户标志
	String id_no            = "";	
	String sm_code          ="";
	String sm_name          ="";
 
	int usedFreeTimes=0;
  String	SqlMarkScore="";
	String  SqlFreeTimes="";
	String  SqlUsedTimes="";
	String	errCode = "";
  String  errMsg = "";

	

	//获取参数
	//String work_no = request.getParameter("loginNo");
	
	String orgCode  =request.getParameter("orgCode");	

	String srv_no = request.getParameter("phoneNo");
	System.out.println("srv_no:"+srv_no);
		
	String verifyType = request.getParameter("verifyType");
//	String curflowCou = request.getParameter("attendant");
	String cardID= request.getParameter("cardID");
    String SrvLevel = request.getParameter("servLevel");
	String user_passwd = request.getParameter("custPWD")==null?"":request.getParameter("custPWD");
	System.out.println("srv_no:"+srv_no);

String     outList[][] = new String [][]{{"0","10"}};
ArrayList retList = new ArrayList();
ArrayList ret = new ArrayList();
 String       sV_Cust_a="";
  String      sV_Run_b="";
    String       sV_Sm_c="";
    String Current_d="";
           String       remainTimes="";  
  
 String regionCode = (String)session.getAttribute("regCode");

String  inputParam[] = new String[5];
inputParam[0]=srv_no;
inputParam[1]=user_passwd;
inputParam[2]=orgCode;
inputParam[3]="1";
inputParam[4]="4400";

try{
//retList = impl.callFXService("s4400Check", inputParam, "5", outList);
%>

    <wtc:service name="s4400Check" outnum="10" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=inputParam[0]%>" />
			<wtc:param value="<%=inputParam[1]%>" />
			<wtc:param value="<%=inputParam[2]%>" />
			<wtc:param value="<%=inputParam[3]%>" />
			<wtc:param value="<%=inputParam[4]%>" />				
		</wtc:service>
		<wtc:array id="result_t2" scope="end"  />

<%
result = result_t2;
	errCode = code;
	errMsg = msg;
 

}catch(Exception e){
System.out.println("4400 Call s4400Check  is Failed!");
}
if(errCode.equals("000000"))
{
  String[][] retListString1 = result;
        System.out.println("retListString1.length;"+retListString1.length);
        if(retListString1.length!=0){
       sV_Cust_a=retListString1[0][2];
       
         System.out.println("sV_Cust_a"+sV_Cust_a);
        sV_Run_b=retListString1[0][3];
             System.out.println("sV_Cust_a"+sV_Run_b);
     sV_Sm_c=retListString1[0][4];
        Current_d=retListString1[0][5];
     remainTimes=retListString1[0][6];
        }
 
%>
	var cust_name = '<%=sV_Cust_a%>';
		var sV_Run_b = '<%=sV_Run_b%>';
			var sV_Sm_c = '<%=sV_Sm_c%>';
				var Current_d = '<%=Current_d%>';
					var remainTimes = '<%=remainTimes%>';
	
	var verifyType = '<%=verifyType%>';
	
	response.data.add("cust_name",cust_name);
		response.data.add("sV_Run_b",sV_Run_b);
			response.data.add("sV_Sm_c",sV_Sm_c);
				response.data.add("Current_d",Current_d);
					response.data.add("remainTimes",remainTimes);
				
	
	
	response.data.add("verifyType",verifyType);
         
	<%
	}
	System.out.println("ddddddddddddddddddd");
	%>
	
	var retCode = '<%=errCode%>';
	var retMsg = '<%=errMsg%>';
	response.data.add("retType","select");
	response.data.add("retCode",retCode);
	response.data.add("retMsg",retMsg);
	response.data.add("cust_name",cust_name);
		response.data.add("sV_Run_b",sV_Run_b);
			response.data.add("sV_Sm_c",sV_Sm_c);
				response.data.add("Current_d",Current_d);
					response.data.add("remainTimes",remainTimes);
	
	core.ajax.receivePacket(response);
