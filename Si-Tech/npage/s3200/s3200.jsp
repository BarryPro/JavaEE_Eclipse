   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-9
********************/
%>
              
<%
  String opCode = "3200";
  String opName = "VPMN集团开户";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
	


<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.pub.*" %>


<%

    ArrayList arr = (ArrayList)session.getAttribute("allArr");
    String[][] baseInfo = (String[][])arr.get(0);
    String[][] agentInfo = (String[][])arr.get(2);
    String[][] pass = (String[][])arr.get(4);
    String ip_Addr = (String)session.getAttribute("ipAddr");
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
    String group_id = "";/* add by daixy 20081127,group_id来自dCustDoc中的org_id */
    String OrgId = baseInfo[0][23];
    String nopass  = (String)session.getAttribute("password");
    String Department = baseInfo[0][16];
    String regionCode = (String)session.getAttribute("regCode");
    String districtCode = Department.substring(2,2);
    String agentProvCode = "";
    String servArea = "";
    String powerRight= baseInfo[0][5];
    
    String cust_id = request.getParameter("cust_id")==null?"":request.getParameter("cust_id");//wuxy alter 20090513
    
    Logger logger = Logger.getLogger("f3200.jsp");
    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    int iDate = Integer.parseInt(dateStr);
    //String addDate = Integer.toString(iDate+1);
    String Date100 = Integer.toString(iDate+1000000);
	String  insql = "select to_char(sysdate+1,'YYYYMMDD') from dual";
	//ArrayList retArrayDate = callView.sPubSelect("1",insql);
	%>
	
	 <wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=insql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_tu1" scope="end"/>
	
<%
	String addDate=result_tu1[0][0];

    String sqlStr = "";
    ArrayList retArray = new ArrayList();
    String[][] result = new String[][]{};
%>
<HTML>
<HEAD>
<TITLE>VPMN-集团开户</TITLE>
</HEAD>
<script language="JavaScript" src="<%=request.getContextPath()%>/npage/s1400/pub.js"></script>
<SCRIPT type=text/javascript>

