<%
/*
 * 版本: 1.0
 * 作者: zhouby
 * 版权: si-tech
*/
%>
<%@ include file="/npage/include/public_title_name_p.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%

String regCode		=	(String)session.getAttribute("regCode");
String iLoginAccept=request.getParameter("login_accept"); 	/*操作流水*/
String iChnSource="01"; 		/*渠道标示*/
String iOpCode="3691"; 		/*操作代码*/
String iLoginNo=(String)session.getAttribute("workNo"); 		/*操作工号*/
String iLoginPwd=(String)session.getAttribute("password"); 		/*工号密码*/
String iPhoneNo=""; 		/*成员号码*/
String iUserPwd=""; 		/*号码密码*/
String iIdNo=request.getParameter("grpIdNo"); 		/*集团用户ID*/
String iCompactNo=request.getParameter("cptNo"); 		/*协议编号*/
String iContractNo=request.getParameter("cntNo"); 		/*合同编号*/
String iOpenDate=request.getParameter("prodOpenTime"); 		/*产品开户时间*/
String iCnttCode=request.getParameter("oCnttCode"); 		/*合同父编号编号*/
String iCptCode=request.getParameter("oCptCode"); 		/*协议父编号*/
String iUnitId=request.getParameter("oUnitId"); 		/*集团编号*/


String grpCurrentAttr = request.getParameter("grpCurrentAttr");

%>
	<wtc:service name="sDevelopUpdate"  outnum="2"
		routerKey="region" routerValue="<%=regCode%>"  
		retcode="cldRc" retmsg="cldRm"  >
  	<wtc:param value="<%=iLoginAccept%>"/>
  	<wtc:param value="<%=iChnSource%>"/>
  	<wtc:param value="<%=iOpCode%>"/>
  	<wtc:param value="<%=iLoginNo%>"/>
  	<wtc:param value="<%=iLoginPwd%>"/>
  	<wtc:param value="<%=iPhoneNo%>"/>
  	<wtc:param value=""/>
  	<wtc:param value="<%=iIdNo%>"/>
  	<wtc:param value="<%=grpCurrentAttr%>"/>
	</wtc:service>
	<wtc:array id="spRst" scope="end" />
<%
if( "000000".equals(cldRc))
{
%>
	<script>
		rdShowMessageDialog("提交成功!");
		removeCurrentTab();
	</script>
<%
}
else
{%>
	<script>
		rdShowMessageDialog("<%=cldRc%>"+":"+"<%=cldRm%>" , 0);
		removeCurrentTab();
	</script>
<%
}%>