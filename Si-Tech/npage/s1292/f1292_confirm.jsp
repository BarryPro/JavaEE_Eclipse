<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.01.15
 模块:预存话费赠电池-申请
********************/
%>

	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%	
	String opCode = "1292";
	String opName = "预存话费赠电池-申请";
	String phoneNo = request.getParameter("phoneNo");
	
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	
	String paraAray[] = new String[12];

    paraAray[0] = request.getParameter("phoneNo").trim();//服务号码
    paraAray[1] = work_no;//工号
    paraAray[2] = request.getParameter("type_code_value");//用户类型
    paraAray[3] = request.getParameter("battery_code");//赠品类型
    paraAray[4] = request.getParameter("battery_fee");//赠费
    paraAray[5] = request.getParameter("prepay_fee");//预存款
    paraAray[6] = request.getParameter("invoice_date");//发票日期
    paraAray[7] = request.getParameter("invoice_work");//发票工号
    paraAray[8] = request.getParameter("invoice_accept");//发票流水
    paraAray[9] = "1292";//操作代码
	paraAray[10] = request.getParameter("opNote");//操作备注
	paraAray[11] = request.getParameter("printAccept");//操作备注
	

	//String[] ret = impl.callService("s1292_Apply",paraAray,"2","phone",request.getParameter("phoneNo"));
%>
	<wtc:service name="s1292_Apply" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="2">			
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
	</wtc:service>	
	<wtc:array id="result1"  scope="end"/>
<%
	String errCode = retCode1;
	String errMsg = retMsg1;
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+request.getParameter("printAccept")+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; 
%>
	<jsp:include page="<%=url%>" flush="true" />
<%
	if (errCode.equals("000000"))
	{
%>
<script language="JavaScript">
   rdShowMessageDialog("预存话费赠电池-申请成功!",2);
   removeCurrentTab();
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("预存话费赠电池-申请失败!(<%=errMsg%>",0);
	history.go(-1);
</script>
<%}%>
