<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>

<%
String s_regCode=(String)session.getAttribute("regCode");

String s_loginacc=request.getParameter("s_loginacc");
String s_chnSrc=request.getParameter("s_chnSrc");
String s_opCode=request.getParameter("s_opCode");
String s_workNo=request.getParameter("s_workNo");
String s_passwd=request.getParameter("s_passwd");
String s_phone=request.getParameter("s_phone");
String s_userPwd=request.getParameter("s_userPwd");
String s_unitId = request.getParameter("s_unidId");
String s_prodId = request.getParameter("s_prodId");
String s_unitOffer = request.getParameter("s_unitOffer");
String r_opType=request.getParameter("r_opType");
%>


<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>	
	<script language="javascript" type="text/javascript" src="/npage/public/zalidate.js"></script>
</head>
<body>
<form method="POST" action = "" name="frm">

<DIV id="Operation_Table">
	<div class="title" id="d_prodIfo" style="display:none" >
		<div id="title_zi">原子产品信息</div>
	</div>
	<table	id="tb_prodIfo" style="display:none">
		<tr>
			<td class="blue" align="center">原子产品资费编号:</th>
			<td>
				<input type="text" ch_name="原子产品资费编号" name="t_bsOfrId" id="t_bsOfrId"/>	
				<input type="button" class="b_text" value="查询" onclick="fn_qryBsProd()"/>	
			</td>	
			<td class="blue" align="center">原子产品资费名称:</th>
			<td>
				<input type="text" ch_name="原子产品资费名称"  name="t_bsOfrNm" id="t_bsOfrNm"/>	
			</td>	
		</tr>
		<tr>
			<td class="blue" align="center">原子产品编码:</th>
			<td>
				<input type="text" ch_name="原子产品编码" name="t_bsProdId"  id="t_bsProdId"/>	
			</td>	
			<td class="blue" align="center">归属产品包编码:</th>
			<td>
				<input type="text" ch_name="归属产品包编码" name="t_bsProdPkgId"  id="t_bsProdPkgId"/>	
			</td>	
		</tr>
		<tr id='tr_prodOdId' >
			<td class="blue" align="center">产品订购实例唯一标识:</th>
			<td colspan="3">
				<input type="text" ch_name="产品订购实例唯一标识" name="t_prodBsId" id="t_prodBsId" class='InputGrey' readOnly />
				<input type="button" class="b_text" value="获取" name='b_prodBsId' onclick='fn_getOrdId()' />		
			</td>	
		</tr>		
	</table>		
	
	<div class="title" id="d_addAtt" style="display:none" >
		<div id="title_zi">产品附加属性</div>
	</div>	
	<div id="d_addAtt2" style="display:none"></div>
	
	<div class="title" id="d_addAttOne" style="display:none" >
		<div id="title_zi">产品服务附加属性</div>
	</div>	
	<div id="d_addAtt2One" style="display:none"></div>

	<table id="tb_next" style="display:none">
		<tr> 
			<td  id="footer">
				<input class="b_foot" type="button" name="b_cls" value="确定"
					onClick="fn_next();">					
				<input class="b_foot" type="button" name="b_cls" value="关闭"
					onClick="window.close();">								
			</td>
		</tr>
	</table>		
</div>
<script>
var stepNum=0;
/**/
$(document).ready(
	function()
	{
		$("#d_prodIfo").show("slow");	
		$("#tb_prodIfo").show("slow");	
		$("#tb_next").show("slow");	
		stepNum=1;
		
		if ("1"=="<%=r_opType%>")
		{
			$("#tr_prodOdId").hide();	
		}
	}
);

function fn_getOrdId()
{
	var packet = new AJAXPacket("f_g663_ajax.jsp","请稍后...");
	packet.data.add("iLoginAccept" 		,"");
	packet.data.add("iOpCode" 			,"<%=s_opCode%>");
	packet.data.add("iLoginNo" 			,"<%=s_workNo%>");
	packet.data.add("iLoginPwd" 		,"<%=s_passwd%>");
	packet.data.add("iPhoneNo" 			,"");
	packet.data.add("iUserPwd" 			,"");
	packet.data.add("ajaxType"			,"fn_doGetProdInst");

	core.ajax.sendPacket(packet		,fn_doGetOrdId,true);//异步			
}

