<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by leimd @ 2009-04-13
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String opCode = "3692";
    String opName = "集团产品资费变更";
		
		System.out.println("gaopengSeeLog===3692===init");
    String workname = (String)session.getAttribute("workName");
    String regionCode = (String)session.getAttribute("regCode");
    String powerRight= (String)session.getAttribute("powerRight");
    String orgCode = (String)session.getAttribute("orgCode");
    String sqlStr = "";
	String[] inParams = new String[2];
    String[][] result = new String[][]{};
    String sm_code ="" ;
    
    String dateStr22 = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    
    String[][] favInfo = (String[][])session.getAttribute("favInfo");
    int infoLen = favInfo.length;
    boolean pwrf = false;
    String tempStr = "";
    for(int ll=0;ll<infoLen;ll++){
        tempStr = (favInfo[ll][0]).trim();
        if(tempStr.compareTo("a317") == 0){
            pwrf = true;
        }
    }
    
    
    String workNo          = (String)session.getAttribute("workNo");
    String in_GrpId        = WtcUtil.repNull(request.getParameter("in_GrpId"));
    String in_ChanceId     = WtcUtil.repNull(request.getParameter("in_ChanceId"));
    String IdNo            = WtcUtil.repNull(request.getParameter("IdNo"));
    String wa_no1          = WtcUtil.repNull(request.getParameter("wa_no1"));
    String crmActiveOpCode = WtcUtil.repNull(request.getParameter("crmActiveOpCode"));
    
    
String retValue = "";//
String retValue_getvalue = "";//
String retValue_yj = "";
String busiflags="";
String duanxintimes="";
String duanxinneirongs="";
//F10964=免费原因
//F10965=相关产品账号
String QryServMC_F10964 = "";
String QryServMC_F10965 = "";

if(in_ChanceId != null&&!"".equals(in_ChanceId)){//由任务管理接入时，商机编码不为空。
%>
  <wtc:service name="QryServMC" outnum="28" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=in_GrpId%>" />
		<wtc:param value="<%=in_ChanceId%>" />	
		<wtc:param value="2" />	
		<wtc:param value="<%=IdNo%>" />	
		<wtc:param value="" />	
	</wtc:service>
	<wtc:array id="result_QryServMC1" scope="end" start="0"  length="6"  />
	<wtc:array id="result_QryServMC" scope="end" start="6"  length="22" />
		
<%			


	
String QryServMC_20_userNo = "";
	
if("000000".equals(code1)){
	if(result_QryServMC.length>0){
		QryServMC_20_userNo = result_QryServMC[0][14];
		retValue_getvalue = result_QryServMC[0][10]+"|";
		retValue_yj = result_QryServMC[0][15];
		busiflags  = result_QryServMC[0][16];
		duanxintimes  = result_QryServMC[0][18];
		duanxinneirongs  = result_QryServMC[0][19];
		
		QryServMC_F10964 = result_QryServMC[0][20];
		QryServMC_F10965 = result_QryServMC[0][21];
	}
	
	System.out.println("hejwa-------------------QryServMC_F10964-------------------------->"+QryServMC_F10964);
	System.out.println("hejwa-------------------QryServMC_F10965-------------------------->"+QryServMC_F10965);
%>
  <wtc:service name="s3096QryCheckE" outnum="19" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=workNo%>" />
		<wtc:param value="<%=in_GrpId%>" />	
		<wtc:param value="u03" />	
		<wtc:param value="<%=in_ChanceId%>" />	
		<wtc:param value="" />	
		<wtc:param value="" />	
		<wtc:param value="<%=QryServMC_20_userNo%>" />			
	</wtc:service>
	<wtc:array id="result_s3096QryCheckE" scope="end"  /> 
<%


	
	 for(int i=0;i<12;i++){
	 	retValue = retValue+result_s3096QryCheckE[0][i]+"|";
	 }
	
}

}


//retValue = 33262|本地专线5000元包月|立即生效|
//document.all.retValue.value = 33262,MZ38,5000,0000,1,0,0.5,|
//vShouldPay = -1


