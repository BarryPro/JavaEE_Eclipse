<%
/********************
 version v2.0
 ������ si-tech
 create hejwa 2011-7-19 
********************/
%>
              
<%
	String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%
		String regionCode     = (String)session.getAttribute("regCode");
		String function_code  = (String)request.getParameter("function_code");
%>
<script language="javascript" type="text/javascript">
	var windowShow = window.dialogArguments; 
function sub(){
	var packet = new AJAXPacket("favfunc_cfm.jsp");
	packet.data.add("function_code","<%=function_code%>");
	packet.data.add("op_type","i");
	packet.data.add("selCls",document.all.selCls.value);
	core.ajax.sendPacket(packet,doFavfunc);
	packet =null;
}
	
function doFavfunc(packet)
{
	var retCode   = packet.data.findValueByName("retCode");
	var retMsg    = packet.data.findValueByName("retMsg");
	var detailMsg = packet.data.findValueByName("detailMsg");
	windowShow.doFavfuncshow(retCode,retMsg,detailMsg);
	window.close();
}

</script>
<title>�����ղؼ�</title>
</head>

<body onload="" style="overflow-y:auto; overflow-x:hidden;">
	<form  name="frmMain" action="" method="post">
   <DIV id="Operation_Table"> 
 			<div class="title">
					<div id="title_zi">�����ղؼ�</div>
				</div>

			<table cellspacing=0>
				 <tr>
				 	<td class="blue">ѡ�����</td>
				 	<td>
				 		<select name="selCls">
				 			<option value='2'>��ѯ��</option>
				 			<option value='1'>ҵ����</option>
				 			<option value='0'>δ����</option>
				 		</select>
				 	</td>
				</tr>
				<tr>
					<td id="footer" colspan=2>
						<input type="button" value="ȷ��" class="b_foot" onclick="sub()">
						<input type="button" value="�ر�" class="b_foot" onclick="window.close()">
					</td>
				</tr>
			</table>
				 
		</DIV>             
</DIV>
		</form>
	</body>
</html>
 
 
 