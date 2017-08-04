<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
%>

<%!
Logger logger = Logger.getLogger("f2266_back_rpc.jsp");
%>

<%
    String opName = "促销品统一付奖";
    String loginNo = (String)session.getAttribute("workNo");
    String loginNoPass = (String)session.getAttribute("password");
    String loginName = (String)session.getAttribute("workName");
    String orgCode = (String)session.getAttribute("orgCode");
    String strRegionCode = orgCode.substring(0,2);
    String IccId = "";
    String cust_address = "";
    String acceptNo = request.getParameter("accept");
    String errorMsg = "";
    String errorflag="true";
    String strPhoneNo = request.getParameter("activePhone");

    String[] paraAray1 = new String[9];
    paraAray1[0] = loginNo; 			/* 操作工号   */
    paraAray1[1] = loginNoPass; 	/* 操作工号   */
    paraAray1[2] = strPhoneNo;		/* 手机号码   */
    paraAray1[3] = acceptNo;
    for(int i=0; i<paraAray1.length; i++)
    {
    	if( paraAray1[i] == null )
    	{
      	paraAray1[i] = "";
    	}
    }
%>
 	<wtc:service name="s2266GetBackinf" routerKey="phone" 
 		 routerValue="<%=strPhoneNo%>" outnum="13" retcode="retCode1" retmsg="retMsg1" >
    	<wtc:param value="<%=paraAray1[0]%>"/>
    	<wtc:param value="<%=paraAray1[1]%>"/>
    	<wtc:param value="<%=paraAray1[2]%>"/>
    	<wtc:param value="<%=paraAray1[3]%>"/>
	</wtc:service>
	<wtc:array id="s2266InitArr" scope="end"/>
    var returnArr = new Array(<%=s2266InitArr.length%>);
    for(var i=0;i<<%=s2266InitArr.length%>;i++)
    {
        returnArr[i] = new Array(10);
    }
<%
if(s2266InitArr != null && s2266InitArr.length != 0)
{
    for(int j=0;j<s2266InitArr.length;j++)
    {
    System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
%>
        returnArr[<%=j%>][0]='<%=s2266InitArr[j][0]%>';
        returnArr[<%=j%>][1]='<%=s2266InitArr[j][1]%>';
        returnArr[<%=j%>][2]='<%=s2266InitArr[j][2]%>';
        returnArr[<%=j%>][3]='<%=s2266InitArr[j][3]%>';
        returnArr[<%=j%>][4]='<%=s2266InitArr[j][4]%>';
        returnArr[<%=j%>][5]='<%=s2266InitArr[j][5]%>';
        returnArr[<%=j%>][6]='<%=s2266InitArr[j][6]%>';
        returnArr[<%=j%>][7]='<%=s2266InitArr[j][7]%>';
        returnArr[<%=j%>][8]='<%=s2266InitArr[j][8]%>';
        returnArr[<%=j%>][9]='<%=s2266InitArr[j][9]%>';
        returnArr[<%=j%>][11]='<%=s2266InitArr[j][11]%>';
<%
System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    }
}
else
{
    errorflag="false";
    errorMsg=retMsg1;
}
%>
var response = new AJAXPacket();
response.data.add("rpc_page","backinfo");
response.data.add("rownum","<%=s2266InitArr.length%>");
response.data.add("value",returnArr);
response.data.add("errorMsg","<%=errorMsg%>");
response.data.add("errorflag","<%=errorflag%>");

core.ajax.receivePacket(response);


