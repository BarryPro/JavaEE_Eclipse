<%
/********************
 version v2.0
开发商: si-tech
update:anln@2009-02-16 页面改造,修改样式
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	int  inputNumber = 5;
	String outputNumber = "4";
	String [] inputParam = new String[inputNumber];
	inputParam[0] = request.getParameter("phoneNo");
	inputParam[1] = request.getParameter("simOldNo");
	inputParam[2] = request.getParameter("simNewNo");
	inputParam[3] = request.getParameter("orgCode");
	inputParam[4] = "1242";
	//SPubCallSvrImpl s1210 = new SPubCallSvrImpl();
	//String[] retStr = s1210.callService("s1220SimVer",inputParam,outputNumber,"phone",inputParam[0]);
	%>
	<wtc:service name="s1220SimVer" routerKey="phone" routerValue="<%=inputParam[0]%>"  retcode="errCode1" retmsg="errMsg1"  outnum="5" >
			<wtc:param value="<%=inputParam[0]%>"/>
			<wtc:param value="<%=inputParam[1]%>"/>
			<wtc:param value="<%=inputParam[2]%>"/>
			<wtc:param value="<%=inputParam[3]%>"/>
	</wtc:service>
	<wtc:array id="retStr" scope="end" />
	<%
	System.out.println("======================+"+errCode1);
	System.out.println("======================+"+errMsg1);
	String errCode= errCode1;
	String errMsg= errMsg1;
	String simFee="";
	String simType="";
	String simStatus="";
	String simName = "";

        if(errCode1.equals("000000")){
		if(retStr!=null&&retStr.length>0)
		{
		  simFee=retStr[0][0]; 
		  simType=retStr[0][4];
		  simStatus=retStr[0][1];
		  simName=retStr[0][3];
		}
	}
	System.out.println("simType=============================" + simType);
	System.out.println("simName=============================" + simName);
%>

var response = new AJAXPacket();
var errCode = "<%=errCode%>";
var errMsg = "<%=errMsg%>";
var simFee = "<%=simFee%>";
var simType = "<%=simType%>";
var simStatus="<%=simStatus%>";
var simName="<%=simName%>";
response.data.add("errCode",errCode);
response.data.add("errMsg",errMsg);
response.data.add("simFee",simFee);
response.data.add("simStatus",simStatus);
response.data.add("simName",simName);
response.data.add("simType",simType);
core.ajax.receivePacket(response);
