<%
/*
 * zhangyan 2012-10-10 14:35:38
*/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
String opCode=request.getParameter("opCode");
String opName=request.getParameter("opName");
String regCode=request.getParameter("regCode");
String iLoginAccept=""; 	/*操作流水*/
String iChnSource="01"; 		/*渠道标示*/
String iOpCode=request.getParameter("opCode"); 		/*操作代码*/
String iLoginNo=(String)session.getAttribute("workNo"); 		/*操作工号*/
String iLoginPwd=(String)session.getAttribute("password"); 		/*工号密码*/
String iPhoneNo=""; 		/*成员号码*/
String iUserPwd=""; 		/*号码密码*/
String iContractNo=request.getParameter("contract_no");   
%>

<wtc:service name="sg176Init" routerKey="region" 
	routerValue="<%=regCode%>" outnum="26" retcode="retCode" retmsg="retMsg">
	<wtc:param value="<%=iLoginAccept%>"/>
	<wtc:param value="<%=iChnSource%>"/> 
	<wtc:param value="<%=iOpCode%>"/>
	<wtc:param value="<%=iLoginNo%>"/>
	<wtc:param value="<%=iLoginPwd%>"/>
	<wtc:param value="<%=iPhoneNo%>"/>
	<wtc:param value="<%=iUserPwd%>"/>
	<wtc:param value="<%=iContractNo              %>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>
<%
if(!retCode.equals("000000"))
{
%>
	<script>
		rdShowMessageDialog("<%=retCode%>:<%=retMsg%>");
		window.location="fG176Login.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
<%
}
else
{
%>
<!--操作流水-->
<wtc:sequence name="sPubSelect" key="sMaxSysAccept"
	routerKey="workNo" routerValue="<%=iLoginNo%>" id="loginAccept"/>
	
<html xmlns="http://www.w3.org/1999/xhtml"> 
	<head>
		<title><%=opCode%></title>
	</head>
	<body >
		<form  name="frm" action="" method="POST" >
			<input type="hidden" id="opCode" name	="opCode"	value= "<%=opCode%>">
			<input type="hidden" id="opName" name	="opName"	value= "<%=opName%>">
			<input type="hidden" id="loginAccept" name	="loginAccept"	value= "<%=loginAccept%>">
			<input type="hidden" id="contract_no" name	="contract_no"	value= "<%=iContractNo%>">
			
			<%@ include file="/npage/include/header.jsp" %>

			<DIV id="Operation_Table">
				<div class="title">
					<div id="title_zi"><%=opName%></div>
				</div>
				<table>
					<tr  >
						<td class="blue">集团编码 </td>
						<td nowrap >
							<input type="text"  name = "vUnitId" class='InputGrey' readOnly
								value="<%=result[0][0]%>" >
						</td>	
						<td class="blue">集团名称 </td>
						<td nowrap >
							<input type="text"  name = "vUnitName" class='InputGrey' readOnly
								value="<%=result[0][1]%>">
						</td>		
					</tr>	
					<tr  >
						<td class="blue">产品名称 </td>
						<td nowrap >
							<input type="text"  name = "vOfferName"  class='InputGrey' readOnly
								value="<%=result[0][2]%>"> 
							</td>	
						<td class="blue">状态 </td>
						<td nowrap >
							<input type="text"  name = "vRunCode"  class='InputGrey' readOnly
								value="<%=result[0][3]%>--><%=result[0][4]%>">
						</td>		
					</tr>
					<%
					if ( opCode.equals("g176") )
					{
					%>					
					<tr  >
						<td class="blue">强开开始时间 </td>
						<td nowrap >
							<input type="text"  name = "vBeginTime"  class='InputGrey' readOnly
								value="<%=result[0][5]%>" >
						</td>	
						<td class="blue">强开结束时间 </td>
						<td nowrap >
							<input type="text"  name = "vEndTime" class='InputGrey' readOnly
								value="<%=result[0][6]%>">
						</td>		
					</tr>					
					<%
					}
					else if (opCode.equals("g177"))
					{
					%>
					<tr  >
						<td class="blue">强关开始时间 </td>
						<td nowrap >
							<input type="text"  name = "vBeginTime"   class='InputGrey' readOnly
								value="<%=result[0][5]%>" >
						</td>	
						<td class="blue">强关结束时间 </td>
						<td nowrap >
							<input type="text"  name = "vEndTime"  class='InputGrey' readOnly
								value="<%=result[0][6]%>">
						</td>		
					</tr>							
					<%
					}
					%>	
					
										
					<tr id = "contact_row" >
						<td class="blue">联系人姓名 </td>
						<td nowrap >
							<input type="text"  name = "contact_name" maxlength = "10" 
								size = "15">
							<font color='orange'>*</font>
						</td>	
						<td class="blue">联系人电话 </td>
						<td nowrap >
							<input type="text"  name = "contact_phone" maxlength = "20" 
								size = "30" >
							<font color='orange'>*</font>
						</td>		
					</tr>	
					<%
					if ( opCode.equals("g176") )
					{
					%>					
					<tr>
						<tr  id = "reason_row" >
							<td class="blue">强开原因 </td>
							<td nowrap colspan = "3">
								<textarea name = "force_reason" cols = "100" ></textarea>
								<font color='orange'>*</font>
							</td>		
						</tr>		
					</tr>					
					<%
					}
					else if (opCode.equals("g177"))
					{
					%>
					<tr>
						<tr  id = "reason_row" >
							<td class="blue">强关原因 </td>
							<td nowrap colspan = "3">
								<textarea name = "force_reason" cols = "100" ></textarea>
								<font color='orange'>*</font>
							</td>		
						</tr>		
					</tr>							
					<%
					}
					%>						
		
					<tr> 
						<td  id="footer" colspan='4'>
							<input class="b_foot" type="button" name=nextBtn value="确认"
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
		if ( document.all.opCode.value=='g176' )
		{
			if ( ""==document.all.force_reason.value.trim() )
			{
				rdShowMessageDialog("强开原因不能为空!",0);
				return false;
			}		
			if (document.all.force_reason.value.len() > 120)
			{
				rdShowMessageDialog("强开原因输入太长!");
				return false;
			} 
		}
		else if ( document.all.opCode.value=='g177' )
		{
			if ( ""==document.all.force_reason.value.trim() )
			{
				rdShowMessageDialog("强关原因不能为空!",0);
				return false;
			}		
			if (document.all.force_reason.value.len() > 120)
			{
				rdShowMessageDialog("强关原因输入太长!");
				return false;
			} 
		}
		else
		{
			rdShowMessageDialog("操作代码出错请联系系统管理员!",0);
			return false;			
		}
		
		if (document.all.contact_name.value.trim()=="")
		{
			rdShowMessageDialog("联系人姓名不能为空!",0);
			return false;			
		}
		
		if (document.all.contact_phone.value.trim()=="")
		{
			rdShowMessageDialog("联系人电话不能为空!",0);
			return false;			
		}

		if(rdShowConfirmDialog('确认提交吗？')==1)
		{
			document.frm.action="fG176Cfm.jsp";
			document.frm.submit();
		}
	}

	</script>
</html>
<%
}
%>