<%
  /*
   * 功能: 彩铃信息费业务受理1465
   * 版本: 1.0
   * 日期: 2008/12/22
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%	
	String opCode="1465";
	String opName="彩铃信息费业务受理";
	String work_no = (String)session.getAttribute("workNo");			//操作工号
	String pass = (String)session.getAttribute("password");				//工号密码
	String regionCode = (String)session.getAttribute("regCode");		//地市代码
	String printAccept=request.getParameter("printAccept");				//打印流水
	String phone_no = request.getParameter("phone_no");					//服务号码
	String user_passwd = request.getParameter("passFromPage");			//用户密码
	String tran_type = request.getParameter("r_cus");
	String opNote = request.getParameter("opNote");
	String ip_Addr = request.getParameter("ip_Addr");
	String strFuncType = request.getParameter("func_type");		/*功能类型*/
   	
	String paraAray[] = new String[11];
	paraAray[0] = work_no;				//登录工号
	paraAray[1] = pass;      			//登录工号密码
	paraAray[2] = "01";      			//登录类型
  	paraAray[3] = printAccept;			//登录工号系统操作流水
	paraAray[4] = "1465";   			//操作代码
	paraAray[5] = phone_no;  			//手机号码
	paraAray[6] = user_passwd;  		//用户密码
	paraAray[7] = tran_type; 			//操作类型
	paraAray[8] = opNote;				//操作注释
	paraAray[9] = ip_Addr;				//用户操作机器IP地址
	paraAray[10] = strFuncType;			//功能类型
	
//	String[] ret = impl.callService("s5510Cfm",paraAray,"1","phone",request.getParameter("phoneNo"));
%>
	<wtc:service name="s5510Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="1" retcode="retCode" retmsg="retMsg">
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
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%	
	System.out.println("result=============="+result[0][0]);
	String errCode = retCode;
	String errMsg = retMsg;
	if (errCode.equals("000000") )
	{
%>
<script language="JavaScript">
	       rdShowMessageDialog("彩铃业务受理成功!",2);
	       window.location="f1465.jsp?activePhone=<%=phone_no%>";
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("彩铃业务受理业务处理失败!<br>errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>",0);
	 window.location="f1465.jsp?activePhone=<%=phone_no%>";
	//history.go(-1);
</script>
<%}%>
<%
	String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+""+"&pageActivePhone="+phone_no+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
%>
	<jsp:include page="<%=url%>" flush="true" />
