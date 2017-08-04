<%
/*
 * zhangyan 2012-10-10 14:35:38
 服务名：sg176Init
功能：  集团产品强制开关机初始化查询服务
时间：  wuxy 20120904

 *@ 输入参数：
 *@        sInLoginAccept             操作流水
 *@        sInChnSource               渠道来源
 *@        sInOpCode                  操作代码
 *@        sInLoginNo                 操作工号
 *@        sInLoginPwd                操作密码
 *@        sInPhone                   手机号码
 *@        sInUserPwd                 手机用户密码
 *@        sInContractNo              集团产品帐户号码 
 *@
 *@ 返回参数：
 *@         vUnitId                   集团编码
 *@         vUnitName                 集团名称
 *@       	vOfferName                产品名称
            vRunCode                  状态
            vRunName                  状态名称
            vBeginTime                开始时间
            vEndTime                  结束时间

*/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
String opCode=request.getParameter("opCode");
String opName=request.getParameter("opName");
%>


<html xmlns="http://www.w3.org/1999/xhtml"> 
	<head>
		<title><%=opCode%></title>
	</head>
	<body >
		<form  name="frm" action="" method="POST" >
			<input type="hidden" id="opCode" name	="opCode"	value= "<%=opCode%>">
			<input type="hidden" id="opName" name	="opName"	value= "<%=opName%>">
			<%@ include file="/npage/include/header.jsp" %>

			<DIV id="Operation_Table">

				<div class="title">
					<div id="title_zi"><%=opName%></div>
				</div>
				<table>
					<tr>
						<td align="center">集团产品帐户号码:</td>
						<td>
							<input type="text" id="contract_no" name="contract_no">
						</td>			
					</tr>			
					<tr> 
						<td  id="footer" colspan='2'>
							<input class="b_foot" type="button" name=nextBtn value="下一步"
								onClick="nextStep();">
							<input class="b_foot" type="button" name=clsBtn value="关闭"
								onClick="removeCurrentTab();">								
						</td>
					</tr>
				</table>	
			</div>
		</form>
	</body>
	<script type="text/javascript">		
		
	/*进入办理界面*/
	function nextStep()
	{
		var opCode=document.all.opCode.value;
		var opName=document.all.opName.value;
		
		if ( !forInt(document.all.contract_no) )
		{
			return false;
		}	
		
		document.frm.action="fG176Main.jsp?opCode="+opCode+"&opName="+opName;
		document.frm.submit();
	}

	</script>
</html>
