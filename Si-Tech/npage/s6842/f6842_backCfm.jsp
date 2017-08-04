<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String phoneNo = WtcUtil.repNull(request.getParameter("phone_no"));
	String strReturnMsg="促销品统一付奖冲正成功";
	String strReturnErrMsg = "促销品统一付奖冲正失败";
	String opName="促销品统一付奖冲正";

	String paraAray[] = new String[7];
	paraAray[0] = (String) session.getAttribute("workNo");              //工号
	paraAray[1] = (String) session.getAttribute("password");            //工号密码
	paraAray[2] = request.getParameter("opcode");                       //操作代码
	paraAray[3] = phoneNo;                                              //手机号码
	paraAray[4] = "用户"+phoneNo+"新版统一促销品付奖冲正";              //冲正备注
	paraAray[5] = WtcUtil.repNull(request.getParameter("printAccept")); //系统操作流水--入his的冲正流水
	String[] paraAray_6 = request.getParameter("backaccept") == null ? null : request.getParameter("backaccept").split("#");//领奖流水

  for(int i=0;i<paraAray.length;i++){System.out.println("冲正入参paraAray["+i+"]="+paraAray[i]);}
  for(int i=0;i<paraAray_6.length;i++){System.out.println("冲正入参paraAray_6["+i+"]="+paraAray_6[i]);}
%>
		<wtc:service name="s6842BackCfm" routerKey="phone" routerValue="<%=phoneNo%>" outnum="2" >
    		<wtc:param  value="<%=paraAray[0]%>"/>
    		<wtc:param  value="<%=paraAray[1]%>"/>
    		<wtc:param  value="<%=paraAray[2]%>"/>
    		<wtc:param  value="<%=paraAray[3]%>"/>
    		<wtc:param  value="<%=paraAray[4]%>"/>
    		<wtc:param  value="<%=paraAray[5]%>"/>
    		<wtc:params value="<%=paraAray_6 %>"/>
		</wtc:service>
<%
  int errCode = retCode==""?999999:Integer.parseInt(retCode);
	String errMsg = retMsg;
	System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");
	String loginAccept = paraAray[6];//服务未返回流水,所以置空
	String cnttActivePhone = phoneNo;
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+paraAray[2]+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+paraAray[0]+"&loginAccept="+loginAccept+"&pageActivePhone="+cnttActivePhone+"&opBeginTime="+opBeginTime+"&contactId="+cnttActivePhone+"&contactType=user";
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