%>
<!--取流水-->
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>集团产品资费变更 </TITLE>
</HEAD>
<SCRIPT type="text/javascript">
onload = function()
{
	//document.all.grpA.style.display = "none";
     if("<%=pwrf%>" == "true"){
        $("#ProdAppendQuery").attr("disabled",false);
    }
    
    if("<%=retValue%>"!=""){
    	
    	getvaluecust("<%=retValue%>");
    	
    	$("input[name='prodQuery']").hide();
    	
    	getvalue("<%=retValue_getvalue%>", "<%=retValue_yj%>");
    	setShouldPay("-1");
    	
    }
    
    
    $("#busi_flag").val("<%=busiflags%>");
    $("#messhotxftime").val("<%=duanxintimes%>");
    $("#messshotinfos").val("<%=duanxinneirongs%>");
    
	  var busi_flagss = $("#busi_flag").val();
	  if(busi_flagss=="118" || busi_flagss=="227" || busi_flagss=="119" || busi_flagss=="121" || busi_flagss=="120" || busi_flagss=="211") {
			$("#dxxiangguan").show();	
	  }else {
	  	$("#dxxiangguan").hide();
	  }
	  
}	

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框
   var h=180;
   var w=350;
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
    	retInfo+="流水："+document.frm.loginAccept.value+"|";
    	retInfo+="变更前产品："+document.frm.product_name2.value+"|";
    	retInfo+="变更后产品："+document.frm.product_code.value.replace(/\|/g,",")+"|";
    	retInfo+="附加产品："+document.frm.product_append.value.replace(/\|/g,",")+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=document.all.opNote.value+" "+document.all.simBell.value+"|";
		 return retInfo;
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
    			
    		}
    		
    	}
    	else
    	{
    		rdShowMessageDialog(retMessage);
    	}
    }
    
    if(retType == "getOldRate")
	{
		if(retCode == "000000")
		{
			document.frm.oldMainRate.value = packet.data.findValueByName("oldMainRate");
			document.frm.oldMainRateName.value=packet.data.findValueByName("oldMainRateName");
			var ss = packet.data.findValueByName("oldOptionalRate");
			var i= 0, len=ss.length;
			for (i = 0; i < len; i ++)
			{
				if (ss.charAt(i) == "|")
				{
					document.frm.oldOptionalRate.value = document.frm.oldOptionalRate.value + "\n";
				}
				else
				{
					document.frm.oldOptionalRate.value = document.frm.oldOptionalRate.value + ss.charAt(i);
				}
			}
		}
		else
		{
			document.frm.oldMainRate.value = "";
			document.frm.oldOptionalRate.value = "";
			rdShowMessageDialog(retMessage,0);
			return false;
		}
	}
	
	if(retType == "getOldAppend"){
		if(retCode == "000000"){
			var vOldAppend = packet.data.findValueByName("oldAppend");
			vOldAppend = vOldAppend.replace(/@/g, "\n"); //add by qidp @ 2009-12-10 for replace all '@' to '\n'
			$("#old_append_product").val(vOldAppend);
		}else{
			rdShowMessageDialog(retMessage,0);
			return false;
		}
	}
 }	
	
//调用公共界面，进行集团客户选择
function getInfo_Cust()
{
    var pageTitle = "集团客户选择";
    var fieldName = "证件号码|客户ID|客户名称|用户ID|用户编号 |用户名称|产品代码|产品名称|集团编号|付费帐户|品牌名称|品牌代码|";
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
	
    var path = "<%=request.getContextPath()%>/npage/s3692/f3692_sel.jsp";
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
    document.frm.grpIdNo.value = document.frm.grp_id.value;
    document.frm.grpOutNo.value = document.frm.user_no.value;
    $("#iccid,#cust_id,#unit_id,#user_no").attr("readOnly",true);
    $("#iccid,#cust_id,#unit_id,#user_no").addClass("InputGrey");
    displayInfo();					//控制显示
    if($("#sm_code").val() == 'va'){
        QryOldRate();
    }else{
        QryOldAppend();
    }
}

function QryOldAppend(){
    var vGrpId = $("#grp_id").val();
    var QryOldAppendPacket = new AJAXPacket("getOldAppend.jsp","正在得到旧集团附加产品信息，请稍候......");
	QryOldAppendPacket.data.add("retType","getOldAppend");
	QryOldAppendPacket.data.add("grpId",vGrpId);
	core.ajax.sendPacket(QryOldAppendPacket);
	QryOldAppendPacket=null;
}

