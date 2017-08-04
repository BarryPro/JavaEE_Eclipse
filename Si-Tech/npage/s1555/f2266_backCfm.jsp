<%
    /********************
     version v2.0
     开发商: si-tech
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opName = "";

    String work_no = (String) session.getAttribute("workNo");
    String pass = (String) session.getAttribute("password");
    
    String strOpCode = request.getParameter("opcode");
    String stream=WtcUtil.repNull(request.getParameter("printAccept"));
    String phoneNo = WtcUtil.repNull(request.getParameter("phone_no"));
	String strReturnMsg = "";
	String strReturnErrMsg = "";
	String paraAray[] = new String[7];
	paraAray[0] = work_no;//工号
	paraAray[1] = pass;//工号密码
	paraAray[2] = strOpCode;//操作代码
	paraAray[3] = phoneNo;//手机号码
	paraAray[4] = request.getParameter("backaccept");//冲正流水号
	paraAray[5] = "用户"+phoneNo+"统一促销品付奖冲正";//备注
	paraAray[6] = stream;//系统操作流水
	
	
    System.out.println("---------------------------------------------------");
    for(int i=0;i<paraAray.length;i++)
    {
        System.out.println("paraAray["+i+"]="+paraAray[i]);
    }

%>

<%
		strReturnMsg="促销品统一付奖冲正成功";
		strReturnErrMsg = "促销品统一付奖冲正失败";
		opName="促销品统一付奖冲正";
%>
		<wtc:service name="s2266BackNew" routerKey="phone" routerValue="<%=phoneNo%>" outnum="2" >
    		<wtc:param value="<%=paraAray[0]%>"/>
    		<wtc:param value="<%=paraAray[1]%>"/>
    		<wtc:param value="<%=paraAray[2]%>"/>
    		<wtc:param value="<%=paraAray[3]%>"/>
    		<wtc:param value="<%=paraAray[4]%>"/>
    		<wtc:param value="<%=paraAray[5]%>"/>
    		<wtc:param value="<%=paraAray[6]%>"/>
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
			   location="f2266.jsp?op_code=2266&activePhone=<%=phoneNo%>";
			</script>
<%
	}else{
%>
			<script language="JavaScript">
				rdShowMessageDialog("<%=strReturnErrMsg%>!<br>errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>");
				location="f2266.jsp?op_code=2266&activePhone=<%=phoneNo%>";
			</script>
<%}%>
