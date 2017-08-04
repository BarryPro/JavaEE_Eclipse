<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-13
********************/
%>
<%
  String opCode = "6726";
  String opName = "集团彩铃增加成员";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.StringTokenizer"%>
<%@ include file="../../include/remark1.htm" %>

<%

String ipAddress = (String)session.getAttribute("ipAddr");
String loginNo = (String)session.getAttribute("workNo");
String workname = (String)session.getAttribute("workName");
String orgCode = (String)session.getAttribute("orgCode");
String loginPwd  = (String)session.getAttribute("password");
String regionCode = (String)session.getAttribute("regCode");
%>
<%
	String sm_code = "";
  String mebProdCode ="";
  String matureProdCode ="";
  mebProdCode = request.getParameter("mebProdCode");
  matureProdCode = request.getParameter("matureProdCode");
  String sqlStr1="";
	String[][] retListString1 = null;
	
  
  //获取从上页得到的信息
	String loginAccept = request.getParameter("login_accept");
	if(loginAccept == null)
	{			
		//获取系统流水
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regionCode" routerValue="<%=regionCode%>"  id="req" />

<%		
		loginAccept=req;	
		//System.out.println("-------------loginAccept--------------hjw----------------"+loginAccept);
	}
%>
<HTML>
<HEAD>
	<TITLE>集团彩铃成员增加</TITLE>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<script language ="javascript">

//锁屏
function ajaxSubmit(){
	$.ajax({
		type: "POST",
		url: "f6726_2.jsp",
		beforeSend:function(XMLHttpRequest){
				loading();
			},
		
		data:"loginAccept="+document.frm.loginAccept.value+"&"+
			"opCode="+document.frm.opCode.value+"&"+
			"loginNo="+document.frm.loginNo.value+"&"+
			"loginPwd="+document.frm.loginPwd.value+"&"+
			"orgCode="+document.frm.orgCode.value+"&"+
			"sysNote="+document.frm.sysNote.value+"&"+
			"opNote="+document.frm.opNote.value+"&"+
			"ipAddress="+document.frm.ipAddress.value+"&"+
			"phoneNo="+document.frm.phoneNo.value+"&"+
			"grpIdNo="+document.frm.grpIdNo.value+"&"+
			"grpOutNo="+document.frm.grpOutNo.value+"&"+
			"unitId="+document.frm.unitId.value+"&"+
			"grpName="+document.frm.grpName.value+"&"+
			"payType1="+document.frm.payType1.value+"&"+
			"mebProdCode="+document.frm.mebProdCode.value+"&"+
			"mebMonthFlag1="+document.frm.mebMonthFlag1.value+"&"+
			"matureFlag="+document.frm.matureFlag.value+"&"+
			"matureProdCode="+document.frm.matureProdCode.value+"&"+
			"phoneNo1="+document.frm.phoneNo1.value,
		
		success: function(data, textStatus){
			$("body").html(data);
			$("body").html();
	  	},
	  	complete: function(XMLHttpRequest, textStatus){
		},
		error:function (XMLHttpRequest, textStatus, errorThrown) {
		}
	});
}
</script>

</HEAD>
<SCRIPT type=text/javascript>
function ChgCurrStep(currStep)
{
	if (currStep == "chkGrpPwd")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		document.frm.doSubmit.disabled = false;
	}
	else if (currStep == "qryPhone")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		document.frm.doSubmit.disabled = false;
	}
	else if (currStep == "chkUserPwd")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		document.frm.doSubmit.disabled = false;
	}
	else if (currStep == "doSubmit")
	{
		document.frm.custQuery.disabled = false;
		document.frm.chkGrpPwd.disabled = false;
		document.frm.doSubmit.disabled = false;
	}
	else if(currStep == "custQuery")
	{
	document.all.idIccid.readonly=true;
	document.all.custId.readonly=true;
	document.all.unitId.readonly=true;		
	document.all.grpOutNo.readonly=true;
	document.all.grpIdNo.readonly=true;
	document.all.custQuery.disabled = false;	
	}
}

