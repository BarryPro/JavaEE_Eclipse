<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-15
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="com.sitech.boss.s1900.config.productCfg" %>
<%@ include file="../../include/remark.htm" %>

<%
    String opCode = "3519";
    String opName = "集团产品资费变更";
    Logger logger = Logger.getLogger("f3519.jsp");

    String ip_Addr = (String)session.getAttribute("ipAddr");
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
    String nopass  = (String)session.getAttribute("password");
    String Department = org_code;
    String regionCode = Department.substring(0,2);
    String districtCode = Department.substring(2,4);

    String sqlStr = "";
    ArrayList retArray = new ArrayList();
    String[][] result = new String[][]{};

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>集团产品资费变更</TITLE>
</HEAD>
<SCRIPT type=text/javascript>

//core.loadUnit("debug");
//core.loadUnit("rpccore");
onload=function(){
    //core.rpc.onreceive = doProcess;
}

function doProcess(packet)
{
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
    self.status="";

    //---------------------------------------
    if(retType == "GrpCustInfo") //BOSS集团用户产品变更客户信息查询
    {
        var retname = packet.data.findValueByName("retname");
        if(retCode=="000000")
        {
            document.frm.cust_name.value = retname;
			document.frm.unit_id.focus();
        }
        else
        {
            retMessage = retMessage + "[errorCode1：" + retCode + "]";
            rdShowMessageDialog(retMessage,0);
            return false;
        }
     }
	 if(retType == "getSysAccept")
     {
        if(retCode == "000000")
        {
            var sysAccept = packet.data.findValueByName("sysAccept");
			document.frm.login_accept.value=sysAccept;
			showPrtDlg("Detail","确实要打印电子免填单吗？","Yes");
			if (rdShowConfirmDialog("是否提交确认操作？")==1){
				page = "f3519_cfm.jsp";
				frm.action=page;
				frm.method="post";
				frm.submit();
			}
			else return false;
         }
        else
        {
                rdShowMessageDialog("查询流水出错,请重新获取！",0);
				return false;
        }
    }
     //---------------------------------------
     if(retType == "checkPwd") //集团客户密码校验
     {
        if(retCode == "000000")
        {
            var retResult = packet.data.findValueByName("retResult");
            if (retResult == "false") {
    	    	rdShowMessageDialog("客户密码校验失败，请重新输入！",0);
	        	frm.custPwd.value = "";
	        	frm.custPwd.focus();
    	    	return false;	        	
            } else {
                rdShowMessageDialog("客户密码校验成功！",2);
                document.frm.sysnote.value = "BOSS集团产品资费变更";
                document.frm.tonote.value = "BOSS集团产品资费变更";
                document.frm.sure.disabled = false;
            }
         }
        else
        {
            rdShowMessageDialog("客户密码校验出错，请重新校验！",0);
    		return false;
        }
     }
     


	var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
	var retMessage=packet.data.findValueByName("retMessage");
    self.status="";
    if(retType == "UserId")
    {
        if(retCode == "000000")
        {
            var retUserId = packet.data.findValueByName("retnewId");    	    
    	    document.frm.grp_id.value = retUserId;
			document.frm.grp_userno.value=retUserId;
            document.frm.reset1.disabled = false;
    	    document.frm.grpQuery.disabled = true;
            document.frm.grp_name.focus();
         }
        else
        {
            rdShowMessageDialog("没有得到用户ID,请重新获取！",0);
			return false;
        }
		//得到集团用户编号的时候，得到集团代码
		//getGrpId();
    }
    if(retType == "GrpId") //得到集团代码
    {
        if(retCode == "000000")
        {
            var GrpId = packet.data.findValueByName("GrpId");
            document.frm.grp_userno.value = oneTok(GrpId,"|",1);
         }
        else
        {
            var retMessage = packet.data.findValueByName("retMessage");
            rdShowMessageDialog(retMessage, 0);
        }
	}
    if(retType == "GrpNo") //得到集团用户编号
    {
        if(retCode == "0")
        {
            var GrpNo = packet.data.findValueByName("GrpNo");
            document.frm.grp_userno.value = GrpNo;
            document.frm.getGrpNo.disabled = true;
         }
        else
        {
            var retMessage = packet.data.findValueByName("retMessage");
            rdShowMessageDialog(retMessage, 0);
        }
	}
    //---------------------------------------
   
    if(retType == "AccountId") //得到帐户ID
    {
        if(retCode == "000000")
        {
            var retnewId = packet.data.findValueByName("retnewId");
            document.frm.account_id.value = retnewId;
            document.frm.accountQuery.disabled = true;
			document.frm.user_passwd.focus();
         }
        else
        {
            rdShowMessageDialog("没有得到帐户ID,请重新获取！",0);
        }
    }
    //---------------------------------------
    if(retType == "UnitInfo")
    {
        //集团信息查询
        var retname = packet.data.findValueByName("retname");
        if(retCode=="000000")
        {
            document.frm.unit_name.value = retname;
			document.frm.contract_name.focus();
        }
        else
        {
            retMessage = retMessage + "[errorCode1:" + retCode + "]";
                rdShowMessageDialog(retMessage,0);
				return false;
        }
     }
    

     //---------------------------------------
     if(retType == "ProdAttr")
     {
        if(retCode == "000000")
        {
            var retnums = packet.data.findValueByName("retnums");
            var retname = packet.data.findValueByName("retname");

            if (retnums == 1) { //只有一个产品属性的时候，不需要用户选择
                document.frm.product_attr.value = retname;
                document.frm.ProdAttrQuery.disabled = false;
            }
            else if (retnums > 1) {
                document.frm.product_attr.value = "";
                document.frm.ProdAttrQuery.disabled = false;
            }
         }
        else
        {
                rdShowMessageDialog("查询产品属性出错,请重新获取！",0);
				return false;
        }
    }
    if(retType=="getBillingType")//得到sbillspcode中的 billingtype luxc add 20070916
    {
    	
    	if(retCode="000000")
    	{
    		
    		var billingtype = packet.data.findValueByName("billingtype");
    		document.all.billingtype.value = billingtype;
    		
    		if(billingtype == "00" || billingtype == "01")//如果免费或包月
    		{
    			document.all.tr_gongnengfee.style.display = "none";
    		}
    		else if(billingtype == "02")//如果按次
    		{
    			document.all.tr_gongnengfee.style.display = "block";
    		}
    		else
    		{
    			document.all.tr_gongnengfee.style.display = "none";
    			
    			//alert("查询sbillspcode,billingtype出错="+billingtype);
    		}
    		
    	}
    	else
    	{
    		rdShowMessageDialog(retMessage);
    	}
    }
 }

