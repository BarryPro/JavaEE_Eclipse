<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>

<%
String s_regCode=(String)session.getAttribute("regCode");

String s_loginacc=request.getParameter("hd_loginacc");
String s_chnSrc=request.getParameter("hd_chnSrc");
String s_opCode=request.getParameter("hd_opCode");
String s_workNo=request.getParameter("hd_workNo");
String s_passwd=request.getParameter("hd_passwd");
String s_phone=request.getParameter("hd_phone");
String s_userPwd=request.getParameter("hd_userPwd");
String s_unitId = request.getParameter("t_UnitId");
String s_unitOffer = request.getParameter("hd_unitOffer");
String t_ECSubsID = request.getParameter("t_ECSubsID");
String s_prodId = request.getParameter("hd_prodId");
String s_sqlClassCode=	"select nvl(b.innet_type,'99') as class_code  "
	+" from dLoginMsg a, sTownCode b "
	+" where a.login_no ='"+s_workNo+"' and a.group_id = b.group_id(+)";
String s_classCode="";
%>
<wtc:pubselect name="sPubSelect" outnum="2" routerKey="region" routerValue="<%=s_regCode%>">
	<wtc:sql><%=s_sqlClassCode%></wtc:sql>
</wtc:pubselect>
<wtc:array id="rst_classCode" scope="end"/> 
<%
if ( rst_classCode.length!=0 )
{
	s_classCode=rst_classCode[0][0];
}
%>	



<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
	<script language="javascript" type="text/javascript" src="/npage/public/zalidate.js"></script>
</head>
<body>
<form method="POST" action = "" name="frm">

<DIV id="Operation_Table">
	<div class="title" id="d_mebIfo" style="display:none" >
		<div id="title_zi">集团成员信息</div>
	</div>
	<table	id="tb_mebIfo" style="display:none">
		<tr>
			<td class="blue" align="center">成员号码:</th>
			<td>
				<input type="text" ch_name="成员号码" name="t_mebPho" id="t_mebPho"/>	
				<input type="button" class="b_text" value="校验" onclick="fn_chkMebPho()"/>	
			</td>	
			<td class="blue" align="center">成员的用户ID:</th>
			<td>
				<input type="text" ch_name="成员的用户ID" name="t_SubsID" id="t_SubsID" class='InputGrey' readOnly />	
			</td>	
			<td class="blue" align="center">成员产品订购实例唯一标识:</th>
			<td>
				<input type="text" ch_name="成员产品订购实例唯一标识" name="t_ProdInstID" id="t_ProdInstID"
					 class='InputGrey' readOnly />	
			</td>	
		</tr>
		<tr>
			<td class="blue" align="center">成员附加资费:</th>
			<td>
				<input type="text" ch_name="成员附加资费" name="t_OfferId" id="t_OfferId" class='InputGrey' readOnly />	
				<input type="hidden" class="b_text" name="b_qryAddOfr" id="b_qryAddOfr" value="查询"
					onclick="fn_qryAddOfr()"/>	
			</td>	
			<td class="blue" align="center">成员附加资费名称:</th>
			<td>
				<input type="text" ch_name="成员附加资费名称" name = "t_OfferName" id = "t_OfferName"  class='InputGrey' readOnly />	
			</td>	
			<td class="blue" align="center">成员产品编码:</th>
			<td>
				<input type="text" ch_name="成员产品编码" name="t_ProdId" id="t_ProdId"  class='InputGrey' readOnly  />	
			</td>	
		</tr>		
	</table>		
	
	<div class="title" id="d_mebIfo2" style="display:none" >
		<div id="title_zi">成员原子产品信息</div>
	</div>	
	<table	id="tb_ifof2" style="display:none">
		<tr>
			<th align="center" >资费代码</th>
			<th align="center" >资费名称</th>
			<th align="center" >原子产品编码</th>
			<th align="center" >归属产品包编码</th>
			<th align="center" >产品订购实例唯一标识</th>
			<th align="center" >操作</th>
		</tr>	
	</table>
	<table id="tb_mebOpr2" style="display:none">
		<tr> 
			<td align="center">
				<input class="b_foot" type="button" name="b_cls" value="新增"
					onClick="fn_addMeb2()">												
			</td>
		</tr>
	</table>	
	
			
		<div name="d2" id="d2">
			<div class="title" >
				<div id="title_zi">其它信息</div>
			</div>
			<table id="tb_oIfo">
				<tr>
					<th align="center" >信息代码<input type="hidden" name="hd_mngHd"></th>
					<th align="center" >信息值</th>
					<th align="center" >操作</th>
				</tr>							
			</table>	
			<table >
				<tr>
					<td align="center" >
						<input type="button" class="b_text" value="新增" onclick="fn_addOther()">
					</td>
				</tr>							
			</table>					
		</div>		
	
	<table id="tb_next" style="display:none">
		<tr> 
			<td  id="footer">
				<input class="b_foot" type="button" name="b_cls" id='b_cls' value="下一步"
					onClick="fn_next();">					
				<input class="b_foot" type="button" name="b_cls" value="关闭"
					onClick="window.close();">								
			</td>
		</tr>
	</table>		
