<%
/********************
* 功能: 客户资料变更 1210
* version v3.0
* 开发商: si-tech
* update by qidp @ 2008-11-12
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%
request.setCharacterEncoding("GBK");
HashMap hm=new HashMap();
hm.put("1","没有客户ID！");
hm.put("3","密码错误！");
hm.put("4","手续费不确定，您不能进行任何操作！");
hm.put("2","未取到数据1，请核查数据或咨询系统管理员！");
hm.put("10","未取到数据2，请核查数据或咨询系统管理员！");
hm.put("11","未取到数据3，请核查数据或咨询系统管理员！");
hm.put("12","未取到数据4，请核查数据或咨询系统管理员！");
hm.put("13","未取到数据5，请核查数据或咨询系统管理员！");
hm.put("14","未取到数据6，请核查数据或咨询系统管理员！");
%>

<%
    /* add by qidp @ 2009-08-13 for 整合端到端流程 . */
    String regionCode = (String)session.getAttribute("regCode");
    String in_GrpId = request.getParameter("in_GrpId");
    String in_ChanceId = request.getParameter("in_ChanceId");
    String wa_no = request.getParameter("wa_no1");
    String openLabel = "";/*add by qidp.添加标志位，link：走端到端流程通过任务控制进入此订购模块；opcode：不走端到端流程，通过opcode打开此页面。*/
    String in_CustId = "";
    
    String accept = WtcUtil.repNull(request.getParameter("accept"));
    String oriPhoneNo = WtcUtil.repNull(request.getParameter("oriPhoneNo"));
    
    /* 判断接入此模块的方式，并做相应的处理。*/
    if(in_ChanceId != null){//由任务管理接入时，商机编码必定不为空。
        openLabel = "link";
    }else{
        in_GrpId = "";
        in_ChanceId = "";
        wa_no = "";
        openLabel = "opcode";
    }
    System.out.println("in_GrpId = "+in_GrpId); 
    if("link".equals(openLabel)){
        String ssql = "select cust_id from dbvipadm.dgrpcustmsg where unit_id = '"+in_GrpId+"'";
    %>
    	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode44" retmsg="retMsg44" outnum="1">
    		<wtc:sql><%=ssql%></wtc:sql>
    	</wtc:pubselect>
    	<wtc:array id="retVal44" scope="end"/>
    <%
        System.out.println("retCode="+retCode44); 
        if("000000".equals(retCode44) && retVal44.length > 0){
            in_CustId = retVal44[0][0];
        }
    }
    System.out.println("custId = "+in_CustId); 
    /* end by qidp @ 2009-08-13 for 整合端到端流程 . */
%>

<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
    <META content="MSHTML 5.00.3315.2870" name=GENERATOR>
    <title>客户资料变更</title>
        
<%											
    String opCode = (String)request.getParameter("opCode")==null?"1210":(String)request.getParameter("opCode");
    String opName = (String)request.getParameter("opName")==null?"客户资料变更":(String)request.getParameter("opName");
String workNo=(String)session.getAttribute("workNo");
String userPhone=(String)request.getParameter("userPhoneNo");
boolean workNoFlag=false;
if(workNo.substring(0,1).equals("k"))
workNoFlag=true;

//ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
//String[][] baseInfoSession = (String[][])arrSession.get(0);
//String work_no = baseInfoSession[0][2];
//String loginName = baseInfoSession[0][3];
//String org_Code = baseInfoSession[0][16];
//String op_code = "1210";

//String work_no = (String)session.getAttribute("workNo");
//String loginName = (String)session.getAttribute("workName");
//String org_Code = (String)session.getAttribute("orgCode");

//----------------------------------------------------------
//String sqls="SELECT trim(id_Name)||'|'||id_type FROM sIdType order by id_type;";
//System.out.println("Sqls = " + sqls);
//SPubCallSvrImpl co=new SPubCallSvrImpl();
//String[][] metaData=co.fillSelect(sqls);
//System.out.println("metaData[0][9]="+metaData[0][9]);
  
  
  boolean hfrf=false;
  
	//2011/6/23 wanghfa添加 对密码权限整改 start
  boolean pwrf=false;
	String pubOpCode = opCode;
	String pubWorkNo = workNo;
