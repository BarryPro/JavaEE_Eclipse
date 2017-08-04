
<%
/*
 * 功能: g667.物联网产品资费变更 
 * 版本: 1.0
 * 日期: 2013/5/7 14:32:08
 * 作者: zhangyan
 * 版权: si-tech
 * update:
*/
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
String s_workNo = (String)session.getAttribute("workNo");
String s_passwd = (String)session.getAttribute("password");
String s_regCode = (String)session.getAttribute("regCode");
String s_phone="";
String s_userPwd="";

String opName=request.getParameter("opName");
String s_orgCode=(String)session.getAttribute("orgCode");
String s_ipAddr = (String)session.getAttribute("ipAddr");
String s_orgId = (String)session.getAttribute("orgId");
String s_belongCode = (String)session.getAttribute("orgCode");
String s_groupId = (String)session.getAttribute("groupId");
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
	<title><%=opCode%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/zalidate.js"></script>
	<script src="../public/json2.js" type="text/javascript"></script>	
	<script language="javascript" type="text/javascript" src="f_g667.js"></script>
</head>
<body >
<form  name="frm" action="" method="POST" >
<input type="hidden" id="hd_loginacc" name ="hd_loginacc"	value= "<%=s_loginacc%>">
<input type="hidden" id="hd_chnSrc" name ="hd_chnSrc"	value= "<%=s_chnSrc%>">
<input type="hidden" id="hd_opCode" name ="hd_opCode"	value= "<%=opCode%>">
<input type="hidden" id="hd_workNo" name ="hd_acc"	value= "<%=s_workNo%>">
<input type="hidden" id="hd_passwd" name ="hd_passwd"	value= "<%=s_passwd%>">
<input type="hidden" id="hd_phone" name ="hd_phone"	value= "<%=s_phone%>">
<input type="hidden" id="hd_userPwd" name ="hd_userPwd"	value= "<%=s_userPwd%>">
<input type="hidden" id="hd_opType" name ="hd_opType"	value= "m01">
<input type="hidden" id="hd_opName" name ="hd_opName"	value= "<%=opName%>">
<input type="hidden" id="hd_ofrId" name ="hd_ofrId"	value= "">
<input type="hidden" id="hd_prodNm" name ="hd_prodNm"	value= "">
<input type="hidden" id="hd_bizType" name ="hd_bizType"	value= "">
<input type="hidden" id="hd_extCode" name ="hd_extCode"	value= "">
<input type="hidden" id="jsonText" name ="jsonText"	value= "">
<input type="hidden" id="showText" name ="showText"	value= "">

<%@ include file="/npage/include/header.jsp" %>