</div>
<script>
	

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
	
var stepNum=0;
/**/
$(document).ready(
	function()
	{
		$("#d_mebIfo").show("slow");	
		$("#tb_mebIfo").show("slow");	
		$("#tb_next").show("slow");	
		
		$("#d2").hide();
		stepNum=1;
	}
);

	function fn_addOther()
	{
		if ( document.getElementsByName("hd_mngHd").length==0 )
		{
			$("#tb_oIfo").append("<tr>"
				+"<th align='center'><input type='hidden' name='hd_otherHd'>信息代码</th>"
				+"<th align='center'>信息值</th>"
				+"<th align='center'>删除</th>	"
			+"</tr>");
		}	

		$("#tb_oIfo").append("<tr>"
			+"<td align='center'>"
				+"<input type='text' name='t_otherCode' value=''  maxlength='3' ch_name='信息代码' >"
			+"</td>"
			+"<td align='center'>"
				+"<input type='text' name='t_otherValue' value=''  maxlength='256' ch_name='信息值' >"
			+"</td>"		
			+"<td align='center'>"
				+"<img src='/nresources/default/images/task-item-close1.gif' name = 'i_delOther'"
					+"style='cursor:Pointer;' class='del_cls'  alt='删除选择的信息' "
					+"onclick='delrow(this)'>"	
			+"</td>"		
		+"</tr>");
	}	
	function delrow(k)
	{
		$(k).parent().parent().remove(); 
	}	