%>
	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
	
<%
	System.out.println("====wanghfa====s1210Login.jsp------------------------------------------------------------==== pwrf = " + pwrf);
	//2011/6/23 wanghfa添加 对密码权限整改 end

String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
if(ReqPageName.equals("s1210Main"))
{
  String retMsg=WtcUtil.repNull(request.getParameter("retMsg"));
%>
<script>
    rdShowMessageDialog("<%=(String)(hm.get(retMsg))%>");
</script>
<%
}
%>


<script language=javascript>

 var js_pwFlag="false";
 js_pwFlag="<%=pwrf%>";
	
	
function doReset(){
   location.reload();
document.all.qry_cond[2].checked=true;
}
//core.loadUnit("debug");
//core.loadUnit("rpccore");


onload=function()
{
	/*
		20120828 gaopeng 新增 将客户资料变更分离成 1210 个人资料变更 和 g049 集团资料变更 begin
	*/
	var reqopcode = "<%=opCode%>";
	if(reqopcode=="1210")
	{
		//隐藏集团编号、智能网编号
		$("input[name='qry_cond']").eq(4).next("span").hide();
		$("input[name='qry_cond']").eq(4).hide();
		$("input[name='qry_cond']").eq(5).next("span").hide();
		$("input[name='qry_cond']").eq(5).hide();
		
	}
	else if(reqopcode=="g049")
	{
		
		//隐藏客户ID、客户证件、预约 ID
		$("input[name='qry_cond']").eq(0).next("span").hide();
		$("input[name='qry_cond']").eq(0).hide();
		$("input[name='qry_cond']").eq(1).next("span").hide();
		$("input[name='qry_cond']").eq(1).hide();
		$("input[name='qry_cond']").eq(3).next("span").hide();
		$("input[name='qry_cond']").eq(3).hide();
		
	}
	/*
		20120828 gaopeng 新增 将客户资料变更分离成 1210 个人资料变更 和 g049 集团资料变更 end
	*/
//core.rpc.onreceive = doProcess;
self.status="";

//fillSelect();
document.all.qry_cond[2].checked=true;
document.all.booking.style.display="none";
document.all.identity.style.display="none";
document.all.unit.style.display="none"; //add by diling@2012/5/3 
document.all.vpmn.style.display="none"; //add by diling@2012/5/3 
/*王梅 20070831 修改 处理申告，
<%
//if(workNoFlag)
//{
%>
document.all.qry_cond[0].disabled=true;
document.all.qry_cond[1].disabled=true;
document.all.phone_no.value="<%=userPhone%>";
document.all.phone_no.readOnly=true;
document.all.qryPage.focus();
getOneId();

<%
//}
//else
//{
%>
document.all.phone_no.focus();
<%
//}
%>
*/

/* add by qidp @ 2009-08-13 for 整合端到端流程 . */
<% if("link".equals(openLabel)){ %>
    document.all.qry_cond[0].checked=true;
    chkId();
    document.all.qry_cond[1].disabled=true;
    document.all.qry_cond[2].disabled=true;
    
    document.all.cus_id.value="<%=in_CustId%>";
    document.all.cus_id.readOnly=true;
    $(document.all.cus_id).addClass("InputGrey");
<% } %>
/* end by qidp @ 2009-08-13 for 整合端到端流程 . */
}

function doProcess(packet)
{
self.status="";
var cussid=packet.data.findValueByName("cussid");
	var phone_no_booking 	=packet.data.findValueByName("phone_no");
	var retcode				=packet.data.findValueByName("retcode");
	var retmsg				=packet.data.findValueByName("retmsg");
	if(document.all.qry_cond[3].checked)
	{
		document.all.cus_id.value = "";
		document.all.phone_no.value = "";
		if (phone_no_booking!="")
		{
			document.all.phone_no.value=phone_no_booking;
			document.all.cus_id.value=cussid;
		}
		else 
		{
			rdShowMessageDialog(retcode+":"+retmsg);
		}
	}
	else
	{
if(cussid!="")
{
document.all.cus_id.value=cussid;

}
else
{
rdShowMessageDialog("没有此客户！");
}
	}
}

