<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>

<%
String loginAccept = request.getParameter("loginAccept");
String opCode= request.getParameter("opCode");
String workNo= request.getParameter("workNo");
String noPass = (String)session.getAttribute("password");
String orgCode=WtcUtil.repNull(request.getParameter("orgCode"));

String opType = request.getParameter("opType");
String blackType = request.getParameter("blackType");
String blackNo = request.getParameter("blackNo");
String handFee= request.getParameter("handFee");
String factPay= request.getParameter("factPay");
String sysRemark= request.getParameter("sysRemark");
String remark= request.getParameter("remark");
String ipAdd= request.getParameter("ipAdd");

String phoneno="";
sysRemark=sysRemark+":"+blackNo;

System.out.println("loginAccept zhouby *****************************");
System.out.println("loginAccept zhouby is :"+loginAccept);
System.out.println("opCode zhouby is :"+opCode);
System.out.println("workNo zhouby is :"+workNo);
System.out.println("noPass zhouby is :"+noPass);
System.out.println("orgCode zhouby is :"+orgCode);
System.out.println("blackType zhouby is :"+blackType);
System.out.println("blackNo zhouby is :"+blackNo);
System.out.println("handFee zhouby is :"+handFee);
System.out.println("factPay zhouby is :"+factPay);
System.out.println("sysRemark zhouby is :"+sysRemark);
System.out.println("remark zhouby is :"+remark);
System.out.println("ipAdd zhouby is :"+ipAdd);
System.out.println("opType zhouby is :"+opType);
System.out.println("loginAccept zhouby *****************************");
%>

<wtc:service name="s2301Cfm" routerKey="region" routerValue="<%=orgCode%>" retcode="retCode" retmsg="retMsg" outnum="1" >
    <wtc:param value="<%=loginAccept%>"/>	
    <wtc:param value="<%=opCode%>"/>
    <wtc:param value="<%=workNo%>"/>
    <wtc:param value="<%=noPass%>"/>
    <wtc:param value="<%=orgCode%>"/>
    <wtc:param value="<%=opType%>"/>
    <wtc:param value="<%=blackType%>"/>
    <wtc:param value="<%=blackNo%>"/>
    <wtc:param value="<%=handFee%>"/>
    <wtc:param value="<%=factPay%>"/>
    <wtc:param value="<%=sysRemark%>"/>
    <wtc:param value="<%=remark%>"/>
    <wtc:param value="<%=ipAdd%>"/>
</wtc:service>

<wtc:array id="result" scope="end"/>

<%
String strArray = CreatePlanerArray.createArray("backInfo", result.length);

System.out.println("zhouby s2301cfm:  " + result.length);

%>
<%=strArray%>
<%
if(result.length > 0){
    for(int i = 0 ; i < result.length ; i ++){
        for(int j = 0 ; j < result[i].length ; j ++){
    %>
            backInfo[<%=i%>][<%=j%>] = "<%=result[i][j].trim()%>";
    <%
        }
    }
}
%>
var response = new AJAXPacket();

response.guid = '<%=request.getParameter("guid")%>';

response.data.add("backString",backInfo);
response.data.add("flag","1");
response.data.add("errCode","<%=retCode%>");
response.data.add("errMsg","<%=retMsg%>");

core.ajax.receivePacket(response);