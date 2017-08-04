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
		String iUnitId = (String)request.getParameter("iUnitId");
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
		 paraAray[7]=iRegionCode;
		 paraAray[8]=iUnitId;
		 paraAray[9]=iProductId;
		 
%>
<wtc:service name="sSKUnitQry" routerKey="regionCode" routerValue="<%=iRegionCode%>" retcode="errCode" retmsg="errMsg"  outnum="3">
		<wtc:param value="<%=paraAray[0]%>" />
		<wtc:param value="<%=paraAray[1]%>" />
		<wtc:param value="<%=paraAray[2]%>" />
		<wtc:param value="<%=paraAray[3]%>" />
		<wtc:param value="<%=paraAray[4]%>" />
		<wtc:param value="<%=paraAray[5]%>" />
		<wtc:param value="<%=paraAray[6]%>" />
		<wtc:param value="<%=paraAray[7]%>" />
		<wtc:param value="<%=paraAray[8]%>" />
		<wtc:param value="<%=paraAray[9]%>" />
	</wtc:service>
	<wtc:array id="result" scope="end" />
<%
	if(errCode.equals("0") || errCode.equals("000000")){
		System.out.println("调用服务 sSKUnitQry in fUnitQry.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
<%
	}else{
		System.out.println("调用服务 sSKUnitQry in fUnitQry.jsp 成功 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
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
		function giveOpenerVal(){
			
			var selectVal = $.trim($("input[name='selectRadio'][checked]").val());
			if(selectVal == ""){
				rdShowMessageDialog("请选择成员！",1);
				return false;
			}
			var unitCode = selectVal.split("|")[0];
			var productCode = selectVal.split("|")[1];
			
			var unitCodeObj = window.opener.$("#unitCode");
			var productCodeObj = window.opener.$("#productCode");
			var submitr = window.opener.$("#submitr");
			
			unitCodeObj.val(unitCode);
			productCodeObj.val(productCode);
			unitCodeObj.attr("readonly","readonly");
			productCodeObj.attr("readonly","readonly");
			
			submitr.attr("disabled","");
			/*父页面查询完毕标识*/
			window.opener.qryFlag = true;
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
			<th>集团编码</th>
			<th>订购关系编码</th>
			<th>集团名称</th>
		</tr>
		<%if((errCode.equals("0")||errCode.equals("000000")) && result.length > 0){
				for(int i=0;i<result.length;i++){
		%>
				<tr>
					<td><input type="radio" name="selectRadio" value="<%=result[i][0]%>|<%=result[i][2]%>" /></td>
					<td><%=result[i][0]%></td>
					<td><%=result[i][2]%></td>
					<td><%=result[i][1]%></td>
				</tr>
				
		<%
			
			 }
			}
		%>
		
	</table>
		<div>
	<table cellSpacing=0>
					<tr>
						<td id="footer">
							<input  name="submitr"  class="b_foot" type="button" value="确认" onclick="giveOpenerVal()" id="Button1">&nbsp;&nbsp;
							<input  name="back1"  class="b_foot" type="button" value=关闭 id="Button2" onclick="window.close()">
						</td>
					</tr>
	</table>
</div>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>

</html>
