<%
  /*
   * 功能:宽带订单状态信息查询-查询结果页面
   * 版本: 1.0
   * 日期: 20121015
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
/**
 * 服务名:sQryKdState
 * input : 
 *			0 业务流水			iLoginAccept
 *			1 渠道标识			iChnSource
 *			2 操作代码			iOpCode
 *			3 工号					iLoginNo
 *			4 工号密码			iLoginPwd
 *			5 号码					iPhoneNo
 *			6 号码密码			iUserPwd
 *			7 组织机构代码	iGroupId
 *			8 宽带账号			sKdUser
 *			9 异常单				sErrFlag (标识仅查询异常订单，1为查询异常单，0为全部)
 *		 10 开始时间			iStartTime
 *     11 结束时间			iEndTime

*/

	/*===========获取参数============*/
  String iLoginAccept = "0";  //0||''
	String iChnSource = "01";  //01
  String opCode = (String)request.getParameter("opCode");//
  String iLoginNo = (String)session.getAttribute("workNo");//(String)session.getAttribute("workNo");
  String iLoginPwd = (String)session.getAttribute("password");;//(String)session.getAttribute("password");
  String iPhoneNo = (String)request.getParameter("activePhone");//前台
  String iUserPwd = (String)request.getParameter("iUserPwd");//''
  String regionCode = (String)session.getAttribute("regCode");
  String opName = (String)request.getParameter("opName");//
   
%>
<wtc:service name="sCallTransQry" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="5">
		<wtc:param value="<%=iLoginAccept%>" />
		<wtc:param value="<%=iChnSource%>" />
		<wtc:param value="<%=opCode%>" />
		<wtc:param value="<%=iLoginNo%>" />
		<wtc:param value="<%=iLoginPwd%>" />
		<wtc:param value="<%=iPhoneNo%>" />
		<wtc:param value="<%=iUserPwd%>" />
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript">
		
	</script>
	</head>
	
<%
		if("000000".equals(errCode)){
			System.out.println("============ s1240CallQry.jsp ==========" + result1.length);
		}else{
%>
			<script language="javascript">
	      rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>",0);
	      window.location = 's1240Jump.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
	   	</script>
<%
		}
%>	
<body>
	<form action="" method="post" name="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table cellspacing="0" name="t1" id="t1">
		<% if(!"".equals(result1[0][1])){%>
			<tr>
				<td class="blue" width="25%">无条件呼转号码</td><td><%=result1[0][1]%></td>
			</tr>
		<%}%>
		<% if(!"".equals(result1[0][2])){%>
		<tr>
			<td class="blue" width="25%">遇忙呼转号码</td><td><%=result1[0][2]%></td>
		</tr>
		<%}%>
		<% if(!"".equals(result1[0][3])){%>
		<tr>
			<td class="blue" width="25%">无应答呼转号码</td><td><%=result1[0][3]%></td>
		</tr>
		<%}%>
		<% if(!"".equals(result1[0][4])){%>
		<tr>
			<td class="blue" width="25%"> 不可及呼转号码</td><td><%=result1[0][4]%></td>
		</tr>
		<%}%>
	</table>
	<table cellSpacing="0">
		<tr align="center">
			<td align="center" id="footer">
			<!--
			<input type="button" class="b_foot" value="查询" onclick="doSubmit()"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			-->
			<input type="button" class="b_foot"  value="返回" onclick="javascript:window.location.href='/npage/s1210/s1240Jump.jsp?opCode=<%=opCode%>&opName=<%=opName%>&crmActiveOpCode=<%=request.getParameter("crmActiveOpCode")%>&activePhone=<%=request.getParameter("activePhone")%>'"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab();"/>
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
