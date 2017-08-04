<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v3.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    
		String opCode = request.getParameter("opCode");
 		String opName = request.getParameter("opName");
 		
 		String workNo = (String)session.getAttribute("workNo");
 		String password = (String)session.getAttribute("password");
		String workName = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode  = (String)session.getAttribute("regCode");
		String groupId = (String)session.getAttribute("groupId");
		String custName = "";
		String ZSCustName11="";
		String blackListStatus= "";
%>
  <wtc:service name="sD307Qry"  routerKey="region" routerValue="<%=regionCode%>" 
  	 retcode="retCode" retmsg="retMessage" outnum="2">
	 		<wtc:param value="" />
			<wtc:param value="01" />
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="<%=password%>" />	
			<wtc:param value="<%=activePhone%>"/>
		  <wtc:param value=""/> 
	</wtc:service>
	<wtc:array id="result"  scope="end"/>
<%
if("000000".equals(retCode)){
	if(result != null && result.length > 0){
		custName = result[0][0];
		
		  if(!("").equals(custName)) {
	
			if(custName.length() == 2 ){
				ZSCustName11 = custName.substring(0,1)+"*";
			}
			if(custName.length() == 3 ){
				ZSCustName11 = custName.substring(0,1)+"**";
			}
			if(custName.length() == 4){
				ZSCustName11 = custName.substring(0,2)+"**";
			}
			if(custName.length() > 4){
				ZSCustName11 = custName.substring(0,2)+"******";
			}
		}
		blackListStatus = result[0][1];
	}
}else{
%>
	<script language="javascript">
		rdShowMessageDialog("错误代码：<%=retCode%>，错误信息：<%=retMessage%>",0);
		removeCurrentTab();
	</script>
<%
}

%>		
<html>
<head>
	<title>有价卡黑名单查询</title>
	<script language="javascript">
	</script>
</head>
<body>
<form action="" method="post" name="form1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">有价卡黑名单查询</div>
	</div>
	<table>
		<tr>
			<td class="blue">手机号码</td>
			<td>
				<input type="text" name="phoneNo" id="phoneNo" value="<%=activePhone%>" 
				Class="InputGrey" readOnly />
			</td>
			<td class="blue">客户名称</td>
			<td>
				<input type="text" name="custName" id="custName"  value = "<%=ZSCustName11%>"
				Class="InputGrey" readOnly />
			</td>
		</tr>
		<tr>
			<td class="blue">黑名单状态</td>
			<td colspan="3">
				<input type="text" name="blackListStatus" id="blackListStatus"  value = "<%=blackListStatus%>"
				Class="InputGrey" readOnly />
			</td>
		</tr>
		<tr>
			<td id="footer" colspan="4"> 
         <input type="button" name="closeButton" class="b_foot" value="关闭" 
          style="cursor:hand;" onClick="removeCurrentTab()">&nbsp;
      </td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>

