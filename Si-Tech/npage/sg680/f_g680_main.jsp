
<%
/*
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
<%@ include file="../../npage/public/checkPhone.jsp" %>
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
	<script language="javascript" type="text/javascript" src="f_g680.js"></script>		
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
<input type="hidden" id="hd_ofrId" name ="hd_ofrId"	value= "">
<input type="hidden" id="hd_prodNm" name ="hd_prodNm"	value= "">
<input type="hidden" id="hd_unitChkFlag" name ="hd_unitChkFlag"	value= "">
<input type="hidden" id="hd_uOfrid" name ="hd_uOfrid"	value= "">
<input type="hidden" id="hd_custId" name ="hd_custId"	value= "">
<input type="hidden" id="hd_unitPwdChkFlag" name ="hd_unitPwdChkFlag"	value= "">
<input type="hidden" id="prodRetStr" name ="prodRetStr"	value= "">
<input type="hidden" id="a_bsIfo" name="a_bsIfo" value="0">
<input type="hidden" id="a_addName" name="a_addName" value="0">
<input type="hidden" id="a_ifNeeds" name="a_ifNeeds" value="0">
<input type="hidden" id="hd_opName" name="hd_opName" value="<%=opName%>">
<input type="hidden" id="jsonText" name ="jsonText"	value= "">
<input type="hidden" id="uUserNo" name ="uUserNo"	value= "">
<input type="hidden" id="showText" name ="showText"	value= "">
<%@ include file="/npage/include/header.jsp" %>

<DIV id="Operation_Table">
	<div id="d0" name="d0" style="display:none">
		<div class="title" >
			<div id="title_zi">集团用户信息查询</div>
		</div>
		<table>
			<tr>
				<td class="blue" align="center" width="25%">证件号码:</td>
				<td width="25%">
					<input type="text" id='t_idIccid' name='t_idIccid' ch_name='证件号码'/>	
					<input type="button" class="b_text" value="查询" onclick="fn_selUnit()" >	
				</td>	
				<td class="blue" align="center">EC唯一标识:</td>
				<td width="25%">
					<input type="text" id='t_customerNumber' name='t_customerNumber' ch_name='EC唯一标识' />	
				</td>	
			<tr>		
			<tr>
				<td class="blue" align="center" width="25%">集团编号:</td>
				<td width="25%">
					<input type="text" id='t_UnitId' name='t_UnitId' ch_name='集团编号'  />	
				</td>	
				<td class="blue" align="center">集团产品ID:</td>
				<td>
					<input type="text" id="prodId" name="prodId"/>	
				</td>	
			<tr>	
			<tr>
				<td class="blue" align="center" width="25%">集团客户名称:</td>
				<td width="25%">
					<input type="text" id="unitname" name="unitname"/>	
				</td>	
				<td class="blue" align="center">产品名称:</td>
				<td>
					<input type="text" id="prodNm" name ="prodNm"/>	
				</td>	
			<tr>					
			<tr>
				<td class="blue" align="center" width="25%">EC企业产品对应的用户ID:</td>
				<td width="25%">
					<input type="text" id="ecUsrId" name="ecUsrId"/>	
				</td>	
				<td class="blue" align="center">企业产品订购实例唯一标识:</td>
				<td>
					<input type="text" id="prodOdId" name ="prodOdId"/>	
				</td>	
			<tr>	
			<tr>
				<td class="blue" align="center" width="25%">集团客户密码:</td>
				<td colspan='3'>
					<jsp:include page="/npage/common/pwd_8.jsp">
						<jsp:param name="width1" value="16%"  />
						<jsp:param name="width2" value="34%"  />
						<jsp:param name="pname" value="product_pwd"  />
						<jsp:param name="pwd" value=""  />
					</jsp:include>
					<input type='button' class='b_text' id='chk_productPwd' name='chk_productPwd' 
						onClick='chkProductPwd()' value='校验' />
					<font class="orange">*</font>
				</td>		
			<tr>																						
		</table>
	</div>
	
	<div id='d2' style="display:none">
		<div class="title" >
			<div id="title_zi">成员资费信息</div>
		</div>
		<table>
			<tr>
				<td class="blue" align="center" width="25%">手机号码:</td>
				<td  width="25%">
					<input type='text' id='phone_no' name='phone_no'>
					<input type='button' class='b_text' id='btn_phoneno' name='btn_phoneno' value='查询' onclick='fn_qryMIfo()' >
				</td>
				<td class="blue" align="center" width="25%">用户名称:</td>
				<td width="25%">
					<input type='text' id='user_name' name='user_name'>
				</td>				
			</tr>
			<tr>
				<td class="blue" align="center" width="25%">成员资费代码:</td>
				<td width="25%">
					<input type='text' id='m_ofr_id' name='m_ofr_id' class='InputGrey' readOnly >
				</td>
				<td class="blue" align="center" width="25%">成员资费名称:</td>
				<td width="25%">
					<input type='text' id='m_ofr_name' name='m_ofr_name' class='InputGrey' readOnly >
				</td>				
			</tr>
			<tr>
				<td class="blue" align="center" width="25%">成员产品编码:</td>
				<td width="25%">
					<input type='text' id='m_prod_id' name='m_prod_id' class='InputGrey' readOnly >
				</td>
				<td class="blue" align="center" width="25%">成员产品订购实例唯一标识:</td>
				<td width="25%">
					<input type='text' id='m_order_id' name='m_order_id' class='InputGrey' readOnly >
				</td>				
			</tr>	
			<tr>
				<td class="blue" align="center" width="25%">成员的用户ID:</td>
				<td  width="25%">
					<input type='text' id='m_usr_id' name='m_usr_id' class='InputGrey' readOnly >
				</td>
				<td class="blue" align="center" width="25%">销售省编码:</td>
				<td  width="25%">
					<input type='text' id='prov_id' name='prov_id' class='InputGrey' readOnly >
				</td>				
			</tr>									
		</table>
	</div>
	<div id='d3' style="display:none">
		<div class="title" >
			<div id="title_zi">成员原子产品信息</div>
		</div>
		<table  id='tb_ifof2'>
			<tr>
				<th>资费代码</th>		
				<th>资费名称</th>		
				<th>原子产品代码</th>		
				<th>归属产品包代码</th>		
				<th>产品订购实例唯一标识</th>		
				<th>生效时间</th>		
				<th>失效时间</th>		
				<th>状态</th>		
				<th>操作</th>		
			</tr>
		</table>
		<table>
			<tr>
				<td align="center">
					<input type='button' id='add_prod' name='add_prod' value='增加' class='b_text' onclick='fn_addprod()'>
				</td>
			</tr>
		</table>
	</div>
	
	<div id='d9' style="display:none">
		<table>
			<tr> 
				<td  id="footer">
					<input class="b_foot" type="button"  id="b_cfm" name="b_cfm" value="下一步"
						onClick="fn_next();">
					<input class="b_foot" type="button" name="b_clr" value="清除"
						onClick="location.reload()">
					<input class="b_foot" type="button" name="b_cls" value="关闭"
						onClick="removeCurrentTab();">								
				</td>
			</tr>
		</table>
	</div>		
</DIV>
	<jsp:include page="/npage/common/pwd_comm.jsp"/>
</form>
<script>
var stepNum=0;
$(document).ready(
	function ()
	{
		$("#d0").show("slow");
		$("#d9").show("slow");
		stepNum=stepNum+1;
	}
);

function fn_qryMIfo()
{	
	var packet = new AJAXPacket("f_g680_ajax.jsp","请稍后...");
	packet.data.add("iLoginAccept" 		,"");
	packet.data.add("iChnSource" 		,"01");
	packet.data.add("iOpCode" 			,document.all.hd_opCode.value);
	packet.data.add("iLoginNo" 			,"<%=s_workNo%>");
	packet.data.add("iLoginPwd" 		,"<%=s_passwd%>");
	
	packet.data.add("iPhoneNo" 			,$("#phone_no").val() );
	packet.data.add("iUserPwd" 			,"");
	packet.data.add("iSubsId" 			,$("#prodId").val());
	
	packet.data.add("iProdInstId" 			,$("#prodOdId").val());
	packet.data.add("ecUsrId" 			,$("#ecUsrId").val());
	
	packet.data.add("ajaxType"			,"fn_doQryMIfo");
 
	core.ajax.sendPacket(packet		,fn_doQryMIfo,true);//异步	
 
}

function fn_doQryMIfo(packet)
{
	var v_retCode=packet.data.findValueByName("oRetCode");
	var v_retMsg=packet.data.findValueByName("oRetMsg");

	if ( "000000"!=v_retCode )
	{
		rdShowMessageDialog(v_retCode+":"+v_retMsg , 0);
		return false;
	}
	else
	{
		$("#phone_no").val(packet.data.findValueByName("oPhoneNo"));
		$("#user_name").val(packet.data.findValueByName("oUserName"));
		$("#m_ofr_id").val(packet.data.findValueByName("oOfferId"));
		$("#m_ofr_name").val(packet.data.findValueByName("oOfferName"));
		$("#m_prod_id").val(packet.data.findValueByName("oProdId"));
		   
		$("#m_order_id").val(packet.data.findValueByName("oProdInstId"));
		$("#m_usr_id").val(packet.data.findValueByName("oMemSubsId"));
		$("#prov_id").val(packet.data.findValueByName("oProvinceId"));
           
		$("#phone_no").attr("disabled" , true);
		$("#user_name").attr("disabled" , true);
		$("#m_ofr_id").attr("disabled" , true);
		$("#m_ofr_name").attr("disabled" , true);
		$("#m_prod_id").attr("disabled" , true);
		   
		$("#m_order_id").attr("disabled" , true);
		$("#m_usr_id").attr("disabled" , true);
		$("#prov_id").attr("disabled" , true);
	}
}

function fn_addprod()
{
	var s_retinfo=window.showModalDialog("f_g680_prod.jsp"
		+"?hd_loginacc="+document.all.hd_loginacc.value
		+"&hd_chnSrc="+document.all.hd_chnSrc.value
		+"&hd_opCode="+document.all.hd_opCode.value
		+"&hd_workNo="+document.all.hd_workNo.value
		+"&hd_passwd="+document.all.hd_passwd.value
		+"&hd_phone="+document.all.hd_phone.value
		+"&hd_userPwd="+document.all.hd_userPwd.value
		+"&t_UnitId="+document.all.t_UnitId.value
		+"&prodId="+document.all.prodId.value
		+"&hd_uOfrid="+document.all.hd_uOfrid.value
		+"&hd_opType="+document.all.hd_opType.value
		,"","dialogWidth=800px;dialogHeight=600px");
	if ( typeof(s_retinfo)=="undefined" )
	{
		return false;
	}
	
	$("#prodRetStr").val(s_retinfo);
	var a_bsIfo =s_retinfo.split("|")[0]; 
	var a_retStr =s_retinfo.split("|")[1]; 
	var a_retStr_1 =s_retinfo.split("|")[2];
	
	//var a_bsIfo =s_retinfo.split("~")[0]; 
	var a_servId =a_retStr.split("~")[1]; 
	var a_addId =a_retStr.split("~")[2]; 
	var a_addName =a_retStr.split("~")[3]; 
	var a_addDef =a_retStr.split("~")[4]; 
	var a_ifNeeds =a_retStr.split("~")[5];
	
	$("#a_bsIfo").val(a_bsIfo);

	if ($("#tb_ifof2 th").length==0 )
	{
		$("#tb_ifof2").append("<tr>"
			+"<th align='center'>资费代码</th>"
			+"<th align='center'>资费名称</th>"
			+"<th align='center'>原子产品编码</th>"
			+"<th align='center'>归属产品包编码</th>"
			+"<th align='center'>产品订购实例唯一标识</th>"
			+"<th align='center'>生效时间</th>"
			+"<th align='center'>失效时间</th>"
			+"<th align='center'>状态</th>"
			+"<th align='center'>操作</th>	"
		+"</tr>");
	}
	$("#tb_ifof2").append("<tr>"
			+"<td align='center'>"
				+"<input type='text' class='InputGrey' readOnly name='bs_OfrId' value='"+	a_bsIfo.split("@")[0]+"'>"
				+"<input type='hidden' class='InputGrey' readOnly name='a_servId' value='"+	a_servId+"'>"
				+"<input type='hidden' class='InputGrey' readOnly name='a_addId' value='"+	a_addId+"'>"
				+"<input type='hidden' class='InputGrey' readOnly name='a_addDef' value='"+	a_addDef+"'>"
				+"<input type='hidden' class='InputGrey' readOnly name='a_retStr' value='"+a_retStr+"'>"
				+"<input type='hidden' class='InputGrey' readOnly name='a_retStr_1' value='"+a_retStr_1+"'>"
			+"</td>"
			+"<td align='center'>"
				+"<input type='text' class='InputGrey' readOnly name='bs_ofrNm' value='"+	a_bsIfo.split("@")[1]+"'>"
			+"</td>"				
			+"<td align='center'>"
				+"<input type='text' class='InputGrey' readOnly name='bs_prodid' value='"+	a_bsIfo.split("@")[2]+"'>"
			+"</td>"
			+"<td align='center'>"
				+"<input type='text' class='InputGrey' readOnly name='bs_pkgid' value='"+	a_bsIfo.split("@")[3]+"'>"
			+"</td>"
			+"<td align='center'>"
				+"<input type='text' class='InputGrey' readOnly name='bs_odrId' value='"+	a_bsIfo.split("@")[4]+"'>"
			+"</td>"
			+"<td align='center'>"
				+"<input type='text' class='InputGrey' readOnly name='' value=''>"
			+"</td>"
			+"<td align='center'>"
				+"<input type='text' class='InputGrey' readOnly name='' value=''>"
			+"</td>"		
			+"<td align='center'></td>"		
			+"<td align='center'>"
				+"<img src='/nresources/default/images/task-item-close1.gif' name = 'i_delOther'"
					+"style='cursor:Pointer;' class='del_cls'  alt='删除选择的信息' "
					+"onclick='delrow(this)'>"	
			+"</td>	"
		+"</tr>");		
}

function fn_cclBack( i )
{
	$("#b_back"+i).attr("disabled" , false);
	$("#b_cclback"+i).attr("disabled" , true);
	$("#o_backFlag"+i).val("0");
}

function fn_back( i )
{
	$("#b_back"+i).attr("disabled" , true);
	$("#b_cclback"+i).attr("disabled" , false);
	$("#o_backFlag"+i).val("1");
}

function fn_doQryMPIfo( packet )
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
		if ($("#tb_ifof2 th").length==0 )
		{
			$("#tb_ifof2").append("<tr>"
				+"<th align='center' >资费代码</th>"
				+"<th align='center' >资费名称</th>"
				+"<th align='center' >原子产品编码</th>"
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
			var s_ServiceID="";
			var s_AttrKey="";
			var s_AttrValue="";
			
			if (v_jsn1.ProdInfo[i].ProdAttrInfo!=null)
			{
				while ( v_jsn1.ProdInfo[i].ProdAttrInfo[j]!=null  )
				{
					s_ServiceID=s_ServiceID+v_jsn1.ProdInfo[i].ProdAttrInfo[j].ServiceID+"@";
					s_AttrKey=s_AttrKey+v_jsn1.ProdInfo[i].ProdAttrInfo[j].AttrKey+"@";
					s_AttrValue=s_AttrValue+v_jsn1.ProdInfo[i].ProdAttrInfo[j].AttrValue+"@";
					j=j+1;
				}				
			}
			
			
			var ret_S = "";
			var is_disabled = "";
			
			if("A"==v_jsn1.ProdInfo[i].State){
				ret_S = "正常";
			}else if("F"==v_jsn1.ProdInfo[i].State){
				ret_S = "暂停";
			}else{
				ret_S = "已退订";
				is_disabled = "disabled";
			}
			
			
			var v_dis = v_jsn1.ProdInfo[i].State=="A" ? "disabled" :" ";
			
			$("#tb_ifof2").append("<tr>"
				+"<td align='center'>"
					+"<input type='text' name='o_addId'  ch_name='附加产品编号' value='"+v_jsn1.ProdInfo[i].OfferId+"' class='InputGrey' readOnly >"
					+"<input type='hidden' name='o_backFlag' id='o_backFlag"+i+"'  ch_name='' value='0'>"
					+"<input type='hidden' name='o_ServiceID' id='o_ServiceID"+i+"'  ch_name='' value='"+s_ServiceID+"'>"
					+"<input type='hidden' name='o_AttrKey' id='o_AttrKey"+i+"'  ch_name='' value='"+s_AttrKey+"'>"
					+"<input type='hidden' name='o_AttrValue' id='o_AttrValue"+i+"'  ch_name='' value='"+s_AttrValue+"'>"
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
					+"<input type='text' name='o_efftime'  ch_name='生效时间' "
						+"  value='"+v_jsn1.ProdInfo[i].ProdInstEffTime+"' class='InputGrey' readOnly >"
				+"</td>"				
				+"<td align='center'>"
					+"<input type='text' name='o_exptime'  ch_name='失效时间' "
						+" value='"+v_jsn1.ProdInfo[i].ProdInstExpTime+"' class='InputGrey' readOnly >"
				+"</td>"		
				+"<td align='center' width='50px'>"
					+
					 ret_S
				+"</td>"										
				+"<td align='center'>"
					+"<input type ='button' value='退订' class='b_text'  id='b_back"+i+"' "
						+"style='cursor:Pointer;' class='del_cls'  alt='' "  
						
						+  
						is_disabled
						
						+" onclick='fn_back("+i+")'>"	
					+"<input type ='button' value='取消' class='b_text' disabled id='b_cclback"+i+"' " 
						+"style='cursor:Pointer;' class='del_cls'  alt='' "
						+"onclick='fn_cclBack("+i+")'>"	
						+"<input type ='button' value='变更' class='b_text' id='b_update"+i+"' " 
						+"style='cursor:Pointer;' class='del_cls' style='display:none' alt='' "
						+"onclick='fn_selUnit22("+i+")'>"
				+"</td>"		
			+"</tr>");	
			if("I00010100096"==(v_jsn1.ProdInfo[i].ProdID)){
				$("#b_update"+i).show();
				
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
/*变更所选择的产品*/
function fn_selUnit22(i)
{
	
	if("1"!=document.getElementsByName("o_backFlag")[i].value){
		$("#b_back"+i).attr("disabled" , true);
		$("#b_cclback"+i).attr("disabled" , true);
		$("#b_update"+i).attr("disabled" , false);
		$("#b_update1"+i).attr("disabled" , true);
		$("#o_backFlag"+i).val("2");
	}
	
	
	var s_retIfo=window.showModalDialog("f_g680_unitIfo1.jsp"
		+"?hd_loginacc="+document.all.hd_loginacc.value
		+"&hd_chnSrc="+document.all.hd_chnSrc.value
		+"&hd_opCode="+document.all.hd_opCode.value
		+"&hd_workNo="+document.all.hd_workNo.value
		+"&hd_passwd="+document.all.hd_passwd.value
		+"&hd_phone="+document.all.uUserNo.value
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
	}else{
		$("#tb_addIfo").append(		
				"<input type='hidden' id ='s_retIfo' name='s_retIfo'  ch_name='附加产品属性' value='' class='InputGrey' readOnly >"
			);
	}
	
	
}
 

