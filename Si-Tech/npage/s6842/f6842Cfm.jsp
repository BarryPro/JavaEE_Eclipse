<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opName = "新版促销品统一付奖预约登记";
	String strReturnMsg = "新版促销品统一付奖预约登记成功";
	String strReturnErrMsg = "新版促销品统一付奖预约登记失败";

	String work_no = (String) session.getAttribute("workNo");
	String work_name = (String) session.getAttribute("workName");
	String org_code = (String) session.getAttribute("orgCode");
	String pass = (String) session.getAttribute("password");
	String strOpCode = request.getParameter("opcode");
	String stream=WtcUtil.repNull(request.getParameter("printAccept"));
	String phoneNo = WtcUtil.repNull(request.getParameter("phone_no"));

	String paraAray[] = new String[14];
	paraAray[0] = work_no;   //工号
	paraAray[1] = pass;      //工号密码
	paraAray[2] = strOpCode; //操作代码
	paraAray[3] = phoneNo;   //手机号码
	paraAray[4] = request.getParameter("projectCodeI"); //营销案
	paraAray[5] = request.getParameter("gradeCodeI");   //登记
	paraAray[6] = request.getParameter("packageCodeI"); //包
	paraAray[7] = request.getParameter("winAcceptI");   //中奖
	paraAray[8] = request.getParameter("actionCodeI");  //活动代码

	//paraAray[9] = request.getParameter("checkLoginAcceptnew");//校验的操作流水
	//paraAray[10] = request.getParameter("rescode_sum_new");//有条件/无条件领奖数量
	paraAray[11] = request.getParameter("printAccept");//系统操作流水
	//paraAray[12] = request.getParameter("card_no");
	paraAray[13] = request.getParameter("gradeCode");//gradeCode liyan 20090429 新增中奖等级

	for (int i=0;i<paraAray.length;i++){
		System.out.println("预约登记确认入参paraAray["+i+"]="+paraAray[i]);
	}
%>
		<wtc:service name="s6842Reg" routerKey="phone" routerValue="<%=phoneNo%>" outnum="2" >
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
		</wtc:service>
<%
  int errCode = retCode==""?999999:Integer.parseInt(retCode);
	String errMsg = retMsg;
	System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");
	String loginAccept = stream;//服务未返回流水,所以置空
	String cnttActivePhone = phoneNo;
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+strOpCode+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+loginAccept+"&pageActivePhone="+cnttActivePhone+"&opBeginTime="+opBeginTime+"&contactId="+cnttActivePhone+"&contactType=user";
%>
		<jsp:include page="<%=url%>" flush="true" />
<%
	System.out.println("%%%%%%%调用统一接触结束%%%%%%%%");
	if (errCode == 0 )
	{
%>
			<script language="JavaScript">
			   rdShowMessageDialog("<%=strReturnMsg%>",2);
			   location="f6842.jsp?op_code=6842&activePhone=<%=phoneNo%>";
			</script>
<%
	}else{
%>
			<script language="JavaScript">
				rdShowMessageDialog("<%=strReturnErrMsg%>!<br>errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>");
				location="f6842.jsp?op_code=6842&activePhone=<%=phoneNo%>";
			</script>
<%}%>
