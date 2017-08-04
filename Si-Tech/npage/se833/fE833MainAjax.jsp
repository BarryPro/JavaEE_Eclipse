<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
/*主页面传递的参数*/
String regCode	=(String)session.getAttribute("regCode");
String workNo	=(String)session.getAttribute("workNo");
String loginAccept=request.getParameter("loginAccept");
String iChnSource=request.getParameter("iChnSource");
String opCode=request.getParameter("opCode");
String opName=request.getParameter("opName");
String iLoginPwd=request.getParameter("iLoginPwd");
String iPhoneNo=request.getParameter("iPhoneNo");
String iUserPwd=request.getParameter("iUserPwd");
String iOpNote=request.getParameter("iOpNote");
String saleCode=request.getParameter("saleCode");

System.out.println("@zhangyan~~~~loginAccept="+loginAccept);
System.out.println("@zhangyan~~~~iChnSource="+iChnSource);
System.out.println("@zhangyan~~~~opCode="+opCode);
System.out.println("@zhangyan~~~~workNo="+workNo);
System.out.println("@zhangyan~~~~iLoginPwd="+iLoginPwd);
System.out.println("@zhangyan~~~~iPhoneNo="+iPhoneNo);
System.out.println("@zhangyan~~~~iUserPwd="+iUserPwd);
System.out.println("@zhangyan~~~~saleCode="+saleCode);
%>

<wtc:service name="sE833Qry" outnum="500" 
	retcode="errCode" retmsg="errMsg" 
	routerKey="region" routerValue="<%=regCode%>">
  	<wtc:param value="<%=loginAccept%>"/>
  	<wtc:param value="<%=iChnSource%>"/>
  	<wtc:param value="<%=opCode%>"/>
  	<wtc:param value="<%=workNo%>"/>
  	<wtc:param value="<%=iLoginPwd%>"/>
  	<wtc:param value="<%=iPhoneNo%>"/>
  	<wtc:param value="<%=iUserPwd%>"/>
  	<wtc:param value="<%=iOpNote%>"/>
  	<wtc:param value="<%=saleCode%>"/>
</wtc:service>
<wtc:array id="rstE833" scope="end"/> 	

/*定义用于传到主界面的数组*/
var arrE833 = new Array;

/*按行遍历服务结果数组*/
<%
for ( int i=0;i<rstE833.length;i++ )
{
	System.out.println("@zhangyan~~~~rstE833="+rstE833[i][0]);
%>
	arrE833[<%=i%>]="<%=rstE833[i][0]%>";
<%
}
%>

var response = new AJAXPacket();
response.data.add("arrScList",arrE833);

core.ajax.receivePacket(response);