function displayInfo()
{
	var sm_code=document.frm.sm_code.value;
	if (sm_code!="va")					//va是BOSS侧VPMN; CR是彩铃业务 
	{	
		document.all.grpA.style.display="";
		document.all.grpB.style.display="";
		document.all.grpC.style.display="";
		document.all.grpD.style.display="";
		document.all.grpE.style.display="";
	}else 
	 {
	 	document.all.grpUser.style.display="";
		document.all.grpF.style.display="";
		document.all.grpG.style.display="";
		document.all.grpA.style.display="none";
		document.all.grpB.style.display="none";
		document.all.grpC.style.display="none";
		document.all.grpD.style.display="none";
		document.all.grpE.style.display="none";
	 }
	
}

//调用公共界面，进行产品信息选择
function getInfo_Prod()
{
		document.frm.product_append.value="";
    //首先判断是否已经选择了服务品牌
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("请首先选择集团信息化产品！",0);
        return false;
    }
    //首先判断是否已经选择了产品属性
		var pageTitle = "集团产品选择";
		var fieldName = "";
		var sqlStr = "";
		var selType = "S";    //'S'单选；'M'多选
		var retQuence = "";
		var retToField = "";
		/* begin update for 关于IMS融合通信营帐优化、新增资费配置和经分报表开发需求的函@2014/8/13 */
		if(document.frm.sm_code.value == "RH"){
			fieldName = "产品代码|产品名称|是否允许议价|生效方式|";
			retQuence = "4|0|1|2|3|";
			retToField = "product_code|product_name|chg_price|send_flag|";
		}else{
			fieldName = "产品代码|产品名称|是否允许议价|生效方式|";
			retQuence = "3|0|1|3|";
			retToField = "product_code|product_name|send_flag|";
		}
		/* end update for 关于IMS融合通信营帐优化、新增资费配置和经分报表开发需求的函@2014/8/13 */

    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/s3692/fpubprod_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
	path = path + "&op_code=" + document.all.op_code.value;
	path = path + "&sm_code=" + document.all.sm_code.value; 
	path = path + "&oldMainProduct=" + document.all.product_code2.value;
    path = path + "&product_attr=" + document.all.product_attr.value;
    path = path + "&grpId=" + $("#grp_id").val();

    retInfo = window.open(path,"newwindow","height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	
	return true;
}

