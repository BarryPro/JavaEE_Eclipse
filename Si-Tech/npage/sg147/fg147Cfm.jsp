<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:校讯通apn功能开通
   * 版本: 1.0
   * 日期: 2012/09/25
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
/**	0 iLoginAccept 流水
		1 iChnSource  渠道代码
		2 iOpCode    操作代码
		3 iLoginNo    工号
		4 iLoginPwd   工号密码
		5 iPhoneNo   用户手机号码
		6 iUserPwd   用户手机密码
		7 sOfferId    资费代码
		8 sSchool     学校名称
		9 sClass      班级名称
*/

	/*===========获取参数============*/
  String  iLoginAccept = (String)request.getParameter("loginAccept");  
  String  iChnSource = "01";
  String  iOpCode = (String)request.getParameter("iopCode");
  String  iLoginNo = (String)request.getParameter("workNo");
  String  iLoginPwd = (String)request.getParameter("noPass");
  String  iPhoneNo = (String)request.getParameter("phoneNo");
  String  iUserPwd = "";
  String  sOfferId = (String)request.getParameter("opTariff").split("\\|")[0];
  String  sSchool = (String)request.getParameter("belongSchool");
  String  sClass = (String)request.getParameter("belongClass");
  String regionCode = (String)session.getAttribute("regCode");			
  String iopName = 	(String)request.getParameter("iopName");           
%>
<wtc:service name="sG147Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="2">
		<wtc:param value="<%=iLoginAccept%>" />
		<wtc:param value="<%=iChnSource%>" />
		<wtc:param value="<%=iOpCode%>" />
		<wtc:param value="<%=iLoginNo%>" />
		<wtc:param value="<%=iLoginPwd%>" />
		<wtc:param value="<%=iPhoneNo%>" />
		<wtc:param value="<%=iUserPwd%>" />
		<wtc:param value="<%=sOfferId%>" />
		<wtc:param value="<%=sSchool%>" />
		<wtc:param value="<%=sClass%>" />
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("调用服务sTeacherAPNOn in fg147Main.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("校讯通apn功能开通成功！");
		window.location = 'fg147Main.jsp?opCode=<%=iOpCode%>&opName=<%=iopName%>&activePhone=<%=iPhoneNo%>';
	</script>
<%
	}else{
		System.out.println("调用服务sTeacherAPNOn in fg147Main.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>");
		window.location = 'fg147Main.jsp?opCode=<%=iOpCode%>&opName=<%=iopName%>&activePhone=<%=iPhoneNo%>';
	</script>
<%
	}		
%>	
