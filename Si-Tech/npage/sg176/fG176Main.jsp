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
String iLoginAccept=""; 	/*������ˮ*/
String iChnSource="01"; 		/*������ʾ*/
String iOpCode=request.getParameter("opCode"); 		/*��������*/
String iLoginNo=(String)session.getAttribute("workNo"); 		/*��������*/
String iLoginPwd=(String)session.getAttribute("password"); 		/*��������*/
String iPhoneNo=""; 		/*��Ա����*/
String iUserPwd=""; 		/*��������*/
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
<!--������ˮ-->
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
						<td class="blue">���ű��� </td>
						<td nowrap >
							<input type="text"  name = "vUnitId" class='InputGrey' readOnly
								value="<%=result[0][0]%>" >
						</td>	
						<td class="blue">�������� </td>
						<td nowrap >
							<input type="text"  name = "vUnitName" class='InputGrey' readOnly
								value="<%=result[0][1]%>">
						</td>		
					</tr>	
					<tr  >
						<td class="blue">��Ʒ���� </td>
						<td nowrap >
							<input type="text"  name = "vOfferName"  class='InputGrey' readOnly
								value="<%=result[0][2]%>"> 
							</td>	
						<td class="blue">״̬ </td>
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
						<td class="blue">ǿ����ʼʱ�� </td>
						<td nowrap >
							<input type="text"  name = "vBeginTime"  class='InputGrey' readOnly
								value="<%=result[0][5]%>" >
						</td>	
						<td class="blue">ǿ������ʱ�� </td>
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
						<td class="blue">ǿ�ؿ�ʼʱ�� </td>
						<td nowrap >
							<input type="text"  name = "vBeginTime"   class='InputGrey' readOnly
								value="<%=result[0][5]%>" >
						</td>	
						<td class="blue">ǿ�ؽ���ʱ�� </td>
						<td nowrap >
							<input type="text"  name = "vEndTime"  class='InputGrey' readOnly
								value="<%=result[0][6]%>">
						</td>		
					</tr>							
					<%
					}
					%>	
					
										
					<tr id = "contact_row" >
						<td class="blue">��ϵ������ </td>
						<td nowrap >
							<input type="text"  name = "contact_name" maxlength = "10" 
								size = "15">
							<font color='orange'>*</font>
						</td>	
						<td class="blue">��ϵ�˵绰 </td>
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
							<td class="blue">ǿ��ԭ�� </td>
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
							<td class="blue">ǿ��ԭ�� </td>
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
							<input class="b_foot" type="button" name=nextBtn value="ȷ��"
								onClick="nextStep();">
							<input class="b_foot" type="button" name=clsBtn value="�ر�"
								onClick="removeCurrentTab();">								
						</td>
					</tr>
				</table>	
			</div>
		</form>
	</body>
	<script type="text/javascript">		
		
	/*����������*/
	function nextStep()
	{
		if ( document.all.opCode.value=='g176' )
		{
			if ( ""==document.all.force_reason.value.trim() )
			{
				rdShowMessageDialog("ǿ��ԭ����Ϊ��!",0);
				return false;
			}		
			if (document.all.force_reason.value.len() > 120)
			{
				rdShowMessageDialog("ǿ��ԭ������̫��!");
				return false;
			} 
		}
		else if ( document.all.opCode.value=='g177' )
		{
			if ( ""==document.all.force_reason.value.trim() )
			{
				rdShowMessageDialog("ǿ��ԭ����Ϊ��!",0);
				return false;
			}		
			if (document.all.force_reason.value.len() > 120)
			{
				rdShowMessageDialog("ǿ��ԭ������̫��!");
				return false;
			} 
		}
		else
		{
			rdShowMessageDialog("���������������ϵϵͳ����Ա!",0);
			return false;			
		}
		
		if (document.all.contact_name.value.trim()=="")
		{
			rdShowMessageDialog("��ϵ����������Ϊ��!",0);
			return false;			
		}
		
		if (document.all.contact_phone.value.trim()=="")
		{
			rdShowMessageDialog("��ϵ�˵绰����Ϊ��!",0);
			return false;			
		}

		if(rdShowConfirmDialog('ȷ���ύ��')==1)
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