function doProcess(packet)
{
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMessage = packet.data.findValueByName("retMessage");
	self.status="";
	    //集团客户密码校验
	     if(retType == "checkPwd") 
     {
        if(retCode == "000000")
        {
            var retResult = packet.data.findValueByName("retResult");
            if (retResult == "false") {
    	    	rdShowMessageDialog("客户密码校验失败，请重新输入！",0);
            frm.doSubmit.disabled = true;
	        	//frm.custPwd.value = "";
	        	//frm.custPwd.focus();
	        	
    	    	return false;	        	
            } else {
                rdShowMessageDialog("客户密码校验成功！",2);
               document.frm.doSubmit.disabled=false;
            }
         }
        else
        {
            rdShowMessageDialog("客户密码校验出错，请重新校验！",0);
            document.frm.doSubmit.disabled = true;
    		return false;
        }
     }	

	if(retType == "chkUserPwd") //集团用户密码校
	{
		if(retCode == "0")
		{
			var retResult = packet.data.findValueByName("retResult");
			var retMessage = packet.data.findValueByName("retMessage");
			if (retResult == "false")
			{
				ChgCurrStep("chkUserPwd");
				rdShowMessageDialog(retMessage,0);
				frm.userPwd.value = "";
				frm.userPwd.focus();
				return false;
			}
			else
			{
				ChgCurrStep("doSubmit");
				rdShowMessageDialog("用户密码校验成功",2);
			}
		}
		else
		{
			rdShowMessageDialog("用户密码校验出错，请重新校验！",0);
			return false;
		}
	}
  //变更产品
  if(retType == "changProd"){  	
	  var triListData = packet.data.findValueByName("tri_list"); 	  
	 	var triList=new Array(triListData.length);
	  triList[0]="mebProdCode";
	  document.all("mebProdCode").length=0;
	  document.all("mebProdCode").options.length=triListData.length;
	  for(j=0;j<triListData.length;j++)
	  {
		document.all("mebProdCode").options[j].text=triListData[j][1];
		document.all("mebProdCode").options[j].value=triListData[j][0];
	  }
	  document.all("mebProdCode").options[0].selected=true; 
  } 
    //变更包年到期转产品
  if(retType == "changmatureProd"){  	
	  var triListData = packet.data.findValueByName("tri_list"); 	  
	 	var triList=new Array(triListData.length);
	  triList[0]="matureProdCode";
	  document.all("matureProdCode").length=0;
	  document.all("matureProdCode").options.length=triListData.length;
	  for(j=0;j<triListData.length;j++)
	  {
		document.all("matureProdCode").options[j].text=triListData[j][1];
		document.all("matureProdCode").options[j].value=triListData[j][0];
	  }
	  document.all("matureProdCode").options[0].selected=true; 
  }  
	//取流水
	if(retType == "getSysAccept")
	{
		if(retCode == "000000")
		{
			var sysAccept = packet.data.findValueByName("sysAccept");
			document.frm.loginAccept.value=sysAccept;
			showPrtDlg("Detail","确实要打印电子免填单吗？","Yes");
			if (rdShowConfirmDialog("是否提交确认操作？")==1)
			{
				//return true;
//				page = "f6726_2.jsp";
//				frm.action=page;
//				frm.method="post";
//				frm.submit();
   
					ajaxSubmit();
			}
			else return false;
		}
		else
		{
			rdShowMessageDialog("查询流水出错,请重新获取！");
			return false;
		}
	}
	if(retType == "QryPhoneInfo") //集团客户密码校
	{
		if(retCode == "000000")
		{
			var retResult = packet.data.findValueByName("retResult");
			var retMessage = packet.data.findValueByName("retMessage");
			if (retResult == "false")
			{
				rdShowMessageDialog(retMessage,0);
				frm.grpPwd.value = "";
				frm.grpPwd.focus();
				ChgCurrStep("qryPhone");
				return false;
			}
			else
			{
				document.frm.idNo.value=packet.data.findValueByName("idNo");
				document.frm.smCode.value=packet.data.findValueByName("smCode");
				document.frm.smName.value=packet.data.findValueByName("smName");
				document.frm.userName.value=packet.data.findValueByName("custName");
				//document.frm.userPwd.value=packet.data.findValueByName("userPwd");
				document.frm.mainRate.value=packet.data.findValueByName("mainRate");
				document.frm.mainRateName.value=packet.data.findValueByName("mainRateName");
				ChgCurrStep("chkUserPwd");
				rdShowMessageDialog("取用户信息成功！");
			}
		}
		else
		{
			rdShowMessageDialog(retMessage+retCode,0);
			return false;
		}
	}
}

