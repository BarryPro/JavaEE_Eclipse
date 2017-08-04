    
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-8
********************/
%>

<%@ include file="/npage/include/public_title_ajax.jsp" %> 
<%@ page contentType= "text/html;charset=gbk" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>

<%
	String workNo = request.getParameter("workNo");
	String phoneNo = request.getParameter("phoneNo");
	String opCode = request.getParameter("opCode");
	String orgCode = request.getParameter("orgCode");
	
	String regionCode = (String)session.getAttribute("regCode");
	//ArrayList arr = F2417Wrapper.callF2417Init(workNo,phoneNo,opCode,orgCode);
%>

<wtc:service name="s2417Init" outnum="38" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="<%=phoneNo%>" />
			<wtc:param value="<%=opCode%>" />
			<wtc:param value="<%=orgCode%>" />
		</wtc:service>
<wtc:array id="result_t1" scope="end"   />
<%
	
//	System.out.println("---------------------------------------------------msg1-------------------------------------------------------"+msg1);
//	System.out.println("---------------------------------------------------code1-------------------------------------------------------"+code1);
	
//	for(int i = 0 ; i < result_t1[0].length ; i ++){
//	System.out.println("-----------------------result_t1[0]["+i+"]--------------------------------"+result_t1[0][i]);
//	}
	
	
	String  errInfo = msg1;
	
	
	if(code1.equals("000000"))
	    errInfo = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(result_t1[0][0]));
	else
		//errInfo ="未知错误信息";
		errInfo =msg1;
	 
	
	//System.out.println(userInfo.length);
	//if(result_t1[0].length==0){
	if(!code1.equals("000000")){


%>
var response = new AJAXPacket();
response.data.add("backString","");

response.data.add("flag","9");
response.data.add("errCode","<%=code1%>");
response.data.add("errMsg","<%=errInfo%>");

core.ajax.receivePacket(response);

<%
	
}else{
/*	System.out.println("idNo			用户id               is : "+result_t1[0][0]);
	System.out.println("smCode			业务类型代码         is : "+result_t1[0][1]);
	System.out.println("smName			业务类型名称         is : "+result_t1[0][2]);
	System.out.println("custName		客户名称             is : "+result_t1[0][3]);
	System.out.println("userPassword	用户密码             is : "+result_t1[0][4]);
	System.out.println("runCode			状态代码             is : "+result_t1[0][5]);
	System.out.println("runName			状态名称             is : "+result_t1[0][6]);
	System.out.println("ownerGrade		等级代码             is : "+result_t1[0][7]);
	System.out.println("gradeName		等级名称             is : "+result_t1[0][8]);
	System.out.println("ownerType		用户类型             is : "+result_t1[0][9]);
	System.out.println("ownerTypeName	用户类型名称         is : "+result_t1[0][10]);
	System.out.println("custAddr		客户住址             is : "+result_t1[0][11]);
	System.out.println("idType			证件类型             is : "+result_t1[0][12]);
	System.out.println("idName			证件名称             is : "+result_t1[0][13]);
	System.out.println("idIccid			证件号码             is : "+result_t1[0][14]);
	System.out.println("totalOwe		当前欠费             is : "+result_t1[0][15]);
	System.out.println("totalPrepay		当前预存             is : "+result_t1[0][16]);
	System.out.println("firstOweConNo	第一个欠费帐号       is : "+result_t1[0][17]);
	System.out.println("firstOweFee		第一个欠费帐号金额   is : "+result_t1[0][18]);
	System.out.println("qryFlag		    是否可以查询		 is : "+result_t1[0][19]);
	System.out.println("qryNote		    申请说明		     is : "+result_t1[0][20]);
*/
%>
<%
	String strArray = CreatePlanerArray.createArray("userInfo",result_t1[0].length);

%>
<%=strArray%>
<%

	for(int i = 0 ; i < result_t1[0].length ; i ++){

%>
	userInfo[<%=0%>][<%=i%>] = "<%=result_t1[0][i].trim()%>";
<%
}
%>
var response = new AJAXPacket();
response.data.add("backString",userInfo);
response.data.add("errCode","<%=code1%>");
response.data.add("errMsg","<%=errInfo%>");
response.data.add("flag","0");

core.ajax.receivePacket(response);
<%}%>
