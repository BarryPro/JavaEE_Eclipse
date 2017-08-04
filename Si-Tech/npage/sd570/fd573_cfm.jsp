<%
/********************
 version v2.0
 开发商: si-tech
 模块: 欢乐家庭退出
 create by wanglma
********************/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp"%>
<%@ page import="java.util.*"%>

<%
	String work_no = (String)session.getAttribute("workNo");
	String passWord = (String)session.getAttribute("password");
	String regCode = (String)session.getAttribute("regCode");
	String org_code = (String)session.getAttribute("orgCode");
	String opName = "欢乐家庭退出";
	String opCode = request.getParameter("opCode");
    String phoneNo = request.getParameter("phoneNo");
    String memberNo = request.getParameter("memberNo");
    String mainFeeId = request.getParameter("mainFeeId");/*当前主资费15804508377*/
    String flag = request.getParameter("flag");/*标志位，为1时，phoneNo为家长号码，0时，memberNo为家长*/
    String opMainFeeId = request.getParameter("opMainFeeId");/*办理主资费*/
    String opFuFeeId = request.getParameter("opFuFeeId");/*办理附加资费*/
    String famProdId = request.getParameter("famProdId");/*家庭代码*/
    String memberNoFlag = request.getParameter("memberNoFlag");/*家庭号码*/
    
    /* 流水 */
    String printAccept="";
    printAccept = getMaxAccept();


%>
	<wtc:service name="sd572Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="2">
	<wtc:param value="<%=printAccept%>"/>
	<wtc:param value="01"/>	
	<wtc:param value="<%=opCode%>"/>	
	<wtc:param value="<%=work_no%>"/>
	<wtc:param value="<%=passWord%>"/>
	<wtc:param value="<%=memberNo%>"/><!--成员号码-->
	<wtc:param value=""/><!--成员号码密码-->
		
	<wtc:param value="<%=opMainFeeId%>"/><!--欢乐家庭主资费-->
	<wtc:param value="<%=opFuFeeId%>"/>	<!--欢乐家庭可选资费-->
	<%
		if("1".equals(flag)){
	%>
	<wtc:param value="<%=phoneNo%>"/><!--家长号码-->
	<%}else{%>
	<wtc:param value="<%=memberNoFlag%>"/><!--家长号码-->
	<%}%>		
						
	<wtc:param value="<%=mainFeeId%>"/>	<!--当前主资费-->
	<wtc:param value="<%=famProdId%>"/>	<!--家庭代码-->
	<wtc:param value="<%=org_code%>"/><!--机构编码-->
	<wtc:param value="欢乐家庭成员退出"/><!--操作日志-->
	</wtc:service>
	<wtc:array id="result"  scope="end"/>

<%
	String errCode = retCode;
	String errMsg = retMsg;
	if (errCode.equals("000000"))
	{
%>
<script language="JavaScript">
   rdShowMessageDialog("业务办理成功!",2);
   // window.location="fd570.jsp?opCode=d570&activePhone=<%=phoneNo%>&opName=<%=opName%>";
   removeCurrentTab();
</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("业务办理失败!<br>errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>",0);
	window.location="fd570.jsp?opCode=d570&activePhone=<%=phoneNo%>&opName=<%=opName%>";
</script>
<%}%>
