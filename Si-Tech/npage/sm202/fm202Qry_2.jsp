<%
  /*
   * 功能:双跨融合V网成员套餐受理@查询界面
   * 版本: 1.0
   * 日期: 2013/11/21 16:11:37
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
		String iRegionCode = (String)request.getParameter("iRegionCode");
		String iProductId = (String)request.getParameter("iProductId");
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
		 paraAray[7]=iProductId;
		 
		 
%>
<wtc:service name="sm202Qry" routerKey="regionCode" routerValue="<%=iRegionCode%>" retcode="errCode" retmsg="errMsg"  outnum="8">
		<wtc:param value="<%=paraAray[0]%>" />
		<wtc:param value="<%=paraAray[1]%>" />
		<wtc:param value="<%=paraAray[2]%>" />
		<wtc:param value="<%=paraAray[3]%>" />
		<wtc:param value="<%=paraAray[4]%>" />
		<wtc:param value="<%=paraAray[5]%>" />
		<wtc:param value="<%=paraAray[6]%>" />
		<wtc:param value="<%=paraAray[7]%>" />
		
	</wtc:service>
	<wtc:array id="result" start="6" length="2"  scope="end" />
<%
	if(errCode.equals("0") || errCode.equals("000000")){
		System.out.println("调用服务 sm202Qry in fm202Qry_2.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
<%
	}else{
		System.out.println("调用服务 sm202Qry in fm202Qry_2.jsp 成功 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>");
		window.close();
	</script>
<%
	}		

%>		
	

<html>
<head>
	<title></title>
	<script language="javascript">
		$(document).ready(function(){
			
		});
		
	</script>
	</head>
<body>
	<form action="" method="post" name="form_i146Qry" id="form_i146Qry">
	<%@ include file="/npage/include/header.jsp" %>
	<div>
		<div>
	<table >
		<tr>
			<th>叠加包添加时间</th>
			<th>叠加包流量</th>
		</tr>
		<%
		System.out.println("gaopengSeeLog=========result.length="+result.length);
		if((errCode.equals("0")||errCode.equals("000000")) && result.length > 0){
				for(int i=0;i<result.length;i++){
		%>
				<tr>
					<td><%=result[i][0]%></td>
					<td><%=result[i][1]%></td>
				</tr>
				
		<%
			
			 }
			}
		%>
		
	</table>
		<div>
</div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>

</html>