<DIV id="Operation_Table">
	<div id="d0" name="d0" style="display:none">
		<div class="title" >
			<div id="title_zi">集团用户信息查询</div>
		</div>
		<table>
			<tr>
				<td class="blue" align="center" width="25%">证件号码:</th>
				<td width="25%">
					<input type="text" id='idiccid' name='idiccid' ch_name='证件号码'/>	
					<input type="button" id='sel_unit' class="b_text" value="查询" onclick="fn_selUnit()" >	
				</td>	
				<td class="blue" align="center">EC集团客户编码:</th>
				<td>
					<input type="text" id='ecid' name='ecid' ch_name='EC集团客户编码' />	
				</td>	
			<tr>		
			<tr>
				<td class="blue" align="center" width="25%">集团编号:</th>
				<td width="25%">
					<input type="text" id='unitid' name='unitid' ch_name='集团客户编号'  />	
				</td>	
				<td class="blue" align="center">集团产品ID:</th>
				<td>
					<input type="text" id="prodId" name="prodId"/>	
				</td>	
			<tr>	
			<tr>
				<td class="blue" align="center" width="25%">集团客户名称:</th>
				<td width="25%">
					<input type="text" id="unitname" name="unitname"/>	
				</td>	
				<td class="blue" align="center">企业产品订购实例唯一标识:</th>
				<td>
					<input type="text" id="prodOdId" name ="prodOdId"/>	
				</td>	
			<tr>					
				
			<tr>
				<td class="blue" align="center" width="25%">集团用户编号:</th>
				<td width="25%">
					<input type="text" id="unitUsrId" name="unitUsrId" id="unitUsrId"/>	
				</td>	
				<td class="blue" align="center">用户唯一标识:</th>
				<td>
					<input type="text" id ="usrId" name="usrId" />	
				</td>	
			<tr>					
			<tr>
				<td class="blue" align="center" width="25%">集团付费账户:</th>
				<td width="25%">
					<input type="text" id="feeId" name="feeId"/>	
				</td>	
				<td class="blue" align="center">集团用户名称:</th>
				<td>
					<input type="text" id="unitUsrNm" name="unitUsrNm"/>	
				</td>	
			<tr>									
			<tr>
				<td class="blue" align="center" width="25%">旧集团主产品:</th>
				<td width="25%">
					<input type="text" name="oldProdId" id="oldProdId" />	
				</td>	
				<td class="blue" align="center">旧企业产品编码:</th>
				<td>
					<input type="text" name="oldentProdId" id = "oldentProdId"/>	
				</td>	
			<tr>	
			<tr>
				<td class="blue" align="center" width="25%">新集团主产品:</th>
				<td width="25%">
					<input type="text" id="newProdId" name="newProdId" readonly class='InputGrey'/>
					<input type="button" class="b_text" value="选择" onclick="fn_selProdId()">			
				</td>	
				<td class="blue" align="center">新企业产品编码:</th>
				<td>
					<input type="text"  id="newEntProdId" name="newEntProdId"  readonly class='InputGrey'/>					
				</td>	
			<tr>															
		</table>
	</div>
	<div id="d1" style="display:none">
		<div class="title" id="d_prodIfo" >
			<div id="title_zi">产品信息</div>
		</div>	
		<div id="d11" >
			<table width="100%" id="tb_addIfo">
				<tr>
					<th align="center" >附加产品编号</th>
					<th align="center" >附加产品名称</th>
					<th align="center" >产品编码</th>
					<th align="center" >归属产品包编码</th>
					<th align="center" >产品订购实例唯一标识</th>
					<th align="center" >生效时间</th>
					<th align="center" >失效时间</th>
					<th align="center" >状态</th>
					<th align="center" >操作</th>
				</tr>			
			</table>	
		</div>
		<table id="tb_prodIfoAdd">
			<tr> 
				<td align = "center">
					<input class="b_text" type="button" name="b_addProd" value="新增" onclick="fn_AddProd()" >						
				</td>
			</tr>
		</table>					
	</div>
	<div id='d2' style="display:none">
		<table>
			<tr> 
				<td  id="footer">
					<input class="b_foot" type="button"  id="b_cfm" name="b_cfm" value="下一步"
						onClick="fn_next();">
					<input class="b_foot" type="button" name="b_clr" value="重置"
						onClick="location.reload();">
					<input class="b_foot" type="button" name="b_cls" value="关闭"
						onClick="removeCurrentTab();">								
				</td>
			</tr>
		</table>
	</div>		
<DIV>
</form>
<script>
	
var stepNum=0;
$(document).ready(
	function ()
	{
		$("#d0").show("slow");
		$("#d1").hide();
		$("#d2").show("slow");	
		stepNum=stepNum+1;
	}
);

