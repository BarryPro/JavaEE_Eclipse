<%
  /*
   * 功能:* 
   * 版本: 1.0
   * 日期: * gaopeng 2015/02/11 9:50:29 关于11月份集团客户部CRM、BOSS和经分系统需求的函-7-行业应用流量卡BOSS系统需求
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
		String iUnitCode = (String)request.getParameter("iUnitCode");
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
		 paraAray[7]=iUnitCode;
		 
		 
%>
<wtc:service name="sm225GrpQry" routerKey="regionCode" routerValue="<%=iRegionCode%>" retcode="errCode" retmsg="errMsg"  outnum="8">
		<wtc:param value="<%=paraAray[0]%>" />
		<wtc:param value="<%=paraAray[1]%>" />
		<wtc:param value="<%=paraAray[2]%>" />
		<wtc:param value="<%=paraAray[3]%>" />
		<wtc:param value="<%=paraAray[4]%>" />
		<wtc:param value="<%=paraAray[5]%>" />
		<wtc:param value="<%=paraAray[6]%>" />
		<wtc:param value="<%=paraAray[7]%>" />
	</wtc:service>
	<wtc:array id="result"   scope="end" start="0"  length="4"/>
	<wtc:array id="result22"   scope="end" start="4"  length="3"/>

<%
	if(errCode.equals("0") || errCode.equals("000000")){
		System.out.println("调用服务 Sm225Qry in fm225Qry_2.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
<%
	}else{
		System.out.println("调用服务 Sm225Qry in fm225Qry_2.jsp 成功 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
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
		/*父页面赋值方法*/
		function giveFa(){
			
			var radVal = $("input[name='selOp'][checked]").val();
			var infoArray = new Array();
			infoArray = radVal.split("|");
			window.opener.$("#product_id").val(infoArray[0]);
			window.opener.$("#product_account").val(infoArray[1]);
			window.opener.$("#oCustName").val(infoArray[2]);
			window.opener.$("#oIccidNo").val(infoArray[3]);
			window.opener.$("#oCustId").val(infoArray[4]);

			/*2015/02/10 16:49:15 gaopeng 置灰查询集团产品按钮*/
			window.opener.$("#qryUnitBtn").attr("disabled","disabled");
			/*2015/02/10 16:49:15 gaopeng 显示卡号输入*/
			window.opener.$("#cardContent").show();
			window.opener.$("#unitCode").attr("readonly","readonly");
			window.opener.$("#unitCode").attr("class","InputGrey");
			window.close();
		}
		
	</script>
	</head>
<body>
	<form action="" method="post" name="form_i146Qry" id="form_i146Qry">
	<%@ include file="/npage/include/header.jsp" %>
	<div>
		<div>
	<table >
		<tr>
			<th>操作</th>
			<th>产品ID</th>
			<th>产品付费帐户</th>
			<th>产品代码</th>
			<th>产品名称</th>
		</tr>
		<%
		System.out.println("gaopengSeeLog=========result.length="+result.length);
		if((errCode.equals("0")||errCode.equals("000000")) && result.length > 0){
				for(int i=0;i<result.length;i++){
		%>
				<tr>
					<td><input type="radio" name="selOp" value="<%=result[i][0]%>|<%=result[i][1]%>|<%=result22[0][0]%>|<%=result22[0][1]%>|<%=result22[0][2]%>"/></td>
					<td><%=result[i][0]%></td>
					<td><%=result[i][1]%></td>
					<td><%=result[i][2]%></td>
					<td><%=result[i][3]%></td>
				</tr>
				
		<%
			
			 }
			}
		%>
		<td align=center colspan="8" id="footer">
				<input class="b_foot" name="sure"  type="button" value="确定"  onclick="giveFa();">&nbsp;&nbsp;
		</td>
		
	</table>
		<div>
</div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>

</html>