function fn_doGetOrdId(packet)
{
	var v_oRetCode=packet.data.findValueByName("oRetCode");
	var v_oRetMsg=packet.data.findValueByName("oRetMsg");
	if ( "000000"==v_oRetCode )
	{
		document.all.t_prodBsId.value=packet.data.findValueByName("outSeq");
		document.all.b_prodBsId.disabled=true;
	}
	else
	{
		rdShowMessageDialog(v_oRetCode+":"+v_oRetMsg , 0);	
		document.all.b_prodBsId.disabled=false;		
	}		
}

function fn_qryBsProd()
{
	var s_bsProd=window.showModalDialog("f_g663_bsProdQry.jsp"
		+"?s_loginacc=<%=s_loginacc%>"
		+"&s_chnSrc=<%=s_chnSrc%>"
		+"&s_opCode=<%=s_opCode%>"
		+"&s_workNo=<%=s_workNo%>"
		+"&s_passwd=<%=s_passwd%>"
		+"&s_phone=<%=s_phone%>"
		+"&s_userPwd=<%=s_userPwd%>"
		+"&s_unitId=<%=s_unitId%>"
		+"&s_unitOffer=<%=s_unitOffer%>"
		+"&s_prodId=<%=s_prodId%>"
		,"","dialogWidth=800px;dialogHeight=600px");		

	if (  typeof (s_bsProd)!="undefined"  )
	{
		$("#t_bsOfrId").val(s_bsProd.split("@")[0]);
		$("#t_bsOfrNm").val(s_bsProd.split("@")[1]);
		$("#t_bsProdId").val(s_bsProd.split("@")[2]);		
		$("#t_bsProdPkgId").val(s_bsProd.split("@")[3]);		
	}		
	
	$("#t_bsOfrId").attr("disabled", true);
	$("#t_bsOfrNm").attr("disabled", true);
	$("#t_bsProdId").attr("disabled", true);	
	$("#t_bsProdPkgId").attr("disabled", true);
	
	$("#d_addAtt").show("slow");	
	$("#d_addAtt2").show("slow");
	/*新增加产品服务附加属性*/
	$("#d_addAttOne").show("slow");	
	$("#d_addAtt2One").show("slow");
	
	/*ajax调用*/
	<%System.out.println("11111111111111111111chenlei");%>
	var packet = new AJAXPacket("f_g663_ajax.jsp","请稍后...");
	packet.data.add("ajaxType"		,"fn_doShowAddAtt");
	packet.data.add("s_loginacc"	,"<%=s_loginacc%>");
	packet.data.add("s_chnSrc"	,"<%=s_chnSrc%>");
	packet.data.add("s_opCode"	,"<%=s_opCode%>");
	packet.data.add("s_workNo"	,"<%=s_workNo%>");
	packet.data.add("s_passwd"	,"<%=s_passwd%>");
	packet.data.add("s_phone"	,"<%=s_phone%>");
	packet.data.add("s_userPwd"	,"<%=s_userPwd%>");
	packet.data.add("s_unitOffer"	,$("#t_bsOfrId").val());
	packet.data.add("s_prodId"		,$("#t_bsProdId").val());
	
	core.ajax.sendPacketHtml(packet,fn_doShowAddAtt);//异步
	packet =null;
}

	
function fn_doShowAddAtt( data )
{
	$("#d_addAtt2").empty();
	$("#d_addAtt2").append(data);
	fn_qryBsProdOne();
}

function fn_qryBsProdOne(){
	var packet = new AJAXPacket("f_g663_ajaxOne.jsp","请稍后...");
	packet.data.add("ajaxType"		,"fn_doShowAddAtt");
	packet.data.add("s_loginacc"	,"<%=s_loginacc%>");
	packet.data.add("s_chnSrc"	,"<%=s_chnSrc%>");
	packet.data.add("s_opCode"	,"<%=s_opCode%>");
	packet.data.add("s_workNo"	,"<%=s_workNo%>");
	packet.data.add("s_passwd"	,"<%=s_passwd%>");
	packet.data.add("s_phone"	,"<%=s_phone%>");
	packet.data.add("s_userPwd"	,"<%=s_userPwd%>");
	packet.data.add("s_unitOffer"	,$("#t_bsOfrId").val());
	packet.data.add("s_prodId"		,$("#t_bsProdId").val());

	core.ajax.sendPacketHtml(packet,fn_doShowAddAttOne);//异步
	packet =null;
}

function fn_doShowAddAttOne( data )
{
	$("#d_addAtt2One").empty();
	$("#d_addAtt2One").append(data);
	
}