//集团附加产品选择
function getInfo_ProdAppend()
{
    var pageTitle = "集团附加产品选择";
    var fieldName = "产品代码|产品名称|";
	var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "1|0|";
    var retToField = "product_append|";
    var product_code = document.frm.product_code.value;

    //首先判断是否已经选择了服务品牌
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("请首先选择集团信息化产品！");
        return false;
    }
   
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
    var path = "<%=request.getContextPath()%>/npage/s3692/fpubprodappend_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    path = path + "&showType=" + "Default";
	path = path + "&op_code=" + document.all.op_code.value;
	path = path + "&sm_code=" + document.all.sm_code.value; 
	path = path + "&product_code=" + product_code; 
	path = path + "&oldMainProduct=" + document.all.product_code2.value;
	path = path + "&grpId=" + $("#grp_id").val();

    retInfo = window.open(path,"newwindow","height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvalue(retInfo, retInfoDetail)
{
		var retToField = "";
		/* begin update for 关于IMS融合通信营帐优化、新增资费配置和经分报表开发需求的函@2014/8/13 */
		if(document.frm.sm_code.value == "RH"){
			retToField = "product_code|product_name|chg_price|send_flag|";
		}else{
			retToField = "product_code|product_name|send_flag|";
		}
		/* end update for 关于IMS融合通信营帐优化、新增资费配置和经分报表开发需求的函@2014/8/13 */
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
  	document.frm.product_prices.value = retInfoDetail;
  	
  	/*luxc add*/
  	if(getBillingType($("#product_code").val()));
  
}

function getBillingType(product_code)
{
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

function getvalueProdAppend(retInfo)
{
    $("#product_append").val(retInfo);
}

//校验客户密码
function check_HidPwd()
{
    	var old_append_product = $.trim($("#old_append_product").val());
    	var product_append = $.trim($("#product_append").val());
    	if(document.frm.product_code.value == document.frm.product_code2.value && ((product_append.length != 0 && old_append_product.indexOf(product_append) != -1)||(product_append.length == 0 && old_append_product.length ==0)) ){
    		rdShowMessageDialog("新集团附加产品和旧集团附加产品、旧集团主产品和新集团主产品不能完全相同",0);
    		return false;
    	}
        /*rdShowMessageDialog("这是旧的集团主产品，请重新选择新集团主产品！",0);
        document.frm.product_code.focus();
        return false;*/
    
    
    var cust_id = document.all.cust_id.value;
    var Pwd1 = document.all.custPwd.value;
    var checkPwd_Packet = new AJAXPacket("../s3692/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
    checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("cust_id",cust_id);
	checkPwd_Packet.data.add("Pwd1",Pwd1);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet = null;		
}

function QryOldRate()
{
	document.all.oldOptionalRate.value="";
	var QryOldRate_Packet = new AJAXPacket("getOldRate.jsp","正在得到原集团主费率信息，请稍候......");
	QryOldRate_Packet.data.add("retType","getOldRate");
	QryOldRate_Packet.data.add("grpIdNo",document.frm.grpIdNo.value);
	QryOldRate_Packet.data.add("regionCode","<%=regionCode%>");
	core.ajax.sendPacket(QryOldRate_Packet);
	QryOldRate_Packet=null;
}


function refMain(){
	
				if($("#F10964").val()=="3"||$("#F10964").val()=="4"){
						if($("#F10965").val()==""){
							rdShowMessageDialog("请输入相关产品账号");
							return;
						}
				}
		
	getAfterPrompt();
    var checkFlag; //注意javascript和JSP中定义的变量也不能相同,否则出现网页错误.
    //说明：检测分成两类,一类是数据是否是空,另一类是数据是否合法.
   var sm_code=document.frm.sm_code.value;
    if(sm_code!="va"){
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
      var old_append_product = $.trim($("#old_append_product").val());
    	var product_append = $.trim($("#product_append").val());
    	if(document.frm.product_code.value == document.frm.product_code2.value && ((product_append.length != 0 && old_append_product.indexOf(product_append) != -1)||(product_append.length == 0 && old_append_product.length ==0)) ){
    		rdShowMessageDialog("新集团附加产品和旧集团附加产品、旧集团主产品和新集团主产品不能完全相同",0);
    		return false;
    	}
	 }else{
		if(  document.frm.grpIdNo.value == "" )
		{
			rdShowMessageDialog("集团用户ID不能为空!!");
			document.frm.idIccid.select();
			return false;
		}
		
		if (document.frm.oldMainRate.value == "")
		{
			rdShowMessageDialog("原集团主费率不能为空，请先查询集团主费率!");
			document.frm.bQryOldRate.focus();
			return false;
		}
	
		if (document.frm.newRate.value=="")
		{
			rdShowMessageDialog("新费率不能为空!");
			document.frm.newRate.focus();
			return false;
		}
	}
	
		//hejwa add 关于上报集团客户部2014年2月第一期系统需求的函-1-优化集团专线端到端信息支撑系统部分功能  2014年3月12日15:22:27
		//多次提示麻烦，用变量的方式设置提示词
		var hitMessage = "";
		if($("#sm_code").val()=="hl"){
			hitMessage = "请确认选择的资费为单条资费非项目资费！";
		}else{
			hitMessage = "是否提交确认操作？";
		}
		

  var busi_flagss = $("#busi_flag").val();
	  if(busi_flagss=="118" || busi_flagss=="227" || busi_flagss=="119" || busi_flagss=="121" || busi_flagss=="120" || busi_flagss=="211") {
	 		 	
	 	if(!checkElement(document.all.messhotxftime)){
				return false;
		}
		
		var timess =$("#messhotxftime").val();
		var messshotinfossss =$("#messshotinfos").val();
	 	var jintiantimess="<%=dateStr22%>";
		
		if(timess!="") {
		 	if (timess <= jintiantimess) {
		 	   rdShowMessageDialog("短信下发时间必须大于当前时间！");
		 	   return false;
		 	}
	 	}
	
		if(!checkElement(document.all.messshotinfos)){
				return false;
		}
		
		if(messshotinfossss.trim() !="" && timess.trim() =="") {
		 	   rdShowMessageDialog("输入提醒短信内容则必须输入提醒短信时间！");
		 	   return false;		
		}
		
	} 		
		
		
		showPrtDlg("Detail","确实要打印电子免填单吗？","Yes");
		if (rdShowConfirmDialog(hitMessage)==1){
			page = "f3692_cfm.jsp";
			$("#sure").attr("disabled",true);
			frm.action=page;
			frm.method="post";
			frm.submit();
			loading();
		}  
}
function setShouldPay(shouldPay){
	if(shouldPay=='-1'){
		$("#shouldPay").val('');
		$("#shouldPayDis").val('');
		$("#should_pay").hide();
	}else{
		$("#shouldPay").val(shouldPay);
		$("#shouldPayDis").val(shouldPay);
		$("#should_pay").show();	
	}
	
}


/**
 * 关于2月下旬集团客户部CRM、BOSS和经分系统需求的函-2-boss侧增加专线0元资费说明信息的需求
 * 2016年4月12日9:42:51
 * hejwa 、陈琳
 */
$(document).ready(function(){
		<%
			if(in_ChanceId != null&&!"".equals(in_ChanceId)){
		%>
				$("#F10965").val("<%=QryServMC_F10965%>");
    		$("#F10964").val("<%=QryServMC_F10964%>");
			go_check_F10964_F10965();
			$("#F10965").blur(function(){
					if($("#F10964").val()=="3"||$("#F10964").val()=="4"){
						go_check_F10965();
					}
			});
		<%}else{%>
			$("#tr_F10964_F10965").hide();
		<%}%>	
});

function go_check_F10964_F10965(){
	  var packet = new AJAXPacket("/npage/s3690/check_F10964_F10965.jsp","请稍后...");
        packet.data.add("sPChanceId","<%=in_ChanceId%>");//
    core.ajax.sendPacket(packet,do_check_F10964_F10965);
    packet =null;	
}
function do_check_F10964_F10965(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code=="000000"){//操作成功
    	var result_count =  packet.data.findValueByName("result_count");
    	if(result_count!="0"){
    		$("#F10964").attr("disabled","disabled");
    		$("#F10965").attr("disabled","disabled");
    	}
    }else{//调用服务失败
	    rdShowMessageDialog(error_code+":"+error_msg);
    }
}

function go_check_F10965(){
	  var packet = new AJAXPacket("/npage/s3690/check_F10965.jsp","请稍后...");
        packet.data.add("prod_id",$("#F10965").val());//
        packet.data.add("unit_id","<%=in_GrpId%>");//
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("c_prod_id",$("#grp_id").val());//
        
    core.ajax.sendPacket(packet,do_check_F10965);
    packet =null;		
}
function do_check_F10965(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code=="000000"){//操作成功
    	var result_count =  packet.data.findValueByName("result_count");
    	if(result_count=="0"){
    		rdShowMessageDialog("免费原因选择“整体信息化项目”和“承载其他业务应用”时，需要填写同一集团编码下的其他产品账号");
    		$("#F10965").val("");
    		$("#F10964").val("");
    	}
    }else{//调用服务失败
	    rdShowMessageDialog(error_code+":"+error_msg);
    }
}


</script>
<BODY>
<FORM action="" method="post" name="frm" >
	<input type="hidden" name="product_code2" value="">
	<input type="hidden" name="op_code"  value="3692">
	<input type="hidden" name="product_attr" value="">
	<input type="hidden" name="product_prices"  value="">
	<input type="hidden" name="product_type"  value="">
	<input type="hidden" name="service_code"  value="">
	<input type="hidden" name="service_attr"  value="">
	<input type="hidden" name="billingtype"  value="">
	<input type="hidden" name="opNote" value="集团产品资费变更">
	<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
	<input type="hidden" name="simBell" value="">
	<input type="hidden" id="shouldPay" name="shouldPay" value="">
<input type='hidden' id='chg_price' name='chg_price' value='' /> <%/* 是否议价*/%>
<input type="hidden" name="wa_no1" value="<%=wa_no1%>">
<input type="hidden" value="" name="busi_flag" id="busi_flag" />
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">集团产品资费变更</div>
</div>

<table cellspacing="0">
	<TR>
        <TD class="blue">证件号码 </TD>
        <TD>
            <input name=iccid id="iccid" size="20" maxlength="18" v_type="string" v_must=1 index="1">
            <input name=custQuery type=button id="custQuery" class="b_text" onMouseUp="getInfo_Cust();" onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursor:hand" value=查询>
            <font class="orange">*</font>
        </TD>
        <TD class="blue">集团客户ID </TD>
        <TD>
            <input type="text" name="cust_id" id="cust_id" size="20" maxlength="18" v_type="0_9" v_must=1 index="2">
            <font class="orange">*</font>
        </TD>
    </TR>
    <TR>
        <TD class="blue">集团编号</TD>
        <TD>
            <input name="unit_id" id="unit_id" size="20" maxlength="10" v_type="0_9" v_must=1 index="3">
            <font class="orange">*</font>
        </TD>
        <TD class=blue>集团客户密码 </TD>
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

    <TR style="display:none" id="grpA">
        <TD class="blue">集团客户名称 </TD>
        <TD >
            <input class="InputGrey" name="cust_name" size="30" readonly v_must=1 v_type=string index="4">
            <font class="orange">*</font>
        </TD>
        <TD class="blue">集团产品ID </TD>
        <TD>
            <input name="grp_id" id="grp_id" type="text" class="InputGrey" size="20" maxlength="12" readonly v_type="0_9" v_must=1 index="3">
            <font class="orange">*</font>
        </TD>
    </TR>
    <TR style="display:none" id="grpB">
        <TD class="blue">集团用户编号 </TD>
        <TD>
            <input name="user_no" id="user_no" size="20" v_must=1 v_type=string index="4" readonly>
            <font class="orange">*</font>
        </TD>
        <TD class="blue">集团用户名称 </TD>
        <TD>
            <input name="grp_name" type="text" class="InputGrey" size="30" maxlength="60" readonly v_must=1 v_maxlength=60 v_type="string" index="4">
            <font class="orange">*</font>
        </TD>
    </TR>
    <TR style="display:none" id="grpC">
    	<TD class="blue">集团付费帐户 </TD>
        <TD>
            <input name="account_id" type="test" class="InputGrey" size="20" maxlength="12" readonly v_type="0_9" v_must=1 index="5">
            <font class="orange">*</font>
        </TD>
        <TD class="blue">服务品牌 </TD>
        <TD>
            <input type="hidden" name="sm_code" id="sm_code" size="20" readonly v_must=1 v_type="string" index="6"> 
            <input class="InputGrey" type="text" name="sm_name" size="20" readonly v_must=1 v_type="string" index="6"> 
        </TD>
        
    </TR>
    <TR style="display:none" id="grpD">
    	<TD class="blue">旧集团主产品 </TD>
        <TD>
            <input class="InputGrey" type="text" name="product_name2" size="20" readonly v_must=1 v_type="string" index="6"> 
        </TD>
        <TD class="blue">旧集团附加产品 </TD>
        <TD>
            <textarea name="old_append_product" id="old_append_product" rows="5" cols="40" value="" readonly></textarea>
        </TD>
    </TR>
    <tr style="display:none;">
        <TD class="blue">生效方式 </TD>
        <TD colspan='3'>
            <input class="InputGrey" type="text" name="send_flag" size="20" readonly >
        </TD>
    </tr>
    <TR style="display:none" id="grpE">
    	<TD class="blue" nowrap>新集团主产品 </TD>
        <TD>
            <input type="text" name="product_name" size="20" readonly v_must=1 v_type="string" value="">
            <input type="text" name="product_code" id="product_code" size="20" readonly v_must=1 v_type="string" value="" style="display:none;">
            <input name="prodQuery" type="button" id="ProdQuery"  class="b_text" onMouseUp="getInfo_Prod();" onKeyUp="if(event.keyCode==13)getInfo_Prod();" value="选择">
            <font class="orange">*</font>
        </TD>
        <TD class="blue" nowrap>新集团附加产品 </TD>
        <TD>
            <input type="text" name="product_append" id="product_append" size="20" readonly v_must=0 v_type="string" value="">
            <input name="ProdAppendQuery" type="button" id="ProdAppendQuery" disabled class="b_text" onMouseUp="getInfo_ProdAppend();" onKeyUp="if(event.keyCode==13)getInfo_ProdAppend();" value="选择">
        </TD>
    </tr>
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
    
    <tr style="display:none" id="grpUser">
    	<TD class="blue">集团用户ID</TD>
		<TD>
			<input class="InputGrey" name="grpIdNo" size="20" readonly v_must=1 v_type=string  index="4" value="">
			<font color="orange">*</font>
		</TD>
		<TD class="blue">集团用户编号</TD>
		<TD>
			<input class="button" name="grpOutNo" size="20" v_must=1 v_type=string  index="4" value="">
			<font color="orange">*</font>
		</TD>
	</tr>	
    <TR style="display:none" id="grpF">
		<TD class="blue" nowrap>原集团主费率</TD>
		<TD nowrap>
		    <input name="oldMainRateName" class="InputGrey" type="text" size="35" v_must=1 v_type="string" index="8" value="" readonly>
			<input name="oldMainRate" class="InputGrey" type="hidden" size="35" v_must=1 v_type="string" index="8" value="" readonly>
			<input name=bQryOldRate type=button id="bQryOldRate" class="b_text" onMouseUp="QryOldRate();" onKeyUp="if(event.keyCode==13)QryOldRate();" style="cursor：hand;display:none;" value=查询>
			<font color="orange">*</font>
		</TD>
		<TD class="blue" nowrap>原集团可选费率</TD>
		<TD nowrap>
			<textarea name="oldOptionalRate" class="button" v_must=0 rows="5" cols="40" v_type="string"  index="8" value="" readonly></textarea>
			<font color="orange">*</font>
		</TD>
	</TR>
	<TR style="display:none" id="grpG">
		<TD class="blue">集团主费率</TD>
		<TD>
			<select name="newRate" id="newRate" v_must=1 v_type="string" index="10">
<%
					try
					{
						sqlStr = "select a.offer_id,a.offer_id || '->' || a.offer_name"
						        +"  from product_offer a,region b ,sregioncode c "
								+"  where c.region_code = substr(:orgCode,1,2) "
								+"   and a.offer_id = b.offer_id"
								+"   and b.group_id = c.group_id"
								+"   and a.offer_attr_type ='VpM0'"
								+" and a.exp_date>=sysdate and b.right_limit<="+powerRight+"";
						
						
						inParams[0] = "select a.offer_id,a.offer_id || '->' || a.offer_name"
						        +"  from product_offer a,region b ,sregioncode c "
								+"  where c.region_code ='"+regionCode+"' "
								+"   and a.offer_id = b.offer_id"
								+"   and b.group_id = c.group_id"
								+"   and a.offer_attr_type ='VpM0'"
								+" and a.exp_date>=sysdate and b.right_limit<="+powerRight;
						
						inParams[1] = "regionCode="+regionCode+",powerRight="+powerRight;
%>
						<wtc:pubselect name="sPubSelect" retcode="retCode" retmsg="retMsg" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
                        	<wtc:sql><%=inParams[0]%></wtc:sql>
                        </wtc:pubselect>
						<wtc:array id="resultTemp1"  scope="end"/>
<%		                
			            result = resultTemp1;
					}
					catch(Exception e){
						System.out.println("取集团主费率信息出错!");
					}
					if (result.length>0)
					{
						System.out.println("result.length"+result.length);
						for(int i=0; i < result.length; i ++)
						{
							out.println("<option value='" + result[i][0] + "'>" + result[i][1] + "</option>");
						}
					}
%>
					</select>
					<font color="orange">*</font>
				</TD>
				<TD class="blue">集团可选费率</TD>
				<TD>
					<select name="optionalRate" id="optionalRate" size="5" MULTIPLE="TRUE" v_must=0 v_type="string" index="10">
<%
					try
					{
					   sqlStr = "select a.offer_id,a.offer_id || '->' || a.offer_name"
						        +"  from product_offer a,region b ,sregioncode c "
								+"  where c.region_code = substr(:orgCode,1,2) "
								+"   and a.offer_id = b.offer_id"
								+"   and b.group_id = c.group_id"
								+"   and a.offer_attr_type ='VpA0'"
								+" and a.exp_date>=sysdate and b.right_limit<="+powerRight+"";
						
						
						inParams[0] = "select a.offer_id,a.offer_id || '->' || a.offer_name"
						        +"  from product_offer a,region b ,sregioncode c "
								+"  where c.region_code ='"+regionCode+"' "
								+"   and a.offer_id = b.offer_id"
								+"   and b.group_id = c.group_id"
								+"   and a.offer_attr_type ='VpA0'"
								+" and a.exp_date>=sysdate and b.right_limit<="+powerRight;
						
						inParams[1] = "regionCode="+regionCode+",powerRight="+powerRight;
%>
						<wtc:pubselect name="sPubSelect" retcode="retCode" retmsg="retMsg" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
                        	<wtc:sql><%=inParams[0]%></wtc:sql>
                        </wtc:pubselect>
						<wtc:array id="resultTemp2"  scope="end"/>
<%		                
			            result = resultTemp2;
					}
					catch(Exception e){
						System.out.println("取集团可选费率信息出错!");
					}
					if (result.length>0)
					{
						System.out.println("result.length"+result.length);
						for(int i=0; i < result.length; i ++)
						{
							out.println("<option value='" + result[i][0] + "'>" + result[i][1] + "</option>");
						}
					}
%>
					</select>
				</TD>
			</tr>
	<tr id="should_pay" style='display:none'>	
		<TD class=blue>一次性费用</TD>	
		<TD colspan="3">
            <input class="InputGrey" id='shouldPayDis' size="60" readonly value=''>
        </TD>
    </tr>
    
    <tr style="display:none" id="dxxiangguan">
    	<TD class="blue">短信下发时间</TD>
			        <td>
					 			
   <input id='messhotxftime' name='messhotxftime' type='text' onKeyPress='return isKeyNumberdot(0)' value='' size='20' maxlength='8' v_must=0 v_type='date' v_format='yyyyMMdd'>&nbsp;格式：YYYYMMDD				 			
					 			
										
			        </td>
		<TD class="blue">提醒短信内容</TD>
		<TD>
			<input type="text" name="messshotinfos" id="messshotinfos" value="" v_type="string"  maxlength="200" size=60  v_must=0  v_maxlength=200 >
		</TD>
	</tr>   
	
	<tr id="tr_F10964_F10965">
	  <TD class=blue >免费原因</TD>
	  <TD  colspan=1> 
		  <select id='F10964' name='F10964' datatype=17  >
			  <option selected value=''>--请选择--</option>
			  <option  value='1'>1--赠送</option>
			  <option  value='2'>2--测试期</option>
			  <option  value='3'>3--整体信息化项目</option>
			  <option  value='4'>4--承载其他业务应用</option>
			  <option  value='5'>5--跨地市专线一端收费</option>
		  </select>
	  </TD>
	  <TD class=blue >相关产品账号</TD>
	  <TD  colspan=3> 
	  	<input id='F10965' name='F10965' style='ime-mode:disabled' onKeyPress='return isKeyNumberdot(0)' class='button' type='text' datatype=10 maxlength='20' value=''    >
	  	</td>
	</tr>   
    
        <TD class=blue>备注</TD>
        <TD colspan="3">
            <input class="InputGrey" name="sysnote" size="60" readonly>
        </TD>
    </TR>
    <TR id="footer">
        <TD colspan="4">
            <input class="b_foot" name="sure"  type=button value="确认"  onclick="refMain()" disabled>
            <input class="b_foot" name="reset1"  onClick="window.location='f3692_1.jsp'" type=button value="清除" >
            <input class="b_foot" name="close"  onClick="removeCurrentTab();" type=button value="关闭">
        </TD>
    </TR>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>	
<script type="text/javascript">
    document.frm.iccid.focus();
 
</script>
</BODY>
</HTML>
