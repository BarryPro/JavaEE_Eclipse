
<%
/*
 * ����: g598��EC��Ϣͬ��PBOSS 
 * �汾: 1.0
 * ����: 2012/9/3 11:05:33
 * ����: zhangyan
 * ��Ȩ: si-tech
 * update:
*/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="sLoginAccept"/>
<%
String opCode=request.getParameter("opCode");
String opName=request.getParameter("opName");
String workNo = (String)session.getAttribute("workNo");
String s_passwd = (String)session.getAttribute("password");
%>
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
	<title><%=opCode%></title>
</head>
<body >
	<form  name="frm" action="" method="POST" >
		<input type="hidden" id="hd_opCode" name	="hd_opCode"	value= "<%=opCode%>">
		<input type="hidden" id="hd_opName" name	="hd_opName"	value= "<%=opName%>">
		<input type="hidden" id="hd_chkFlag" name	="hd_chkFlag"	value= "0">
		<%@ include file="/npage/include/header.jsp" %>

		<DIV id="Operation_Table">

			<div class="title">
				<div id="title_zi"><%=opName%></div>
			</div>
			<table>
				<tr>
					<td class="blue" align="center">���ű��:</th>
					<td>
						<input type="text" id="t_unitId" name="t_unitId" size="20" />	
					</td>	
					<td class="blue" align="center">EC���ſͻ�����:</th>
					<td>
						<input type="text" id="t_customerNumber" name="t_customerNumber"  size="20" />	
					</td>	
				<tr>
				</tr>
					<td class="blue" align="center">��������:</th>
					<td>
						<select name="s_oprType" id="s_oprType">
							<option value="$$$$$$">---��ѡ��---</option>
							<option value="01">01-->����</option>
							<option value="02">02-->���</option>
							<option value="03">03-->ɾ��</option>
						</select>
					</td>
					<td class="blue" align="center">���ſͻ�����:</th>
					<td>
						<input type="text" id="t_unitName" name="t_unitName" disabled  size="40"/>	
					</td>	
									
				</tr>			
			</table>

			<table>
				<tr> 
					<td  id="footer">
						<input class="b_foot" type="button" name=btnChk value="У��"
							onClick="fn_chkIfo();">
						<input class="b_foot" type="button" name=btnCfm value="ͬ��"
							onClick="fn_cfm();">
						<input class="b_foot" type="button" name=btnClr value="���"
							onClick="clrFrm();">
						<input class="b_foot" type="button" name=btnCls value="�ر�"
							onClick="removeCurrentTab();">								
					</td>
				</tr>
			</table>	
		</div>
	</form>
</body>
<script type="text/javascript">		
	function clrFrm()
	{
		document.all.t_unitId.value="";	
		document.all.t_customerNumber.value="";	
		document.all.t_unitName.value="";	
		document.all.s_oprType[0].selected=true;	
		document.all.hd_chkFlag.value="0";
		
		document.all.t_unitId.disabled=false;
		document.all.t_customerNumber.disabled=false;
		document.all.s_oprType.disabled=false;
	}
	
	function fn_cfm()
	{	
		if ( "0"==document.all.hd_chkFlag.value )
		{
			rdShowMessageDialog("����У�鼯����Ϣ�����ͬ��!",0);	
			return false;
		}
		
		if ("$$$$$$"==document.all.s_oprType.value)
		{
			rdShowMessageDialog("�������ͱ���ѡ��!",0);	
			return false;
		}
		document.all.btnCfm.disabled=true;
		
		document.all.t_unitId.disabled=false;
		document.all.t_customerNumber.disabled=false;
		document.all.t_unitName.disabled=false;
		document.all.s_oprType.disabled=false;
		
		var packet = new AJAXPacket("f_g598_ajax.jsp","���Ժ�...");
		packet.data.add("iLoginAccept" 		,"<%=sLoginAccept%>");
		packet.data.add("iOpCode" 			,"<%=opCode%>");
		packet.data.add("iLoginNo" 			,"<%=workNo%>");
		packet.data.add("iLoginPwd" 		,"<%=s_passwd%>");
		packet.data.add("iPhoneNo" 			,"");
		packet.data.add("iUserPwd" 			,"");
		packet.data.add("iUnitId" 			,document.all.t_unitId.value);
		packet.data.add("iCustomerNumber"	,document.all.t_customerNumber.value);
		packet.data.add("iOpType"			,document.all.s_oprType.value);
		packet.data.add("ajaxType"			,"fn_doCfm");

		core.ajax.sendPacket(packet		,fn_doCfm,true);//�첽
		packet =null;	

	}
	
	function fn_doCfm(packet)
	{
		var v_oRetCode=packet.data.findValueByName("oRetCode");
		var v_oRetMsg=packet.data.findValueByName("oRetMsg");
		if ( "000000"==v_oRetCode )
		{
			rdShowMessageDialog(v_oRetCode+":"+v_oRetMsg , 2);
		}
		else
		{
			rdShowMessageDialog(v_oRetCode+":"+v_oRetMsg , 0);			
		}

		removeCurrentTab();
	}
	
	function fn_chkIfo()
	{
		if ( ""==document.all.t_unitId.value && ""==document.all.t_customerNumber.value )
		{
			rdShowMessageDialog("���ű�ź�EC���ſͻ��������������һ����У��" , 0);
			return false;
		}
		
		if ("$$$$$$"==document.all.s_oprType.value)
		{
			rdShowMessageDialog("�������ͱ���ѡ��!",0);	
			return false;
		}
		
		var packet = new AJAXPacket("f_g598_ajax.jsp","���Ժ�...");
		packet.data.add("iLoginAccept" 		,"<%=sLoginAccept%>");
		packet.data.add("iOpCode" 			,"<%=opCode%>");
		packet.data.add("iLoginNo" 			,"<%=workNo%>");
		packet.data.add("iLoginPwd" 		,"<%=s_passwd%>");
		packet.data.add("iPhoneNo" 			,"");
		packet.data.add("iUserPwd" 			,"");
		packet.data.add("iUnitId" 			,document.all.t_unitId.value);
		packet.data.add("iCustomerNumber"	,document.all.t_customerNumber.value);
		packet.data.add("iOpType"			,document.all.s_oprType.value);
		packet.data.add("ajaxType"			,"fn_chkIfo");

		core.ajax.sendPacket(packet		,fn_doChkIfo,true);//�첽
		packet =null;
	}
	
	function fn_doChkIfo(packet)
	{
		var v_oRetCode=packet.data.findValueByName("oRetCode");
		var v_oRetMsg=packet.data.findValueByName("oRetMsg");
		document.all.hd_chkFlag.value="0";
		
		if ( "000000"!=v_oRetCode )
		{
			rdShowMessageDialog(v_oRetCode+":"+v_oRetMsg , 0);
			return false;
		}
		else
		{
			document.all.t_unitId.value=packet.data.findValueByName("oUnitId");
			document.all.t_customerNumber.value=packet.data.findValueByName("oCustomerNumber");
			document.all.t_unitName.value=packet.data.findValueByName("oCustomerName");
			
			document.all.t_unitId.disabled=true;
			document.all.t_customerNumber.disabled=true;
			document.all.t_unitName.disabled=true;
			document.all.s_oprType.disabled=true;
			document.all.hd_chkFlag.value="1";
		}
	}
</script>
</html>