function fn_next()
{
	if ( stepNum==1 )
	{
		if (""==$("#idiccid").val().trim())
		{
			rdShowMessageDialog("必须查询集团信息" , 0);
			return false;
		}
		
		$("#d0 input").attr("disabled" , "true");
		$("#d1").show("slow");
		$("#d2").show("slow");	
		$("#b_cfm").val("确认");
		stepNum=stepNum+1;
	}	
	else if( stepNum==2 )
	{
		$("#d0 input").attr("disabled" , "true");
		$("#d1 input").attr("disabled" , "true");
		//$("#b_cfm").attr("disabled" , "true")
		
		var ipt = new input ();
		ipt.setOrgCode("<%=s_orgCode%>");
		ipt.setIpAddress("<%=s_ipAddr%>");
		ipt.setOpNote("[<%=s_workNo%>]进行[<%=opName%>]操作");	
		ipt.setOrgId("<%=s_orgId%>");	
		ipt.setBelongCode("<%=s_belongCode%>");	
		
		ipt.setGroupId("<%=s_groupId%>");	
		ipt.setIdIccid(document.all.idiccid.value);	
		ipt.setUnitId(document.all.unitid.value);		
		ipt.setCustomerNumber(document.all.ecid.value);	
		ipt.setIdNo(document.all.prodId.value);	
		
		ipt.setCustName(document.all.unitname.value);	
		ipt.setUserNo(document.all.unitUsrId.value);	
		ipt.setProdInstID(document.all.prodOdId.value);	
		ipt.setSubsID(document.all.usrId.value);	
		ipt.setOfferId(document.all.newProdId.value);
			
		ipt.setProdID(document.all.newEntProdId.value);	
		ipt.setOldOfferId(document.all.oldProdId.value);	
		ipt.setOldProdID(document.all.oldentProdId.value);		
		/*增加的产品		ProdInfoAdd*/

		for ( var i=0;i<document.getElementsByName("t_addid").length;i++ )
		{
			var padd = new ProdInfoAdd();
			padd.setOfferId(document.getElementsByName("t_addid")[i].value)
			padd.setProdID(document.getElementsByName("t_prodid")[i].value)
			padd.setPkgProdID(document.getElementsByName("t_pkgid")[i].value)
			padd.setProdInstID(document.getElementsByName("t_orderid")[i].value)
			
			var s_ServiceID=""
			if ( typeof (document.getElementsByName("str_attr")[i].value.split("~")[0])!="undefined" )
			{
				s_ServiceID=document.getElementsByName("str_attr")[i].value.split("~")[0];   
			}

			var s_AttrKey="";
			if ( typeof (document.getElementsByName("str_attr")[i].value.split("~")[1])!="undefined" )
			{
				s_AttrKey=document.getElementsByName("str_attr")[i].value.split("~")[1];   
			} 

			var s_AttrValue="";
			if ( typeof (document.getElementsByName("str_attr")[i].value.split("~")[2])!="undefined" )
			{
				s_AttrValue=document.getElementsByName("str_attr")[i].value.split("~")[2];   
			} 
			
			if ( ""!=s_ServiceID )
			{
				for ( var j=0;j<s_ServiceID.split("@").length;j++ )
				{
					if (s_ServiceID.split("@")[j]!="")
					{
						var attr = new ProdAttrInfo();
						attr.setServiceID(s_ServiceID.split("@")[j]);
						attr.setAttrKey(s_AttrKey.split("@")[j]);
						attr.setAttrValue(s_AttrValue.split("@")[j]);
						padd.setProdAttrInfo(attr);
					}
				} 
			}

			
			var s_ServiceID_1=""
				if ( typeof (document.getElementsByName("str_attr_1")[i].value.split("~")[0])!="undefined" )
				{
					s_ServiceID_1=document.getElementsByName("str_attr_1")[i].value.split("~")[0];   
				}

				var s_AttrKey_1="";
				if ( typeof (document.getElementsByName("str_attr_1")[i].value.split("~")[1])!="undefined" )
				{
					s_AttrKey_1=document.getElementsByName("str_attr_1")[i].value.split("~")[1];   
				} 

				var s_AttrValue_1="";
				if ( typeof (document.getElementsByName("str_attr_1")[i].value.split("~")[2])!="undefined" )
				{
					s_AttrValue_1=document.getElementsByName("str_attr_1")[i].value.split("~")[2];   
				} 
				
				if ( ""!=s_ServiceID_1 )
				{
					for ( var j=0;j<s_ServiceID_1.split("@").length;j++ )
					{
						if (s_ServiceID_1.split("@")[j]!="")
						{
							var attr = new ProdAttrInfo();
							attr.setServiceID(s_ServiceID_1.split("@")[j]);
							attr.setAttrKey(s_AttrKey_1.split("@")[j]);
							attr.setAttrValue(s_AttrValue_1.split("@")[j]);
							padd.setProdServiceAttrInfo(attr);
						}
					} 
				}
			ipt.setProdInfoAdd(padd);
		}
		
		/*删除的产品*/
		for ( var i=0;i<document.getElementsByName("o_addid").length;i++ )
		{
			if ( "1"==document.getElementsByName("o_backFlag")[i].value )
			{
				var pdel = new ProdInfoDel();
				pdel.setOfferId(document.getElementsByName("o_addid")[i].value)
				pdel.setProdID(document.getElementsByName("o_prodid")[i].value)
				pdel.setPkgProdID(document.getElementsByName("o_pkgid")[i].value)
				pdel.setProdInstID(document.getElementsByName("o_orderid")[i].value)
				pdel.setOpType("02")
				
				if (""!=document.getElementsByName("o_ServiceID")[i].value)
				{
					for ( var j=0;j<document.getElementsByName("o_ServiceID")[i].value.split("@").length;j++ )
					{
						if (""!=document.getElementsByName("o_ServiceID")[i].value.split("@")[j])
						{
							var attr = new ProdAttrInfo();
							attr.setServiceID(document.getElementsByName("o_ServiceID")[i].value.split("@")[j]);
							attr.setAttrKey(document.getElementsByName("o_AttrKey")[i].value.split("@")[j]);
							attr.setAttrValue(document.getElementsByName("o_AttrValue")[i].value.split("@")[j]);
							pdel.setProdAttrInfo(attr);							
						}

					} 					
				}
				if (""!=document.getElementsByName("o_ServiceID_1")[i].value)
				{
					for ( var j=0;j<document.getElementsByName("o_ServiceID_1")[i].value.split("@").length;j++ )
					{
						if (""!=document.getElementsByName("o_ServiceID_1")[i].value.split("@")[j])
						{
							var attr = new ProdServiceAttrInfo();
							attr.setServiceID(document.getElementsByName("o_ServiceID_1")[i].value.split("@")[j]);
							attr.setAttrKey(document.getElementsByName("o_AttrKey_1")[i].value.split("@")[j]);
							attr.setAttrValue(document.getElementsByName("o_AttrValue_1")[i].value.split("@")[j]);
							pdel.setProdServiceAttrInfo(attr);							
						}

					} 					
				}
				ipt.setProdInfoDel(pdel);
				
			}
		}		
		/*变更的产品*/
		alert("长度:"+document.getElementsByName("o_addid").length);
		for ( var i=0;i<document.getElementsByName("o_addid").length;i++ )
		{
			if ( "2"==document.getElementsByName("o_backFlag")[i].value )
			{
				var pdel = new ProdInfoDel();
				pdel.setOfferId(document.getElementsByName("o_addid")[i].value)
				pdel.setProdID(document.getElementsByName("o_prodid")[i].value)
				pdel.setPkgProdID(document.getElementsByName("o_pkgid")[i].value)
				pdel.setProdInstID(document.getElementsByName("o_orderid")[i].value)
				pdel.setOpType("03")
				var a_retStr =  document.getElementsByName("s_retIfo")[i].value;
				s_pServId=a_retStr.split("~")[0];
				s_pAttrKey=a_retStr.split("~")[1];
				s_pAttrValue=a_retStr.split("~")[3];
				if (""!=document.getElementsByName("s_retIfo")[i].value)
				{
					for ( var k=0;k<s_pServId.split("@").length;k++ )
					{
						
						var pAIfo= new ProdServiceAttrInfo();
						pAIfo.setServiceID(s_pServId.split("@")[k]);
						pAIfo.setAttrKey(s_pAttrKey.split("@")[k]);
						pAIfo.setAttrValue(s_pAttrValue.split("@")[k]);
						
						pdel.setProdServiceAttrInfo(pAIfo);
					} 					
				}
				
				ipt.setProdInfoDel(pdel);
				
			}
		}		
		
		var qka = new jqk();
		qka.setInput(ipt);
		/*拼json串*/
		var myJSONText = JSON.stringify(qka,function(key,value){
			return value;
		});
				document.getElementById("jsonText").value=myJSONText;
		//return false;
		
		if ("1"!=rdShowConfirmDialog("确认提交吗?"))
		{
			return false;
		}		
		$("#b_cfm").attr("disabled",true);	
		
		document.frm.action="f_g667_cfm.jsp";
		alert(2222);
		document.frm.submit();		
	}
}

