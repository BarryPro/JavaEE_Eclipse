<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>

<%
String s_retIfo="";

String s_workNo=(String)session.getAttribute("workNo");
String s_passwd=(String)session.getAttribute("password");
String s_opCode=request.getParameter("hd_opCode");
String s_orgId=(String)session.getAttribute("orgId");
String s_groupId=(String)session.getAttribute("groupId");
String s_classCode=request.getParameter("s_classCode");
String s_servCode=request.getParameter("hd_bizType");
String oldProdId=request.getParameter("oldProdId");
String unitUsrId=request.getParameter("unitUsrId");
String s_powerRight = ((String)session.getAttribute("powerRight")).trim();
String s_regCode = ((String)session.getAttribute("regCode")).trim();
%>
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
	<title></title>
		<script language="javascript" type="text/javascript" src="/npage/public/zalidate.js"></script>
</head>
<body>
<form method="POST" action = "" name="frm">
<DIV id="Operation_Table">
	<div class="title">
		<div id="title_zi">附加产品信息</div>
	</div>
	<table	id="productInfo" style="display:block">
		<tr>
			<td align="center" >附加产品编号</td>
			<td >
				<input type="text" readOnly class="InputGrey" name="prodAId" id="prodAId" ch_name="附加产品编号">
				<input type="button" value="查询" class="b_text" onclick="fn_qryProdAdd();">
			</td>
			<td align="center" >附加产品名称</td>
			<td >
				<input type="text"  readOnly class="InputGrey" name="prodAName"  id="prodAName">
			</td>
		</tr>	
		<tr>
			<td align="center" >产品编码</td>
			<td >
				<input type="text"  readOnly class="InputGrey" name="prodId" id="prodId" >
			</td>
			<td align="center" >归属产品编码</td>
			<td  >
				<input type="text"  readOnly class="InputGrey" name="prdPkgId"  id="prdPkgId">
			</td>
		</tr>								
		<tr>
			<td align="center" >产品订购实例</td>
			<td colspan="3">
				<input type="text" name="t_prodInstID" id="t_prodInstID" readOnly class="InputGrey" ch_name="产品订购实例">
				<input type="button" value="获取" class="b_text" name="b_prodInstID" onclick ="fn_getProdInstID()">
			</td>
		</tr>			
	</table>
	<div class="title">
		<div id="title_zi">产品附加属性</div>
	</div>
	<div id="queryDiv"></div>
	<div class="title">
		<div id="title_zi">产品服务附加属性</div>
	</div>		
	<div id="queryDiv1"></div>
	<table>
		<tr> 
			<td  id="footer">
				<input class="b_foot" type="button" name="b_cls" value="确认"
					onClick="fn_cfmProd()">								
				<input class="b_foot" type="button" name="b_cls" value="取消"
					onClick="window.close();">								
			</td>
		</tr>
	</table>		
</div>
<script>
function fn_getProdInstID()
{
	var packet = new AJAXPacket("f_g667_ajax.jsp","请稍后...");
	packet.data.add("iLoginAccept" 		,"");
	packet.data.add("iOpCode" 			,"<%=s_opCode%>");
	packet.data.add("iLoginNo" 			,"<%=s_workNo%>");
	packet.data.add("iLoginPwd" 		,"<%=s_passwd%>");
	packet.data.add("iPhoneNo" 			,"");
	packet.data.add("iUserPwd" 			,"");
	packet.data.add("ajaxType"			,"fn_doGetProdInst");

	core.ajax.sendPacket(packet		,fn_doGetProdInst,true);//异步		
}
function fn_doGetProdInst(packet)
{
	var v_oRetCode=packet.data.findValueByName("oRetCode");
	var v_oRetMsg=packet.data.findValueByName("oRetMsg");
	if ( "000000"==v_oRetCode )
	{
		document.all.t_prodInstID.value=packet.data.findValueByName("outSeq");
		document.all.b_prodInstID.disabled=true;
	}
	else
	{
		rdShowMessageDialog(v_oRetCode+":"+v_oRetMsg , 0);	
		document.all.b_prodInstID.disabled=false;		
	}

}		
	
function fn_qryProdAdd()
{
	var s_retIfo=window.showModalDialog("f_g667_addAtt.jsp"
		+"?hd_loginacc="
		+"&hd_chnSrc="
		+"&hd_opCode=<%=s_opCode%>"
		+"&hd_workNo=<%=s_workNo%>"
		+"&hd_passwd=<%=s_passwd%>"
		+"&hd_phone="
		+"&hd_userPwd="
		+"&hd_bizType=<%=s_servCode%>"
		+"&oldProdId=<%=oldProdId%>"
		+"&unitUsrId=<%=unitUsrId%>"
		+"&s_classCode=<%=s_classCode%>"
		,"","dialogWidth=800px;dialogHeight=600px");		

	if ( typeof ( s_retIfo )!="undefined" )
	{
		$("#prodAId").val( s_retIfo.split("@")[0] );
		$("#prodAName").val( s_retIfo.split("@")[1] );
		$("#prodId").val( s_retIfo.split("@")[2] );
		$("#prdPkgId").val( s_retIfo.split("@")[3] );
	}	
	
	var packet = new AJAXPacket("f_g667_ajax.jsp","请稍后...");
	packet.data.add("ajaxType"		,"doGetProdAA");
	packet.data.add("s_accept"		,"");
	packet.data.add("s_chnSrc"		,"01");
	packet.data.add("s_opCode"		,"<%=s_opCode%>");
	packet.data.add("s_workNo"		,"<%=s_workNo%>");
	packet.data.add("s_passwd"		,"<%=s_passwd%>");
	packet.data.add("s_phoNo"		,"");
	packet.data.add("s_usrPwd"		,"");
	packet.data.add("s_offerId"		,$("#prodAId").val());
	packet.data.add("s_entType"		,$("#prodId").val());
	
	core.ajax.sendPacketHtml(packet		,fn_doGetProdAA);//异步
	packet =null;
	
	
	
}	
function fn_doGetProdAA( data )
{
	$("#queryDiv").empty();
	$("#queryDiv").append(data);
	fn_doGetProdAAOne();
}

