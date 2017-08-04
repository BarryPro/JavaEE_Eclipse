<%
/********************
 *version v2.0
 *开发商: si-tech
 *update by qidp @ 2008-12-29
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.boss.pub.util.*" %>

<% request.setCharacterEncoding("GBK"); %>
<%
    String phoneNo=request.getParameter("phoneNo");
    String	errCode = "";
    String  errMsg = "";
        //SPubCallSvrImpl callWrapper = new SPubCallSvrImpl();
        //ArrayList  inputParam = new ArrayList();
        //String     outList[][] = new String [][]{{"0","1"}};
        //ArrayList retArray = new ArrayList();
    String[][] backInfo = new String[][]{{"0","0"}};
    String loginAccept      	 = request.getParameter("loginAccept");
    String opCode  				= request.getParameter("opCode");
    String workNo 				 = request.getParameter("workNo");
    String noPass  				= (String)session.getAttribute("password");
    String orgCode  			= request.getParameter("orgCode");
    String idNo 			 	= request.getParameter("idNo");
    String handFee  			= request.getParameter("handFee");
    String systemNote  			= request.getParameter("systemNote");
    String opNote						 = request.getParameter("opNote");
    String ipAddr 				 = request.getParameter("ipAddr");
    String payBroken 				 = request.getParameter("payBroken");
    String phoneFee 				 = request.getParameter("phoneFee");
    String rentFee 				 = request.getParameter("rentFee");
    String rent_indemnity = request.getParameter("rent_indemnity");
	System.out.println("===loginAccept " + loginAccept);
	System.out.println("===rentFee " + rentFee);
        //inputParam.add(loginAccept);
        //inputParam.add(opCode);
        //inputParam.add(workNo);
        //inputParam.add(noPass);
        //inputParam.add(orgCode);
        //inputParam.add(idNo);
        //inputParam.add(rentFee);
        //inputParam.add(phoneFee);
        //inputParam.add(handFee);
        //inputParam.add(payBroken);
        //inputParam.add(systemNote);
        //inputParam.add(opNote);
        //inputParam.add(ipAddr);
        //inputParam.add(rent_indemnity);

try
{
	//retArray = callWrapper.callFXService("s1225Cfm",inputParam,"14",outList);
%>
    <wtc:service name="s1225Cfm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="s1225CfmCode" retmsg="s1225CfmMsg" outnum="1" >
        <wtc:param value="<%=loginAccept%>"/>
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=workNo%>"/>
        <wtc:param value="<%=noPass%>"/>
        <wtc:param value="<%=orgCode%>"/>
        
        <wtc:param value="<%=idNo%>"/>
        <wtc:param value="<%=rentFee%>"/>
        <wtc:param value="<%=phoneFee%>"/>
        <wtc:param value="<%=handFee%>"/>
        <wtc:param value="<%=payBroken%>"/>
        
        <wtc:param value="<%=systemNote%>"/>
        <wtc:param value="<%=opNote%>"/>
        <wtc:param value="<%=ipAddr%>"/>
        <wtc:param value="<%=rent_indemnity%>"/>
    </wtc:service>
    <wtc:array id="s1225CfmArr" scope="end" />
    
<%

    System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");
    String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+s1225CfmCode+"&opName="+"异制租机退租"+"&workNo="+workNo+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+s1225CfmMsg+"&opBeginTime="+opBeginTime;
    System.out.println("url================="+url);
%>
    <jsp:include page="<%=url%>" flush="true" />
<%

    System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");	
if(s1225CfmCode.equals("000000"))
    {
     	backInfo = s1225CfmArr;
    }
	//errCode = String.valueOf(callWrapper.getErrCode());
	//errMsg = callWrapper.getErrMsg();
	errCode = s1225CfmCode;
	errMsg = s1225CfmMsg;
	System.out.println("retCode = " + errCode);
	System.out.println("retMessage = " + errMsg);
}catch(Exception e){
    System.out.println("1225 Call s1225Cfm  is Failed!");
}


	 

String strArray = CreatePlanerArray.createArray("backInfo",backInfo.length);

%>
<%=strArray%>
<%

for(int i = 0 ; i < backInfo.length ; i ++){
      for(int j = 0 ; j < backInfo[i].length ; j ++){
	System.out.println("backInfo["+i+"]["+j+"]="+backInfo[i][j]);

%>

backInfo[<%=i%>][<%=j%>] = "<%=backInfo[i][j].trim()%>";
<%
}
}
%>
var response = new AJAXPacket();

response.guid = '<%= request.getParameter("guid") %>';

response.data.add("backString",backInfo);
response.data.add("flag","1");
response.data.add("errCode","<%=errCode%>");
response.data.add("errMsg","<%=errMsg%>");

core.ajax.receivePacket(response);