//-------1--------查询系列函数----------------
function forMobilGh(obj)
{
	
	var patrn=/^((\(\d{3}\))|(\d{3}\-))?[12][03458]\d{9}$/;
	var sInput = obj.value;
	if(sInput.substring(0,3)=="451"||sInput.substring(0,3)=="046"||sInput.substring(0,3)=="045"){
		 var sInput1 = sInput.substring(3,sInput.length);
		 var patrn1=/^[0-9]{8}$/;
		 
		 if(sInput1.search(patrn1)==-1){
		 	showTip(obj,"固话格式不正确！");
			return false;
		 }else{
		 	hiddenTip(obj);
		 	return true;
		}
	}
	
	if(sInput.search(patrn)==-1){
		showTip(obj,"格式不正确！");
		return false;
	}
	hiddenTip(obj);
	return true;
	
}
//通过服务号码得到客户ID
function getOneId()
{
if(((document.all.phone_no.value).trim()).length<1)
{
rdShowMessageDialog("手机号码不能为空！");
return;
}

if (!checkServiceId()){
		return;
}

if(!forMobilGh(document.all.phone_no)) return;
var myPacket = new AJAXPacket("qryCus_id.jsp","正在查询客户ID，请稍候......");
myPacket.data.add("phoneNo",(document.all.phone_no.value).trim());
core.ajax.sendPacket(myPacket);
myPacket = null;
}
/*add by diling@2012/5/3 */
/*通过集团编号获取客户id*/
function getOneId_unit(){
  if(((document.all.unitNo.value).trim()).length<1)
  {
    rdShowMessageDialog("集团编号不能为空！");
    return;
  }
  var myPacket = new AJAXPacket("qryCustidByUnitNo.jsp","正在查询客户ID，请稍候......");
  myPacket.data.add("unitNo",(document.all.unitNo.value).trim());
  core.ajax.sendPacket(myPacket);
  myPacket = null;
}

/*通过vpmn编码获取客户id*/
function getOneId_vpmn(){
  if(((document.all.vpmnNo.value).trim()).length<1)
  {
    rdShowMessageDialog("集团编号不能为空！");
    return;
  }else{
    var pageTitle = "集团查询";
    var fieldName = "集团编号|客户ID|集团名称|集团地址|智能网编码|"; 
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|0|1|";
    var retToField = "unitId|cus_id|";

		var sqlStr = "90000111";
    var params = document.all.vpmnNo.value+"|";
    
  	PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,params);
  }
  
}