//调用公共界面，进行集团客户选择
function getInfo_Cust()
{
    var pageTitle = "集团客户选择";
    var fieldName = "证件号码|客户ID|客户名称|用户ID|用户编号 |用户名称|产品代码|产品名称|集团ID|付费帐户|品牌名称|品牌代码|";
	var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "12|0|1|2|3|4|5|6|7|8|9|10|11|";
    var retToField = "iccid|cust_id|cust_name|grp_id|user_no|grp_name|product_code2|product_name2|unit_id|account_id|sm_name|sm_code|";
    var cust_id = document.frm.cust_id.value;
    if(document.frm.iccid.value == "" &&
       document.frm.cust_id.value == "" &&
       document.frm.unit_id.value == "" &&
       document.frm.user_no.value == "")
    {
        rdShowMessageDialog("请输入证件号码、集团客户ID、集团编号或集团产品编号进行查询！",0);
        document.frm.iccid.focus();
        return false;
    }

    if(document.frm.cust_id.value != "" && forNonNegInt(frm.cust_id) == false)
    {
    	frm.cust_id.value = "";
        rdShowMessageDialog("必须是数字！",0);
    	return false;
    }

    if(document.frm.unit_id.value != "" && forNonNegInt(frm.unit_id) == false)
    {
    	frm.unit_id.value = "";
        rdShowMessageDialog("必须是数字！",0);
    	return false;
    }

    if(document.frm.user_no.value == "0")
    {
    	frm.user_no.value = "";
        rdShowMessageDialog("集团产品编号不能为0！",0);
    	return false;
    }

    PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField); 
}