function delrow(k)
{
	$(k).parent().parent().remove(); 
}
function fn_next()
{
	if (stepNum==1)
	{
		
		$("#d0 input").attr("disabled" , "true");
		
		$("#d2").show("slow");
		stepNum=stepNum+1;
	}	
	else if (stepNum==2)
	{
		$("#d2 input").attr("disabled" , "true");
		$("#d3").show("slow");
		
		/*ajax\*/
		var packet = new AJAXPacket("f_g680_ajax.jsp","请稍后...");
		packet.data.add("iLoginAccept" 		,"");
		packet.data.add("iChnSource" 		,"01");
		packet.data.add("iOpCode" 			,document.all.hd_opCode.value);
		packet.data.add("iLoginNo" 			,"<%=s_workNo%>");
		packet.data.add("iLoginPwd" 		,"<%=s_passwd%>");
		
		packet.data.add("iPhoneNo" 			,$("#phone_no").val() );
		packet.data.add("iUserPwd" 			,"");
		packet.data.add("iSubsId" 			,$("#m_usr_id").val());		
		packet.data.add("iProdInstId" 		,$("#ecUsrId").val());
		packet.data.add("ajaxType"			,"fn_doQryMPIfo");
	 
		core.ajax.sendPacket(packet		,fn_doQryMPIfo,true);//异步			
		
		$("#b_cfm").val("确认");
		stepNum=stepNum+1;
	}	
	else if (stepNum==3)
	{
		var ipt = new input ();	
		
		ipt.setOrgCode("<%=s_orgCode%>");
		ipt.setIpAddress("<%=s_ipAddr%>");
		ipt.setOpNote("[<%=s_workNo%>]进行[<%=opName%>]操作");	
		ipt.setOrgId("<%=s_orgId%>");	
		ipt.setBelongCode("<%=s_belongCode%>");	
		
		ipt.setGroupId("<%=s_groupId%>");	
		ipt.setIdIccid(document.all.t_idIccid.value);	
		ipt.setUnitId(document.all.t_UnitId.value);		
		ipt.setCustomerNumber(document.all.t_customerNumber.value);	
		ipt.setECProdInstID(document.all.prodOdId.value);	
					
		ipt.setECSubsID(document.all.ecUsrId.value);
		
		var mIfo = new MemInfo();
		var v_pho=document.all.phone_no.value;
//		if(v_pho.substring(0,3)=="147")
//		{
//			v_pho="206"+v_pho.substring(3,v_pho.length);
//		}
		if(v_pho.substring(0,5)=="10647")
		{
			v_pho="206"+v_pho.substring(5,v_pho.length);
		}
		if(v_pho.substring(0,5)=="10648")
		{
			v_pho="205"+v_pho.substring(5,v_pho.length);
		}		
		
		mIfo.setPhoneNo(v_pho);		
		mIfo.setSubsID(document.all.m_usr_id.value);		
		mIfo.setOfferId(document.all.m_ofr_id.value);		
		mIfo.setProdID(document.all.m_prod_id.value);		
		mIfo.setProdInstID(document.all.m_order_id.value);		
		mIfo.setProvinceID(document.all.prov_id.value);		
		
		for ( var i=0;i<document.getElementsByName("bs_OfrId").length;i++ )
		{
			var pIfoA = new ProdInfoAdd();
			pIfoA.setOfferId(document.getElementsByName("bs_OfrId")[i].value);	
			pIfoA.setProdID(document.getElementsByName("bs_prodid")[i].value);	
			pIfoA.setPkgProdID(document.getElementsByName("bs_pkgid")[i].value);	
			pIfoA.setProdInstID(document.getElementsByName("bs_odrId")[i].value);	
			var a_retStr =  document.getElementsByName("a_retStr")[i].value;
			if(""!=a_retStr){
				s_pServId=a_retStr.split("~")[0];
				s_pAttrKey=a_retStr.split("~")[1];
				s_pAttrValue=a_retStr.split("~")[3];
				for ( var k=0;k<s_pServId.split("@").length;k++ )
				{
					var pAtt = new ProdAttrInfo();
					pAtt.setServiceID( s_pServId.split("@")[k] );	
					pAtt.setAttrKey( s_pAttrKey.split("@")[k] );	
					pAtt.setAttrValue( s_pAttrValue.split("@")[k] );	
					pIfoA.setProdAttrInfo(pAtt);
				}
			}	
			var a_retStr_1 =  document.getElementsByName("a_retStr_1")[i].value;
			if(""!=a_retStr_1){
				s_pServId=a_retStr_1.split("~")[0];
				s_pAttrKey=a_retStr_1.split("~")[1];
				s_pAttrValue=a_retStr_1.split("~")[3];
				for ( var k=0;k<s_pServId.split("@").length;k++ )
				{
					var pAtt = new ProdServiceAttrInfo();
					pAtt.setServiceID( s_pServId.split("@")[k] );	
					pAtt.setAttrKey( s_pAttrKey.split("@")[k] );	
					pAtt.setAttrValue( s_pAttrValue.split("@")[k] );	
					pIfoA.setProdServiceAttrInfo(pAtt);
				}
			}
			mIfo.setProdInfoAdd(pIfoA);
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
	
				if ( "" != document.getElementsByName("o_ServiceID")[i].value )
				{
					for ( var j=0;j<document.getElementsByName("o_ServiceID")[i].value.split("@").length;j++ )
					{
						if (""!= document.getElementsByName("o_ServiceID")[i].value.split("@")[j] )
						{
							var attr = new ProdAttrInfo();
							attr.setServiceID(document.getElementsByName("o_ServiceID")[i].value.split("@")[j]);
							attr.setAttrKey(document.getElementsByName("o_AttrKey")[i].value.split("@")[j]);
							attr.setAttrValue(document.getElementsByName("o_AttrValue")[i].value.split("@")[j]);
							pdel.setProdAttrInfo(attr);						
						}
					} 
				}

				mIfo.setProdInfoDel(pdel);				
			}
		}
		/*变更的产品*/
		alert("长度:"+document.getElementsByName("o_addid").length);
		for ( var i=0;i<document.getElementsByName("o_addid").length;i++ )
		{
			if ( "2"==document.getElementsByName("o_backFlag")[i].value )
			{
				var a_retStr =  document.getElementsByName("s_retIfo")[i].value;
				if (""!=document.getElementsByName("s_retIfo")[i].value)
				{
					var pdel = new ProdInfoDel();
					pdel.setOfferId(document.getElementsByName("o_addid")[i].value)
					pdel.setProdID(document.getElementsByName("o_prodid")[i].value)
					pdel.setPkgProdID(document.getElementsByName("o_pkgid")[i].value)
					pdel.setProdInstID(document.getElementsByName("o_orderid")[i].value)
					pdel.setOpType("03")
					
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
		}		
				
		ipt.setMemInfo(mIfo);
		var qka = new jqk();
		qka.setInput(ipt);
		/*拼json串*/
		var myJSONText = JSON.stringify(qka,function(key,value){
			return value;
		});
		
			if ("1"!=rdShowConfirmDialog("确认提交吗?"))
			{
				return false;
			}			
			
		$("#b_cfm").attr("disabled" , true);
		document.getElementById("jsonText").value=myJSONText;
		document.frm.action="f_g680_cfm.jsp";
		document.frm.submit();		
	}
}

function fn_selUnit()
{
	document.all.hd_unitChkFlag.value="0";
	var a_chkIfo = [ document.all.t_idIccid,document.all.t_UnitId,document.all.t_customerNumber ];
	
	if (0!=fn_chkAllNull(a_chkIfo)) return false;
	if (0!=fn_forInt(document.all.t_UnitId)) return false;
	if (0!=fn_forInt(document.all.t_customerNumber)) return false;

	var s_unitIfo=window.showModalDialog("f_g680_unitIfo.jsp"
		+"?hd_loginacc="+document.all.hd_loginacc.value
		+"&hd_chnSrc="+document.all.hd_chnSrc.value
		+"&hd_opCode="+document.all.hd_opCode.value
		+"&hd_workNo="+document.all.hd_workNo.value
		+"&hd_passwd="+document.all.hd_passwd.value
		+"&hd_phone="+document.all.hd_phone.value
		+"&hd_userPwd="+document.all.hd_userPwd.value
		+"&t_UnitId="+document.all.t_UnitId.value
		+"&t_customerNumber="+document.all.t_customerNumber.value
		+"&t_idIccid="+document.all.t_idIccid.value
		+"&hd_opType="+document.all.hd_opType.value
		,"","dialogWidth=800px;dialogHeight=600px");


	if ( typeof (s_unitIfo)!="undefined" )
	{
		document.all.t_idIccid.value=s_unitIfo.split("@")[0];
		document.all.unitname.value=s_unitIfo.split("@")[2];
		document.all.t_UnitId.value=s_unitIfo.split("@")[1];
		document.all.t_customerNumber.value=s_unitIfo.split("@")[3];
		document.all.hd_uOfrid.value=s_unitIfo.split("@")[4];
		
		document.all.prodNm.value=s_unitIfo.split("@")[5];
		document.all.prodId.value=s_unitIfo.split("@")[6];
		document.all.prodOdId.value=s_unitIfo.split("@")[7];
		document.all.ecUsrId.value=s_unitIfo.split("@")[8];
		document.all.uUserNo.value=s_unitIfo.split("@")[9];
		document.all.hd_custId.value=s_unitIfo.split("@")[13];
		
		document.all.hd_unitChkFlag.value="1";
		
		$("#t_idIccid").attr("disabled" , true);
		$("#unitname").attr("disabled" , true);
		$("#t_UnitId").attr("disabled" , true);
		$("#t_customerNumber").attr("disabled" , true);
		$("#hd_uOfrid").attr("disabled" , true);
		
		$("#prodNm").attr("disabled" , true);
		$("#prodId").attr("disabled" , true);
		$("#prodOdId").attr("disabled" , true);
		$("#ecUsrId").attr("disabled" , true);
		$("#hd_custId").attr("disabled" , true);
	}	
}

/* 校验集团产品密码 */
function chkProductPwd()
{
	document.all.hd_unitPwdChkFlag.value="0";
	if ( document.all.hd_unitChkFlag.value!="1" )
	{
		rdShowMessageDialog("必须查询集团信息");
		return false;
	}
	
	var cust_id = document.all.hd_custId.value;
	var Pwd1 = document.all.product_pwd.value;
	var checkPwd_Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/s7983/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
	checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("cust_id",cust_id);
	checkPwd_Packet.data.add("Pwd1",Pwd1);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet = null;
}

function doProcess(packet)
{
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMessage=packet.data.findValueByName("retMessage");
	
	var backArrMsg = packet.data.findValueByName("backArrMsg");
	var backArrMsg1 = packet.data.findValueByName("backArrMsg1");
	var backArrMsg2=packet.data.findValueByName("backArrMsg2");
	
	self.status="";
	if(retType == "checkPwd") //集团客户密码校验
	{
		if(retCode == "000000")
		{
			var retResult = packet.data.findValueByName("retResult");
			if (retResult == "false") 
			{
				rdShowMessageDialog("客户密码校验失败，请重新输入！",0);
				frm.product_pwd.value = "";
				frm.product_pwd.focus();
				document.all.hd_unitPwdChkFlag.value="0";
				return false;
			} 
			else 
			{
				rdShowMessageDialog("客户密码校验成功！",2);
				document.all.product_pwd.disabled=true;
				document.all.hd_unitPwdChkFlag.value="1";
			}
		}
		else
		{
			rdShowMessageDialog("客户密码校验出错，请重新校验！",0);
			document.all.hd_unitPwdChkFlag.value="0";
			return false;
		}
	}
}    

</script>
</body>
</html>
