<%
/********************
 version v2.0
开发商: si-tech
<!-- baixf 20080613 modify 将“集团无条件赠机”名称更改为“集团客户行业应用赠机”  -->
********************/
%>
<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.06
 模块:集团客户行业应用赠机
********************/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>


<%	
	String opCode = "8032";
	String opName = "集团客户行业应用赠机";
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String regCode = (String)session.getAttribute("regCode");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	
	String paraAray[] = new String[22];
	String phone_type = request.getParameter("phone_type");
	String award_flag=request.getParameter("award_flag");
	String phoneNo = request.getParameter("phone_no");
	

	paraAray[0] =request.getParameter("login_accept");
	paraAray[1] = request.getParameter("opcode");
    paraAray[2] = work_no;
	paraAray[3] = request.getParameter("phone_no");
    paraAray[4] = request.getParameter("sale_type");
    paraAray[5] = request.getParameter("sale_code"); 
    paraAray[6] = request.getParameter("sum_money");
    paraAray[7] = request.getParameter("pay_money");
    paraAray[8] = request.getParameter("opNote");
    paraAray[9] = request.getParameter("ip_Addr");
	paraAray[10] = request.getParameter("vUnitId");
    paraAray[11] = request.getParameter("vUnitName");
    paraAray[12] = request.getParameter("vProductId");
	paraAray[13] = request.getParameter("vProductCode");
    paraAray[14] = request.getParameter("vTargetCode");
    paraAray[15] = request.getParameter("phone_typename");
	paraAray[16] = request.getParameter("IMEINo");
    paraAray[17] = request.getParameter("payTime");
    paraAray[18] = request.getParameter("repairLimit");
    paraAray[19] = request.getParameter("vZw");
    paraAray[20] = phone_type;
	paraAray[21] = award_flag;

	//String[] ret = impl.callService("s8032Cfm",paraAray,"2","region",org_code.substring(0,2));
%>
	<wtc:service name="s8032Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2">			
	<wtc:param value="<%=paraAray[0]%>"/>
	<wtc:param value="<%=paraAray[1]%>"/>	
	<wtc:param value="<%=paraAray[2]%>"/>	
	<wtc:param value="<%=paraAray[3]%>"/>	
	<wtc:param value="<%=paraAray[4]%>"/>	
	<wtc:param value="<%=paraAray[5]%>"/>
	<wtc:param value="<%=paraAray[6]%>"/>	
	<wtc:param value="<%=paraAray[7]%>"/>	
	<wtc:param value="<%=paraAray[8]%>"/>	
	<wtc:param value="<%=paraAray[9]%>"/>
	<wtc:param value="<%=paraAray[10]%>"/>
	<wtc:param value="<%=paraAray[11]%>"/>	
	<wtc:param value="<%=paraAray[12]%>"/>	
	<wtc:param value="<%=paraAray[13]%>"/>	
	<wtc:param value="<%=paraAray[14]%>"/>
	<wtc:param value="<%=paraAray[15]%>"/>
	<wtc:param value="<%=paraAray[16]%>"/>	
	<wtc:param value="<%=paraAray[17]%>"/>	
	<wtc:param value="<%=paraAray[18]%>"/>	
	<wtc:param value="<%=paraAray[19]%>"/>	
	<wtc:param value="<%=paraAray[20]%>"/>	
	<wtc:param value="<%=paraAray[21]%>"/>	
	</wtc:service>	
	<wtc:array id="retTemp"  scope="end"/>
<%
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime;
	String errCode = retCode1;
	String errMsg = retMsg1;
%>
	<jsp:include page="<%=url%>" flush="true" />
<%
	if (errCode.equals("000000"))
	{
%>
		<script language="JavaScript">
		   rdShowMessageDialog("提交成功! ",2);
		   location="f8032_login.jsp?activePhone=<%=paraAray[3]%>&opCode=<%=opCode%>&opName=<%=opName%>";
		</script>
<%
	}else{
%>   
		<script language="JavaScript">
			rdShowMessageDialog("集团客户行业应用赠机失败!(<%=errMsg%>",0);
			history.go(-2);
		</script>
<%}%>
