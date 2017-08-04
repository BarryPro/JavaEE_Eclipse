<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>


<%	
	String work_no = (String)session.getAttribute("workNo");
	String org_code = (String)session.getAttribute("orgCode");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	
	
	String paraAray[] = new String[15];
	

		paraAray[0] =request.getParameter("login_accept");
		paraAray[1] = request.getParameter("opcode");
    paraAray[2] = work_no;
		paraAray[3] = request.getParameter("phone_no");
    paraAray[4] = request.getParameter("sale_type");
    paraAray[5] = request.getParameter("sale_code");
    paraAray[6] = request.getParameter("vUnitId");
    paraAray[7] = request.getParameter("vUnitCotract");
    paraAray[8] = request.getParameter("vUnitPayFee");
    paraAray[9] = request.getParameter("opNote");
    paraAray[10] = request.getParameter("ip_Addr");
    paraAray[11] = request.getParameter("phone_typename");
		paraAray[12] = request.getParameter("IMEINo");
		paraAray[13] = request.getParameter("payTime");
		paraAray[14] = request.getParameter("repairLimit");
	
	//String[] ret = impl.callService("s8609Cfm",paraAray,"2","region",org_code.substring(0,2));
	%>
	
	<wtc:service name="s8609Cfm" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=org_code.substring(0,2)%>">
			<wtc:param value="<%=paraAray[0]%>" />
			<wtc:param value="<%=paraAray[1]%>" />
			<wtc:param value="<%=paraAray[2]%>" />
			<wtc:param value="<%=paraAray[3]%>" />			
			<wtc:param value="<%=paraAray[4]%>" />
			<wtc:param value="<%=paraAray[5]%>" />
			<wtc:param value="<%=paraAray[6]%>" />			
			<wtc:param value="<%=paraAray[7]%>" />
			<wtc:param value="<%=paraAray[8]%>" />
			<wtc:param value="<%=paraAray[9]%>" />
			<wtc:param value="<%=paraAray[10]%>" />
			<wtc:param value="<%=paraAray[11]%>" />
			<wtc:param value="<%=paraAray[12]%>" />
			<wtc:param value="<%=paraAray[13]%>" />
			<wtc:param value="<%=paraAray[14]%>" />
		</wtc:service>
	<wtc:array id="result_t" scope="end"  />
	
	<%
	String errCode = code;
	String errMsg = msg;
	if (errCode.equals("000000"))
	{
S1100View callView = new S1100View();
String chinaFee = ((String[][])(callView.view_sToChinaFee(Pub_lxd.formatNumber(paraAray[7],2)).get(0)))[0][2];//大写金额
System.out.print(chinaFee);
%>
<script language="JavaScript">
   rdShowMessageDialog("提交成功! ");
window.location="f8609_login.jsp?phone_no=<%=paraAray[3]%>";

</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("提交失败!(<%=errMsg%>");
	window.location="f8609_login.jsp?phone_no=<%=paraAray[3]%>";
</script>
<%}%>
