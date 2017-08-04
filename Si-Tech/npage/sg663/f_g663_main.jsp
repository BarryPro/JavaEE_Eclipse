
<%
/*
 * 功能: g663.集团物联网成员添加 
 * 版本: 1.0
 * 日期: 2012/9/3 11:05:33
 * 作者: zhangyan
 * 版权: si-tech
 * update:
*/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/public/pubSASql.jsp" %>
<%@ include file="../../npage/public/checkPhone.jsp" %>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="sLoginAccept"/>
<%
String s_loginacc= sLoginAccept;
String s_chnSrc="01";
String opCode=request.getParameter("opCode");
String s_workNo = (String)session.getAttribute("workNo");
String s_passwd = (String)session.getAttribute("password");
String s_phone="";
String s_userPwd="";

String opName=request.getParameter("opName");
String s_orgCode=(String)session.getAttribute("orgCode");
String s_ipAddr = (String)session.getAttribute("ipAddr");
String s_orgId = (String)session.getAttribute("orgId");
String s_belongCode = (String)session.getAttribute("orgCode");
String s_groupId = (String)session.getAttribute("groupId");
%>
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
	<title><%=opCode%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/zalidate.js"></script>
	<script src="../public/json2.js" type="text/javascript"></script>	
	<script language="javascript" type="text/javascript" src="f_g663.js"></script>
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
	<input type="hidden" id="hd_unitOffer" name ="hd_unitOffer"	value= "">
	<input type='hidden' id='inputFile' name='inputFile' value='' />
	<input type='hidden' id='filenames' name='filenames' value='' />
	<input type="hidden" id="hd_custId" name ="hd_custId"	value= "">
	<input type="hidden" id="hd_unitChkFlag" name="hd_unitChkFlag" value="0">
	<input type="hidden" id="hd_unitPwdChkFlag" name="hd_unitPwdChkFlag" value="0">
	<input type="hidden" id="hd_retPho" name="hd_retPho" value="0">

	<input type="hidden" id="hd_bizType" name="hd_bizType" value="0">
	<input type="hidden" id="jsonText" name ="jsonText"	value= "">
	<input type="hidden" id="hd_prodAttr" 		name="hd_prodAttr" value = "0">
	<input type="hidden" id="hd_prodAttr1" 		name="hd_prodAttr1" value = "0">
	<iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>

	<%@ include file="/npage/include/header.jsp" %>

	<DIV id="Operation_Table">
		<div id="d0" name="d0">
			<div class="title" id="d_1">
				<div id="title_zi">集团用户信息查询</div>
			</div>
			<table id="tb_1">
				<tr>
					<td class="blue" align="center" width="25%">证件号码:</th>
					<td width="25%">
						<input type="text" id="t_idIccid" name="t_idIccid" ch_name="证件号码" size="20" />	
						<input type="button" class="b_text" value="查询" onclick="fn_selUnit()">	
					</td>	
					<td class="blue" align="center">EC唯一标识:</th>
					<td>
						<input type="text" id="t_customerNumber" name="t_customerNumber" ch_name="EC唯一标识" size="20" />	
					</td>	
				<tr>
				<tr>
					<td class="blue" align="center">集团编号:</th>
					<td>
						<input type="text" ch_name="集团编号" id="t_UnitId" name="t_UnitId"/>	
					</td>	
					<td class="blue" align="center">企业产品订购实例<br>唯一标识:</th>
					<td>
						<input type="text" ch_name="企业产品订购实例唯一标识" id="t_ECProdInstID" name="t_ECProdInstID"/>	
					</td>	
				<tr>		
				<tr>
					<td class="blue" align="center">产品名称:</th>
					<td>
						<input type="text" name="t_prodName" id="t_prodName" ch_name="产品名称"/>	
						<input type="hidden" ch_name="产品ID" value = "" name="hd_prodId" id="hd_prodId">
					</td>	
					<td class="blue" align="center">EC企业产品实例<br>对应的用户ID:</th>
					<td>
						<input type="text" name="t_ECSubsID" id="t_ECSubsID" ch_name="EC企业产品实例对应的用户ID"/>	
					</td>	
				<tr>					
				<tr>
					<td class="blue" align="center">品牌名称:</th>
					<td>
						<input type="text" ch_name="品牌名称" name='t_smName' class="InputGrey" value='PA-->集团物联网'/>
						<input type="hidden" name='hd_smCode' value='PA'>	
					</td>	
					<td class="blue" align="center">销售省编码:</th>
					<td>
						<select id='provid' name='provname' disabled>
							<option value='100'>100-->北京移动</option>
							<option value='200'>200-->广东移动</option>
							<option value='210'>210-->上海移动</option>
							<option value='220'>220-->天津移动</option>
							<option value='230'>230-->重庆移动</option>
							<option value='240'>240-->辽宁移动</option>
							<option value='250'>250-->江苏移动</option>
							<option value='270'>270-->湖北移动</option>
							<option value='280'>280-->四川移动</option>
							<option value='290'>290-->陕西移动</option>
							<option value='991'>991-->新疆移动</option>
							<option value='002'>002-->物联网公司</option>
							<option value='311'>311-->河北移动</option>
							<option value='351'>351-->山西移动</option>
							<option value='371'>371-->河南移动</option>
							<option value='431'>431-->吉林移动</option>
							<option value='451' selected>451-->黑龙江移动</option>
							<option value='471'>471-->内蒙移动</option>
							<option value='531'>531-->山东移动</option>
							<option value='551'>551-->安徽移动</option>
							<option value='571'>571-->浙江移动</option>
							<option value='591'>591-->福建移动</option>
							<option value='000'>000-->全网平台</option>
							<option value='731'>731-->湖南移动</option>
							<option value='771'>771-->广西移动</option>
							<option value='791'>791-->江西移动</option>
							<option value='851'>851-->贵州移动</option>
							<option value='871'>871-->云南移动</option>
							<option value='891'>891-->西藏移动</option>
							<option value='898'>898-->海南移动</option>						
						</select>
					</td>	
				<tr>
				<tr>
			        <td class='blue'  align="center" nowrap>集团客户密码</td>
			        <td>
			            <jsp:include page="/npage/common/pwd_8.jsp">
			                <jsp:param name="width1" value="16%"  />
			                <jsp:param name="width2" value="34%"  />
			                <jsp:param name="pname" value="product_pwd"  />
			                <jsp:param name="pwd" value=""  />
			            </jsp:include>
			            <input type='button' class='b_text' id='chk_productPwd' name='chk_productPwd' onClick='chkProductPwd()' value='校验' />
			            <font class="orange">*</font>
			        </td>
					<td class="blue" align="center">号码录入方式:</th>
					<td>
						<input type="radio" name ="r_opType" id ="r_opType" value="1" checked/>文件
					</td>	
				<tr>				
					
					<!-- hejwa add 2015/5/25 10:18:00  需求名称：关于协助在集团产品开户界面增加SA代理商发展选项需求的函 -->
		<tr>
			<td class="blue"  align="center">销售代理商</td>
			<td >
				<input type="text" name="F1006" id="F1006" readOnly class="InputGrey" >
				<input type="button" value="查询" class="b_text" onclick="selSales();" >
			</td>
			
			<td class="blue"  align="center">成员套餐折扣</td>
			<td>
				<select id="mem_off_disc" name="mem_off_disc">
					<option value="100" selected>无折扣</option>
					<option value="70" >7折</option>
				</select>
			</td>
		</tr>
		
		
		<tr>
			<td class="blue"  align="center">付费方式 </td>
			<td>
					<select name="pay_flag" id="pay_flag">
        	    <option value="0" selected>0--集团统付</option> 
            	<option value="1">1--个人付费</option>
          </select>
			</td>
			
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			
		</tr>
		
		
		
			</table>
		</div>
		<div class="title" id="d_ttl2" style="display:none">
			<div id="title_zi">成员信息列表</div>
		</div>
		<table id="tb_ifo2" style="display:none">
			<tr>
				<th class="blue" align="center">成员号码</th>
				<th class="blue" align="center">成员的用户ID</th>
				<th class="blue" align="center">成员产品号码</th>
				<th class="blue" align="center">成员产品订购实例唯一标识</th>
				<th class="blue" align="center">操作</th>
			<tr>
		</table>		
		<table id="tb_opr2" style="display:none">
			<tr> 
				<td align = "center">
					<input class="b_text" type="button"  value="新增" name="b_addMem" onclick="fn_addMeb()" >						
				</td>
			</tr>
		</table>		
			
		<div name="d1" id="d1">
			<div class="title" id="d_ttlf2">
				<div id="title_zi">成员原子产品信息</div>
			</div>
			<table id="tb_ifof2" >
				<tr>
					<th align="center" >资费代码</th>
					<th align="center" >资费名称</th>
					<th align="center" >原子产品编码</th>
					<th align="center" >归属产品包编码</th>
					<th align="center" >产品订购实例唯一标识</th>
					<th align="center" >操作</th>
				</tr>							
			</table>		
			<table >
				<tr>
					<td align="center" >
						<input type="button" class="b_text" value="新增" onclick="fn_addMeb2()">
					</td>
				</tr>							
			</table>				
		</div>			
		
			
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
		<div name="d3" id="d3">		
			<div class="title" id="d_ttlf2">
				<div id="title_zi">成员文件</div>
			</div>
			<table id="tb_ifof3">
				<tr>
					<td align = "center"><input type="file"  value="" name="b_addMemf" id="b_addMemf" >	</td>	
					<td align="left">
						<font color='red' >
							文件中每个号码占一行,如:&nbsp&nbsp1064802090011
							<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
							&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp14702090014
						</font>
					</td>		
				</tr>
			</table>
		</div>
			
		<table>
			<tr> 
				<td  id="footer">
					<input class="b_foot" type="button" name=btnChk id='btnChk' value="下一步"
						onClick="fn_chkIfo();">
					<input class="b_foot" type="button" name=btnClr value="清除"
						onClick="location.reload();">
					<input class="b_foot" type="button" name=btnCls value="关闭"
						onClick="removeCurrentTab();">								
				</td>
			</tr>
		</table>	
	</div>
	<jsp:include page="/npage/common/pwd_comm.jsp"/>