function doProcess(packet)
{
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
    self.status="";
    if(retType == "GrpId") //得到集团代码
    {
        if(retCode == "000000")
        {
            var GrpId = packet.data.findValueByName("GrpId");
            //document.frm.grp_no.value = oneTok(GrpId,"|",1);
            document.frm.TCustId.value = oneTok(GrpId,"|",2);
            document.frm.getGrpNo.disabled = true;
            document.frm.grp_name.focus();
         }
        else
        {
            rdShowMessageDialog("没有得到集团代码,请重新获取！",0);
				return false;
        }
	}
    if(retType == "GrpNo") //得到集团用户编号
    {
        if(retCode == "000000")
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
    if(retType == "UserId")
    {
        if(retCode == "000000")
        {
            var retUserId = packet.data.findValueByName("retnewId");    	    
    	    document.frm.grp_id.value = retUserId;
            document.frm.grpQuery.disabled = true;
         }
        else
        {
                rdShowMessageDialog("没有得到用户ID,请重新获取！",0);
				return false;
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
            document.frm.pay_code.disabled = false;
			document.frm.user_passwd.focus();
         }
        else
        {
            rdShowMessageDialog("没有得到帐户ID,请重新获取！",0);
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
                document.frm.sure.disabled = true;
	        	frm.custPwd.value = "";
	        	frm.custPwd.focus();
    	    	return false;	        	
            } else {
                rdShowMessageDialog("客户密码校验成功！",2);
                document.frm.sure.disabled = false;
            }
         }
        else
        {
            rdShowMessageDialog("客户密码校验出错，请重新校验！",0);
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
                document.frm.ProdAttrQuery.disabled = true;
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
}

function check_HidPwd()
{
    var cust_id = document.all.cust_id.value;
    var Pwd1 = document.all.custPwd.value;
    var checkPwd_Packet = new AJAXPacket("/npage/s3432/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
    checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("cust_id",cust_id);
	checkPwd_Packet.data.add("Pwd1",Pwd1);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet = null;	
}

function getAccountId()
{
	//得到帐户ID
    var getAccountId_Packet = new AJAXPacket("/npage/innet/f1100_getId.jsp","正在获得帐户ID，请稍候......");
	getAccountId_Packet.data.add("region_code","<%=regionCode%>");
	getAccountId_Packet.data.add("retType","AccountId");
	getAccountId_Packet.data.add("idType","1");
	getAccountId_Packet.data.add("oldId","0");
	core.ajax.sendPacket(getAccountId_Packet);
	getAccountId_Packet = null;
}

//得到集团用户编号user_no
function getGrpUserNo()
{
    var sm_code = document.frm.sm_code.value;

    //首先判断是否已经选择了服务品牌
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("请首先选择服务品牌！",0);
        return false;
    }

    var getgrp_Userno_Packet = new AJAXPacket("/npage/s3432/getGrpUserno.jsp","正在获得集团用户编号，请稍候......");
    getgrp_Userno_Packet.data.add("retType","GrpNo");
    getgrp_Userno_Packet.data.add("orgCode","<%=org_code%>");
    getgrp_Userno_Packet.data.add("smCode",sm_code);
    core.ajax.sendPacket(getgrp_Userno_Packet);
    getgrp_Userno_Packet = null;
}

function getUserId()
{
    //得到集团用户ID，和个人用户ID一致
    var getUserId_Packet = new AJAXPacket("/npage/innet/f1100_getId.jsp","正在获得用户ID，请稍候......");
	getUserId_Packet.data.add("region_code","<%=regionCode%>");
	getUserId_Packet.data.add("retType","UserId");
	getUserId_Packet.data.add("idType","1");
	getUserId_Packet.data.add("oldId","0");
	core.ajax.sendPacket(getUserId_Packet);
	getUserId_Packet = null;
}

function getAccountId()
{
	//得到帐户ID
    var getAccountId_Packet = new AJAXPacket("/npage/innet/f1100_getId.jsp","正在获得帐户ID，请稍候......");
	getAccountId_Packet.data.add("region_code","<%=regionCode%>");
	getAccountId_Packet.data.add("retType","AccountId");
	getAccountId_Packet.data.add("idType","1");
	getAccountId_Packet.data.add("oldId","0");
	core.ajax.sendPacket(getAccountId_Packet);
	getAccountId_Packet = null;
}

//调用公共界面，进行集团帐户选择
function getInfo_Acct()
{
    var pageTitle = "集团帐户选择";
    var fieldName = "集团用户ID|集团用户名称|产品名称|集团帐号|";
	var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "4|0|1|2|3|";
    var retToField = "tmp1|tmp2|tmp3|account_id|"; //这里只需要返回帐号
    var cust_id = document.frm.cust_id.value;

    if(document.frm.cust_id.value == "")
    {
        rdShowMessageDialog("请先选择集团客户，才能进行集团帐户查询！",0);
        document.frm.iccid.focus();
        return false;
    }

    if(PubSimpSelAcct(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelAcct(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "/npage/s3432/fpubcustacct_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType+"&cust_id=" + document.all.cust_id.value;

    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

    document.frm.accountQuery.disabled = false;

    return true;
}

function getvalueacct(retInfo)
{
  var retToField = "tmp1|tmp2|tmp3|account_id|";;
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
    document.frm.pay_code.disabled = true;
}

//调用公共界面，进行集团客户选择
function getInfo_Cust()
{
    var pageTitle = "集团客户选择";
    var fieldName = "证件号码|客户ID|客户名称|集团ID|集团名称|归属地|联系人姓名|集团联系地址|集团联系电话|归属组织|";
	  var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
/** add by daixy 20081127,group_id来自dCustDoc中的org_id    
**    var retQuence = "9|0|1|2|3|4|5|6|7|8|";
**    var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_code|contact|address|telephone|";
**/    
    var retQuence = "10|0|1|2|3|4|5|6|7|8|9|";
    var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_code|contact|address|telephone|group_id|";
    var cust_id = document.frm.cust_id.value;

    if(document.frm.iccid.value == "" &&
       document.frm.cust_id.value == "" &&
       document.frm.unit_id.value == "")
    {
        rdShowMessageDialog("请输入身份证号、客户ID或集团ID进行查询！",0);
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

    if(PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "f3200_cust_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType+"&iccid=" + document.all.iccid.value;
    path = path + "&cust_id=" + document.all.cust_id.value;
    path = path + "&unit_id=" + document.all.unit_id.value;

    retInfo = window.open(path,"newwindow","height=450, width=900,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvaluecust(retInfo)
{
/** add by daixy 20081127,group_id来自dCustDoc中的org_id  
** var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_code|contact|address|telephone|";
**/
	var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|belong_code|contact|address|telephone|group_id|";
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

    document.all.grp_name.value = document.all.unit_name.value;
    document.frm.sure.disabled = true;
}

//查询产品属性
function query_prodAttr()
{
    var sm_code = document.frm.sm_code.value;

    if(document.frm.sm_code.value == "")
    {
        return false;
    }

    var getInfoPacket = new AJAXPacket("/npage/s3432/fpubprodattr_qry.jsp","正在查询产品属性代码，请稍候......");
        getInfoPacket.data.add("retType","ProdAttr");
        getInfoPacket.data.add("sm_code",sm_code);
        core.ajax.sendPacket(getInfoPacket);
        getInfoPacket = null;
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
        rdShowMessageDialog("请首先选择服务品牌！",0);
        return false;
    }

    if(PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelProdAttr(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{

    var path = "/npage/s3432/fpubprodattr_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
	path = path + "&op_code=" + document.all.op_code.value;
	path = path + "&sm_code=" + document.all.sm_code.value; 

    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
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

function checkUserPwd(obj1,obj2)
{
        //密码一致性校验,明码校验
        var pwd1 = obj1.value;
        var pwd2 = obj2.value;
        if(pwd1 != pwd2)
        {
                var message = "'" + obj1.v_name + "'和'" + obj2.v_name + "'不一致，请重新输入！";
                rdShowMessageDialog(message,0);
                if(obj1.type != "hidden")
                {   obj1.value = "";    }
                if(obj2.type != "hidden")
                {   obj2.value = "";    }
                obj1.focus();
                return false;
        }
        return true;
}

//调用公共界面，进行产品信息选择
function getInfo_Prod()
{
    var pageTitle = "集团产品选择";
    var fieldName = "产品代码|产品名称|";
	var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|0|1|";
    var retToField = "product_code|product_name|";

    //首先判断是否已经选择了服务品牌
    if(document.frm.sm_code.value == "")
    {
        rdShowMessageDialog("请首先选择服务品牌！",0);
        return false;
    }
    //首先判断是否已经选择了产品属性
    if(document.frm.product_attr.value == "")
    {
        rdShowMessageDialog("请首先选择产品属性！",0);
        return false;
    }

    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
		
    var path = "/npage/s3432/fpubprod_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
	path = path + "&op_code=" + document.all.op_code.value;
	path = path + "&sm_code=" + document.all.sm_code.value; 
    path = path + "&product_attr=" + document.all.product_attr.value; 

    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvalue(retInfo)
{
  var retToField = "product_code|product_name|";
  if(retInfo ==undefined)      
    {   return false;   }

  document.all.product_code.value = retInfo;
  document.frm.product_append.value = "";
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
        rdShowMessageDialog("请首先选择服务品牌！",0);
        return false;
    }
    //首先判断是否已经选择了产品属性
    if(document.frm.product_attr.value == "")
    {
        rdShowMessageDialog("请首先选择产品属性！",0);
        return false;
    }
    //首先判断是否已经申请了集团主产品
    if(document.frm.product_code.value == "")
    {
        rdShowMessageDialog("请首先选择集团主产品！",0);
        return false;
    }

    if(PubSimpSelAppend(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelAppend(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var product_code = document.all.product_code.value;
    var chPos = product_code.indexOf("|");
    product_code = product_code.substring(0,chPos);
    var path = "/npage/s3432/fpubprodappend_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    path = path + "&showType=" + "Default";
	path = path + "&op_code=" + document.all.op_code.value;
	path = path + "&sm_code=" + document.all.sm_code.value; 
	path = path + "&product_code=" + product_code; 

    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

function getvalueProdAppend(retInfo)
{
  var retToField = "product_append|product_name|";
  if(retInfo ==undefined)      
    {   return false;   }

  document.all.product_append.value = retInfo;
}

//服务品牌变更事件
function changeSmCode() {
    document.frm.product_attr.value = "";
	document.frm.product_code.value = "";
    document.frm.product_append.value = "";
    document.frm.grp_userno.value = "";
    query_prodAttr();
}

//产品属性变更事件
function changeProdAttr() {
	document.frm.product_code.value = "";
    document.frm.product_append.value = "";
}

//产品变更事件
function changeProduct() {
    document.frm.product_append.value = "";
}

function call_flags(){
   var h=580;
   var w=1150;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
	   
	var str=window.showModalDialog('/npage/s3200/group_flags.jsp?flags='+document.frm.flags.value,"",prop);
	   
	if( str != undefined ){
		document.frm.flags.value = str;
	}
	return true;
}

function refMain(){
getAfterPrompt();
    var checkFlag; //注意javascript和JSP中定义的变量也不能相同,否则出现网页错误.

    if (document.frm.grp_name.value.length > 36) {
        rdShowMessageDialog("VPMN集团用户名称最长36位!");
        document.frm.grp_name.select();
        return false;
    }

    //说明:检测分成两类,一类是数据是否是空,另一类是数据是否合法.
    if(check(frm))
    {
        if(  document.frm.grp_userno.value == "" ){
            rdShowMessageDialog("集团代码必须输入!!");
            //document.frm.grp_no.select();
            return false;
        }
        if(  document.frm.grp_name.value == "" ){
            rdShowMessageDialog("集团名称:"+document.frm.grp_name.value+",必须输入!!");
            document.frm.grp_name.select();
            return false;
        }
        if(  document.frm.serv_area.value == "" ){
            rdShowMessageDialog("集团所在业务区号必须输入!!");
            document.frm.serv_area.select();
            return false;
        }
        if(  document.frm.inter_fee.value == "" ){
            rdShowMessageDialog("网内费率索引必须输入!!");
            document.frm.inter_fee.select();
            return false;
        }
        if(  document.frm.out_grpfee.value == "" ){
            rdShowMessageDialog("网外号码费率索引必须输入!!");
            document.frm.out_grpfee.select();
            return false;
        }
        if(  document.frm.adm_no.value == "" ){
            rdShowMessageDialog("集团管理接入码必须输入!!");
            document.frm.adm_no.select();
            return false;
        }
        if(  document.frm.out_fee.value == "" ){
            rdShowMessageDialog("网外费率索引必须输入!!");
            document.frm.out_fee.select();
            return false;
        }
        if(  document.frm.normal_fee.value == "" ){
            rdShowMessageDialog("非优惠费率索引必须输入!!");
            document.frm.normal_fee.select();
            return false;
        }
        if(  document.frm.trans_no.value == "" ){
            rdShowMessageDialog("呼叫话务员转接号必须输入!!");
            document.frm.trans_no.select();
            return false;
        }
        if(  document.frm.max_users.value == "" ){
            rdShowMessageDialog("集团最大用户数必须输入!!",0);
            document.frm.max_users.select();
            return false;
        }
    
        //2.转换业务起始日期和业务结束日期的YYYYMMDD---->YYYY-MM-DD
        if(!forDate(document.frm.srv_start)){
            rdShowMessageDialog("业务起始日期:"+document.frm.srv_start.value+",日期不合法!!",0);
            document.frm.srv_start.select();
            return false;
        }
        if(!forDate(document.frm.srv_start)){
            rdShowMessageDialog("业务结束日期:"+document.frm.srv_stop.value+",日期不合法!!",0);
            document.frm.srv_stop.select();
    
            return false;
        }
        //业务起始日期和业务结束日期的时间比较
        checkFlag = dateCompare(document.frm.srv_start.value,document.frm.srv_stop.value);
        if( checkFlag == 1 ){
            rdShowMessageDialog("业务结束日期应该大于业务起始日期!!",0);
            document.frm.srv_stop.select();
            return false;
        }
        //由于参数太多，需要通过form的post传输,因此,需要将传输的内容复制到隐含域中. yl.
        document.frm.chgsrv_start.value = changeDateFormat(document.frm.srv_start.value);
        document.frm.chgsrv_stop.value  = changeDateFormat(document.frm.srv_stop.value);
    
        if( parseInt(document.frm.pmax_close.value) > 5){
            rdShowMessageDialog("单个用户最大可加入的闭合群数:"+document.frm.pmax_close.value+",范围[0,5]!!",0);
            document.frm.pmax_close.select();
            return false;
        }
        checkFlag = parseInt(document.frm.max_users.value);
        if(checkFlag < 20 || checkFlag > 1000){
            rdShowMessageDialog("集团可拥有的最大用户数:"+document.frm.max_users.value+",范围[20,50000]!!",0);
            document.frm.max_users.select();
            return false;
        }
        checkFlag = isValidYYYYMMDD(document.frm.pkg_day.value);
        if(checkFlag < 0 ){
            rdShowMessageDialog("资费套餐生效日期:"+document.frm.pkg_day.value+",日期不合法!!",0);
            document.frm.pkg_day.select();
            return false;
        }
        //必须晚于当前日期
        checkFlag = dateCompare(document.frm.srv_start.value,document.frm.pkg_day.value);
        if( (checkFlag == 1) || (checkFlag == 0) ){
            rdShowMessageDialog("必须晚于当前日期!!",0);
            document.frm.pkg_day.select();
            return false;
        }
		//进行密码校验
		function dateCompare(sDate1,sDate2){
	
	if(sDate1>sDate2)	//sDate1 早于 sDate2
		return 1;
	if(sDate1==sDate2)	//sDate1、sDate2 为同一天
		return 0;
	return -1;		//sDate1 晚于 sDate2
}

		if((document.all.user_passwd.value).trim().length >0)
        {
            if(document.all.user_passwd.value.length!=6)
            {
                rdShowMessageDialog("客户密码长度有误！",0);
                document.all.user_passwd.focus();
                return false;
             }
             if(checkUserPwd(document.frm.user_passwd,document.frm.account_passwd)==false)
                return false;
        }
    		if(document.all.contact.value.length > 9)//luxc20061217 联系人姓名最多9个汉字dvpmngrpmsg//页面不分汉字字母
    		{
    				rdShowMessageDialog("联系人姓名最多9个字!",0);
            document.frm.contact.select();
            return false;
    		}
    
    
        //由于参数太多，需要通过form的post传输,因此,需要将传输的内容复制到隐含域中. yl.
        document.frm.chgpkg_day.value = changeDateFormat(document.frm.pkg_day.value);
        document.frm.sysnote.value = "VPMN集团开户";
        
        
        var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
		    if(typeof(ret)!="undefined")
		     {
		        if((ret=="confirm"))
		        {
		          if(rdShowConfirmDialog('确认电子免填单吗？如确认,将提交本次业务!')==1)
		          {
		             page = "s3200Cfm.jsp";
				         frm.action=page;
				         frm.method="post";
				         frm.submit();
		          }
			      }
			      if(ret=="continueSub")
			      {
		          if(rdShowConfirmDialog('确认要提交信息吗？')==1)
		          {
		            page = "s3200Cfm.jsp";
				        frm.action=page;
				        frm.method="post";
				        frm.submit();
		          }
			      }
			    }
			    else
		      {
		        if(rdShowConfirmDialog('确认要提交信息吗？')==1)
		        {
		            page = "s3200Cfm.jsp";
				        frm.action=page;
				        frm.method="post";
				        frm.submit();
		        }
		      }
	    /*    
	    page = "s3200Cfm.jsp";
      frm.action=page;
      frm.method="post";
      frm.submit();
	     */   
	}
}


function printInfo(printType)
{		
			var grp_typeIndex=document.all.grp_type.selectedIndex;
			var inter_feeIndex=document.all.inter_fee.selectedIndex;
			var displayIndex=document.all.display.selectedIndex;
			var grp_type=document.all.grp_type.options[grp_typeIndex].text;
			var inter_fee=document.all.inter_fee.options[inter_feeIndex].text;
			var display=document.all.display.options[displayIndex].text;
			
	  	var retInfo = "";
      retInfo+='<%=workno%>  <%=workname%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime())%>'+"|";
      
      retInfo+="集团名称"+document.all.grp_name.value+"|";
      retInfo+="集团代码"+document.all.grp_userno.value+"|";
	    retInfo+="联系人姓名"+document.all.contact.value+"|";
      retInfo+="集团联系地址"+document.all.address.value +"|";
      retInfo+="集团联系电话: "+document.all.telephone.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
      
      retInfo+="办理业务"+"智能网VPMN开户"+"|";
      retInfo+="网内费率"+inter_fee+"|";
	    retInfo+="集团最大用户数"+document.all.max_users.value+"|";
	    retInfo+="显示方式			"+display+"|";     
	    retInfo+="集团类型			"+grp_type+"|";
	    retInfo+="业务开始时间		"+document.all.srv_start.value+"|";
	    retInfo+="业务结束时间		"+document.all.srv_stop.value+"|";
	    retInfo+=" "+"|";
	    retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";

	  return retInfo;
}

 function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框 
     var h=178;
     var w=390;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
   
     var printStr = printInfo(printType);
   
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
     var path = "<%=request.getContextPath()%>/npage/innet/hljGdPrint.jsp?DlgMsg=" + DlgMessage;
     var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
     var ret=window.showModalDialog(path,"",prop);
     return ret;     
}

</script>
<BODY>
<FORM action="" method="post" name="frm" >
	

<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi">VPMN集团开户</div>
	</div>
<input type="hidden" name="chgsrv_start" value="">
<input type="hidden" name="chgsrv_stop"  value="">
<input type="hidden" name="belong_code"  value="">
<input type="hidden" name="login_accept"  value="0">
<input type="hidden" name="tmp1"  value="">
<input type="hidden" name="tmp2"  value="">
<input type="hidden" name="tmp3"  value="">
<input type="hidden" name="tfFlag" value="n">
<input type="hidden" name="chgpkg_day" value="">
<input type="hidden" name="product_type" value="">
<input type="hidden" name="product_prices" value="">
<input type="hidden" name="service_code" value="">
<input type="hidden" name="service_attr" value="">
<input type="hidden" name="TCustId"  value="">
<input type="hidden" name="unit_name"  value="">
<input type="hidden" name="op_type"  value="1">
<input type="hidden" name="op_code"  value="3200">
<input type="hidden" name="fee_rate"  value="1">
<input type="hidden" name="lock_flag"  value="0">
<input type="hidden" name="busi_type"  value="01">
<input type="hidden" name="use_status"  value="Y">
<input type="hidden" name="cover_region"  value="">
<input type="hidden" name="max_outnumcl"  value="10">
<input type="hidden" name="org_id"  value="<%=OrgId%>">

<input type="hidden" name="group_id"  value="<%=group_id%>">
<input type="hidden" name="chg_flag"  value="N">
<input type="hidden" name="bill_type"  value="0">
<input type="hidden" name="OrgCode"  value="<%=org_code%>">
<input type="hidden" name="region_code"  value="<%=regionCode%>">
<input type="hidden" name="district_code"  value="<%=districtCode%>">
<input type="hidden" name="WorkNo"   value="<%=workno%>">
<input type="hidden" name="NoPass"   value="<%=nopass%>">
<input type="hidden" name="ip_Addr"  value="<%=ip_Addr%>">


        <TABLE cellSpacing="0">
          <TR>
            <TD class="blue">
              <div align="left">身份证号</div>
            </TD>
            <TD class="blue">
                <input name=iccid  id="iccid" size="24" maxlength="18" v_type="string" v_must=1 v_name="身份证号" index="1" onchange="getInfo_Cust()">
                <input name=custQuery type="button" class="b_text" id="custQuery"  onclick="getInfo_Cust();" style="cursor:hand" value=查询>
                 <font class="orange">*</font>
            </TD>
            <TD class="blue" width=18%>集团客户ID</TD>
            <TD class="blue" width=32%><!--wuxy alter 20090513 为动力100链接过来可以显示客户ID-->
              <input  type="text" name="cust_id" size="20" maxlength="14" value="<%=cust_id%>" v_type="0_9" v_must=1 v_name="客户ID" index="2">
               <font class="orange">*</font>
            </TD>
          </TR>
          <TR>
            <TD class="blue">
               <div align="left">集团ID</div>
            </TD>
            <TD class="blue">
		    <input name=unit_id  id="unit_id" size="24" maxlength="10" value="" v_type="0_9" v_must=1 v_name="集团ID" index="3">
             <font class="orange">*</font>
            </TD>
            <TD class="blue" width=18%>集团客户名称</TD>
            <TD class="blue" width=32%>
              <input  name="cust_name" size="20" value="" readonly  Class="InputGrey" v_must=1 v_type=string v_name="客户名称" index="4">
               <font class="orange">*</font> </TD>
          </TR>
          <TR>
            <TD class="blue">集团客户密码</TD>
            <TD class="blue">
				<jsp:include page="f3200_pwd.jsp">
					<jsp:param name="width1" value="16%"  />
					<jsp:param name="width2" value="34%"  />
					<jsp:param name="pname" value="custPwd"  />
					<jsp:param name="pwd" value=""  />
						<jsp:param name="pvalue" value=""  />
				</jsp:include>
            <input name=chkPass type="button" class="b_text" onClick="check_HidPwd();"  style="cursor:hand" id="chkPass2" value=校验>
             <font class="orange">*</font>
            </TD>
            <TD class="blue">集团用户名称</TD>
            <TD class="blue">
              <input name="grp_name" type="text"  size="20" maxlength="60" value="" v_must=1 v_maxlength=60 v_type="string" v_name="集团用户名称">
             <font class="orange">*</font>
            </TD>
          </TR>
          <TR>
            <TD class="blue">服务品牌</TD>
            <TD class="blue">
<select name="sm_code" id="sm_code" onChange="changeSmCode()" v_must=1 v_type="string" v_name="服务品牌" index="10">
<%
        try
        {
                sqlStr = "select distinct a.sm_code, a.sm_name from sSmCode a, sGrpSmCode b where a.sm_code = b.sm_code and a.sm_code = 'vp'";

                //retArray = callView.sPubSelect("2",sqlStr);
                %>
                
 		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_tu2" scope="end"/>               
                
                <%
                result = result_tu2;
                int recordNum = result.length;
                if (result[0][0].trim().length() == 0)
                    recordNum = 0;
                for(int i=0;i<recordNum;i++){
                    out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
                }
        }catch(Exception e){
                logger.error("Call sunView is Failed!");
        }
%>  <font class="orange">*</font>
</select>
           </TD>
            <TD class="blue">产品属性</TD>
            <TD class="blue">
              <input  type="text" name="product_attr" size="20" readonly  Class="InputGrey"  onChange="changeProdAttr()" v_must=1 v_type="string" v_name="产品属性">
              <input name="ProdAttrQuery" type="button" class="b_text" id="ProdAttrQuery"   onclick="getInfo_ProdAttr();" value="选择">
			   <font class="orange">*</font>
            </TD>
          </TR>
          <TR>
            <TD class="blue">集团主产品</TD>
            <TD class="blue">
              <input  type="text" name="product_code" size="20" value="" readonly  Class="InputGrey" onChange="changeProduct()" v_must=1 v_type="string" v_name="集团主产品">
              <input name="prodQuery" type="button" class="b_text" id="ProdQuery"   onclick="getInfo_Prod();" value="选择">
			   <font class="orange">*</font>
            </TD>
            <TD class="blue">集团附加产品</TD>
            <TD class="blue">
              <input  type="text" name="product_append" size="20" value="" readonly  Class="InputGrey" v_must=0 v_type="string" v_name="集团附加产品">
              <input name="ProdAppendQuery" type="button" class="b_text" id="ProdAppendQuery"   onclick="getInfo_ProdAppend();" value="选择">
            </TD>
          </TR>
          <TR>
            <TD class="blue" >集团产品ID</TD>
            <TD class="blue">
              <input name="grp_id" type="text"  size="20" maxlength="12" value="" readonly  Class="InputGrey" v_type="0_9" v_must=1 v_name="用户ID">
              <input name="grpQuery" type="button" class="b_text" id="grpQuery"   onclick="getUserId();" value="获取">
               <font class="orange">*</font>
            </TD>
            <TD class="blue" >集团编号</TD>
            <TD class="blue">
              <input name="grp_userno" type="text"  size="20" maxlength="12" value="" readonly  Class="InputGrey" v_type="0_9" v_must=1 v_name="集团用户编号">
              <input name="getGrpNo" type="button" class="b_text"  id="getGrpNo" onclick="getGrpUserNo();" value="获得" >
               <font class="orange">*</font>
            </TD>
          </TR>
          <TR>
            <TD class="blue" >帐户ID</TD>
            <TD class="blue">
              <input name="account_id" type="text"  size="20" maxlength="12" value="" readonly  Class="InputGrey" v_type="0_9" v_must=1 v_name="帐户ID">
              <input name="accountQuery" type="button" class="b_text"  id="accountQuery" onclick="getAccountId();"  value="获取" >
              <!--<input name="accountSelect" type="button" class="b_text"  id="accountSelect" onMouseUp="getInfo_Acct();" onKeyUp="if(event.keyCode==13)getInfo_Acct();" value="选择" >-->
               <font class="orange">*</font>
            </TD>
            <TD class="blue" >付款方式</TD>
            <TD class="blue">
<select name="pay_code" id="pay_code" v_must=1 v_type="string" v_name="付款方式" index="10">
<%
        try
        {
                sqlStr = "select pay_code, pay_name from sPayCode where region_code = '" + regionCode + "' order by pay_code";
                //retArray = callView.sPubSelect("2",sqlStr);
                %>
                
 		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_tu3" scope="end"/>               
                
                <%
                result = result_tu3;
                int recordNum = result.length;
                for(int i=0;i<recordNum;i++){
                    out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
                }
        }catch(Exception e){
                logger.error("Call sunView is Failed!");
        }
%>  <font class="orange">*</font>
</select>
               <font class="orange">*</font>
            </TD>
          </TR>
          <TR>
			<jsp:include page="pwd_2.jsp">
				<jsp:param name="width1" value="16%"  />
				<jsp:param name="width2" value="34%"  />
				<jsp:param name="pname" value="user_passwd"  />
				<jsp:param name="pcname" value="account_passwd"  />
			</jsp:include>
          </TR>
          <TR> 
            <TD class="blue">集团所在省区号</TD>
            <TD class="blue">
<%
        try
        {
                sqlStr = "select AGENT_PROV_CODE from sprovinceCode where run_flag = 'Y'";
                //retArray = callView.sPubSelect("1",sqlStr);
                %>
                
   <wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_tu4" scope="end"/>             
                
                <%
                result =result_tu4;
                if (result.length <= 0)
                {
                	logger.error("查询省代码出错失败!");
                }
                agentProvCode = result[0][0];
        }catch(Exception e){
                logger.error("查询集团省区号失败!");
        }
%>
              <input  type="text" name="province" size="20" value="<%=agentProvCode%>" readonly  Class="InputGrey" v_must=1 v_type="0_9" v_name="集团所在省区号" index="11">
               <font class="orange">*</font>
            </TD>
            <TD class="blue" width="117">业务区号</TD>
            <TD class="blue" width="253"> 
              
<%
        try
        {
            sqlStr = "select trim(toll_no) from sRegionCode where region_code = '" + regionCode + "'";
            %>
            
     <wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_tu5" scope="end"/>              
            
            <%
            //retArray = callView.sPubSelect("1",sqlStr);
            result = result_tu5;
            int tollNum = result.length;
            if (tollNum <= 0)
            {
            	logger.error("查询业务区号失败!");
            }
			servArea = agentProvCode + "0" + result[0][0] + "01";
        }catch(Exception e){
                logger.error("查询业务区号失败!");
        }
%>
              <input  type="text" name="serv_area" size="20" value="<%=servArea%>" onKeyPress="return isKeyNumberdot(0)" v_must=1 v_type="0_9" v_name="业务区号" index="12" readonly  Class="InputGrey">
               <font class="orange">*</font> </TD>
          </TR>
          <TR>
<%
        //得到输入参数
        try																			
        {
                sqlStr ="select scp_id from  svpmnscp Where region_code='" + regionCode + "'"; 
               //retArray = callView.sPubSelect("1",sqlStr);
                %>
                
		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_tu6" scope="end"/>                
                
                
                <%
                result = result_tu6;
        }catch(Exception e){
                logger.error("Call sunView is Failed!");
        }              
%>
            <TD class="blue">SCP号</TD>
            <TD class="blue">
              <input  type="text" name="scp_id" size="20" onKeyPress="return isKeyNumberdot(0)" value="<%=result[0][0]%>" v_must=1 v_type="0_9" v_name="SCP号" index="13"> (各地市不同)
            </TD>
            <TD class="blue" width="117">集团类型</TD>
            <TD class="blue" width="253"> 
              <select name="grp_type" id="grp_type">
              <%
                if(workno.equals("aavg21")){
							%>
								<option value="0"selected >0->本地集团</option>
                <option value="1">1->全省集团</option>
                <option value="2">2->全国集团</option>
                <option value="3">3->本地化省级集团</option>
							<%
							}else{
							%>
                <option value="0"selected >0->本地集团</option>
              <%}%>
              </select> <font class="orange">*</font>
            </TD>
          </TR>
          <TR>
            <TD class="blue" width="130">联系人姓名</TD>
            <TD class="blue" width="239"> 
              <input name="contact" type="text"  id="contact" size="20"  v_must=0 v_type="string" v_name="联系人姓名" index="14">
            </TD>
            <TD class="blue" width="117">集团联系地址</TD>
            <TD class="blue" width="253"> 
              <input name="address" type="text"  id="address" size="20"  v_must=0 v_type="string" v_name="集团联系地址" index="15">
            </TD>
          </TR>
          <TR> 
            <TD class="blue" width="130">集团联系电话</TD>
            <TD class="blue" width="239"> 
              <input name="telephone" type="text"  id="telephone" maxlength=12 onKeyPress="return isKeyNumberdot(0)" size="20" v_must=0 v_type="string" v_name="集团联系电话">
            </TD>
            <TD class="blue" width="117">业务激活标志</TD>
            <TD class="blue" width="253"> 
              <select name="sub_state" id="sub_state">
                <option value="0" >0->未激活</option>
                <option value="1" selected>1->激活</option>
              </select> <font class="orange">*</font>
            </TD>
          </TR>
          <TR> 
            <TD class="blue" width="130">业务起始日期</TD>
            <TD class="blue" width="239"> 
              <input name="srv_start" type="text"  id="srv_start"  onKeyPress="return isKeyNumberdot(0)" value="<%=dateStr%>" size="20" maxlength="8" v_must=0 v_type="date" v_name="业务起始日期"  v_format="yyyyMMdd">
            </TD>
            <TD class="blue" width="117">业务结束日期</TD>
            <TD class="blue" width="253"> 
            	<!--update by wangzn Date100-->
              <input name="srv_stop" type="text"  id="srv_stop"  onKeyPress="return isKeyNumberdot(0)" value="20500101" size="20" maxlength="8" v_must=0 v_type="date" v_name="业务结束日期"  v_format="yyyyMMdd" readonly>
            </TD>
          </TR>
          <TR>
            <TD class="blue">用户功能集</TD>
            <TD class="blue" colspan="1">
              <input  type="text" name="flags" size="36" value="220000221110000000010100000000000000" readonly  Class="InputGrey">
              <input type="button" class="b_text" name="updateFlsg"  value="修改" onclick="call_flags()" v_must=1 v_type="string" v_name="用户功能集"> <font class="orange">*</font>
            </TD>
           <TD class="blue">是否为综合v网</TD>
           <TD class="blue" class="formTd">
		          <select name=flags_no_2> 
   		            <option value="0">否</option>	
		              <option value="1">标准综合v网</option>	
			            <option value="2">特殊综合v网</option>
			        </select>	
          </td>    	 		
             	
          </TR>
          <TR>
            <TD class="blue">网内费率索引</TD>
            <TD class="blue"> <select name="inter_fee" v_must=1 v_type="0_9" v_name="国内费率索引">
<%
        try
        {
                sqlStr ="select FEEINDEX,FEEINDEX||'-->'||FEEINDEX_NAME from  svpmnfeeindex  where feeindex > 0 and region_code='"+regionCode+"' and stop_time>=sysdate and power_right<="+powerRight+" order by feeindex";
                //System.out.println("luxc:"+sqlStr);
                //retArray = callView.sPubSelect("2",sqlStr);
                %>
                
 		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_tu7" scope="end"/>               
                
                <%
               
                result = result_tu7;
                int recordNum = result.length;
                for(int i=0;i<recordNum;i++){
                        out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
                }
        }catch(Exception e){
                logger.error("Call sunView is Failed!");
        }
%>
            </select>
             <font class="orange">*</font> </TD>
            <TD class="blue">网外费率索引</TD>
            <TD class="blue">
              <input  type="text" name="out_fee" size="20" value="1" readonly  Class="InputGrey" onKeyPress="return isKeyNumberdot(0)" v_must=1 v_type="0_9" v_name="网外费率索引">
               <font class="orange">*</font> </TD>
          </TR>
          <TR>
            <TD class="blue">网外号码费率索引</TD>
            <TD class="blue">  <select name="out_grpfee" v_must=0 v_type="0_9" v_name="网外号码费率索引">
<%
            int recordNum = result.length;
            for(int i=0;i<recordNum;i++){
                    out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
            }
%>
            </select>
               <font class="orange">*</font> 
            </TD>
            <TD class="blue">非优惠费率索引</TD>
            <TD class="blue">
              <input  type="text" name="normal_fee" size="20" value="1" readonly  Class="InputGrey" onKeyPress="return isKeyNumberdot(0)" v_must=0 v_type="0_9" v_name="非优惠费率索引">
               <font class="orange">*</font> </TD>
          </TR>
          <TR>
            <TD class="blue">集团管理接入码</TD>
            <TD class="blue">
              <input  type="text" name="adm_no" size="20" value="61860" onKeyPress="return isKeyNumberdot(0)" v_must=0 v_type="0_9" v_name="集团管理接入码">
               <font class="orange">*</font> </TD>
            <TD class="blue">呼叫话务员转接号</TD>
            <TD class="blue">
              <input  type="text" name="trans_no" size="20" value="1860" onKeyPress="return isKeyNumberdot(0)" v_must=0 v_type="0_9" v_name="呼叫话务员转接号">
               <font class="orange">*</font> </TD>
          </TR>
          <TR>
            <TD class="blue">主叫号码显示方式</TD>
            <TD class="blue">
              <select name="display" id="display" v_must=1 v_type="0_9" v_name="主叫号码显示方式">
                <option value="0">0->使用个人标志</option>
                <option value="1" selected>1->显示短号</option>
                <option value="2">2->显示真实号码</option>
                <option value="3">3->PBX主叫显示真实号码，其余显示短号</option>
              </select> <font class="orange">*</font>
            </TD>
            <TD class="blue">集团最大闭合群数</TD>
            <TD class="blue">
              <input  type="text" name="max_clnum" size="20" value="10" onKeyPress="return isKeyNumberdot(0)" v_must=0 v_type="0_9" v_name="集团最大闭合群数">
            </TD>
          </TR>
          <TR>
            <TD class="blue">单闭合群最大用户数</TD>
            <TD class="blue">
              <input  type="text" name="max_numcl" size="20" value="100" v_must=1 v_type="int" v_name="单闭合群最大用户数" onKeyPress="return isKeyNumberdot(0)">
            </TD>
            <TD class="blue">单用户最大加入闭合群数</TD>
            <TD class="blue">
              <input  type="text" name="pmax_close" size="20" value="1" v_must=1 v_type="int" v_name="单用户最大加入闭合群数" onKeyPress="return isKeyNumberdot(0)">
            </TD>
          </TR>
          <TR>
            <TD class="blue">集团最大网外号码数</TD>
            <TD class="blue">
              <input  type="text" name="max_outnum" size="20" value="100" v_must=1 v_type="int" v_name="集团最大网外号码数" onKeyPress="return isKeyNumberdot(0)">
            </TD>
            <TD class="blue">集团最大用户数</TD>
            <TD class="blue">
              <input  type="text" name="max_users" size="20" v_must=1 v_type="int" value="1000" v_name="集团最大用户数" onKeyPress="return isKeyNumberdot(0)">
            	 <font class="orange">*</font>
            </TD>
          </TR>
          <TR>
            <TD class="blue">集团资费套餐类型</TD>
            <TD class="blue">
              <select name="pkg_type" v_must=0 v_type="0_9" v_name="集团资费套餐类型">
                <option value="0" selected >0->无套餐</option>
                <option value="1">1->套餐</option>
              </select>
            </TD>
            <TD class="blue">资费套餐生效日期</TD>
            <TD class="blue">
              <input name="pkg_day" type="text"  id="pkg_day" v_must=0 v_type="date" v_name="资费套餐生效日期" onKeyPress="return isKeyNumberdot(0)" value="<%=addDate%>" size="20" >
            </TD>
          </TR>
          <TR>
            <TD class="blue">总折扣</TD>
            <TD class="blue">
              <input  type="text" name="discount" size="20" value="100" v_must=1 v_type="int" v_name="总折扣" onKeyPress="return isKeyNumberdot(1)">
            </TD>
            <TD class="blue">集团月费用限额</TD>
            <TD class="blue">
              <input  type="text" name="lmt_fee" size="20" value="1000000" v_must=1 v_type="int" v_name="集团月费用限额" onKeyPress="return isKeyNumberdot(1)">
            </TD>
          </TR>
        </TABLE>
        <TABLE cellSpacing="0">
           <TR>
               <TD class="blue" width="18%">备注</TD>
               <TD class="blue" width="82%" colspan="3">
               <input  name="sysnote" size="60" readonly  Class="InputGrey">
               <input  name="tonote" size="60" type="hidden">
               </TD>
           </TR>

       </TABLE>

        <TABLE width="98%" border=0 align=center cellpadding="4" cellSpacing=1>
          <TBODY>
            <TR>
              <TD align=center id="footer">
              <input  name="sure"  type="button"  class="b_foot" value="确认" onclick="refMain()"  >
              <input  name="reset1"  onClick="" type=reset value="清除"  class="b_foot">
              <input  name="kkkk"  onClick="parent.window.close()" type="button" class="b_foot" value="关闭">
              </TD>
            </TR>
          </TBODY>
        </TABLE>

		<jsp:include page="/npage/common/pwd_comm.jsp"/>
			<%@ include file="/npage/include/footer.jsp" %>
</FORM>
 <script language="JavaScript">
 document.frm.iccid.focus();
 query_prodAttr();
 </script>
</BODY>
</HTML>