function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,params)
{
	var theFirstRetToField=retToField;
    /*
    参数1(pageTitle)：查询页面标题
    参数2(fieldName)：列中文名称，以'|'分隔的串
    参数3(sqlStr)：sql语句
    参数4(selType)：类型1 rediobutton 2 checkbox
    参数5(retQuence)：返回域信息，返回域个数＋ 返回域标识，以'|'分隔，如"3|0|2|3"表示返回3个域0，2，3
    参数6(retToField))：返回值存放域的名称,以'|'分隔
    注意：sql的校验，防止sql注射
    使用window.open实现新窗口的打开，否则opener不生效.
    可通过opener.arg4.values=''赋值
    */
    var path = "../../npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType+ "&params=" + params; 
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
/*end add by diling*/
function getOneId_booking()
{
if(((document.all.booking_id.value).trim()).length<1)
{
rdShowMessageDialog("预约ID不能为空！");
return;
}
var myPacket = new AJAXPacket("qryCustidByBookId.jsp","正在查询客户ID，请稍候......");
myPacket.data.add("booking_id",(document.all.booking_id.value).trim());
core.ajax.sendPacket(myPacket);
myPacket = null;
}
function getAllId_No(){
if(((document.all.id_no.value).trim()).length<1)
{
rdShowMessageDialog("证件号码不能为空！");
return;
}

if(((document.all.id_type.value).trim())=="0")
{
if(forIdCard(document.all.id_no)==false)
return false;
}

var h=400;
var w=500;
var t=screen.availHeight/2-h/2;
var l=screen.availWidth/2-w/2;
var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
var ret=window.showModalDialog("AllId_No.jsp?id_no="+(document.all.id_no.value).trim()+"&id_type=" +document.all.id_type.value,"",prop);


if(typeof(ret)!="undefined")
{
document.all.cus_id.value=ret;
document.all.cus_pass.value="";
}
else
{
rdShowMessageDialog("您必须选择一个客户ID！");
document.all.id_no.select();
document.all.id_no.focus();
}
}

function chkId()
{
if(self.status!="")
{
rdShowMessageDialog("正在验证信息，请稍候！");
return;
}

if(document.all.qry_cond[0].checked)
{
document.all.identity.style.display="none";
document.all.phone.style.display="none";
document.all.cus_id.value="";
document.all.cus_id.focus();
document.all.booking.style.display="none";
document.all.unit.style.display="none"; //add by diling@2012/5/3 
document.all.vpmn.style.display="none"; //add by diling@2012/5/3 
}
else if(document.all.qry_cond[1].checked)
{
document.all.identity.style.display="";
document.all.id_no.value="";
document.all.cus_id.value="";
document.all.id_no.focus();
document.all.phone.style.display="none";
document.all.booking.style.display="none";
document.all.unit.style.display="none"; //add by diling@2012/5/3 
document.all.vpmn.style.display="none"; //add by diling@2012/5/3 
}
else if(document.all.qry_cond[2].checked)
{
    document.all.identity.style.display="none";
    document.all.phone.style.display="";
    document.all.phone_no.value="";
    document.all.cus_id.value="";
    document.all.phone_no.focus();
    document.all.booking.style.display="none";
    document.all.qryId_No2.style.display = "";
    document.all.unit.style.display="none"; //add by diling@2012/5/3 
    document.all.vpmn.style.display="none"; //add by diling@2012/5/3 
}
else if(document.all.qry_cond[3].checked)
{
    document.all.identity.style.display="none";
    document.all.phone.style.display="";
    document.all.phone_no.value="";
    document.all.cus_id.value="";
    document.all.booking.style.display="block";
    document.all.qryId_No2.style.display = "none";
    document.all.unit.style.display="none"; //add by diling@2012/5/3 
    document.all.vpmn.style.display="none"; //add by diling@2012/5/3 
}
/*begin add by diling for 关于增加集团客户业务相关需求的函（BOSS部分第一批）@2012/5/3 */
else if(document.all.qry_cond[4].checked)
{
  document.all.identity.style.display="none";
  document.all.phone.style.display="none";
  document.all.cus_id.value="";
  document.all.booking.style.display="none";
  document.all.vpmn.style.display="none";
  document.all.unit.style.display="";
  document.all.unitNo.value="";
  document.all.qryId_unit.style.display = "";
}
else if(document.all.qry_cond[5].checked)
{
  document.all.identity.style.display="none";
  document.all.phone.style.display="none";
  document.all.booking.style.display="none";
  document.all.unit.style.display="none";
  document.all.vpmn.style.display="";
  document.all.vpmnNo.value="";
  document.all.qryId_vpmn.style.display = "";
  
}
/*end add by diling @2012/5/3 */
}

//-------2---------验证及提交函数-----------------
function 	checkCustId(){
		var opCode = '<%=opCode%>';
		if (opCode != '1210'){
				return true;
		}
		
		if (!$($("input[name='qry_cond']")[0]).is(":checked")){
				return true;
		}
		
		if ((document.all.cus_id.value).trim() == ''){
				rdShowMessageDialog('客户ID不能为空！', 1 );
				return false; 
		}
		
		var t = false;
		var packet = new AJAXPacket("checkIdNo.jsp","正在查询客户ID，请稍候......");
		packet.data.add("custId",(document.all.cus_id.value).trim());
		
		core.ajax.sendPacket(packet, function(packet){
      		var retCode = packet.data.findValueByName("retCode");
      		var retMsg = packet.data.findValueByName("retMsg");
      		
      		if (retCode != '000000'){
							$('#submitBtn').attr('disabled', 'true');
							rdShowMessageDialog("调用页面失败，请联系管理人员！" + retCode + " " + retMsg , 1);
							return;
					}
      	
          var result = packet.data.findValueByName("result");
          
          if (result[0][0] == '1'){
          		t = true;
          } else {
          		rdShowMessageDialog('不能使用集团ID或家庭ID查询！', 1 );
          		document.all.cus_id.value = "";
          }
      });
		packet = null;
		
		return t;
}

function doCfm()
{
	
if(self.status!="")
{
    rdShowMessageDialog("正在查询信息，请稍候！");
    return false;
}

if (!checkCustId()){
		return false;
}

//if(js_pwFlag=="false")
//{
   if(document.all.cus_pass.value.length==0)
   {
     rdShowMessageDialog("客户密码不能为空！");
	 document.all.cus_pass.focus();
     return false;
   }
//}

if(check(s3216) && checkServiceId())
{
    if(document.all.identity.style.display!="none")
    {
        if(document.all.id_type.options[document.all.id_type.options.selectedIndex].text=="身份证")
        {
            if(document.all.id_no.value.length==0)
            {
                rdShowMessageDialog("身份证号码有误！长度不对！");
                document.all.id_no.focus();
                return false;
            }

            if(forIdCard(document.all.id_no)==false)
            {
                document.all.id_no.value="";
                document.all.id_no.focus();
                return;
            }
        }
    }

    //if(document.all.qry_cond[2].checked){
    //    document.all.phone_no.value = "";
    //}
    s3216.action="s1210Main.jsp";
    s3216.submit();
}
}


//zhouby add to check gorup/personal service id 
function checkServiceId(){
		if (!$($("input[name='qry_cond']")[2]).is(":checked")){
				return true;
		}
	
		var opCode = '<%=opCode%>';
		var reg, msg_;
		if (opCode == '1210'){
				reg = /^[^2]{1}.*/;
				msg_ = '不能输入以2开头的号码！';
		} else if (opCode == 'g049'){
				reg = /^2{1}.*/;
				msg_ = '只能输入以2开头的号码！';
		}

		var value = $.trim($('#phone_no').val());
		var result = reg.test(value);
		if (!result){
				rdShowMessageDialog(msg_, 1);
		}
		return result;
}



function clearID()
{
document.all.id_no.value="";
document.all.id_no.focus();
}

</script>
</head>
<body>

<form name="s3216" method="POST"  onKeyUp="chgFocus(s3216)">
<input type="hidden" name="accept" value="<%=accept%>"/>
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
<div id="title_zi">用户信息</div>
</div>
<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">
<table cellspacing="0" align="center">
<tr>
    <td width="16%" class="blue">查询条件</td>
    <td colspan="3" class="blue" width="84%">
		 	<input type="radio" name="qry_cond" id="qry_cond" value="0" onclick="chkId()" index="0"><span>客户ID</span></input>
		 	<input type="radio" name="qry_cond" id="qry_cond" value="1" onclick="chkId()" index="1"><span>客户证件</span></input>
		  <input type="radio" name="qry_cond" id="qry_cond" value="2" onClick="chkId()" index="2" checked>服务号码</input>
		  <input type="radio" name="qry_cond" id="qry_cond" value="3" onClick="chkId()" index="3" ><span>预约ID</span></input>
		  <input type="radio" name="qry_cond" id="qry_cond" value="4" onClick="chkId()" index="4" ><span>集团编号</span></input>
			<input type="radio" name="qry_cond" id="qry_cond" value="5" onClick="chkId()" index="5" ><span>智能网编号</span></input>     
    </td>
</tr>
<tr id="identity">
    <td width="16%" class="blue">证件类型</td>
    <td>
        <select name="id_type" id="id_type" onchange="clearID()" index="3">
            <wtc:qoption name="sPubSelect" outnum="11">
				<wtc:sql>select trim(ID_TYPE),ID_NAME from sIdType order by id_type</wtc:sql>
		    </wtc:qoption>         
        </select>
    </td>
    <td width="16%" class="blue">证件号码</td>
    <td width="40%">
        <input type="text" size="18" name="id_no" id="id_no" maxlength="18" index="4" onkeyup="if(event.keyCode==13)getAllId_No()">
        <font class="orange">*</font>
        <input class="b_text" type="button" name="qryId_No" value="查询" onClick="getAllId_No()">
    </td>
</tr>
<tr id="booking">
    <td width="16%" class="blue">预约ID</td>
    <td colspan="3">
        <input type="text" size="15"  name="booking_id" id="booking_id"  maxlength="16" onkeyup="if(event.keyCode==13)getBookingId()" index="5" >
        <font class="orange">*</font>
        <input class="b_text" type="button" name="qryBooking_No2"  id = "qryBooking_No2" value="查询" onClick="getOneId_booking()">
    </td>
</tr>
<tr id="phone">
    <td width="16%" class="blue">服务号码</td>
    <td colspan="3">
        <input type="text" size="11"  name="phone_no" id="phone_no" value="<%=oriPhoneNo%>"  maxlength="11" onkeyup="if(event.keyCode==13)getOneId()" index="5" >
        <font class="orange">*</font>
        <input class="b_text" type="button" name="qryId_No2" value="查询" onClick="getOneId()">
    </td>
</tr>
<%/*** begin 新增集团编号，智能网编号查询条件 by diling@2012/5/3  ***/%>
<tr id="unit">
    <td width="16%" class="blue">集团编号</td>
    <td colspan="3">
        <input type="text" size="11"  name="unitNo" id="unitNo" v_type="0_9"  maxlength="10" onkeyup="if(event.keyCode==13)getOneId()" index="5" >
        <font class="orange">*</font>
        <input class="b_text" type="button" name="qryId_unit" value="查询" onClick="getOneId_unit()">
    </td>
</tr>
<tr id="vpmn">
    <td width="16%" class="blue">智能网编号</td>
    <td colspan="3">
        <input type="text" size="11"  name="vpmnNo" id="vpmnNo"  maxlength="11" onkeyup="if(event.keyCode==13)getOneId()" index="5" >
        <font class="orange">*</font>
        <input class="b_text" type="button" name="qryId_vpmn" value="查询" onClick="getOneId_vpmn()">
        <input type="hidden" name="unitId" value="" />
    </td>
</tr>
<%/*** end by diling@2012/5/3  ***/%>
<tr>
    <td width="16%" class="blue">客户ID</td>
    <td class=Input width="28%" >
        <input type="text" size="17" name="cus_id" id="cus_id" v_minlength=1 v_maxlength=22 v_type=int  maxlength="22" index="6">

    </td>
       <td  class="blue" width="16%"> 
          客户密码
        </td>
        <td  width="40%"> 
         <jsp:include page="/npage/common/pwd_one.jsp">
	      <jsp:param name="width1" value="16%"  />
	      <jsp:param name="width2" value="34%"  />
	      <jsp:param name="pname" value="cus_pass"  />
	      <jsp:param name="pwd" value="12345"  />
        </jsp:include>
            </td>
            </tr>
        </table>
        <table cellspacing="0">
            <tbody>
                <tr>
                    <td id="footer">
                        <input class="b_foot" type=button name=qryPage id=qryPage value="确认" onmouseup="doCfm()" onkeyup="if(event.keyCode==13)doCfm()" index="8">
                        <input class="b_foot" type=button name=back value="清除" onClick="doReset()"  >
                        <input class="b_foot" type=button name=close value="关闭" onClick="parent.removeTab('<%=opCode%>')"  >
                    </td>
                </tr>
            </tbody>
        </table>
        
        <input type="hidden" name="in_ChanceId" id="in_ChanceId" value="<%=in_ChanceId%>" />
        <input type="hidden" name="wa_no" id="wa_no" value="<%=wa_no%>" />
        <!--20120828 gaopeng 加入隐藏域 opcode 和 opname -->
        <input type="hidden" name="vopcode" value="<%=opCode%>"/>
        <input type="hidden" name="vopname" value="<%=opName%>"/>
      <%@ include file="/npage/include/footer_simple.jsp" %>
        </form>
    </body>
</html>  
