<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>

<%
String s_opCode=request.getParameter("hd_opCode");
String s_opName=request.getParameter("hd_opName");
String s_accept=request.getParameter("hd_accept");
String s_regCode=(String)session.getAttribute("regCode");
String s_workNo=(String)session.getAttribute("workNo");
String s_passwd=(String)session.getAttribute("password");
String s_orgId=(String)session.getAttribute("orgId");
String s_groupId=(String)session.getAttribute("groupId");

String s_iextCode= request.getParameter("s_servCode");
String s_custId=request.getParameter("t_custId");
String s_offerId=request.getParameter("hd_offerId");

String s_classCode=request.getParameter("classCode");
String s_servCode=request.getParameter("s_servCode");
String s_entType=request.getParameter("t_entType");
/*
 *@        iExternalCode        业务唯一标示
 *@        iCustId              集团客户ID
 *@        iOpType              操作类型：u01
 *@        iOfferId             物联网产品主资费
 */
%>
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
	<title><%=s_opName%></title>
		<script language="javascript" type="text/javascript" src="/npage/public/zalidate.js"></script>
</head>
<body>
<form method="post" action = "" name="frm">
<div id="Operation_Title">
	<div class="icon"></div>
		<B><%=s_opName%></B>
</div>

<DIV id="Operation_Table">
	<div class="title">
		<div id="title_zi">附加产品信息</div>
	</div>
	<table	id="productInfo" style="display:block">
		<tr>
			<td align="center" >附加产品编号</td>
			<td >
				<input type="text" readOnly class="InputGrey" name="prodAId" ch_name="附加产品编号">
				<input type="button" value="查询" class="b_text" onclick="fn_qryProdAdd();">
			</td>
			<td align="center" >附加产品名称</td>
			<td >
				<input type="text"  readOnly class="InputGrey" name="prodAName">
			</td>
		</tr>	
		<tr>
			<td align="center" >产品编码</td>
			<td >
				<input type="text"  readOnly class="InputGrey" name="prodId">
			</td>
			<td align="center" >归属产品编码</td>
			<td  >
				<input type="text"  readOnly class="InputGrey" name="prdPkgId">
			</td>
		</tr>								
		<tr>
			<td align="center" >产品订购实例</td>
			<td colspan="3">
				<input type="text" name="t_prodInstID" readOnly class="InputGrey" ch_name="产品订购实例">
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
	var packet = new AJAXPacket("f_g599_ajax.jsp","请稍后...");
	packet.data.add("iLoginAccept" 		,"<%=s_accept%>");
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
function fn_cfmProd(){
	if ( fn_notNull( document.all.t_prodInstID )!=0 ) return false;
	if ( fn_notNull( document.all.prodAId )!=0 ) return false;
	
	for (var i=0;i<document.getElementsByName("t_needsCode").length;i++){
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
	
	/*
	附加产品|产品属性
	aprod1@aprod2@aprod3|aprodid1@aprodid2@aprodid3~
	
	附加产品编号@产品编码@归属产品编码@产品订购实例@用户唯一标识
	*/
	
	var aProd=document.all.prodAId.value
		+"@"+document.all.prodId.value
		+"@"+document.all.prdPkgId.value
		+"@"+document.all.t_prodInstID.value
		+"@"
		+"@"+document.all.prodAName.value;
		/*	*/
	var aProdAtt="";
	if("0"==document.getElementsByName("t_prodAAServId").length)
	{
		aProdAtt="";
	}
	else
	{
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
	}
	
	var aProdAtt1="";
	if("0"==document.getElementsByName("t_prodAAServId_1").length)
	{
		aProdAtt1="";
	}
	else
	{
		for ( var i=0;i<document.getElementsByName("t_prodAAServId_1").length;i++ )
		{
			aProdAtt1=aProdAtt1+document.getElementsByName("t_prodAAServId_1")[i].value+"@";
		}
		
		aProdAtt1 = aProdAtt1.substr(0,aProdAtt1.length-1)+"~";
		for (  var i=0;i<document.getElementsByName("t_prodAAId_1").length;i++ )
		{
			aProdAtt1=aProdAtt1+document.getElementsByName("t_prodAAId_1")[i].value+"@";
		}
		
		aProdAtt1 = aProdAtt1.substr(0,aProdAtt1.length-1)+"~";
		for (  var i=0;i<document.getElementsByName("t_prodAADef_1").length;i++ )
		{
			aProdAtt1=aProdAtt1+document.getElementsByName("t_prodAADef_1")[i].value+"@";
		}
		
		aProdAtt1 = aProdAtt1.substr(0,aProdAtt1.length-1)+"~";
		for (  var i=0;i<document.getElementsByName("t_prodAAIfNeeds_1").length;i++ )
		{
			aProdAtt1=aProdAtt1+document.getElementsByName("t_prodAAIfNeeds_1")[i].value+"@";
		}
		
		aProdAtt1 = aProdAtt1.substr(0,aProdAtt1.length-1)
	}
 
	window.returnValue =aProd+"|"+aProdAtt+"|"+aProdAtt1;
	window.close();
}
	
function fn_qryProdAdd()
{	
	var retStr=window.showModalDialog("f_g599_qryProdAdd.jsp"
		+"?s_accept=<%=s_accept%>"
		+"&s_opCode=<%=s_opCode%>"
		+"&s_iextCode=<%=s_iextCode%>"
		+"&s_custId=<%=s_custId%>"
		+"&s_offerId=<%=s_offerId%>"
		+"&s_opName=<%=s_opName%>"
		+"&classCode=<%=s_classCode%>"
		+"&s_servCode=<%=s_servCode%>"
		,"","dialogWidth=800px;dialogHeight=600px");	
	if (typeof (retStr)=="undefined")
	{
		return false;
	}
	
	document.all.prodAId.value=retStr.split("@")[0];	
	document.all.prodAName.value=retStr.split("@")[1];	
	document.all.prodId.value=retStr.split("@")[2];	
	document.all.prdPkgId.value=retStr.split("@")[3];

	var packet = new AJAXPacket("f_g599_ajax.jsp","请稍后...");
	packet.data.add("ajaxType"		,"doGetProdAA");
	packet.data.add("s_accept"		,"<%=s_accept%>");
	packet.data.add("s_chnSrc"		,"01");
	packet.data.add("s_opCode"		,"<%=s_opCode%>");
	packet.data.add("s_workNo"		,"<%=s_workNo%>");
	packet.data.add("s_passwd"		,"<%=s_passwd%>");
	packet.data.add("s_phoNo"		,"");
	packet.data.add("s_usrPwd"		,"");
	packet.data.add("s_offerId"		,document.all.prodAId.value);
	packet.data.add("s_entType"		,document.all.prodId.value);

	core.ajax.sendPacketHtml(packet,fn_doGetProdAA);//异步
	packet =null;
}
	
function fn_doGetProdAA(data){
	$("#queryDiv").empty();
	$("#queryDiv").append(data);
	fn_qryProdAdd1();
}

function fn_qryProdAdd1(){	
	var packet = new AJAXPacket("f_g599_ajax1.jsp","请稍后...");
	packet.data.add("ajaxType"		,"doGetProdAA");
	packet.data.add("s_accept"		,"<%=s_accept%>");
	packet.data.add("s_chnSrc"		,"01");
	packet.data.add("s_opCode"		,"<%=s_opCode%>");
	packet.data.add("s_workNo"		,"<%=s_workNo%>");
	packet.data.add("s_passwd"		,"<%=s_passwd%>");
	packet.data.add("s_phoNo"		,"");
	packet.data.add("s_usrPwd"		,"");
	packet.data.add("s_offerId"		,document.all.prodAId.value);
	packet.data.add("s_entType"		,document.all.prodId.value);

	core.ajax.sendPacketHtml(packet,fn_doGetProdAA1);//异步
	packet =null;
}
	
function fn_doGetProdAA1(data){
	$("#queryDiv1").empty();
	$("#queryDiv1").append(data);
}

function fn_selProdIfo()
{
	if (document.all.prodAId.value.trim()=="")
	{
		rdShowMessageDialog("必须查询附加产品信息",0);
		return false;
	}
	window.returnValue =document.all.r_prodIfo.value;
	window.close();
}
</script>
</form>
</body>
</html>