function fn_selUnit()
{	
	var s_retIfo=window.showModalDialog("f_g667_unitIfo.jsp"
		+"?hd_loginacc="+document.all.hd_loginacc.value
		+"&hd_chnSrc="+document.all.hd_chnSrc.value
		+"&hd_opCode="+document.all.hd_opCode.value
		+"&hd_workNo="+document.all.hd_workNo.value
		+"&hd_passwd="+document.all.hd_passwd.value
		+"&hd_phone="+document.all.hd_phone.value
		+"&hd_userPwd="+document.all.hd_userPwd.value
		+"&unitid="+document.all.unitid.value
		+"&ecid="+document.all.ecid.value
		+"&idiccid="+document.all.idiccid.value
		+"&opType=u03"
		,"","dialogWidth=800px;dialogHeight=600px");

	if ( typeof ( s_retIfo ) !="undefined")
	{
		$("#idiccid").val(s_retIfo.split("@")[0]);
		$("#unitname").val(s_retIfo.split("@")[2]);
		$("#unitid").val(s_retIfo.split("@")[1]);
		$("#ecid").val(s_retIfo.split("@")[3]);
		$("#oldProdId").val(s_retIfo.split("@")[4]);
		$("#hd_prodNm").val(s_retIfo.split("@")[5]);
		$("#prodId").val(s_retIfo.split("@")[6]);
		$("#prodOdId").val(s_retIfo.split("@")[7]);
		$("#usrId").val(s_retIfo.split("@")[8]);
		$("#unitUsrId").val(s_retIfo.split("@")[9]);
		$("#unitUsrNm").val(s_retIfo.split("@")[10]);
		$("#feeId").val(s_retIfo.split("@")[11]);
		$("#oldentProdId").val(s_retIfo.split("@")[12]);
		$("#hd_bizType").val(s_retIfo.split("@")[14]);
		$("#hd_extCode").val(s_retIfo.split("@")[13]);
		
		$("#idiccid").attr("disabled","true");
		$("#unitname").attr("disabled","true");
		$("#unitid").attr("disabled","true");
		$("#ecid").attr("disabled","true");
		$("#oldProdId").attr("disabled","true");
		$("#hd_prodNm").attr("disabled","true");
		$("#prodId").attr("disabled","true");
		$("#prodOdId").attr("disabled","true");
		$("#usrId").attr("disabled","true");
		$("#unitUsrId").attr("disabled","true");
		$("#unitUsrNm").attr("disabled","true");
		$("#feeId").attr("disabled","true");
		$("#oldentProdId").attr("disabled","true");
		$("#sel_unit").attr("disabled","true");
	}
	
	var packet = new AJAXPacket("f_g667_ajax.jsp","请稍后...");
	packet.data.add("iLoginAccept" 		,"");
	packet.data.add("iChnSource" 		,"01");
	packet.data.add("iOpCode" 			,"<%=opCode%>");
	packet.data.add("iLoginNo" 			,"<%=s_workNo%>");
	packet.data.add("iLoginPwd" 		,"<%=s_passwd%>");
	packet.data.add("iPhoneNo" 			,"");
	packet.data.add("iUserPwd" 			,"");
	packet.data.add("iGrpId" 			,$("#prodId").val());
	packet.data.add("iSubsId" 			,$("#usrId").val());
	packet.data.add("iProdInstId" 		,$("#prodOdId").val());
	packet.data.add("ajaxType"			,"fn_doGetProd");

	core.ajax.sendPacket(packet		,fn_doGetProd,true);//异步			
}
	