</form>
<script>		
	
	

/**
 * hejwa add 2015/5/25 10:19:13
 * 后台人员：wangleic
 * 需求名称：关于协助在集团产品开户界面增加SA代理商发展选项需求的函
 * 增加成员级别属性，销售代理商，选填，后期不可以变更
 * 新增的属性仿照3690模块里的这个销售代理商就行，点击查询按钮，调用公共页面查询
 */
// 查询销售代理商
function selSales(){
    var pageTitle = "销售代理商查询";
    var fieldName = "代理商代码|代理商名称|";
    /* ningtn 关于优化集团客户SA酬金结算系统的函*/
    // ningtn SQL注入改造。
		var sqlStr="90000017";
		var params = "<%=s_groupId%>" + "|";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "1|0|";
    var retToField = "F1006|";
    PubSimpSelSales(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,params);
}

function PubSimpSelSales(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,params)
{
    var path = "/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    path = path + "&params=" + params;
    retInfo = window.showModalDialog(path);
    if(typeof(retInfo)=="undefined")      
    {   return false;   }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
    }
}



var stepNum;
$(document).ready(
	function()
	{
		$("#d0").show("slow");	
		$("#d1").hide();	
		$("#d2").hide();	
		$("#d3").hide();	
		stepNum=1;
	}
);
	
	/*删除所选择的产品*/
	function delrow(k)
	{
		$(k).parent().parent().remove(); 
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

	function fn_addMeb()
	{
		
		/*弹出成员添加页面*/
		var retVal=window.showModalDialog("f_g663_addMeb.jsp"
			+"?hd_loginacc="+document.all.hd_loginacc.value
			+"&hd_chnSrc="+document.all.hd_chnSrc.value
			+"&hd_opCode="+document.all.hd_opCode.value
			+"&hd_workNo="+document.all.hd_workNo.value
			+"&hd_passwd="+document.all.hd_passwd.value
			+"&hd_phone="+document.all.hd_phone.value
			+"&hd_userPwd="+document.all.hd_userPwd.value
			+"&t_UnitId="+document.all.t_UnitId.value
			+"&hd_unitOffer="+document.all.hd_unitOffer.value
			+"&hd_prodId="+document.all.hd_prodId.value
			+"&t_ECSubsID="+document.all.t_ECSubsID.value
			,"","dialogWidth=800px;dialogHeight=600px");	

		if ($("#tb_ifo2 th").length==0 )
		{
			$("#tb_ifo2").append("<tr>"
				+"<th align='center'>成员号码</th>"
				+"<th align='center'>成员的用户ID</th>"
				+"<th align='center'>成员产品号码</th>"
				+"<th align='center'>成员产品订购实例唯一标识</th>"
				+"<th align='center'>操作</th>	"
			+"</tr>");
		}

		if ( typeof (retVal)!="undefined" )
		{
	
		
			
		var mbIfo=retVal.split("#")[0];

			$("#tb_ifo2").append("<tr>"
				+"<td align='center'>"
					+"<input type='text' id='mebPho' name='mebPho' value='"+mbIfo.split("@")[0]+"' class='InputGrey'>"	
					+"<input type='hidden' id='mebIfo' name='mebIfo' value='"+retVal+"' class='InputGrey'>"	
				+"</td>"
				+"<td align='center'>"
					+"<input type='text' id='mebUsrId' name='mebUsrId' value='"+mbIfo.split("@")[1]+"' class='InputGrey'>"	
				+"</td>"
				+"<td align='center'>"
					+"<input type='text' id='mebProdId' name='mebProdId' value='"+mbIfo.split("@")[4]+"' class='InputGrey'>"	
				+"</td>"
				+"<td align='center'>"
					+"<input type='text' id='mebOdId' name='mebOdId' value='"+mbIfo.split("@")[2]+"' class='InputGrey'>"	
				+"</td>"
				+"<td align='center'>"
					+"<img src='/nresources/default/images/task-item-close1.gif' name = 'i_delProd'"
						+"style='cursor:Pointer;' class='del_cls'  alt='' "
						+"onclick='delrow(this)'>"	
				+"</td>"	
			+"</tr>");		
		}
	}
	

	function fn_chkIfo ()
	{
		if ( 1==stepNum )
		{
			if ( document.all.hd_unitChkFlag.value!="1" )
			{
				rdShowMessageDialog("必须查询集团信息",0);
				//stepNum=stepNum-1;
				return false;
			}
			if ( document.all.hd_unitPwdChkFlag.value!="1")
			{
				rdShowMessageDialog("必须校验集团客户密码",0);
				//stepNum=stepNum-1;
				return false;	
			}
			
			if ( 0==$(":radio:checked").val() )
			{
				$("#d_ttl2").show("slow");		
				$("#tb_ifo2").show("slow");		
				$("#tb_opr2").show("slow");		
			}
			else if (1==$(":radio:checked").val())
			{
				$("#d1").show("slow");		
			}
			
			else
			{
				rdShowMessageDialog("必须选择操作类型",0);
				//stepNum=stepNum-1;
				return false;	
			}
			$("#tb_1 input").attr("disabled" , "ture");
		}
		else if ( 2==stepNum )
		{
			if ( 0==$(":radio:checked").val() ) {
			}			
			else if (1==$(":radio:checked").val())
			{
				$("#d2").show("slow");		
			}			
		}
		else if ( 3==stepNum )
		{ 
			if ( 0==$(":radio:checked").val() )
			{

			}
			else if (1==$(":radio:checked").val())
			{
				$("#d3").show("slow");		
				$("#btnChk").val("确认");		
			}			
		}
		else if ( 4==stepNum )
		{
			if ( 0==$(":radio:checked").val() )
			{

			}
			else if (1==$(":radio:checked").val())
			{
				document.frm.target="hidden_frame";
				document.frm.encoding="multipart/form-data";
				document.frm.action="f_g663_upload.jsp";
				document.frm.method="post";
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
				if ("1"!=rdShowConfirmDialog("确认提交吗?"))
				{
					return false;
				}
				$("#btnChk").attr("disabled" , true)				
				document.frm.submit();	
			}	
		}
		stepNum=stepNum+1; 
	}
	
	function refMain()
	{
		var ipt = new input();
		
		var a_pho=$("#hd_retPho").val().substring(0,$("#hd_retPho").val().length-1);

		for ( var i=0;i<1;i++ )
		{
			
			var v_pho=a_pho.split("@")[i];
								

			var s_pServId="";
			var s_pAttrKey="";
			var s_pAttrValue="";
			for ( var j=0;j<document.getElementsByName("bs_prodid").length;j++ )
			{
				var pIfo = new ProdInfo();
				pIfo.setOfferId(document.getElementsByName("bs_OfrId")[j].value);
				pIfo.setProdID(document.getElementsByName("bs_prodid")[j].value);
				pIfo.setPkgProdID(document.getElementsByName("bs_pkgid")[j].value);
				var a_retStr =  document.getElementsByName("a_retStr")[j].value;
				if(""!=a_retStr){
					s_pServId=a_retStr.split("~")[0];
					s_pAttrKey=a_retStr.split("~")[1];
					s_pAttrValue=a_retStr.split("~")[3];
					for ( var k=0;k<s_pServId.split("@").length;k++ )
					{
						
							var pAIfo= new ProdAttrInfo();
							pAIfo.setServiceID(s_pServId.split("@")[k]);
							pAIfo.setAttrKey(s_pAttrKey.split("@")[k]);
							pAIfo.setAttrValue(s_pAttrValue.split("@")[k]);
							pIfo.setProdAttrInfo(pAIfo);		
						

					}
					
				}
				var a_retStr_1 =  document.getElementsByName("a_retStr_1")[j].value;
				if(""!=a_retStr_1){
					s_pServId=a_retStr_1.split("~")[0];
					s_pAttrKey=a_retStr_1.split("~")[1];
					s_pAttrValue=a_retStr_1.split("~")[3];
					for ( var k=0;k<s_pServId.split("@").length;k++ )
					{
						
							var pAIfo= new ProdServiceAttrInfo();
							pAIfo.setServiceID(s_pServId.split("@")[k]);
							pAIfo.setAttrKey(s_pAttrKey.split("@")[k]);
							pAIfo.setAttrValue(s_pAttrValue.split("@")[k]);
							pIfo.setProdServiceAttrInfo(pAIfo);		
						

					}
					
				}	
				
				ipt.setProdInfo(pIfo);
			}	
			
			for ( var ii=0;ii<document.getElementsByName("t_otherCode").length;ii++ )
			{
				var oIfo = new OtherInfo();
				oIfo.setInfoCode(document.getElementsByName("t_otherCode")[ii].value);
				oIfo.setInfoValue(document.getElementsByName("t_otherValue")[ii].value);
				ipt.setOtherInfo(oIfo);	
			}				
			
		}

		var qka = new jqk();
		qka.setInput(ipt);
		qka.setSa($("#F1006").val());	
		qka.setMemDiscount($("#mem_off_disc").val());	
		qka.setIpAddress("<%=s_ipAddr%>");		
		qka.setIdIccid(document.all.t_idIccid.value);			
		qka.setCustomerNumber(document.all.t_customerNumber.value);			
		qka.setUnitId(document.all.t_UnitId.value);			
		qka.setECProdInstID(document.all.t_ECProdInstID.value);			
		qka.setECSubsID(document.all.t_ECSubsID.value);			
		qka.setPayFlag(document.all.pay_flag.value);	

		/*拼json串*/
		var myJSONText = JSON.stringify(qka,function(key,value){
			return value;
		});
			
		document.getElementById("jsonText").value=myJSONText;	
		document.frm.target="_self";
	  document.frm.encoding="application/x-www-form-urlencoded";		
		document.frm.action="f_g663_cfm.jsp";
		document.frm.submit();		
	}
	
	function doUnLoading()
	{
	
	  stepNum="4"
		$("#btnChk").attr("disabled",false);
		unLoading();
	}
	
	function fn_selUnit()
	{
		document.all.hd_unitChkFlag.value="0";
		var a_chkIfo = [ document.all.t_idIccid,document.all.t_UnitId,document.all.t_customerNumber ];
		
		if (0!=fn_chkAllNull(a_chkIfo)) return false;
		if (0!=fn_forInt(document.all.t_UnitId)) return false;
		if (0!=fn_forInt(document.all.t_customerNumber)) return false;

		var s_unitIfo=window.showModalDialog("f_g663_unitIfo.jsp"
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
			document.all.t_UnitId.value=s_unitIfo.split("@")[2];
			document.all.t_customerNumber.value=s_unitIfo.split("@")[3];
			document.all.hd_unitOffer.value=s_unitIfo.split("@")[4];
			document.all.t_prodName.value=s_unitIfo.split("@")[5];
			document.all.hd_prodId.value=s_unitIfo.split("@")[6];
			//document.all.t_customerNumber.value=a_unitIfo.split("@")[3];
			document.all.t_ECProdInstID.value=s_unitIfo.split("@")[7];
			document.all.t_ECSubsID.value=s_unitIfo.split("@")[8];
			document.all.hd_custId.value=s_unitIfo.split("@")[13];
			document.all.hd_bizType.value=s_unitIfo.split("@")[14];
			document.all.hd_unitChkFlag.value="1";
			
			$("#t_idIccid").attr("disabled" , true);
			$("#t_UnitId").attr("disabled" , true);
			$("#t_customerNumber").attr("disabled" , true);
			$("#t_prodName").attr("disabled" , true);
			$("#t_ECProdInstID").attr("disabled" , true);
			$("#t_ECSubsID").attr("disabled" , true);
			
			if(s_unitIfo.split("@")[15]!="1"){//非直管客户标志
				$("#mem_off_disc").find("option[value='60']").remove();
			}
		}
	}

	
function fn_qryAddOfr()
{
	var s_addOfr=window.showModalDialog("f_g663_qryOfr.jsp"
		+"?s_loginacc=<%=s_loginacc%>"
		+"&s_chnSrc=<%=s_chnSrc%>"
		+"&s_opCode=<%=opCode%>"
		+"&s_workNo=<%=s_workNo%>"
		+"&s_passwd=<%=s_passwd%>"
		+"&s_phone=<%=s_phone%>"
		+"&s_userPwd=<%=s_userPwd%>"
		+"&r_opType="+$("#r_opType").val()
		+"&hd_bizType="+$("#hd_bizType").val()
		,"","dialogWidth=800px;dialogHeight=600px");
	if (  typeof (s_addOfr)!="undefined"  )
	{
		$("#t_OfferId").val(s_addOfr.split("@")[0]);
		$("#t_OfferName").val(s_addOfr.split("@")[1]);
		$("#t_ProdId").val(s_addOfr.split("@")[2]);		
	}	
}	


function fn_addMeb2()
{
	var opType="";
	for ( var i=0;i<document.getElementsByName("r_opType").length;i++ )
	{
		if ( document.getElementsByName("r_opType")[i].checked==true )
		{
			opType=document.getElementsByName("r_opType")[i].value
		}
	}
	
	var s_bsProd=window.showModalDialog("f_g663_bsProd.jsp"
		+"?s_loginacc=<%=s_loginacc%>"
		+"&s_chnSrc=<%=s_chnSrc%>"
		+"&s_opCode=<%=opCode%>"
		+"&s_workNo=<%=s_workNo%>"
		+"&s_passwd=<%=s_passwd%>"
		+"&s_phone=<%=s_phone%>"
		+"&s_userPwd=<%=s_userPwd%>"
		+"&s_unidId="+$("#t_UnitId").val()
		+"&s_unitOffer="+$("#hd_unitOffer").val()
		+"&s_prodId="+$("#hd_prodId").val()
		+"&r_opType="+opType
		,"","dialogWidth=800px;dialogHeight=600px");
	var a_bsIfo =s_bsProd.split("|")[0]; 
	var a_retStr =s_bsProd.split("|")[1]; 
	var a_retStr_1 =s_bsProd.split("|")[2];
	document.all.hd_prodAttr.value=a_retStr;
	document.all.hd_prodAttr1.value=a_retStr_1;
	var a_servId =a_retStr.split("@")[1]; 
	var a_addId =a_retStr.split("@")[2];
	var a_addName =a_retStr.split("@")[3]; 
	var a_addDef =a_retStr.split("@")[4]; 
	var a_ifNeeds =a_retStr.split("@")[5]; 
	
	
	
	$("#a_bsIfo").val(a_bsIfo);
	$("#a_servId").val(a_servId);
	$("#a_addId").val(a_addId);
	$("#a_addName").val(a_addName);
	$("#a_addDef").val(a_addDef);
	$("#a_ifNeeds").val(a_ifNeeds);
	
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
				+"<input type='hidden' class='InputGrey' readOnly name='a_bsIfos' value='"+	a_bsIfo+"'>"
				+"<input type='hidden' class='InputGrey' readOnly name='bs_OfrId' value='"+	a_bsIfo.split("@")[0]+"'>"
				+"<input type='hidden' class='InputGrey' readOnly name='a_servIds' value='"+a_servId+"'>"
				+"<input type='hidden' class='InputGrey' readOnly name='a_addIds' value='"+a_addId+"'>"
				+"<input type='hidden' class='InputGrey' readOnly name='a_addNames' value='"+a_addName+"'>"
				+"<input type='hidden' class='InputGrey' readOnly name='a_addDefs' value='"+a_addDef+"'>"
				+"<input type='hidden' class='InputGrey' readOnly name='a_ifNeedss' value='"+a_ifNeeds+"'>"
				+"<input type='hidden' class='InputGrey' readOnly name='a_retStr' value='"+a_retStr+"'>"
				+"<input type='hidden' class='InputGrey' readOnly name='a_retStr_1' value='"+a_retStr_1+"'>"
				

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
</script>
</body>
</html>