//调用公共界面，进行产品属性选择
function getmebProdCodeQuery()
{
    var pageTitle = "集团成员产品选择";
    var fieldName = "产品属性代码|产品属性|";
		var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|0|1|";
    var retToField = "mebProdCode|mebProdName|";
    var smName = document.frm.smName.value;
    
    //首先判断是否已经选择了集团信息
    if(document.frm.smName.value == "")
   {
    rdShowMessageDialog("请首先选择集团信息！",0);
    return false;
   }
   //判断是否选择付费类型
	 if(document.frm.payType.value == "")
   {
    rdShowMessageDialog("请选择付费方式！",0);
    return false;
   }
    if(PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "/npage/s6726/fpubmebProdCode_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    path = path + "&groupFlag=Y";
	  path = path + "&op_code=" + document.all.opCode.value;
	  path = path + "&sm_code=" + document.all.smCode.value; 
	  path = path + "&smName=" + document.all.smName.value;
	  path = path + "&payType=" +document.all.payType.value;
	  path = path + "&regionCode=<%=regionCode%>"
	  path = path + "&mebMonthFlag=" + document.all.mebMonthFlag.value;  	       
    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	return true;
}

function getmebProdCode(retInfo)
{
	var retToField = "mebProdCode|mebProdName|";
	if(retInfo ==undefined)      
	{
		//ChgCurrStep("custQuery");
		return false;
	}
	
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
	document.frm.payType1.value=document.frm.payType.value;
	document.frm.payType.disabled=true;
}

function getmatureProdCodeQuery()
 {  
 	  var pageTitle = "保年到期转包月产品选择";
    var fieldName = "产品属性代码|产品属性|";    
		var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|0|1|";
    var retToField = "matureProdCode|matureProdName|";
    var smName = document.frm.smName.value;
    //首先判断是否已经选择了集团信息
    if(document.frm.smName.value == "")
   {
    rdShowMessageDialog("请首先选择集团信息！",0);
    return false;
   }
	if(PubSimpSelmatureProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
 }
 
function PubSimpSelmatureProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{   
    var path = "/npage/s6726/fpubmatureProdCode_sel.jsp"; 
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    path = path + "&groupFlag=Y";
	  path = path + "&regionCode=<%=regionCode%>" 
	  path = path + "&smName=" + document.all.smName.value;  
	  path = path + "&mebMonthFlag=" + document.all.mebMonthFlag1.value;  
	  path = path + "&payType=" +document.all.payType.value; 
    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	return true;	
}
function getmatureProd(retInfo)
{ 
	var retToField = "matureProdCode|matureName|";
	if(retInfo ==undefined)      
	{
		//ChgCurrStep("custQuery");
		return false;
	}
	
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


//调用公共界面，进行集团客户选择
function getInfo_Cust()
{
	var pageTitle = "集团客户选择";
	var fieldName = "证件号码|集团客户ID|集团用户ID|集团用户编码|集团ID|集团产品代码|集团名称|品牌名称|包月标志|";
	var sqlStr = "";
	var selType = "S";    //'S'单选；'M'多选
	var retQuence = "9|0|1|2|3|4|5|6|7|8|";
	var retToField = "idIccid|custId|grpIdNo|grpOutNo|unitId|smName|grpName|smCode|mebMonthFlag|";
	var custId = document.frm.custId.value;

	if(document.frm.idIccid.value == "" &&
	document.frm.custId.value == "" &&
	document.frm.unitId.value == "" &&
	document.frm.grpOutNo.value == "")
	{
		rdShowMessageDialog("请输入身份证号、客户ID、集团ID或集团产品编号进行查询！",0);
		document.frm.idIccid.focus();
		return false;
	}

	if(document.frm.custId.value != "" && forNonNegInt(frm.custId) == false)
	{
		frm.custId.value = "";
		rdShowMessageDialog("必须是数字！",0);
		return false;
	}

	if(document.frm.unitId.value != "" && forNonNegInt(frm.unitId) == false)
	{
		frm.unitId.value = "";
		rdShowMessageDialog("必须是数字！",0);
		return false;
	}

	if(document.frm.grpOutNo.value == "0")
	{
		frm.grpOutNo.value = "";
		rdShowMessageDialog("集团产品编号不能为0！",0);
		return false;
	}

	PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
}

function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
	var path = "/npage/s6726/fpubgrpusr_sel.jsp";
	path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	path = path + "&selType=" + selType+"&idIccid=" + document.all.idIccid.value;
	path = path + "&custId=" + document.all.custId.value;
	path = path + "&unitId=" + document.all.unitId.value;
	path = path + "&grpOutNo=" + document.all.grpOutNo.value;
	

	retInfo = window.open(path,"newwindow","height=450, width=830,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvaluecust(retInfo)
{
	var retToField = "idIccid|custId|grpIdNo|grpOutNo|unitId|smName|grpName|smCode|mebMonthFlag|";

	ChgCurrStep("custQuery");
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
	  document.all(obj).readOnly=true;
		retToField = retToField.substring(chPos_field + 1);
		retInfo = retInfo.substring(chPos_retInfo + 1);
		chPos_field = retToField.indexOf("|");
	}
	//alert("mebMonthFlag"+document.frm.mebMonthFlag.value);
	document.frm.mebMonthFlag1.value=document.frm.mebMonthFlag.value;
	document.frm.mebMonthFlag.disabled=true;	
	//tochange();
	//tomaturechange();
}

function check_HidPwd()
{
	var custId = document.frm.custId.value;
	var Pwd1 = document.frm.grpPwd.value;
	var checkPwd_Packet = new AJAXPacket("/npage/s6726/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
	checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("cust_id",custId);
	checkPwd_Packet.data.add("Pwd1",Pwd1);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet =null ;
}

function ChkUserPwd()
{
	var checkPwd_Packet = new AJAXPacket("/npage/s6726/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
	checkPwd_Packet.data.add("retType","chkUserPwd");
	checkPwd_Packet.data.add("ID_NO",document.frm.idNo.value);
	checkPwd_Packet.data.add("inPwd",document.frm.userPwd.value);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet =null;
}

function QryPhoneInfo()
{
	if (checkElement("phoneNo"))
	{
		document.frm.phoneNo.focus();
	}
	var checkPwd_Packet = new AJAXPacket("/npage/s6726/getPhoneInfo.jsp","正在进行密码校验，请稍候......");
	checkPwd_Packet.data.add("retType","QryPhoneInfo");
	checkPwd_Packet.data.add("loginNo","<%=loginNo%>");
	checkPwd_Packet.data.add("phoneNo",document.frm.phoneNo.value);
	checkPwd_Packet.data.add("opCode",document.frm.opCode.value);
	checkPwd_Packet.data.add("grpIdNo",document.frm.grpIdNo.value);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet=null;
}

//打印信息
	 function printInfo(printType)
	 { 
	 	var payType = document.frm.payType.value;
	 	var matureFlag = document.frm.matureFlag.value;
	 	var matureProdCode = document.frm.matureProdCode.value;
	 	var phoneNo = "";
	 	if(payType=="2") {
	 		payType="个人付费";
	 	}
	 	if(payType=="0"); {
	 		payType="集团付费";
	 	}
	 	var mebMonthFlag =document.frm.mebMonthFlag1.value;
	 	if(mebMonthFlag=="N") {
	 		mebMonthFlag="包年";	
	 		phoneNo = document.frm.phoneNo1.value;
	 	}
	 	if(mebMonthFlag=="Y") {
	 		mebMonthFlag="包月";
	 		matureProdCode="无";
	 		matureFlag="否";
	 		phoneNo = document.frm.phoneNo.value;
	 	}
		    var retInfo = "";
			  retInfo+='<%=workname%>'+"|";
    		retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    		retInfo+="身份证号:"+document.frm.idIccid.value+"|";
    		retInfo+="用户名称:"+document.frm.grpName.value+"|";
    		retInfo+="集团用户编码:"+document.frm.grpOutNo.value+"|";
    		retInfo+="付费方式:"+payType+"|";
  	    retInfo+="产品周期:"+mebMonthFlag+"|";
  	    retInfo+="集团成员产品:"+document.frm.mebProdCode.value+"|";
  	    retInfo+="包年到期转包月:"+matureFlag+"|";
  	    retInfo+="转包月产品:"+matureProdCode+"|";
	    	retInfo+="手机号码:"+phoneNo+"|";
	    	retInfo+=""+"|";
	    	retInfo+=""+"|";
	    	retInfo+=""+"|";
	    	retInfo+=""+"|";
	    	retInfo+=""+"|";
	    	retInfo+=""+"|";
	    	retInfo+=""+"|";
	    	retInfo+=""+"|";
	    	retInfo+=""+"|";
	    	retInfo+="流水："+document.frm.loginAccept.value+"|";
	    	retInfo+=""+"|";
	    	retInfo+=""+"|";
	    	retInfo+=""+"|";
	    	retInfo+=""+"|";
	    	retInfo+=""+"|";
	    	retInfo+=""+"|";
	    	retInfo+=document.frm.sysNote.value+"|";
			  return retInfo;
  }

//显示打印对话框
function showPrtDlg(printType,DlgMessage,submitCfm)
{
	var h=150;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var printStr = printInfo(printType);	
	if(printStr == "failed")
	{
		return false;
	}
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:no; resizable:no;location:no;status:no;help:no"
	var path = "/npage/innet/hljBillPrint.jsp?DlgMsg=" + DlgMessage;
	var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
	var ret=window.showModalDialog(path,printStr,prop);
}


function QryNewRate()
{
    var pageTitle = "集团费率信息查询";
    var fieldName = "集团费率代码|集团费率名称|";

	if (document.frm.grpIdNo.value == "")
	{
		rdShowMessageDialog("集团代码不能为空！",0);
		return false;
	}
	var sqlStr =	 "SELECT b.mode_code, b.mode_name"
				+"  FROM dGrpUserMsgAdd a, sBillModeCode b"
				+" WHERE trim(a.field_value) = b.mode_code"
				+"   AND id_no = " + document.frm.grpIdNo.value
				+"   AND b.region_code = '" + "<%=regionCode%>" + "'"
				+"   AND a.field_code = any('10000', '10001')"
				+" ORDER BY b.mode_code";
    
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|0|1|";
    var retToField = "newRate|newRateName|";
    PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
}


function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
	var path = "/npage/public/fPubSimpSel.jsp";
	path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	path = path + "&selType=" + selType;
	var retInfo = window.showModalDialog(path);
	//window.open(path);
	if(typeof(retInfo)=="undefined")
	{
		return false;
	}
	var chPos_field = retToField.indexOf("|");
	var chPos_retStr;
	var valueStr;
	var obj;
	//alert(retInfo);
	while(chPos_field > -1)
	{
		obj = retToField.substring(0,chPos_field);
		//alert(obj);
		chPos_retInfo = retInfo.indexOf("|");
		valueStr = retInfo.substring(0,chPos_retInfo);
		document.all(obj).value = valueStr;
		retToField = retToField.substring(chPos_field + 1);
		retInfo = retInfo.substring(chPos_retInfo + 1);
		chPos_field = retToField.indexOf("|");
	}
}

//取流水
function getSysAccept()
{
	var getSysAccept_Packet = new AJAXPacket("pubSysAccept.jsp","正在生成操作流水，请稍候......");
	getSysAccept_Packet.data.add("retType","getSysAccept");
	core.ajax.sendPacket(getSysAccept_Packet);
	getSysAccept_Packet =null;
}

function refMain()
{	
	     getAfterPrompt();
		if(document.frm.payType.value == "2"){		
		 if(document.frm.mebMonthFlag.value == "N" )
		 {
			 if(document.frm.matureFlag.value == "Y" )    
		   {		if(document.frm.matureProdCode.value == "" )    
		        {	
				    rdShowMessageDialog("请选择转换产品!!",2);
				    document.frm.matureProdCode.focus();
				    return false;
				   }
		    }
		 }	
	 }
	if(document.frm.mebMonthFlag1.value == "Y"){		
		if(  document.frm.phoneNo.value == "" )
		{
			rdShowMessageDialog("集团成员号码不能为空!!",0);
			document.frm.phoneNo.focus();
			return false;
		}	
	 }else{
	    if(document.frm.payType.value == "2"){	
	         if(document.frm.phoneNo1.value == "" )
					 {
						rdShowMessageDialog("集团成员号码不能为空!!",0);
						document.frm.phoneNo1.focus();
						return false;
					 }
		  }else{
			     if(  document.frm.phoneNo.value == "" )
					 {
						rdShowMessageDialog("集团成员号码不能为空!!",0);
						document.frm.phoneNo1.focus();
						return false;
					 }
	      }
	  }
	 	if(  document.frm.mebProdCode.value == "" )
		{
			rdShowMessageDialog("集团成员产品不能为空!!",0);
			document.frm.mebProdCode.focus();
			return false;
		}	
if(document.frm.mebMonthFlag1.value=="Y"){
			  var phoneNo=document.frm.phoneNo.value;
				var chPos_field ;
				var MobPhone;	
				var count=0;		
				while(phoneNo!=""){
				    chPos_field = phoneNo.indexOf("|");
				    MobPhone   =phoneNo.substring(0,chPos_field);
				    phoneNo = phoneNo.substring(chPos_field + 1);
					  //phoneNo=phoneNo.replace("\r\n","");
				    MobPhone = MobPhone.replace("\r\n","");
				    MobPhone=trimAll(MobPhone);			    
					  if(MobPhone!=""){
						    if((MobPhone.substring(0,1) !=1) || (MobPhone.substring(1,2) !=3 && MobPhone.substring(1,2) !=5&& MobPhone.substring(1,2) !=4&& MobPhone.substring(1,2) !=8))
				        {
				        rdShowMessageDialog("手机号码只能以13或15或14或18开头，请重新输入手机号码！" ,0);
					      document.frm.phoneNo.focus();
						    return false;
				        }
		            if((myParseInt(MobPhone.substring(0,3),10)<134) || (myParseInt(MobPhone.substring(0,3),10)>139 && myParseInt(MobPhone.substring(0,2),10) !=15&& myParseInt(MobPhone.substring(0,2),10) !=14&& myParseInt(MobPhone.substring(0,2),10) !=18))
			          { 
			          rdShowMessageDialog("手机号码范围应该在134~139之间或者是15X号段或者是14X号段或者是18X号段");
			          document.frm.phoneNo.focus();
				        return false;	
			          }	
		         }		    
				    count ++;
						if(count>30){
				      rdShowMessageDialog("添加的成员号码信息格式错误或成员数量超过30个！",0);
			        document.frm.phoneNo.focus();
			        return false;
					 }
			 }
		} 
		 
	document.frm.sysNote.value = "工号[<%=loginNo%>]为集团["+document.all.custId.value+"]办理集团彩铃成员添加";
	 if((document.all.opNote.value).trim().length==0)
	 {
	 document.all.opNote.value= "工号[<%=loginNo%>]为集团["+document.all.custId.value+"]办理集团彩铃成员添加";
	 }
	getSysAccept();
  //wuxy alter 20090826 解决确定、取消都提交的问题
	//ajaxSubmit();
}

// 名称:全截取函数
// 功能:把指定的文本中左边和右边的空格全部截取
// 返回:已经截取的文本
// 参数:text 指定的文本
function trimAll(text)
{
        return leftTrim(rightTrim(text));//先右截取,再左截取,返回
}


// 名称:左截取函数
// 功能:把指定的文本中左边的空格全部截取
// 返回:已经截取的文本
// 参数:text 指定的文本
function leftTrim(text)
{
        if(text==null || text=="") return text;//如果text无内容,返回text
        var leftIndex=0;//定义最左非空格字符的索引下标(空格字符数)
        while(text.substring(leftIndex,leftIndex+1)==" ")//直至找到最左的非空格的字符,要么进行
                leftIndex++;//最右非空格字符的索引下标后移
        return text.substring(leftIndex,text.length);//返回
}

// 名称:右截取函数
// 功能:把指定的文本中右边的空格全部截取
// 返回:已经截取的文本
// 参数:text 指定的文本
function rightTrim(text)
{
        if(text==null || text=="") return text;//如果text无内容,返回text
        var rightIndex=text.length;//定义最右非空格字符的索引下标
        while(text.substring(rightIndex-1,rightIndex)==" ")//直至找到最右的非空格的字符,要么进行
                rightIndex--;//最右非空格字符的索引下标前移
        return text.substring(0,rightIndex);//返回
} 


function choiceFilePut()
{
	if(document.all.byFile.checked){
		document.all.phoneNo.readOnly=true;
	  document.all.setBBChbByFile.disabled = false;
		document.all.setPdButton.disabled = true;
	}else{
		document.all.phoneNo.readOnly=false;
		document.all.setBBChbByFile.disabled = true;
		document.all.setPdButton.disabled = false;
	}
}

function setBBChgByFile()
{

	if(document.all.addFile.value== ""){
		rdShowMessageDialog("请点击【浏览...】按钮选择文件！");
		document.all.addFile.focus();
 		return;
	}

	var region_code = form1.region_code.value;
	document.frm.action="f5246_setBBChgByFile.jsp?region_code=" + region_code;
  document.frm.submit();
}

function changeOthers(){
	var payType=document.frm.payType.value;
	var mebMonthFlag1=document.frm.mebMonthFlag1.value;
	if(payType=="2"){
		  document.frm.matureProdCode.value="";	
		  document.frm.matureFlag.value="N";					
			tbs2.style.display="";
			tbs3.style.display="";			
			if(mebMonthFlag1=="Y"){
				document.frm.phoneNo1.value=""
				tbs2.style.display="none";
				tbs3.style.display="none";
				tbs4.style.display="";	
				tbs5.style.display="none";
				document.frm.matureProdCode.readonly=false;
				//document.frm.matureProdCode.style.display='none';
				document.frm.matureProdCodeQuery.disabled=true;			  		  			         
			}else{			
				document.frm.phoneNo.value=""		
				tbs4.style.display="none";
				tbs5.style.display="";							
			}				         
	}else{
		  	tbs2.style.display="none";
				tbs3.style.display="none";
			if(mebMonthFlag1=="Y"){
				document.frm.matureProdCode.value="";	
		    document.frm.matureFlag.value="N";
				document.frm.phoneNo1.value=""
				tbs4.style.display="";	
				tbs5.style.display="none";				  		  			         
			}else{
				document.frm.phoneNo.value=""
				document.frm.matureProdCode.value="";
				document.frm.matureProdCode.disabled=true;
				document.frm.matureFlag.value="N";	
				tbs4.style.display="";
				tbs5.style.display="none";							
			}	
	}	
}


function changeMatureFlag(){
	var matureFlag=document.frm.matureFlag.value;
	if(matureFlag=="Y"){
	 document.frm.matureProdCode.value="";
	 document.frm.matureProdCode.readonly=true;
	 //document.frm.matureProdCode.style.display='block'; 
	 document.frm.matureProdCodeQuery.disabled=false;
   }else{
   document.frm.matureProdCode.value="";  
   document.frm.matureProdCode.disabled=false;
   document.frm.matureProdCode.readonly=false;
   //document.frm.matureProdCode.style.display='none'   
   document.frm.matureProdCodeQuery.disabled=true;
   }	
}


function   checkLength(text)   
{   
  if (text.value.length >= 360){
  rdShowMessageDialog("最多允许输入30个手机号码!!");	   
  return   false;   
  }
} 



</script>
<BODY>
	<FORM action="" method="post" name="frm" >
			<%@ include file="/npage/include/header.jsp" %>  
		<input type="hidden" name="loginAccept"  value="<%=loginAccept%>"> <!-- 操作流水号 -->
		<input type="hidden" name="loginNo"  value="<%=loginNo%>">
		<input type="hidden" name="loginPwd"  value="<%=loginPwd%>">
		<input type="hidden" name="smCode"  value="">
		<input type="hidden" name="opCode" id="opCode" value="6726">	
		<input type="hidden" name="smName"  value="">
		<input type="hidden" name="grpName"  value="">
		<input type="hidden" name="mebProdCode"  value="">
		<input type="hidden" name="matureProdCode"  value="">
	  <input type="hidden" name="regionCode"  value="<%=regionCode%>">
		<input type="hidden" name="pay_type"  value="">
		<input type="hidden" name="orgCode"  value="<%=orgCode%>">
		<input type="hidden" name="ipAddress"  value="<%=ipAddress%>">
	  <input type="hidden" name="matureName"  value="">
	  <input type="hidden" name="payType1"  value="2">
	  <input type="hidden" name="mebMonthFlag1"  value="Y">	  
		<div class="title">
		<div id="title_zi">集团彩铃增加成员</div>
	</div>
						<TABLE  cellSpacing=0>
							<TR>
								<td class="blue">
									操作类型
								</TD>
								<TD colspan="3">
									<SELECT name="opCode1"  id="opCode1" onChange="OpCodeChange()"  disabled >
										<option value="6726" selected>批量集团成员加入</option>
										<option value="6727">批量集团成员删除</option>
									</SELECT>
									<font class="orange">*</font>
								</TD>
							</TR>
							<TR>
								<td class="blue">
									证件号码
								</TD>
								<TD>
									<input name="idIccid"  id="idIccid" size="24" maxlength="18" v_type="string" v_must=1 v_name="身份证号" index="1" value="">
									<input name=custQuery type=button id="custQuery" class="b_text" onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursorhand" value=查询>
									<font class="orange">*</font>
								</TD>
								<td class="blue">集团客户ID</TD>
								<TD>
									<input  type="text" name="custId" size="20" maxlength="18" v_type="0_9" v_must=1 v_name="客户ID" index="2" value="">
									<font class="orange">*</font>
								</TD>
							</TR>
							<TR>
								<td class="blue">
								集团编号</div>
								</TD>
								<TD>
									<input name=unitId  id="unitId" size="24" maxlength="10" v_type="0_9" v_must=1 v_name="集团ID" index="3" value="">
									<font class="orange">*</font>
								</TD>
								<td class="blue">集团产品编号</TD>
								<TD>
									<input  name="grpOutNo" size="20" v_must=1 v_type=string v_name="集团产品编号" index="4" value="">
									<font class="orange">*</font>
								</TD>
							</TR>
							<TR>
								<td class="blue">集团产品ID</TD>
								<TD COLSPAN="1">
									<input  name="grpIdNo" size="20" readonly v_must=1 v_type=string v_name="集团用户ID" index="4" value="" class="InputGrey">
									<font class="orange">*</font>
								</TD>
								<td class="blue">集团客户密码</TD>
								<TD colspan="1">
									<jsp:include page="/npage/common/pwd_1.jsp">
									<jsp:param name="width1" value="16%"  />
									<jsp:param name="width2" value="34%"  />
									<jsp:param name="pname" value="grpPwd"  />
									<jsp:param name="pwd" value=""  />
									</jsp:include>

									<input name=chkGrpPwd type=button onClick="check_HidPwd();" class="b_text" style="cursorhand" id="chkGrpPwd" value=校验 >
									<font class="orange">*</font>               
								</TD>                                                                    
							</TR>                                                                 
              <TR>                                                 
								<TD class="blue">                                                               
									付费方式                           
								</TD>
								<TD >
									<SELECT name="payType"  id="payType" onclick="changeOthers()">
                    <option value="" selected>--请选择--</option>
										<option value="2" >个人付费</option>
										<option value="0" >集团付费</option>
									</SELECT>
									<font class="orange">*</font>
								</TD>
								<td class="blue">
									产品周期
								</TD>
								<TD >
									<SELECT name="mebMonthFlag"  id="mebMonthFlag"  onclick="changeOthers()">
										<option value="N" >包年</option>
										<option value="Y" >包月 </option>
									</SELECT>
									<font class="orange">*</font>
								</TD>
							</TR>
						 <TR>
								<td class="blue">
									集团成员产品
								</TD>											
	           <TD>
	              <input  type="text" id="mebProdName"  name="mebProdName" size="20" value=""  readonly>
	              <input name="mebProdCodeQuery" type="button" id="mebProdCodeQuery"  class="b_text" onMouseUp="getmebProdCodeQuery();" onKeyUp="if(event.keyCode==13)getmebProdCodeQuery();" value="选择">
				  			<font class="orange">*</font>
	  			   	</TD>													
								<td class="blue">
								<div id=tbs2 style="display:none">包年到期转包月</div>
								</TD>								
							   
							  <TD >
							  	<div id=tbs3 style="display:none">																
										<SELECT name="matureFlag"  id="change_year" onChange="changeMatureFlag()" >
											<option value="Y" >是 </option>
											<option value="N" selected>否 </option>
										</SELECT>									         		      
			              <input  type="text" id="matureProdName"  name="matureProdName" size="15" value="" readonly>
			              <input name="matureProdCodeQuery" type="button" id="matureProdCodeQuery"  class="b_text" onMouseUp="getmatureProdCodeQuery();" onKeyUp="if(event.keyCode==13)getmatureProdCodeQuery();" value="选择">
						  			<font class="orange">*</font>		 			   	  														 			
							 		</div>									
								</TD>												           
		          </TR>															
							<TR>
								<td class="blue">手机号码</TD>
								<TD colspan="1">
							  <div id="tbs4" style="display:">
								<textarea cols=30 rows=8 name="phoneNo" style="overflow:auto" v_must=1 v_minlength="11" v_maxlength="12" v_type="string" v_name="手机号码" index="8" onpropertychange="if(this.value.length>600){this.value=this.value.substr(0,600);}" value=""></textarea>
								<br>注批量增加手机号码时,请用"|"作为分隔<br>
								符,并且最后一个号码也请用"|"作为结束,批量数量最大不超过30个。<br>
								例如：13900000000|<br>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13900000001|<br>
								</div>
								 <div id="tbs5" style=display="none">
									<input  name="phoneNo1" size="24" value="" maxlength="11" v_minlength="11" v_maxlength="11">
									<br>注一次只允许增加一个手机号码,不需要加“|”。<br>					
								</div>
								</TD>
								<TD>
								<TD>
								<div id="tbs1" style="display:none">
									<font color="red">成员主资费必须为000030AA <br>
								  (0月租，基本通信费0.40元/分钟)<br> 
								  才能加入本集团<br></font>
								</div>
								</TD>
							  </tr>
	
							<TR>
								<td>&nbsp;</TD>
								<TD colspan="3">
									<input  name="sysNote" size="60" value="" readonly type="hidden">
								</TD>
							</TR>
							<TR>
								<td class="blue">用户备注</TD>
								<TD colspan="3">
									<input  name="opNote" size="60" value="" class="InputGrey">
								</TD>
							</TR>
						</TABLE>
						<TABLE cellSpacing=0>
							<TR>
								<TD align=center id="footer">
									<input class="b_foot" name="doSubmit"  type=button value="确认" onclick="refMain()"  disabled >
									<input class="b_foot" name="reset1"  onClick="location = 'f6726_1.jsp';" type=reset value="清除" >
									<input class="b_foot" name="kkkk"  onClick="removeCurrentTab()" type=button value="关闭" >
								</TD>
							</TR>
						</TABLE>
    <%@ include file="/npage/include/footer.jsp" %>
		<jsp:include page="/npage/common/pwd_comm.jsp"/>
	</FORM>
 <script language="JavaScript">
	document.frm.idIccid.focus();
</script>
</BODY>
</HTML>
