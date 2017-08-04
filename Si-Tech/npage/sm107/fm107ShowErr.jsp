<%
  /*
   * 功能:流量统付业务本省受理本省支付模式支撑改造
   * 版本: 1.0
   * 日期: 2014/11/04 9:20:00
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
		
		String iLoginAccept = (String)request.getParameter("iLoginAccept");
		String iChnSource = (String)request.getParameter("iChnSource");
		String iOpCode = (String)request.getParameter("iOpCode");
		String iOpName = (String)request.getParameter("iOpName");
		String iLoginNo = (String)request.getParameter("iLoginNo");
		String iLoginPwd = (String)request.getParameter("iLoginPwd");
		String iPhoneNo = (String)request.getParameter("iPhoneNo");
		String iUserPwd = (String)request.getParameter("iUserPwd");
		String regionCode = (String)session.getAttribute("regCode");
		String errorStr = (String)request.getParameter("errorStr");
		
		
		
		String opCode = iOpCode;
		String opName = iOpName;
		
		 String paraAray[] = new String[10];
		 paraAray[0]=iLoginAccept;
		 paraAray[1]=iChnSource;
		 paraAray[2]=iOpCode;
		 paraAray[3]=iLoginNo;
		 paraAray[4]=iLoginPwd;
		 paraAray[5]=iPhoneNo;
		 paraAray[6]=iUserPwd;
		 
%>
	
	

<html>
<head>
	<title></title>
	<script language="javascript">
		
	</script>
	</head>
<body>
	<form action="" method="post" name="form_i146Qry" id="form_i146Qry">
	<%@ include file="/npage/include/header.jsp" %>
	
	<table>
		<tr>
			<th colspan='2'>未成功号码列表</th>
		</tr>
		<tr>
			<th>未添加成功号码</th>
			<th>失败原因</th>
		</tr>
		<%=errorStr%>
	</table>
	<table cellSpacing=0>
					<tr>
						<td id="footer">
							<input  name="back1"  class="b_foot" type="button" value=关闭 id="Button2" onclick="removeCurrentTab();">
							<input  name="back1"  class="b_foot" type="button" value=返回 id="Button2" onclick="window.location='fm107_main.jsp?opCode=m107&opName=成员叠加包订购&crmActiveOpCode=m107'">
						</td>
					</tr>
	</table>
</div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>

</html>
