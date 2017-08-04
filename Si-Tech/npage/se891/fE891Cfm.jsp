<%
/*
 * 功能: 儿童套餐
 * 版本: 1.0
 * 日期: 2012-07-12 14:20:33
 * 作者: zhangyan
 * 版权: si-tech
 * update:
*/

%>
<%@ include file="/npage/include/public_title_name_p.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
String opName=request.getParameter("opName");
String regCode		=	(String)session.getAttribute("regCode");
String iLoginAccept=request.getParameter("loginAccept"); 	/*操作流水*/
String iChnSource="01"; 		/*渠道标示*/
String iOpCode=request.getParameter("opCode"); 		/*操作代码*/
String iLoginNo=(String)session.getAttribute("workNo"); 		/*操作工号*/
String iLoginPwd=(String)session.getAttribute("password"); 		/*工号密码*/
String iPhoneNo=request.getParameter("cldPhone"); 		/*成员号码*/
String iUserPwd=""; 		/*号码密码*/
String iNextMode=request.getParameter("offerId"); 		/*儿童资费代码*/
String iParentNo=request.getParameter("pPhoneNo");		/*家长号码*/
String iProductStr=""; 	/*退订特服串*/
String iPayAmount="";  		/*所付金额*/
String iBusiTypeStr="";  	/*SP业务类型串*/
String iSpIdStr= ""; 		/*SP企业代码串*/
String iSpBizCodeStr="";  	/*SP业务代码串*/
String iIpAddr=(String)session.getAttribute("ipAddr");  //IP地址   
String iOpNote=iOpCode+opName;  /*操作日志 */
%>
	<wtc:service name="sChildOfferCfm"  outnum="2"
		routerKey="region" routerValue="<%=regCode%>"  
		retcode="cldRc" retmsg="cldRm"  >
	<wtc:param value="<%=iLoginAccept%>"/>
	<wtc:param value="<%=iChnSource%>"/>
	<wtc:param value="<%=iOpCode%>"/>
	<wtc:param value="<%=iLoginNo%>"/>
	<wtc:param value="<%=iLoginPwd%>"/>
	<wtc:param value="<%=iPhoneNo%>"/>
	<wtc:param value="<%=iUserPwd%>"/>
	<wtc:param value="<%=iNextMode%>"/>
	<wtc:param value="<%=iParentNo%>"/>
	<wtc:param value="<%=iProductStr%>"/>
	<wtc:param value="<%=iPayAmount%>"/>
		
	<wtc:param value="<%=iBusiTypeStr%>"/>
	<wtc:param value="<%=iSpIdStr%>"/>
	<wtc:param value="<%=iSpBizCodeStr%>"/>
	<wtc:param value="<%=iIpAddr%>"/>
	<wtc:param value="<%=iOpNote%>"/>
	</wtc:service>
	<wtc:array id="spRst" scope="end" />
<%
if( "000000".equals(cldRc))
{
%>
	<script>
		rdShowMessageDialog("<%=opName%>提交成功!");
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