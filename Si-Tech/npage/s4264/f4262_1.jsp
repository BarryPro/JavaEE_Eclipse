<%
/********************
 version v2.0
 开发商: si-tech
 作者: dujl
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<%        
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName"); 	
	String iPhoneNo = request.getParameter("phoneNo");
	
	String sale_name="";
	String phone_ty="";
            
	String loginNo = (String)session.getAttribute("workNo");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");  	
	
	StringBuffer  appsql = new StringBuffer();
	appsql.append("select level_code,level_name ");
	appsql.append("  from sUseLevel ");
	appsql.append(" where USE_FLAG = 'Y' ");
	System.out.println("appsql====="+appsql);
%>

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
<wtc:sql><%=appsql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result1" scope="end" />

<%
    String retFlag="",retMsg="";  
    String  bp_name="",sm_code="",rate_code="",sm_name="",phone_type="",use_unit="",use_department="";
    String  rate_name="",warning_money="",limit_money="",end_time="",type_code="",use_center="",cust_id="";
    String  bp_add="",cardId_type="", cardId_no="",use_application="",use_level="",type_co="";
    String unit_code="",department_code="",center_code="",application_code="",level_code="";

    String iOpCode = request.getParameter("opCode");
    String cus_pass = request.getParameter("cus_pass");	
    String monitorValue = "";

	String  inputParsm [] = new String[4];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = iOpCode;
	System.out.println("phoneNO === "+ iPhoneNo);
%>
	<wtc:service name="s4262Init" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCode2" retmsg="retMsg2" outnum="26">			
	<wtc:param value="<%=inputParsm[0]%>"/>	
	<wtc:param value="<%=inputParsm[1]%>"/>	
	<wtc:param value="<%=inputParsm[2]%>"/>	
	<wtc:param value="<%=inputParsm[3]%>"/>	
	</wtc:service>	
	<wtc:array id="tempArr"  scope="end"/>
<%
  String errCode = retCode2;
  String errMsg = retMsg2;

  if(tempArr.length==0)
  {
	   retFlag = "1";
	   retMsg = "s126bInit查询号码基本信息为空!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;  
  }
  else 
  {
	if(errCode.equals("000000") && tempArr.length>0)
	{
		if(!(tempArr[0][2].equals(""))){
		    bp_name = tempArr[0][2];           				//客户名称
		}
		if(!(tempArr[0][3].equals(""))){
		    bp_add = tempArr[0][3];           				//客户地址
		}
		if(!(tempArr[0][4].equals(""))){
		    cardId_type = tempArr[0][4]; 					//证件类型
		} 
		if(!(tempArr[0][5].equals(""))){
		    cardId_no = tempArr[0][5];						//证件号码
		}
		if(!(tempArr[0][6].equals(""))){
		    sm_name = tempArr[0][6];						//业务品牌
		}
		if(!(tempArr[0][7].equals(""))){
		    rate_name = tempArr[0][7];						//资费名称
		}
		if(!(tempArr[0][8].equals(""))){
		    phone_ty = tempArr[0][8];            			//号码类型
		    if(phone_ty.equals("0"))
		    {
		    	phone_type="测试号";
		    }else if(phone_ty.equals("1"))
		    {
		    	phone_type="公务号";
		    }
		}
		if(!(tempArr[0][9].equals(""))){
		    warning_money = tempArr[0][9];            		//告警金额
		}  
		if(!(tempArr[0][10].equals(""))){
		    limit_money = tempArr[0][10];            		//预存限额
		}  
		if(!(tempArr[0][11].equals(""))){
		    end_time = tempArr[0][11];            			//结束时间
		} 
		if(!(tempArr[0][12].equals(""))){
		    type_co = tempArr[0][12];            			//省市标志代码
		}
		if(!(tempArr[0][13].equals(""))){
		    type_code = tempArr[0][13];            			//省市标志名称
		}
		if(!(tempArr[0][14].equals(""))){
		    unit_code = tempArr[0][14];            			//使用单位代码
		}
		if(!(tempArr[0][15].equals(""))){
		    use_unit = tempArr[0][15];            			//使用单位名称
		} 
		if(!(tempArr[0][16].equals(""))){
		    department_code = tempArr[0][16];           	//使用部门代码
		}
		if(!(tempArr[0][17].equals(""))){
		    use_department = tempArr[0][17];           		//使用部门名称
		} 
		if(!(tempArr[0][18].equals(""))){
		    center_code = tempArr[0][18];            		//使用中心代码
		}
		if(!(tempArr[0][19].equals(""))){
		    use_center = tempArr[0][19];            		//使用中心名称
		}
		if(!(tempArr[0][20].equals(""))){
		    application_code = tempArr[0][20];          	//使用用途代码
		}
		if(!(tempArr[0][21].equals(""))){
		    use_application = tempArr[0][21];          		//使用用途名称
		}
		if(!(tempArr[0][22].equals(""))){
		    level_code = tempArr[0][22];            		//级别代码
		} 
		if(!(tempArr[0][23].equals(""))){
		    use_level = tempArr[0][23];            			//级别名称
		}
		if(!(tempArr[0][24].equals(""))){
		    cust_id = tempArr[0][24];            			//用户ID
		}
		monitorValue = tempArr[0][25];
 	}
 	else{
%>
	<script language="JavaScript">
		rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>",0);
		history.go(-1);
	</script>
<%	 
	}
}
%>

<%
String insql = "select a.unit_code,b.unit_name from sUseCenter a,sUseUnit b where a.USE_FLAG = 'Y' and b.USE_FLAG = 'Y' and a.type_code = '"+type_co+"' and b.type_code = '"+type_co+"' and a.unit_code = b.unit_code group by a.unit_code,b.unit_name ";
System.out.println("insql====="+insql);

String apsql = "select application_code,application_name from sUseApplication  where use_flag='Y'  and phone_type = '"+phone_ty+"' order by application_code";
System.out.println("apsql====="+apsql);

String desql = "select a.department_code,b.department_name from sUseCenter a,sUseDepartment b where a.use_flag='Y' and b.use_flag='Y' and a.department_code = b.department_code  and a.type_code = '"+type_co+"' and a.unit_code = '"+unit_code+"' and b.type_code = '"+type_co+"' and b.unit_code = '"+unit_code+"' group by a.department_code,b.department_name ";
System.out.println("desql====="+desql);

String lesql = "select center_code,center_name from sUseCenter  where use_flag='Y'  and type_code = '"+type_co+"' and unit_code = '"+unit_code+"'  and department_code = '"+department_code+"' group by center_code,center_name ";
System.out.println("lesql====="+lesql);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
<wtc:sql><%=insql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />
	
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
<wtc:sql><%=apsql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result2" scope="end" />
	
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
<wtc:sql><%=desql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result3" scope="end" />

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
<wtc:sql><%=lesql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result4" scope="end" />

<head>
<title>公务测试号信息修改</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<style>
.nodisp{
	display: none;
}
</style>
<script language="JavaScript">
var page = null;
<!-- 
onload=function()
{
	document.all.phoneNo.focus();
	self.status="";
}

//--------1---------doProcess函数----------------

function doProcess(packet)
{
	self.status="";
    var vRetPage=packet.data.findValueByName("rpc_page");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg =  packet.data.findValueByName("retMsg");
	var rpc_flag = packet.data.findValueByName("rpc_flag");
		
	if(retCode != "000000")
	{
		rdShowMessageDialog(retMsg);
		return;
	}
	else if(rpc_flag == "chg_typeCode")
	{
		var code = packet.data.findValueByName("code");
		var text =  packet.data.findValueByName("text");
		fillSelect(document.all.useUnit,code,text);
	}
	else if(rpc_flag == "chg_unit")
	{
		var code = packet.data.findValueByName("code");
		var text =  packet.data.findValueByName("text");
		fillSelect(document.all.useDepartment,code,text);
	}
	else if(rpc_flag == "chg_department")
	{
		var code = packet.data.findValueByName("code");
		var text =  packet.data.findValueByName("text");
		fillSelect(document.all.useCenter,code,text);
	}
	
    if(vRetPage == "qryAreaFlag")
    {    
    var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");
    var area_flag = packet.data.findValueByName("area_flag");

		if(retCode == 000000)
		{
		    if(parseInt(area_flag)>0)
		    {
		       document.all.flagCodeTr.style.display="";
		       getFlagCode();
		    }
		}
		else
		{
			rdShowMessageDialog("错误:"+ retCode + "->" + retMsg);
			return;
		}
	}
}

  //--------2---------验证按钮专用函数------------- 
function formCommit()
{

	if (document.all.typeCode.value=="")
	{
		rdShowMessageDialog("省市标志不能为空,必须选择!",0);
		return false;
	}
	if (document.all.useUnit.value=="")
	{
		rdShowMessageDialog("使用单位不能为空,必须选择!",0);
		return false;
	}	
	if (document.all.useDepartment.value=="")
	{
		rdShowMessageDialog("使用部门不能为空,必须选择!",0);
		return false;
	}		
	if (document.all.useCenter.value=="")
	{
		rdShowMessageDialog("使用中心不能为空,必须选择!",0);
		return false;
	}		
	
	if (document.all.useLevel.value=="")
	{
		rdShowMessageDialog("级别不能为空,必须选择!",0);
		return false;
	}		
	
	getAfterPrompt();
	
	//检测监测模式
	var value = $('select[name="useApplication"]').val();
	if ((value == '3005' || value == '3010') && page.sale_kind){
			var values = {};
			if ($('#enum-message').is(':checked')){
					var opposite_codes = document.getElementsByName('code-opposite');
					for (var i = 0; i < opposite_codes.length; i++){
							if(!checkElement(opposite_codes[i])){
									return false;
							}
							var v = opposite_codes[i].value.trim();
							if (v != ''){
									if (values[v]){//检测是否已经存在
											rdShowMessageDialog('对端号码不能重复，请删除重复数据！');
											return false;
									}
									values[v] = 'true';//放入容器
							}
					}
			}
			if ($('#enum-gprs').is(':checked')){
					var apn_codes = document.getElementsByName('code-apn');
					for (var i = 0; i < apn_codes.length; i++){
							if(!checkElement(apn_codes[i])){
									return false;
							}
					}
			}
			if ($('#enum-voice').is(':checked')){
					var base_station = document.getElementById('base-station');
					var pattern = /^[A-Za-z0-9]+$/;
					if(!checkElement(base_station)){
							return false;
					}
					
					var neighborhood = document.getElementById('neighborhood');
					if(!checkElement(neighborhood)){
							return false;
					}
					
					//验证特殊符号
					if (!pattern.test(base_station.value.trim())){
							rdShowMessageDialog('基站只能由8位以内的字母或数字组成');
							return false;
					}
					if (!pattern.test(neighborhood.value.trim())){
							rdShowMessageDialog('小区只能由8位以内的字母或数字组成');
							return false;
					}
			}
	}
	//构造监测模式
	var monitorValue = page.setupMonitorValues();
	document.frm.monitorValue.value = monitorValue;
	frmCfm();
}

function frmCfm()
{ 
	frm.submit();
}

function getFlagCode1()
{
	document.all.commit.disabled=false;
	if (document.frm.back_flag_code.value == 2)
	{
 	  	document.all.flagCodeTextTd.style.display = "";
		document.all.flagCodeTd.style.display = "";
	}		
}

function getFlagCode()
{
  	//调用公共js
    var pageTitle = "资费查询";
    var fieldName = "小区代码|小区名称|二批代码";//弹出窗口显示的列、列名 
    //var sqlStr ="select a.flag_code, a.flag_code_name,a.rate_code from sRateFlagCode a, sBillModeDetail b where a.region_code=b.region_code and a.rate_code=b.detail_code and b.detail_type='0' and a.region_code='" + document.frm.orgCode.value.substring(0,2) + "' and b.mode_code='" + document.frm.New_Mode_Code.value + "' order by a.flag_code" ;
	var sqlStr ="select a.flag_code, a.flag_code_name from sofferflagcode a, sregioncode b where a.group_id = b.group_id and b.region_code = '" + document.frm.orgCode.value.substring(0,2) + "' and a.offer_id = " + document.frm.New_Mode_Code.value +"order by a.flag_code" ;
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "0|1|2";//返回字段
    var retToField = "flag_code|flag_code_name|rate_code";//返回赋值的域
    
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

// 省市标志--单位
function chg_typeCode()
{
	if(document.all.useUnit.value != "")
	{
		var sql = "90000246";
		var sqlParam = document.all.typeCode.value+"|"+document.all.typeCode.value+"|";
		var rpc_flag = "chg_typeCode";
		sendRpc(sql,sqlParam,rpc_flag);
	}
	document.all.useDepartment.value = "";
	document.all.useCenter.value = "";
}

// 单位--部门
function unitchange()
{
	if(document.all.useUnit.value != "")
	{
		var sql = "90000247";
		var sqlParam = document.all.typeCode.value+"|"+document.all.useUnit.value+"|"+document.all.typeCode.value+"|"+document.all.useUnit.value+"|";
		var rpc_flag = "chg_unit";
		sendRpc(sql,sqlParam,rpc_flag);
	}
	document.all.useDepartment.value = "";
	document.all.useCenter.value = "";
}

// 部门--中心
function chg_department()
{
	if(document.all.useDepartment.value != "")
	{
		var sql = "90000248";
		var sqlParam = document.all.typeCode.value+"|"+document.all.useUnit.value+"|"+document.all.useDepartment.value+"|";
		var rpc_flag = "chg_department";
		sendRpc(sql,sqlParam,rpc_flag);
	}
}

function sendRpc(sql,sqlparam,rpc_flag)
{
	var myPacket = new AJAXPacket("/npage/s9387/rpc_select.jsp","正在获取信息，请稍候......");
	myPacket.data.add("sql",sql);
	myPacket.data.add("sqlParam",sqlparam);
	myPacket.data.add("rpc_flag", rpc_flag);
	core.ajax.sendPacket(myPacket);
	myPacket=null;  
}

function fillSelect(obj,code,text)
{
	obj.length=0;
	var option0 = new Option("--请选择--","");
	obj.add(option0);
	for(var i=0; i<code.length; i++)
	{
		var option1 = new Option(text[i],code[i]);
        obj.add(option1);
	}
}

//-->

function Page(){
		this.sale_kind = ('<%=phone_ty%>' == '0')? true: false;//true代表测试，false代表公务
		this.monitorValue = '<%=monitorValue%>';
		
		this.init();
}

Page.prototype.init = function(){
		var self = this;
		
		$('#enum-message').click(function(e){
			 	e.stopPropagation();
			  
				if ($(this).is(':checked')){
						$('#opposite-code').show();
				} else {
						$('#opposite-code, .ErrorTip').hide();
				}
		});
		
		$('#enum-gprs').click(function(e){
				e.stopPropagation();
				
				if ($(this).is(':checked')){
						$('#apn-code').show();
				} else {
						$('#apn-code, .ErrorTip').hide();
				}
		});
		
		$('#enum-voice').click(function(e){
				e.stopPropagation();
				
				if ($(this).is(':checked')){
						$('#voice-info').show();
				} else {
						$('#voice-info, .ErrorTip').hide();
				}
		});
		
		$('select[name="useApplication"]').change(function(e){
				e.stopPropagation();
				
				var value = $(this).val();
				if ((value == '3005' || value == '3010') && self.sale_kind){
						$('#monitor-pattern').show();
				} else {
						$('#opposite-code, .ErrorTip, #monitor-pattern, #apn-code, #voice-info').hide();
						$('#enum-message, #enum-gprs, #enum-voice').attr('checked', false);
				}
		});
		
		var value = $('select[name="useApplication"]').val();
		if ((value == '3005' || value == '3010') && self.sale_kind){
				$('#monitor-pattern').show();
				this.initMonitorValues();
		}else {
				$('#opposite-code, .ErrorTip, #monitor-pattern, #apn-code, #voice-info').hide();
				$('#enum-message, #enum-gprs, #enum-voice').attr('checked', false);
		}
}

Page.prototype.setupMonitorValues = function(){
		var array = [];
		var value = $('select[name="useApplication"]').val();
		if ((value == '3005' || value == '3010') && page.sale_kind){
				if ($('#enum-message').is(':checked')){
						var opposite_codes = document.getElementsByName('code-opposite');
						for (var i = 0; i < opposite_codes.length; i++){
								var code = opposite_codes[i].value.trim();
								if(code != ''){
										var t = this.setupValue('01', i, code);
										array.push(t);
								}
						}
				}
				if ($('#enum-gprs').is(':checked')){
						var apn_codes = document.getElementsByName('code-apn');
						for (var i = 0; i < apn_codes.length; i++){
								var code = apn_codes[i].value.trim();
								if(code != ''){
										var t = this.setupValue('02', i, code);
										array.push(t);
								}
						}
				}
				if ($('#enum-voice').is(':checked')){
						var base_station = document.getElementById('base-station');
						var code = base_station.value.trim();
						if(code != ''){
								var t = this.setupValue('03', 0, code);
								array.push(t);
						}
						
						var neighborhood = document.getElementById('neighborhood');
						var code = neighborhood.value.trim();
						if(code != ''){
								var t = this.setupValue('04', 0, code);
								array.push(t);
						}
				}
		}
		return array.join(',');
}

Page.prototype.initMonitorValues = function(){
		if (!this.monitorValue){
				return;
		}
		var records = this.monitorValue.split(',');
		for (var i = 0; i < records.length; i++){
				var array = records[i].split('~');
				var type = array[0];//01 短信，02 grps，03基站，04小区
				var index = array[1].charAt((array[1].length - 1));//通过最后一位取得序号
				var code = array[2];
				var opposite_inputs = $('input[name="code-opposite"]');
				if (type == '01'){
						$('#enum-message').attr('checked', 'true');
						$(opposite_inputs.get(index - 1)).val(code);
						$('#opposite-code').show();
				} else if (type == '02'){
						$('#enum-gprs').attr('checked', 'true');
						$('#code-apn').val(code);
						$('#apn-code').show();
				} else if (type == '03'){
						$('#enum-voice').attr('checked', 'true');
						$('#base-station').val(code);
						$('#voice-info').show();
				} else if (type == '04'){
						$('#enum-voice').attr('checked', 'true');
						$('#neighborhood').val(code);
						$('#voice-info').show();
				}
		}
}

Page.prototype.setupValue = function(type, index, code){
		var array = [];
		index += 1;//传入的下标从0开始，而后台要求下标从1开始
		if (type == '01'){//代表短信
				array.push('01');
				array.push('dx00' + index);
				array.push(code);
		} else if (type == '02'){
				array.push('02');
				array.push('gprs00' + index);
				array.push(code);
		} else if (type == '03'){
				array.push('03');
				array.push('jz00' + index);
				array.push(code);
		} else if (type == '04'){
				array.push('04');
				array.push('xq00' + index);
				array.push(code);
		}
		return array.join('~');
}

$(function(){
		page = new Page();
});
</script>
</head>
<body>
	<form name="frm" method="post" action="f4262Cfm.jsp" onKeyUp="chgFocus(frm)">
		<input type="hidden" value="" name="monitorValue"/>
		<%@ include file="/npage/include/header.jsp" %>   
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
		<input name="oSmCode" type="hidden" class="button" id="oSmCode" value="<%=sm_code%>">
	  	<input type="hidden" name="m_smCode" value="">
		<input name="oModeCode" type="hidden" class="button" id="oModeCode" value="<%=rate_code%>">
		<input type="hidden" name="back_flag_code" value="">
		<input type="hidden" name="Gift_Code" value="">
		<input type="hidden" name="tyCode" value="<%=type_co%>">
		<input type="hidden" name="custId" value="<%=cust_id%>">
 	<table cellspacing="0">
		<tr>
			<td class="blue">手机号码</td>
            <td>
				<input class="InputGrey"  type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" value="<%=iPhoneNo%>" id="phoneNo" v_name="手机号码" onBlur="if(this.value!=''){if(checkElement(document.all.phoneNo)==false){return false;}}" maxlength=11 index="3" readonly >
			</td>
			<td class="blue">客户名称</td>
			<td>
				<input name="oCustName" type="text" class="InputGrey" id="oCustName" value="<%=bp_name%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">客户地址</td>
            <td>
				<input name="oCustAdd" type="text" class="InputGrey" id="oCustAdd" value="<%=bp_add%>" readonly>
			</td>
			<td class="blue">证件类型</td>
            <td>
				<input name="cardIdType" type="text" class="InputGrey" id="cardIdType" value="<%=cardId_type%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">证件号码</td>
            <td>
				<input name="cardIdNo" type="text" class="InputGrey" id="cardIdNo" value="<%=cardId_no%>" readonly>
			</td>
			<td class="blue">业务品牌</td>
            <td>
				<input name="oSmName" type="text" class="InputGrey" id="oSmName" value="<%=sm_name%>" readonly>
			</td>
		</tr>
		<tr>
            <td class="blue">资费名称</td>
            <td>
				<input name="oModeName" type="text" class="InputGrey" id="oModeName" value="<%=rate_name%>" readonly>
			</td>
			<td class="blue">号码类型</td>
			<td>
				<input name="phoneType" class="InputGrey" type="text" v_name="号码类型"  value="<%=phone_type%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">告警金额</td>
			<td>
				<input name="warningMoney" class="button" type="text" v_name="告警金额" maxlength="17" value="<%=warning_money%>" onKeyPress="return isKeyNumberdot(1)" onKeyDown="if(event.keyCode==13) doprint();">
			</td>
			<td class="blue">话费限额</td>
			<td>
				<input name="limitMoney" class="button" type="text" v_name="预存限额" maxlength="17" value="<%=limit_money%>" onKeyPress="return isKeyNumberdot(1)" onKeyDown="if(event.keyCode==13) doprint();">
			</td>
		</tr>
		<tr>
			<td class="blue">结束时间</td>
			<td>
				<input name="endTime" class="button" type="text" v_name="结束时间"  value="<%=end_time%>" >
			</td>
			<td class="blue">省市标志</td>
			<td>
				<select name="typeCode" class="button" id="select" onchange="chg_typeCode()" >
					<option value="" selected>--请选择--</option>
					<option value="99" selected>省公司</option>
			      	<option value="<%=type_co%>" selected><%=type_code%></option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="blue">使用单位</td>
			<td>
				<select name="useUnit" id="useUnit" v_name="使用单位" onchange="unitchange()">
					<option value="" selected>--请选择--</option>
					<%for (int i = 0; i < result.length; i++) 
					{
						if(unit_code.equals(result[i][0]))
						{%>
			      			<option value="<%=result[i][0]%>" selected><%=result[i][1]%>
			      			</option>
		    			<%}
	    				else
	    				{%>
	    					<option value="<%=result[i][0]%>"><%=result[i][1]%>
	      					</option>
	    				<%}
	    			}%>	
				</select>
			</td>
			<td class="blue">使用部门</td>
			<td>
				<select name="useDepartment" id="useDepartment" v_name="使用部门" onchange="chg_department()">
					<option value="">--请选择--</option>
					<%for (int i = 0; i < result3.length; i++) 
					{
						if(department_code.equals(result3[i][0]))
						{%>
			      			<option value="<%=result3[i][0]%>" selected><%=result3[i][1]%>
			      			</option>
		    			<%}
	    				else
	    				{%>
	    					<option value="<%=result3[i][0]%>"><%=result3[i][1]%>
	      					</option>
	    				<%}
	    			}%>	
				</select>
			</td>
		</tr>
		<tr>
			<td class="blue">使用中心</td>
			<td>
				<select name="useCenter" id="useCenter" v_name="使用中心" >
					<option value="">--请选择--</option>
					<%for (int i = 0; i < result4.length; i++) 
					{
						if(center_code.equals(result4[i][0]))
						{%>
			      			<option value="<%=result4[i][0]%>" selected><%=result4[i][1]%>
			      			</option>
		    			<%}
	    				else
	    				{%>
	    					<option value="<%=result4[i][0]%>"><%=result4[i][1]%>
	      					</option>
	    				<%}
	    			}%>	
				</select>
			</td>
			<td class="blue">使用用途</td>
			<td>
				<select name="useApplication" id="useApplication" v_name="使用用途" >
					<option value="">--请选择--</option>
					<%for (int i = 0; i < result2.length; i++) 
					{
						if(application_code.equals(result2[i][0]))
						{%>
			      			<option value="<%=result2[i][0]%>" selected><%=result2[i][1]%>
			      			</option>
		    			<%}
	    				else
	    				{%>
	    					<option value="<%=result2[i][0]%>"><%=result2[i][1]%>
	      					</option>
	    				<%}
	    			}%>	
				</select>
			</td>
		</tr>
		<tr>
			<td class="blue">级别</td>
			<td colspan="3">
				<select name="useLevel" id="useLevel" v_name="级别" >
					<option value="">--请选择--</option>
	    			<%for (int i = 0; i < result1.length; i++) 
					{
						if(level_code.equals(result1[i][0]))
						{%>
			      			<option value="<%=result1[i][0]%>" selected><%=result1[i][1]%>
			      			</option>
		    			<%}
	    				else
	    				{%>
	    					<option value="<%=result1[i][0]%>"><%=result1[i][1]%>
	      					</option>
	    				<%}
	    			}%>	
				</select>
			</td>
		</tr>
    <tr id="monitor-pattern" class="nodisp">
		  <td class="blue" width="12%">监控模式</td>
		  <td colspan="3">
		 	  <label>
		 	    <input type="checkbox" id="enum-message">短信</input>
		   	</label>
		   	<label>
		   	  <input type="checkbox" id="enum-gprs">GPRS</input>
		   	</label>
		   	<label>
		   	  <input type="checkbox" id="enum-voice">语音</input>
		   	</label>
		  </td>
		</tr>
		 
		<tr id="opposite-code" class="nodisp">
		  <td class="blue">对端号码</td>
		  <td colspan="3">
		  	<input type="text" v_maxlength="20" v_type="0_9" name="code-opposite" value=""/>
		   	<input type="text" v_maxlength="20" v_type="0_9" name="code-opposite" value=""/>
		   	<input type="text" v_maxlength="20" v_type="0_9" name="code-opposite" value=""/>
		   	<input type="text" v_maxlength="20" v_type="0_9" name="code-opposite" value=""/>
		   	<input type="text" v_maxlength="20" v_type="0_9" name="code-opposite" value=""/>
		  </td>
		</tr>		
		 
		<tr id="apn-code" class="nodisp">
		  <td class="blue">APN接入节点</td>
		  <td colspan="3">
		    <input type="text" v_maxlength="20" v_type="string" name="code-apn" value="" id="code-apn"/>
		  </td>
		</tr>
		
		<tr id="voice-info" class="nodisp">
		  <td class="blue">基站</td>
		  <td>
		    <input type="text" v_maxlength="8" v_type="string" name="base-station" id="base-station" value=""/>
		  </td>
		  <td class="blue">小区</td>
		  <td>
		    <input type="text" v_maxlength="8" v_type="string" name="neighborhood" id="neighborhood" value=""/>
		  </td>
		</tr>
		
		<tr id="flagCodeTr" style="display:none">
		    <TD class="blue">小区代码</TD>
			  <TD colspan="3">
				    <input type="hidden" size="17" name="rate_code" id="rate_code" readonly>
           			<input type="text" class="InputGrey" name="flag_code" size="8" maxlength="10" readonly>
			      <input type="text" class="InputGrey" name="flag_code_name" size="18" readonly >&nbsp;&nbsp;
			      <input name="newFlagCodeQuery" type="button" class="b_text"  style="cursor:hand" onClick="getFlagCode()" value=选择>
       		 </TD>
      	</tr>
		<tr>
			<td id="footer" colspan="4">
				<div align="center">
                &nbsp;
				<input name="commit" id="commit" type="button" class="b_foot"   value="确认" onClick="formCommit();"  >
                &nbsp; 
                <input name="close" onClick="removeCurrentTab();" type="button" class="b_foot" value="关闭">
                &nbsp; 
				</div>
			</td>
		</tr>
	</table>
	
<div name="licl" id="licl">
			<input type="hidden" name="iOpCode" value="4262">
			<input type="hidden" name="loginNo" value="<%=loginNo%>">
			<input type="hidden" name="orgCode" value="<%=orgCode%>">
</div>
 <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
