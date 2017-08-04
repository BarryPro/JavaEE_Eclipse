<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:MIS-POS统一冲正-CRM冲正
   * 版本: 1.0
   * 日期: 
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
/**	
	*@     iLoginAccept  流水
  *@		 iChnSource    渠道标识(必须输入01-BOSS；02-网上营业厅；
                       03-掌上营业厅；04-短信营业厅；05-多媒体查询机；06-10086)
  *@		 iOpCode       操作代码	
  *@		 iLoginNo      工号
  *@		 iLoginPwd     工号密码
  *@		 iPhoneNo,     申请人号码
  *@		 iUserPwd,     号码密码
  *@		 iOpNote,      操作略注
  *@     iOldAccept    原业务流水
  *@     iRrn          原交易系统检索号
  *@     inIpAddr      IP地址

*/

	/*===========获取参数============*/
  String  iLoginAccept = getMaxAccept();
  String 	regionCode = (String)session.getAttribute("regCode");  
  String  iChnSource = "01";
  String  iOpCode = (String)request.getParameter("iOpCode");
  String  iLoginNo = (String)request.getParameter("iLoginNo");
  String  iLoginPwd = (String)request.getParameter("iLoginPwd");
  String  iPhoneNo = (String)request.getParameter("iPhoneNo");
  String  iUserPwd = (String)request.getParameter("iUserPwd");
  String  iOpNote = (String)request.getParameter("iOpNote");
  String  iOldAccept = (String)request.getParameter("iOldAccept");
  String  inIpAddr = (String)request.getParameter("inIpAddr");
  String  iRrn = (String)request.getParameter("iRrn");
  String 	iopName = 	(String)request.getParameter("iOpName");           
%>
<wtc:service name="sg175Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="2">
		<wtc:param value="<%=iLoginAccept%>" />
		<wtc:param value="<%=iChnSource%>" />
		<wtc:param value="<%=iOpCode%>" />
		<wtc:param value="<%=iLoginNo%>" />
		<wtc:param value="<%=iLoginPwd%>" />
		<wtc:param value="<%=iPhoneNo%>" />
		<wtc:param value="<%=iUserPwd%>" />
		<wtc:param value="<%=iOpNote%>" />
		<wtc:param value="<%=iOldAccept%>" />
		<wtc:param value="<%=iRrn%>" />
		<wtc:param value="<%=inIpAddr%>" />
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("调用服务sg175Cfm in fg175Cfm.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("MIS-POS统一冲正成功！");
		window.location = 'fg175Login.jsp?opCode=<%=iOpCode%>&opName=<%=iopName%>&activePhone=<%=iPhoneNo%>';
	</script>
<%
	}else{
		System.out.println("调用服务sg175Cfm in fg175Cfm.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>");
		window.location = 'fg175Login.jsp?opCode=<%=iOpCode%>&opName=<%=iopName%>&activePhone=<%=iPhoneNo%>';
	</script>
<%
	}		
%>	