function fn_next()
{
	if ($("#t_bsOfrId").val()=="")
	{
		rdShowMessageDialog("原子产品资费编号不能为空",0);
		return false;
	}	
	if ("1"!="<%=r_opType%>")
	{
		if ($("#t_prodBsId").val()=="")
		{
		rdShowMessageDialog("产品订购实例唯一标识不能为空",0);
		return false;
		}
	}
	
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
		
	var retStr="";

	var s_bsIfo=$("#t_bsOfrId").val()
		+"@"+ $("#t_bsOfrNm").val()
		+"@"+ $("#t_bsProdId").val()
		+"@"+ $("#t_bsProdPkgId").val()
		+"@"+ $("#t_prodBsId").val();
	
	
	if("0"==document.getElementsByName("t_prodAAServId").length)
	{
		retStr="";
	}
	else
	{
		var s_srvId="";
		for ( var i=0; i<document.getElementsByName("t_prodAAServId").length ; i++)
		{
			s_srvId =s_srvId+document.getElementsByName("t_prodAAServId")[i].value+"@";
		}
	
			
		var s_addId="";
		for (var i=0; i<document.getElementsByName("t_prodAAId").length ; i++)
		{
			s_addId=s_addId+document.getElementsByName("t_prodAAId")[i].value+"@";
		}
		
		var s_addName="";
		for (var i=0; i<document.getElementsByName("t_prodAAName").length ; i++)
		{
			s_addName=s_addName+document.getElementsByName("t_prodAAName")[i].value+"@";
		}	
		
		var s_addDef="";
		for (var i=0; i<document.getElementsByName("t_prodAADef").length ; i++)
		{
			s_addDef=s_addDef+document.getElementsByName("t_prodAADef")[i].value+"@";
		}		
		
		var s_ifNeeds="";
		for (var i=0; i<document.getElementsByName("t_prodAAIfNeeds").length ; i++)
		{
			s_ifNeeds=s_ifNeeds+document.getElementsByName("t_prodAAIfNeeds")[i].value+"@";
		}
		retStr=s_srvId.substr(0,s_srvId.length-1)
		+"~"+s_addId.substr(0,s_addId.length-1)
		+"~"+s_addName.substr(0,s_addName.length-1)
		+"~"+s_addDef.substr(0,s_addDef.length-1)
		+"~"+s_ifNeeds.substr(0,s_ifNeeds.length-1);
	}
	/*产品服务附加属性*/
	var retStr_1="";
	if("0"==document.getElementsByName("t_prodAAServId_1").length)
	{
		retStr_1="";
	}
	else
	{
		var s_srvId_1="";
		for ( var i=0; i<document.getElementsByName("t_prodAAServId_1").length ; i++)
		{
			s_srvId_1 =s_srvId_1+document.getElementsByName("t_prodAAServId_1")[i].value+"@";
		}
	
			
		var s_addId_1="";
		for (var i=0; i<document.getElementsByName("t_prodAAId_1").length ; i++)
		{
			s_addId_1=s_addId_1+document.getElementsByName("t_prodAAId_1")[i].value+"@";
		}
		
		var s_addName_1="";
		for (var i=0; i<document.getElementsByName("t_prodAAName_1").length ; i++)
		{
			s_addName_1=s_addName_1+document.getElementsByName("t_prodAAName_1")[i].value+"@";
		}	
		
		var s_addDef_1="";
		for (var i=0; i<document.getElementsByName("t_prodAADef_1").length ; i++)
		{
			s_addDef_1=s_addDef_1+document.getElementsByName("t_prodAADef_1")[i].value+"@";
		}		
		
		var s_ifNeeds_1="";
		for (var i=0; i<document.getElementsByName("t_prodAAIfNeeds_1").length ; i++)
		{
			s_ifNeeds_1=s_ifNeeds_1+document.getElementsByName("t_prodAAIfNeeds_1")[i].value+"@";
		}
		retStr_1=s_srvId_1.substr(0,s_srvId_1.length-1)
		+"~"+s_addId_1.substr(0,s_addId_1.length-1)
		+"~"+s_addName_1.substr(0,s_addName_1.length-1)
		+"~"+s_addDef_1.substr(0,s_addDef_1.length-1)
		+"~"+s_ifNeeds_1.substr(0,s_ifNeeds_1.length-1);
	}
		
	window.returnValue=s_bsIfo+"|"+retStr+"|"+retStr_1;
	window.close();
}
</script>
</form>
</body>
</html>
