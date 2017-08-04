<%
/*********************
 * 版本: 1.0
 * 作者: zhangyan
**********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="sLoginAccept"/>
<%
String s_loginacc= sLoginAccept;
String s_chnSrc="01";
String opCode=request.getParameter("opCode");
String opName=request.getParameter("opName");
String s_workNo = (String)session.getAttribute("workNo");
String s_passwd = (String)session.getAttribute("password");
String s_regCode = (String)session.getAttribute("regCode");
%>    
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/zalidate.js"></script>
	<script src="../public/json2.js" type="text/javascript"></script>    
	<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
</head>
<body >
<form  name="frm" action="" method="POST" >
<DIV id="Operation_Table">
	<div id="d0" name="d0" style="display:none">
		<div class="title" >
			<div id="title_zi"><%=opName%></div>
		</div>
		<table>
			<tr>
				<td class="blue" align="center" width="25%">地市:</td>
				<td width="25%">
					<select id='reg_code' name = 'reg_code' onchange='doQry()'>
						<option value='$$$$$$'>---请选择---</option>
						<wtc:qoption name="TlsPubSelCrm" outnum="2">
							<wtc:sql>
								SELECT GROUP_ID, GROUP_ID || '-->' || GROUP_NAME
								FROM DCHNGROUPMSG T
								WHERE T.ROOT_DISTANCE = '2'
								AND T.CLASS_CODE = '6'
							</wtc:sql>
						</wtc:qoption>
					</select>			
				</td>    
				<td class="blue" align="center">手机号码: </td>
				<td width="25%">
					<input type="text" id='pho_no' name='pho_no' ch_name='手机号码' maxLength="" value='' />    
				</td>    
			<tr> 
			<tr>
				<td colspan="4" align="center" id="footer">
					<input type="button" id="" name="" class="b_foot" value="增加" onClick="doAdd()" />    
					<input type="button" id="" name="" class="b_foot" value="重置" onClick="doRet()" />   
					<input type="button" id="" name="" class="b_foot" value="关闭" onClick="removeCurrentTab();" />
				</td>
			</tr>        
		</table>
	</div>	
	<div id="queryDiv"></div>	
</DIV>
<INPUT TYPE = 'HIDDEN' ID = 'hd_loginacc' NAME ='hd_loginacc' VALUE = '<%=sLoginAccept%>' >
<INPUT TYPE = 'HIDDEN' ID = 'hd_opCode' NAME ='hd_opCode' VALUE = '<%=opCode%>' >
<INPUT TYPE = 'HIDDEN' ID = 'hd_opName' NAME ='hd_opName' VALUE = '<%=opName%>' >
<INPUT TYPE = 'HIDDEN' ID = 'del_pho' NAME ='del_pho' VALUE = '' >
<INPUT TYPE = 'HIDDEN' ID = 'del_reg' NAME ='del_reg' VALUE = '' >
</form>
<script>
var stepNum=0;
$(document).ready(
	function ()
	{
		$("#d0").show("slow");
		stepNum=stepNum+1;
	}
);
function doAdd()
{
	if ( fn_notNull( document.all.pho_no )!=0) return false;
	if ( fn_notNull( document.all.reg_code )!=0) return false;
	document.frm.action="fg888_add.jsp";
	document.frm.submit();
}
function doQry()
{
	var packet = new AJAXPacket("fg888_qry.jsp","请稍后...");

	packet.data.add("ajaxType"        ,"setQry");
	packet.data.add("s_accept"        ,"");
	packet.data.add("s_chnSrc"        ,"01");
	packet.data.add("s_opCode"        ,"<%=opCode%>");
	packet.data.add("s_workNo"        ,"<%=s_workNo%>");

	packet.data.add("s_passwd"        ,"<%=s_passwd%>");
	packet.data.add("s_phoNo"        ,"");
	packet.data.add("s_usrPwd"        ,"");
	packet.data.add("reg_code"        ,$("#reg_code").val());
	packet.data.add("pho_no"        ,$("#pho_no").val());

	core.ajax.sendPacketHtml(packet , getQry);//异步
	packet =null;
}


//ajax返回html
function getQry( data )
{
	$("#queryDiv").empty();
	$("#queryDiv").append(data);
}

function doDel( i )
{
	document.all.del_pho.value=document.getElementsByName("qry_pho_no")[i].value;
	document.all.del_reg.value=document.getElementsByName("qry_reg_code")[i].value;
	
	document.frm.action="fg888_del.jsp";
	document.frm.submit();
}

</script>
</body>
</html>