function fn_doGetProd( packet )
{
	var v_oRetCode=packet.data.findValueByName("oRetCode");
	var v_oRetMsg=packet.data.findValueByName("oRetMsg");
	

	if ( "000000"==v_oRetCode )
	{

		var v_jsn=packet.data.findValueByName("oProdJsonStr") ;

		var v_jsn1 = JSON.parse(v_jsn,function(key,value){
		
			return value;
		});
		document.all.showText.value=v_jsn;
		
		
		if ($("#tb_addIfo th").length==0 )
		{
			$("#tb_addIfo").append("<tr>"
				+"<th align='center' >附加产品编号</th>"
				+"<th align='center' >附加产品名称</th>"
				+"<th align='center' >产品编码</th>"
				+"<th align='center' >归属产品包编码</th>"
				+"<th align='center' >产品订购实例唯一标识</th>"
				+"<th align='center' >生效时间</th>"
				+"<th align='center' >失效时间</th>"
				+"<th align='center' >状态</th>"
				+"<th align='center' >操作</th>"
			+"</tr>");
		}		
		
		var i=0;
		
		while (v_jsn1.ProdInfo[i]!=null )
		{
			var j=0;
			var k=0;
			var s_ServiceID="";
			var s_AttrKey="";
			var s_AttrValue="";
			var s_ServiceID_1="";
			var s_AttrKey_1="";
			var s_AttrValue_1="";

			if (v_jsn1.ProdInfo[i].ProdAttrInfo !=null)
			{
				while ( v_jsn1.ProdInfo[i].ProdAttrInfo[j]!=null )
				{		
					//alert(v_jsn1.ProdInfo[i].ProdAttrInfo[])
					s_ServiceID=s_ServiceID+v_jsn1.ProdInfo[i].ProdAttrInfo[j].ServiceID+"@";
					s_AttrKey=s_AttrKey+v_jsn1.ProdInfo[i].ProdAttrInfo[j].AttrKey+"@";
					s_AttrValue=s_AttrValue+v_jsn1.ProdInfo[i].ProdAttrInfo[j].AttrValue+"@";
					
					j=j+1;
				}	
			}
			if (v_jsn1.ProdInfo[i].ProdServiceAttrInfo !=null)
			{
				while ( v_jsn1.ProdInfo[i].ProdServiceAttrInfo[k]!=null )
				{		
					
					s_ServiceID_1=s_ServiceID_1+v_jsn1.ProdInfo[i].ProdServiceAttrInfo[k].ServiceID+"@";
					s_AttrKey_1=s_AttrKey_1+v_jsn1.ProdInfo[i].ProdServiceAttrInfo[k].AttrKey+"@";
					s_AttrValue_1=s_AttrValue_1+v_jsn1.ProdInfo[i].ProdServiceAttrInfo[k].AttrValue+"@";
					k=k+1;
				}	
			}
			
			var op_dis_flag=v_jsn1.ProdInfo[i].State=="X"?"disabled":" ";
			
			$("#tb_addIfo").append("<tr>"
				+"<td align='center'>"
					+"<input type='text' name='o_addId'  ch_name='附加产品编号' value='"+v_jsn1.ProdInfo[i].OfferId+"' class='InputGrey' readOnly >"
					+"<input type='hidden' name='o_backFlag' id='o_backFlag"+i+"'  ch_name='' value='0'>"
					+"<input type='hidden' name='o_ServiceID' id='o_ServiceID"+i+"'  ch_name='' value='"+s_ServiceID+"'>"
					+"<input type='hidden' name='o_AttrKey' id='o_AttrKey"+i+"'  ch_name='' value='"+s_AttrKey+"'>"
					+"<input type='hidden' name='o_AttrValue' id='o_AttrValue"+i+"'  ch_name='' value='"+s_AttrValue+"'>"
					+"<input type='hidden' name='o_ServiceID_1' id='o_ServiceID_1"+i+"'  ch_name='' value='"+s_ServiceID_1+"'>"
					+"<input type='hidden' name='o_AttrKey_1' id='o_AttrKey_1"+i+"'  ch_name='' value='"+s_AttrKey_1+"'>"
					+"<input type='hidden' name='o_AttrValue_1' id='o_AttrValue_1"+i+"'  ch_name='' value='"+s_AttrValue_1+"'>"
					
				+"</td>"
				+"<td align='center'>"
					+"<input type='text' name='o_addName'  ch_name='附加产品名称' value='"+v_jsn1.ProdInfo[i].OfferName+"' class='InputGrey' readOnly >"
				+"</td>"
				+"<td align='center'>"
					+"<input type='text' name='o_prodId' ch_name='产品编码'  value='"+v_jsn1.ProdInfo[i].ProdID+"' class='InputGrey' readOnly >"
				+"</td>"
				+"<td align='center'>"
					+"<input type='text' name='o_pkgid'  ch_name='归属产品包编码'   value='"+v_jsn1.ProdInfo[i].PkgProdID+"' class='InputGrey' readOnly >"
				+"</td>"		
				+"<td align='center'>"
					+"<input type='text' name='o_orderid'  ch_name='产品订购实例唯一标识'   value='"+v_jsn1.ProdInfo[i].ProdInstID+"' class='InputGrey' readOnly >"
				+"</td>"		
				+"<td align='center'>"
					+"<input type='text' name='o_eff'  ch_name='生效时间' "
						+"  value='"+v_jsn1.ProdInfo[i].ProdInstEffTime+"' class='InputGrey' readOnly >"
				+"</td>"	
				+"<td align='center'>"
					+"<input type='text' name='o_exp'  ch_name='失效时间'  "
						+" value='"+v_jsn1.ProdInfo[i].ProdInstExpTime+"' class='InputGrey' readOnly >"
				+"</td>"
				+"<td align='center'>"
					+ ( v_jsn1.ProdInfo[i].State=="A"?"正常":"已退订")
				+"</td>"														
				+"<td align='center'>"
					+"<input type ='button' value='退订' class='b_text'  id='b_back"+i+"' "
						+"onclick='fn_back("+i+")'>"	
					+"<input type ='button' value='取消' class='b_text' disabled id='b_cclback"+i+"' " 
						+"style='cursor:Pointer;' class='del_cls'  alt='' "
						+"onclick='fn_cclBack("+i+")'>"
					+"<input type ='button' value='变更' class='b_text' id='b_update"+i+"' " 
						+"style='cursor:Pointer;' class='del_cls' style='display:none' alt='' "
						+"onclick='fn_selUnit1("+i+")'>"
					+"<input type ='button' value='变更黑名单' class='b_text' id='b_update1"+i+"' " 
						+"style='cursor:Pointer;' class='del_cls' style='display:none' alt='' "
						+"onclick='fn_selUnit2("+i+")'>"	
				+"</td>"		
			+"</tr>");	
				
			if("I00010100097"==(v_jsn1.ProdInfo[i].ProdID)){
				$("#b_update"+i).show();
				$("#b_update1"+i).show();
				//alert(v_jsn1.ProdInfo[i].PkgProdID+"----");
			}
			i=i+1;
		}	
	}
	else
	{
		rdShowMessageDialog(v_oRetCode+":"+v_oRetMsg , 0);	
		return false;	
	}

}
function fn_cclBack( i )
{
	 
	if("1"==document.getElementsByName("o_backFlag")[i].value){
		$("#b_back"+i).attr("disabled" , false);
		$("#b_cclback"+i).attr("disabled" , true);
		$("#b_update"+i).attr("disabled" , false);
		$("#b_update1"+i).attr("disabled" , false);
		$("#o_backFlag"+i).val("0");
	}
	
	
}