function fn_doGetProdAAOne(  )
{
	var packet1 = new AJAXPacket("f_g667_ajax1.jsp","请稍后...");
	packet1.data.add("ajaxType"		,"doGetProdAA");
	packet1.data.add("s_accept"		,"");
	packet1.data.add("s_chnSrc"		,"01");
	packet1.data.add("s_opCode"		,"<%=s_opCode%>");
	packet1.data.add("s_workNo"		,"<%=s_workNo%>");
	packet1.data.add("s_passwd"		,"<%=s_passwd%>");
	packet1.data.add("s_phoNo"		,"");
	packet1.data.add("s_usrPwd"		,"");
	packet1.data.add("s_offerId"		,$("#prodAId").val());
	packet1.data.add("s_entType"		,$("#prodId").val());
	
	core.ajax.sendPacketHtml(packet1		,fn_doGetProdAA1);//异步
	packet1 =null;
}

function fn_doGetProdAA1( data )
{
	$("#queryDiv1").empty();
	$("#queryDiv1").append(data);
}

$(document).ready(
	function ()
	{
		$("#Operation_Table").show("slow");
	}
);	

function fn_cfmProd()
{
	if ( fn_notNull( document.all.t_prodInstID )!=0 ) return false;
	if ( fn_notNull( document.all.prodAId )!=0 ) return false;
	for (var i=0;i<document.getElementsByName("t_needsCode").length;i++)
	{
		if ( "1"==document.getElementsByName("t_needsCode")[i].value.trim()  )
		{
			if ( fn_notNull( document.getElementsByName("t_prodAADef")[i] )!=0 ) return false;
		}
	}
	for (var i=0;i<document.getElementsByName("t_needsCode_1").length;i++)
	{
		if ( "1"==document.getElementsByName("t_needsCode_1")[i].value.trim()  )
		{
			if ( fn_notNull( document.getElementsByName("t_prodAADef_1")[i] )!=0 ) return false;
		}
	}
	
	var s_prodifo=$("#prodAId").val()+"@"
		+$("#prodId").val()+"@"
		+$("#prdPkgId").val()+"@"	
		+$("#t_prodInstID").val()+"@"	
		+"@"	
		+$("#prodAName").val()+"@"
		
	var aProdAtt="";
	for ( var i=0;i<document.getElementsByName("t_prodAAServId").length;i++ )
	{
		aProdAtt=aProdAtt+document.getElementsByName("t_prodAAServId")[i].value+"@";
	}
	
	aProdAtt = aProdAtt.substr(0,aProdAtt.length-1)+"~";
	for (  var i=0;i<document.getElementsByName("t_prodAAId").length;i++ )
	{
		aProdAtt=aProdAtt+document.getElementsByName("t_prodAAId")[i].value+"@";
	}
	
	aProdAtt = aProdAtt.substr(0,aProdAtt.length-1)+"~";
	for (  var i=0;i<document.getElementsByName("t_prodAADef").length;i++ )
	{
		aProdAtt=aProdAtt+document.getElementsByName("t_prodAADef")[i].value+"@";
	}
	
	aProdAtt = aProdAtt.substr(0,aProdAtt.length-1)+"~";
	for (  var i=0;i<document.getElementsByName("t_prodAAIfNeeds").length;i++ )
	{
		aProdAtt=aProdAtt+document.getElementsByName("t_prodAAIfNeeds")[i].value+"@";
	}	
	aProdAtt = aProdAtt.substr(0,aProdAtt.length-1)
	/*产品服务附加属性start*/
	var aProdAtt_1="";
	for ( var i=0;i<document.getElementsByName("t_prodAAServId_1").length;i++ )
	{
		aProdAtt_1=aProdAtt_1+document.getElementsByName("t_prodAAServId_1")[i].value+"@";
	}
	
	aProdAtt_1 = aProdAtt_1.substr(0,aProdAtt_1.length-1)+"~";
	for (  var i=0;i<document.getElementsByName("t_prodAAId_1").length;i++ )
	{
		aProdAtt_1=aProdAtt_1+document.getElementsByName("t_prodAAId_1")[i].value+"@";
	}
	
	aProdAtt_1 = aProdAtt_1.substr(0,aProdAtt_1.length-1)+"~";
	for (  var i=0;i<document.getElementsByName("t_prodAADef_1").length;i++ )
	{
		aProdAtt_1=aProdAtt_1+document.getElementsByName("t_prodAADef_1")[i].value+"@";
	}
	
	aProdAtt_1 = aProdAtt_1.substr(0,aProdAtt_1.length-1)+"~";
	for (  var i=0;i<document.getElementsByName("t_prodAAIfNeeds_1").length;i++ )
	{
		aProdAtt_1=aProdAtt_1+document.getElementsByName("t_prodAAIfNeeds_1")[i].value+"@";
	}	
	aProdAtt_1 = aProdAtt_1.substr(0,aProdAtt.length-1)
	/*产品服务附加属性end*/	
	window.returnValue =s_prodifo+"|"+aProdAtt+"|"+aProdAtt_1;
	window.close();
}
</script>
</form>
</body>
</html>