function fn_addMeb2()
{
	if ($("#tb_mebIfo2 th").length==0 )
	{
		$("#tb_mebIfo2").append("<tr>"
			+"<th align='center'>原子产品编码</th>"
			+"<th align='center'>归属产品包编码</th>"
			+"<th align='center'>产品订购实例唯一标识</th>"
			+"<th align='center'>操作</th>	"
		+"</tr>");
	}
	
	var s_bsProd=window.showModalDialog("f_g663_bsProd.jsp"
		+"?s_loginacc=<%=s_loginacc%>"
		+"&s_chnSrc=<%=s_chnSrc%>"
		+"&s_opCode=<%=s_opCode%>"
		+"&s_workNo=<%=s_workNo%>"
		+"&s_passwd=<%=s_passwd%>"
		+"&s_phone=<%=s_phone%>"
		+"&s_userPwd=<%=s_userPwd%>"
		+"&s_unidId=<%=s_unitId%>"
		+"&s_unitOffer=<%=s_unitOffer%>"
		+"&s_prodId=<%=s_prodId%>"
		,"","dialogWidth=800px;dialogHeight=600px");
	if ( typeof (s_bsProd) =="undefined")
	{
		return false;
	}
	var a_bsIfo =s_bsProd.split("~")[0]; 
	var a_servId =s_bsProd.split("~")[1]; 
	var a_addId =s_bsProd.split("~")[2]; 
	var a_addName =s_bsProd.split("~")[3]; 
	var a_addDef =s_bsProd.split("~")[4]; 
	var a_ifNeeds =s_bsProd.split("~")[5]; 
	
	$("#a_bsIfo").val(a_bsIfo);
	$("#a_servId").val(a_servId);
	$("#a_addId").val(a_addId);
	$("#a_addName").val(a_addName);
	$("#a_addDef").val(a_addDef);
	$("#a_ifNeeds").val(a_ifNeeds);
	
	if (	a_bsIfo.split("@")[0]=="")
	{
		return false;
	}
	
	if ($("#tb_ifof2 th").length==0 )
	{
		$("#tb_ifof2").append("<tr>"
			+"<th align='center'>资费代码</th>"
			+"<th align='center'>资费名称</th>"
			+"<th align='center'>原子产品编码</th>"
			+"<th align='center'>归属产品包编码</th>"
			+"<th align='center'>产品订购实例唯一标识</th>"
			+"<th align='center'>操作</th>	"
		+"</tr>");
	}
	$("#tb_ifof2").append("<tr>"
			+"<td align='center'>"
				+"<input type='text' class='InputGrey' readOnly name='' value='"+	a_bsIfo.split("@")[0]+"'>"
			+"</td>"
			+"<td align='center'>"
				+"<input type='text' class='InputGrey' readOnly name='' value='"+	a_bsIfo.split("@")[1]+"'>"
			+"</td>"	
			+"<td align='center'>"
				+"<input type='text' class='InputGrey' readOnly name='bs_prodid' value='"+	a_bsIfo.split("@")[2]+"'>"
				+"<input type='HIDDEN' class='InputGrey' readOnly name='bs_OfrId' value='"+	a_bsIfo.split("@")[0]+"'>"
				+"<input type='HIDDEN' class='InputGrey' readOnly name='a_servId' value='"+a_servId+"'>"
				+"<input type='HIDDEN' class='InputGrey' readOnly name='a_addId' value='"+a_addId+"'>"
				+"<input type='HIDDEN' class='InputGrey' readOnly name='a_addDef' value='"+a_addDef+"'>"
				+"<input type='HIDDEN' class='InputGrey' readOnly name='a_bsIfo' value='"+a_bsIfo+"'>"
				+"<input type='HIDDEN' class='InputGrey' readOnly name='s_bsProd' value='"+s_bsProd+"'>"
			+"</td>"
			+"<td align='center'>"
				+"<input type='text' class='InputGrey' readOnly name='bs_pkgid' value='"+	a_bsIfo.split("@")[3]+"'>"
			+"</td>"
			+"<td align='center'><input type='text' class='InputGrey' readOnly name='bs_odrId' value='"+	a_bsIfo.split("@")[4]+"'></td>"
			+"<td align='center'>"
				+"<img src='/nresources/default/images/task-item-close1.gif' name = 'i_delOther'"
					+"style='cursor:Pointer;' class='del_cls'  alt='删除选择的信息' "
					+"onclick='delrow(this)'>"	
			+"</td>	"
		+"</tr>");
}

