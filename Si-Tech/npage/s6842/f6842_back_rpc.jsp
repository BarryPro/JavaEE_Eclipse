<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);

    String opName = "促销品统一付奖冲正";
    String opCode = "7514";
    String errorMsg = "";
    String errorflag="true";
    String strPhoneNo = request.getParameter("activePhone");

    String[] paraAray = new String[3];
    paraAray[0] = (String)session.getAttribute("workNo"); 	/* 操作工号 */
    paraAray[1] = (String)session.getAttribute("password"); /* 工号密码 */
    paraAray[2] = strPhoneNo;		                            /* 手机号码 */
    String[] paraAray_3 = request.getParameter("accept") ==null ? null : request.getParameter("accept").split("#");/* 领奖流水 */
    for (int i=0;i<paraAray.length;i++)
		{
			System.out.println("paraAray["+i+"]="+paraAray[i]);
		}
		for (int i=0;i<paraAray_3.length;i++)
		{
			System.out.println("paraAray_3["+i+"]="+paraAray_3[i]);
		}
%>
 	<wtc:service name="s6842SelBack" routerKey="phone" routerValue="<%=strPhoneNo%>" outnum="13" >
    	<wtc:param  value="<%=paraAray[0]%>"/>
    	<wtc:param  value="<%=paraAray[1]%>"/>
    	<wtc:param  value="<%=paraAray[2]%>"/>
    	<wtc:params value="<%=paraAray_3%>"/>
	</wtc:service>
	<wtc:array id="s7514InitArr" scope="end"/>

    var returnArr = new Array(<%=s7514InitArr.length%>);
    for(var i=0;i<<%=s7514InitArr.length%>;i++)
    {
        returnArr[i] = new Array(8);
    }
<%
if(s7514InitArr != null && s7514InitArr.length != 0)
{
    for(int j=0;j<s7514InitArr.length;j++)
    {
%>
        returnArr[<%=j%>][0]='<%=s7514InitArr[j][0]%>';
        returnArr[<%=j%>][1]='<%=s7514InitArr[j][1]%>';
        returnArr[<%=j%>][2]='<%=s7514InitArr[j][2]%>';
        returnArr[<%=j%>][3]='<%=s7514InitArr[j][3]%>';
        returnArr[<%=j%>][4]='<%=s7514InitArr[j][4]%>';
        returnArr[<%=j%>][5]='<%=s7514InitArr[j][5]%>';
        returnArr[<%=j%>][6]='<%=s7514InitArr[j][6]%>';
        returnArr[<%=j%>][7]='<%=s7514InitArr[j][7]%>';
<%
    }
}
else
{
    errorflag="false";
    errorMsg="没有获取到相关信息！";
}
%>
var response = new AJAXPacket();
response.data.add("rpc_page","backinfo");
response.data.add("rownum","<%=s7514InitArr.length%>");
response.data.add("value",returnArr);
response.data.add("errorMsg","<%=errorMsg%>");
response.data.add("errorflag","<%=errorflag%>");

core.ajax.receivePacket(response);