function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/s3519/f3519_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType+"&iccid=" + document.all.iccid.value;
    path = path + "&cust_id=" + document.all.cust_id.value;
    path = path + "&unit_id=" + document.all.unit_id.value;
    path = path + "&user_no=" + document.all.user_no.value;

    retInfo = window.open(path,"newwindow","height=450, width=1000,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvaluecust(retInfo)
{
  var retToField = "iccid|cust_id|cust_name|grp_id|user_no|grp_name|product_code2|product_name2|unit_id|account_id|sm_name|sm_code|";
  if(retInfo ==undefined)      
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

function check_HidPwd()
{

	if(document.frm.product_code.value == document.frm.product_code2.value)
    {
        rdShowMessageDialog("这是旧的集团主产品，请重新选择新集团主产品！",0);
        document.frm.product_code.focus();
        return false;
    }
    
    var cust_id = document.all.cust_id.value;
    var Pwd1 = document.all.custPwd.value;
    var checkPwd_Packet = new AJAXPacket("../s3519/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
    checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("cust_id",cust_id);
	checkPwd_Packet.data.add("Pwd1",Pwd1);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet = null;		
}
function getSysAccept()
{
	var getSysAccept_Packet = new AJAXPacket("../s3519/pubSysAccept.jsp","正在生成操作流水，请稍候......");
	getSysAccept_Packet.data.add("retType","getSysAccept");
	core.ajax.sendPacket(getSysAccept_Packet);
	getSysAccept_Packet = null;   
}
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框
   var h=190;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var printStr = printInfo(printType);
   if(printStr == "failed")
   {    return false;   }

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
   var path = "<%=request.getContextPath()%>/npage/innet/hljPrint.jsp?DlgMsg=" + DlgMessage;
   var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
   var ret=window.showModalDialog(path,"",prop);
}
	 
function printInfo(printType)
{ 
		var retInfo = "";
 		retInfo+='<%=workname%>'+"|";
    	retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    	retInfo+="证件号码:"+document.frm.iccid.value+"|";
    	retInfo+="集团客户名称:"+document.frm.cust_name.value+"|";
    	retInfo+="集团产品编号:"+document.frm.user_no.value+"|";
    	retInfo+="帐户ID:"+document.frm.account_id.value+"|";
    	retInfo+="服务品牌:"+document.frm.sm_name.value+"|";
    	retInfo+=""+"|";
		retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+="业务类型："+document.frm.sm_name.value+"BOSS集团产品资费变更"+"|";
    	retInfo+="流水："+document.frm.login_accept.value+"|";
    	retInfo+="变更前产品："+document.frm.product_name2.value+"|";
    	retInfo+="变更后产品："+document.frm.product_code.value.replace(/\|/g,",")+"|";
    	retInfo+="附加产品："+document.frm.product_append.value.replace(/\|/g,",")+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=document.all.tonote.value+" "+document.all.simBell.value+"|";
		 return retInfo;
}
function refMain(){
	getAfterPrompt();
    var checkFlag; //注意javascript和JSP中定义的变量也不能相同,否则出现网页错误.
    //说明：检测分成两类,一类是数据是否是空,另一类是数据是否合法.
    //if(check(frm))
    //{
        if(document.frm.product_code.value == ""){
            rdShowMessageDialog("'集团产品'为必填项，请务必填写");
            return false;
        }
        if(  document.frm.grp_name.value == "" ){
            rdShowMessageDialog("集团名称："+document.frm.grp_name.value+",必须输入!!");
            document.frm.grp_name.select();
            return false;
        }
        if(  document.frm.grp_id.value == "" ){
            rdShowMessageDialog("集团代码必须输入!!");
            document.frm.grp_id.select();
            return false;
        }
        if(document.frm.product_code.value == document.frm.product_code2.value)
    {
        rdShowMessageDialog("这是旧的集团主产品，请重新选择新集团主产品！",0);
        document.frm.product_code.focus();
        return false;
    }
		getSysAccept();
		/*
        page = "QrySimBack_3707.jsp";
        frm.action=page;
        frm.method="post";
        frm.submit();
		*/
    //}
    
}  
  
//调用公共界面，进行产品信息选择
function getInfo_Prod()
{
    var pageTitle = "集团产品选择";
    var fieldName = "产品代码|产品名称|是否允许议价|生效方式|";
	  var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "3|0|1|3|";
    var retToField = "product_code|product_name|send_flag|";

    //首先判断是否已经选择了服务品牌
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("请首先选择集团信息化产品！",0);
        return false;
    }
    //首先判断是否已经选择了产品属性
    /*if(document.frm.product_attr.value == "")
    {
        rdShowMessageDialog("请首先选择产品属性！",0);
        return false;
    }*/

    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/s3519/fpubprod_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
	  path = path + "&op_code=" + document.all.op_code.value;
	  path = path + "&sm_code=" + document.all.sm_code.value; 
	  path = path + "&oldMainProduct=" + document.all.product_code2.value;
    path = path + "&product_attr=" + document.all.product_attr.value; 

    retInfo = window.open(path,"newwindow","height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	
	return true;
}

function getvalue(retInfo, retInfoDetail)
{
  	var retToField = "product_code|product_name|send_flag|";
  	if(retInfo ==undefined)      
  	  {   return false;   }
  	var productNum = retInfo.indexOf("|");
  	var product = retInfo.substring(0,productNum);
  	
  	/***
  	if(product==document.all.product_code2.value)
  	{
  			rdShowMessageDialog("选择的主产品和变更前不能相同！",0);
  	      return false;	
  	}
  	***/
  	var retInfo2 = retInfo.substring(productNum+1);
  	var productNum2 = retInfo2.indexOf("|"); 
  	document.all.product_code.value = retInfo.substring(0,productNum+1)+ retInfo2.substring(0,productNum2+1);
  	var send_flag=retInfo2.substring(productNum2+1,retInfo2.length-1);
  	document.all.send_flag.value = send_flag;
  	document.frm.product_prices.value = retInfoDetail;
  	
  	/*luxc add*/
  	if(getBillingType(product));
  	
  
}

function getBillingType(product_code)
{
	//alert("getBillingType()product_code="+product_code);
	if((product_code).trim() == "")
    {
       	rdShowMessageDialog("选择集团产品失败24!",0);
        return false;
    }

    var getBillingType_Packet = new AJAXPacket("fgetBillingType.jsp","正在获取billingtype，请稍候......");
	getBillingType_Packet.data.add("retType","getBillingType");
    getBillingType_Packet.data.add("product_code",product_code);
	core.ajax.sendPacket(getBillingType_Packet);
	getBillingType_Packet = null;
	
}

//集团附加产品选择
function getInfo_ProdAppend()
{
    var pageTitle = "集团附加产品选择";
    var fieldName = "产品代码|产品名称|";
	var sqlStr = "";
    var selType = "M";    //'S'单选；'M'多选
    var retQuence = "2|0|1|";
    var retToField = "product_append|product_name|";
    var product_code = document.frm.product_code.value;

    //首先判断是否已经选择了服务品牌
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("请首先选择集团信息化产品！");
        return false;
    }
    //首先判断是否已经选择了产品属性
    /*if(document.frm.product_attr.value == "")
    {
        rdShowMessageDialog("请首先选择产品属性！",0);
        return false;
    }*/
    //首先判断是否已经申请了集团产品
    if(document.frm.product_code.value == "")
    {
        rdShowMessageDialog("请首先选择集团产品！");
        return false;
    }

    if(PubSimpSelAppend(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelAppend(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var product_code = document.all.product_code.value;
    var chPos = product_code.indexOf("|");
    product_code = product_code.substring(0,chPos);
    var path = "<%=request.getContextPath()%>/npage/s3500/fpubprodappend_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    path = path + "&showType=" + "Default";
	path = path + "&op_code=" + document.all.op_code.value;
	path = path + "&sm_code=" + document.all.sm_code.value; 
	path = path + "&product_code=" + product_code; 

    retInfo = window.open(path,"newwindow","height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvalueProdAppend(retInfo)
{
  var retToField = "product_append|product_name|";
  if(retInfo ==undefined)      
    {   return false;   }

  document.all.product_append.value = retInfo;
}
    


//调用公共界面，进行产品属性选择
function getInfo_ProdAttr()
{
    var pageTitle = "产品属性选择";
    var fieldName = "产品属性代码|产品属性|";
	  var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "1|0|";
    var retToField = "product_attr|";

    //首先判断是否已经选择了服务品牌
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("请首先选择服务品牌！");
        return false;
    }

    if(PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}
function PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/page/s3519/fpubprodattr_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
		path = path + "&op_code=" + document.all.op_code.value;
		path = path + "&sm_code=" + document.all.sm_code.value; 

    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}
function changeProdAttr() {
	document.frm.product_code.value = "";
    document.frm.product_append.value = "";
}
function getvalueProdAttr(retInfo)
{
  var retToField = "product_attr|";
  if(retInfo ==undefined)      
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
    document.frm.product_code.value = "";
    document.frm.product_append.value = "";
}

</script>
<BODY>
<FORM action="" method="post" name="frm" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">集团产品资费变更</div>
</div>
<input type="hidden" name="product_code2" value="">
<input type="hidden" name="product_level"  value="1">
<input type="hidden" name="op_type" value="1">
<input type="hidden" name="grp_no" value="0">
<input type="hidden" name="tfFlag" value="n">
<input type="hidden" name="chgpkg_day"   value="">
<input type="hidden" name="TCustId"  value="">
<input type="hidden" name="unit_name"  value="">
<input type="hidden" name="login_accept"  value="0"> <!-- 操作流水号 -->
<input type="hidden" name="op_code"  value="3519">
<input type="hidden" name="OrgCode"  value="<%=org_code%>">
<input type="hidden" name="region_code"  value="<%=regionCode%>">
<input type="hidden" name="district_code"  value="<%=districtCode%>">
<input type="hidden" name="WorkNo"   value="<%=workno%>">
<input type="hidden" name="NoPass"   value="<%=nopass%>">
<input type="hidden" name="ip_Addr"  value=<%=ip_Addr%>>
<input type="hidden" name="product_name"  value="">
<input type="hidden" name="product_attr" value="">
<input type="hidden" name="product_prices"  value="">
<input type="hidden" name="product_type"  value="">
<input type="hidden" name="service_code"  value="">
<input type="hidden" name="service_attr"  value="">
<input type="hidden" name="billingtype"  value="">
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">

<TABLE cellSpacing=0>
    <TR>
        <TD class=blue>
            <div align="left">证件号码</div>
        </TD>
        <TD>
            <input name=iccid id="iccid" size="20" maxlength="18" v_type="string" v_must=1 index="1">
            <input name=custQuery type=button id="custQuery" class="b_text" onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursor：hand" value=查询>
            <font class="orange">*</font>
        </TD>
        <TD class=blue>集团客户ID</TD>
        <TD>
            <input type="text" name="cust_id" size="20" maxlength="18" v_type="0_9" v_must=1 index="2">
            <font class="orange">*</font>
        </TD>
    </TR>
    <TR>
        <TD class=blue>
            <div align="left">集团编号</div>
        </TD>
        <TD>
            <input name=unit_id id="unit_id" size="20" maxlength="10" v_type="0_9" v_must=1 index="3">
            <font class="orange">*</font>
        </TD>
        <TD class=blue>集团用户编号</TD>
        <TD>
            <input name="user_no" size="20" v_must=1 v_type=string index="4">
            <font class="orange">*</font>
        </TD>
    </TR>
    <TR>
        <TD class=blue>集团客户名称</TD>
        <TD >
            <input class="InputGrey" name="cust_name" size="20" readonly v_must=1 v_type=string index="4">
            <font class="orange">*</font>
        </TD>
        <TD class=blue>集团产品付费帐户</TD>
        <TD>
            <input name="account_id" type="test" class="InputGrey" size="20" maxlength="12" readonly v_type="0_9" v_must=1 index="5">
            <font class="orange">*</font>
        </TD>
    </TR>
    <TR>
        <TD class=blue>集团产品ID</TD>
        <TD>
            <input name="grp_id" type="text" class="InputGrey" size="20" maxlength="12" readonly v_type="0_9" v_must=1 index="3">
            <font class="orange">*</font>
        </TD>
        <TD class=blue>集团用户名称</TD>
        <TD>
            <input name="grp_name" type="text" class="InputGrey" size="20" maxlength="60" readonly v_must=1 v_maxlength=60 v_type="string" index="4">
            <font class="orange">*</font>
        </TD>
    </TR>
    <TR>
        <TD class=blue>服务品牌</TD>
        <TD>
            <input type="hidden" name="sm_code" size="20" readonly v_must=1 v_type="string" index="6"> 
            <input class="InputGrey" type="text" name="sm_name" size="20" readonly v_must=1 v_type="string" index="6"> 
        </TD>
        <TD class=blue>集团主产品</TD>
        <TD>
            <input class="InputGrey" type="text" name="product_name2" size="20" readonly v_must=1 v_type="string" index="6"> 
        </TD>
    </TR>
    <TR>
        <TD class=blue>新集团主产品</TD>
        <TD>
            <input type="text" name="product_code" size="20" readonly onChange="changeProduct()" v_must=1 v_type="string" value="">
            <input name="prodQuery" type="button" id="ProdQuery"  class="b_text" onMouseUp="getInfo_Prod();" onKeyUp="if(event.keyCode==13)getInfo_Prod();" value="选择">
            <font class="orange">*</font>
        </TD>
        <TD class=blue>生效方式</TD>
        <TD>
            <input class="InputGrey" type="text" name="send_flag" size="20" readonly >
        </TD>
    </TR>
    <TR>
        <TD class=blue>集团附加产品</TD>
        <TD >
            <input type="text" name="product_append" size="20" readonly v_must=0 v_type="string" value="">
            <input name="ProdAppendQuery" type="button" id="ProdAppendQuery"  class="b_text" onMouseUp="getInfo_ProdAppend();" onKeyUp="if(event.keyCode==13)getInfo_ProdAppend();" value="选择">
        </TD>
        <TD class=blue>集团客户密码</TD>
        <TD >
            <jsp:include page="/npage/common/pwd_1.jsp">
                <jsp:param name="width1" value="16%"  />
                <jsp:param name="width2" value="34%"  />
                <jsp:param name="pname" value="custPwd"  />
                <jsp:param name="pwd" value=""  />
            </jsp:include>
            <input name=chkPass type=button onClick="check_HidPwd();" class="b_text" style="cursor：hand" id="chkPass2" value=校验>
            <font class="orange">*</font>
        </TD>
    </TR>
    
    <TR id="tr_gongnengfee"  name="tr_gongnengfee" style="display:none">
        <TD class=blue>功能费付费方式</TD>
        <TD colspan=3>
            <select name="gongnengfee" id="gongnengfee" >
                <option value="0"> 0-集团付费 </option>
                <option value="1"> 1-个人付费 </option>
            </select>
            <font class="orange">*</font>
        </TD>
    </TR>
    
    <TR>
        <TD class=blue>备注</TD>
        <TD colspan="3">
            <input class="InputGrey" name="sysnote" size="60" readonly>
        </TD>
    </TR>
    <TR style="display:none">
        <TD>用户备注</TD>
        <TD colspan="3">
            <input name="tonote" size="60">
        </TD>
    </TR>
    <TR id="footer">
        <TD colspan="4">
            <input class="b_foot" name="sure"  type=button value="确认"  onclick="refMain()" disabled>
            <input class="b_foot" name="reset1"  onClick="" type=reset value="清除" >
            <input class="b_foot" name="kkkk"  onClick="removeCurrentTab()" type=button value="关闭">
        </TD>
    </TR>
</TABLE>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
<script language="JavaScript">
    document.frm.iccid.focus();
</script>
</BODY>
</HTML>