function fn_next()
{
	if (stepNum==1)
	{
		if (""==$("#t_SubsID").val())
		{
			rdShowMessageDialog("成员信息必须查询",0);
			return false;
		}
		
		$("#tb_mebIfo input").attr("disabled" , "true")
		$("#d_mebIfo2").show("slow");	
		$("#tb_mebIfo2").show("slow");	
		$("#tb_mebOpr2").show("slow");
			$("#tb_ifof2").show("slow");
	}
	else if ( stepNum==2 )
	{
		$("#d2").show("slow");
		$("#b_cls").val("确认");
	}
	else if ( stepNum=3 )
	{
		for ( var i=0;i<document.getElementsByName("t_otherCode").length;i++ )
		{
			if ( fn_notNull( document.getElementsByName("t_otherCode")[i])!=0 ) return false;
				
			if ( fn_notNull( document.getElementsByName("t_otherValue")[i])!=0 )  return false;		

			if (document.getElementsByName("t_otherCode")[i].value.length!=3  )
			{
				rdShowMessageDialog("其它信息代码必须三位",0);
				return false;
			}
			
		}
		
		
		var retVal="";
		
		var mebIfo=$("#t_mebPho").val()+"@"+$("#t_SubsID").val()+"@"+$("#t_ProdInstID").val()
			+"@"+$("#t_OfferId").val()+"@"+$("#t_ProdId").val();
		var prodIfo="";
		for ( var i=0;i<document.getElementsByName("s_bsProd").length;i++ )
		{
			prodIfo=prodIfo+document.getElementsByName("s_bsProd")[i].value+"$";
		}
		var oCodeIfo="";
		for ( var i=0;i<document.getElementsByName("t_otherCode").length;i++ )
		{
			oCodeIfo=oCodeIfo+document.getElementsByName("t_otherCode")[i].value+"@";
		}
		var oValIfo="";
		for ( var i=0;i<document.getElementsByName("t_otherValue").length;i++ )
		{
			oValIfo=oValIfo+document.getElementsByName("t_otherValue")[i].value+"@";
		}		

		retVal=mebIfo+"#"+prodIfo.substr(0,prodIfo.length-1)
			+"#"+oCodeIfo.substr(0,oCodeIfo.length-1)+"#"+oValIfo.substr(0,oValIfo.length-1);
		window.returnValue=retVal;
		window.close();
	}
	stepNum+=1;
}

function fn_qryAddOfr()
{
	var s_addOfr=window.showModalDialog("f_g663_qryOfr.jsp"
		+"?s_loginacc=<%=s_loginacc%>"
		+"&s_chnSrc=<%=s_chnSrc%>"
		+"&s_opCode=<%=s_opCode%>"
		+"&s_workNo=<%=s_workNo%>"
		+"&s_passwd=<%=s_passwd%>"
		+"&s_phone=<%=s_phone%>"
		+"&s_userPwd=<%=s_userPwd%>"
		+"&s_classCode=<%=s_classCode%>"
		+"&t_ECSubsID=<%=t_ECSubsID%>"
		,"","dialogWidth=800px;dialogHeight=600px");
	if (  typeof (s_addOfr)!="undefined"  )
	{
		$("#t_OfferId").val(s_addOfr.split("@")[0]);
		$("#t_OfferName").val(s_addOfr.split("@")[1]);
		$("#t_ProdId").val(s_addOfr.split("@")[2]);		
	}	
}
		
function fn_chkMebPho()
{
	var packet = new AJAXPacket("f_g663_ajax.jsp","请稍后...");
	packet.data.add("s_loginacc","<%=s_loginacc%>");
	packet.data.add("s_chnSrc"	,"<%=s_chnSrc%>");
	packet.data.add("s_opCode"	,"<%=s_opCode%>");
	packet.data.add("s_workNo"	,"<%=s_workNo%>");
	packet.data.add("s_passwd"	,"<%=s_passwd%>");
	packet.data.add("s_phone"	,"<%=s_phone%>");
	packet.data.add("s_userPwd"	,"<%=s_userPwd%>");
	packet.data.add("s_unitId"	,"<%=s_unitId%>");
	packet.data.add("t_mebPho"	,document.all.t_mebPho.value);
	packet.data.add("ajaxType"	,"fn_chkMebPho");
	core.ajax.sendPacket(packet		,fn_doChkMebPho,true);//异步		
}
	
function fn_doChkMebPho(packet)
{
	var v_oRetCode=packet.data.findValueByName("oRetCode");
	var v_oRetMsg=packet.data.findValueByName("oRetMsg");
	if ( v_oRetCode!="000000" )
	{
		rdShowMessageDialog(v_oRetCode+":"+v_oRetMsg,0);
		return 0;
	}
	else
	{
		$("#t_mebPho").attr("disabled" , true)
		$("#t_SubsID").val(packet.data.findValueByName("SubsID"));
		$("#t_OfferId").val(packet.data.findValueByName("OfferId"));
		$("#t_OfferName").val(packet.data.findValueByName("OfferName"));
		$("#t_ProdId").val(packet.data.findValueByName("ProdID"));
		$("#t_ProdInstID").val(packet.data.findValueByName("ProdInstID"));
	}
}
	
</script>
</form>
</body>
</html>