function fn_back( i )
{
	if("2"!=document.getElementsByName("o_backFlag")[i].value){
		$("#b_back"+i).attr("disabled" , true);
		$("#b_cclback"+i).attr("disabled" , false);
		$("#b_update"+i).attr("disabled" , true);
		$("#b_update1"+i).attr("disabled" , true);
		$("#o_backFlag"+i).val("1");
	}
	
	
}

function fn_selProdId()
{
	var s_retIfo=window.showModalDialog("f_g667_prodIfo.jsp"
		+"?hd_loginacc="+document.all.hd_loginacc.value
		+"&hd_chnSrc="+document.all.hd_chnSrc.value
		+"&hd_opCode="+document.all.hd_opCode.value
		+"&hd_workNo="+document.all.hd_workNo.value
		+"&hd_passwd="+document.all.hd_passwd.value
		+"&hd_phone="+document.all.hd_phone.value
		+"&hd_userPwd="+document.all.hd_userPwd.value
		+"&hd_bizType="+document.all.hd_bizType.value
		+"&oldProdId="+document.all.oldProdId.value
		+"&unitUsrId="+document.all.prodId.value
		+"&s_classCode=<%=s_classCode%>"
		,"","dialogWidth=800px;dialogHeight=600px");	
} 

function fn_AddProd()
{
	var s_retIfo=window.showModalDialog("f_g667_addIfo.jsp"
		+"?hd_loginacc="+document.all.hd_loginacc.value
		+"&hd_chnSrc="+document.all.hd_chnSrc.value
		+"&hd_opCode="+document.all.hd_opCode.value
		+"&hd_workNo="+document.all.hd_workNo.value
		+"&hd_passwd="+document.all.hd_passwd.value
		+"&hd_phone="+document.all.hd_phone.value
		+"&hd_userPwd="+document.all.hd_userPwd.value
		+"&hd_bizType="+document.all.hd_bizType.value
		+"&oldProdId="+document.all.oldProdId.value
		+"&unitUsrId="+document.all.unitUsrId.value
		+"&s_classCode=<%=s_classCode%>"
		,"","dialogWidth=800px;dialogHeight=600px");	
	if ( typeof (s_retIfo)=="undefined" )
	{
		rdShowMessageDialog("没有选择任何产品!");
		return false;
	}
		
	var a_prodBs=s_retIfo.split("|")[0];
	
	var s_prodAttr=s_retIfo.split("|")[1];
	/*产品服务附加属性start*/
	var s_prodAttr_1=s_retIfo.split("|")[2];

	var s_prodAId=a_prodBs.split("@")[0];//附加产品编号
	var s_prodId=a_prodBs.split("@")[1];//产品编码
	var s_prdPkgId=a_prodBs.split("@")[2];//归属产品包编码
	var s_prodInstID=a_prodBs.split("@")[3];//产品订购实例
	var s_userId=a_prodBs.split("@")[4];//用户唯一标识
	var s_prodName=a_prodBs.split("@")[5];//附加产品名称
	/*
		附加产品编号@产品编码@归属产品编码@产品订购实例@用户唯一标识@附加产品名称
	*/
	if ($("#tb_addIfo th").length==0 )
	{
		$("#tb_addIfo").append("<tr>"
			+"<th align='center' >附加产品编号</th>"
			+"<th align='center' >附加产品名称</th>"
			+"<th align='center' >产品编码</th>"
			+"<th align='center' >归属产品包编码</th>"
			+"<th align='center' >产品订购实例唯一标识</th>"
			+"<th align='center' >生效时间</th>"
			+"<th align='center' >失效时间</th>"
			+"<th align='center' >状态</th>"
			+"<th align='center' >操作</th>"
		+"</tr>");
	}	
	
	$("#tb_addIfo").append("<tr>"
		+"<td align='center'>"
			+"<input type='text' name='t_addId'  ch_name='附加产品编号' value='"+s_prodAId+"' class='InputGrey' readOnly >"
			+"<input type='hidden' id ='str_attr' name='text'  ch_name='附加产品属性' value='"+s_prodAttr+"' class='InputGrey' readOnly >"
			+"<input type='hidden' id ='str_attr_1' name='text_1'  ch_name='附加产品属性' value='"+s_prodAttr_1+"' class='InputGrey' readOnly >"
		+"</td>"
		+"<td align='center'>"
			+"<input type='text' name='t_addname'  ch_name='附加产品名称' value='"+s_prodName+"' class='InputGrey' readOnly >"
		+"</td>"
		+"<td align='center'>"
			+"<input type='text' name='t_prodid'   ch_name='产品编码'  value='"+s_prodId+"' class='InputGrey' readOnly >"
		+"</td>"
		+"<td align='center'>"
			+"<input type='text' name='t_pkgid'  ch_name='归属产品包编码'   value='"+s_prdPkgId+"' class='InputGrey' readOnly >"
		+"</td>"		
		+"<td align='center'>"
			+"<input type='text' name='t_orderid'  ch_name='产品订购实例唯一标识'   value='"+s_prodInstID+"' class='InputGrey' readOnly >"
		+"</td>"		
		+"<td align='center'>"
			+"<input type='text' name='t_orderid'  ch_name='生效时间'   value='' class='InputGrey' readOnly >"
		+"</td>"			
		+"<td align='center'>"
			+"<input type='text' name='t_orderid'  ch_name='失效时间'   value='' class='InputGrey' readOnly >"
		+"</td>"	
		+"<td align='center'>"
		+"</td>"						
		+"<td align='center'>"
				+"<input type ='button' value='删除' class='b_text'"
					+"style='cursor:Pointer;' class='del_cls'  alt='删除选择的产品' "
					+"onclick='delrow(this)'>"	
		+"</td>"		
	+"</tr>");
}
	/*删除所选择的产品*/
	function delrow(k)
	{
		$(k).parent().parent().remove(); 
	}
	
	/*变更所选择的产品*/
	function fn_selUnit1(i)
	{
		
		if("1"!=document.getElementsByName("o_backFlag")[i].value){
			$("#b_back"+i).attr("disabled" , true);
			$("#b_cclback"+i).attr("disabled" , true);
			$("#b_update"+i).attr("disabled" , false);
			$("#b_update1"+i).attr("disabled" , true);
			$("#o_backFlag"+i).val("2");
		}
		
		
		var s_retIfo=window.showModalDialog("f_g667_unitIfo1.jsp"
			+"?hd_loginacc="+document.all.hd_loginacc.value
			+"&hd_chnSrc="+document.all.hd_chnSrc.value
			+"&hd_opCode="+document.all.hd_opCode.value
			+"&hd_workNo="+document.all.hd_workNo.value
			+"&hd_passwd="+document.all.hd_passwd.value
			+"&hd_phone="+document.all.unitUsrId.value
			+"&hd_userPwd="+document.all.hd_userPwd.value
			+"&iOfferId="+document.getElementsByName("o_addId")[i].value
			+"&iNetWorkId="+document.getElementsByName("o_prodId")[i].value
			+"&opType=03"
			+"&index="+i
			,"","dialogWidth=800px;b=600px");
alert("变更出参main:"+s_retIfo);
 

		if ( typeof ( s_retIfo ) !="undefined")
		{
			
			$("#tb_addIfo").append(		
				"<input type='hidden' id ='s_retIfo' name='s_retIfo'  ch_name='附加产品属性' value='"+s_retIfo+"' class='InputGrey' readOnly >"
			);
		}
		
		
	}
	/*变更所选择的产品   变更黑名单*/
	function fn_selUnit2(i)
	{
		
		if("1"!=document.getElementsByName("o_backFlag")[i].value){
			$("#b_back"+i).attr("disabled" , true);
			$("#b_cclback"+i).attr("disabled" , true);
			$("#b_update"+i).attr("disabled" , true);
			$("#b_update1"+i).attr("disabled" , false);
			$("#o_backFlag"+i).val("2");
		}
		
		
		var s_retIfo=window.showModalDialog("f_g667_unitIfo2.jsp"
			+"?hd_loginacc="+document.all.hd_loginacc.value
			+"&hd_chnSrc="+document.all.hd_chnSrc.value
			+"&hd_opCode="+document.all.hd_opCode.value
			+"&hd_workNo="+document.all.hd_workNo.value
			+"&hd_passwd="+document.all.hd_passwd.value
			+"&hd_phone="+document.all.unitUsrId.value
			+"&hd_userPwd="+document.all.hd_userPwd.value
			+"&iOfferId="+document.getElementsByName("o_addId")[i].value
			+"&iNetWorkId="+document.getElementsByName("o_prodId")[i].value
			+"&opType=03"
			+"&black=B"
			+"&index="+i
			,"","dialogWidth=800px;b=600px");
alert("变更出参main:"+s_retIfo);
 

		if ( typeof ( s_retIfo ) !="undefined")
		{
			
			$("#tb_addIfo").append(		
				"<input type='hidden' id ='s_retIfo' name='s_retIfo'  ch_name='附加产品属性' value='"+s_retIfo+"' class='InputGrey' readOnly >"
			);
		}
		
		
	}
</script>
</body>
</html>
