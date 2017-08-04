<%
   /*
   * 功能: 帐户开户(1102)
　 * 版本: v2.0
　 * 日期: 2006-10-13 10:20
　 * 作者: luorui
　 * 版权: sitech
   * 修改历史
   * 修改日期      		修改人      修改目的
 　*/
    String opName = WtcUtil.repNull(request.getParameter("opName"));
  String opCode = WtcUtil.repNull(request.getParameter("opCode"));
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="java.text.*" %>
<%      

System.out.println("-------------------------------newContractNo.jsp---------------------------------------");  
		ArrayList retArray = new ArrayList();
        String[][] result = new String[][]{};
   
 		String printAccept = ""; 
%>
<%
		ArrayList arr = (ArrayList)session.getAttribute("allArr");
		String[][] baseInfo = (String[][])arr.get(0);
		String[][] agentInfo = (String[][])arr.get(2);
		String workNo = baseInfo[0][2];
		String workName = baseInfo[0][3];
		String Role = baseInfo[0][5];
		String Department = baseInfo[0][16];
		String ip_Addr = agentInfo[0][2];
		//String regionCode = Department.substring(0,2);
		String belongCode = Department.substring(0,7);
String orgCode = (String)session.getAttribute("orgCode");		
	String regionCode = (String)session.getAttribute("regCode");
System.out.println("-------------------------------orgCode-----------------------------------"+orgCode);  
System.out.println("-------------------------------Department--------------------------------"+Department);  
System.out.println("-------------------------------orgCode-----------------------------------"+orgCode.substring(0,7));  
System.out.println("-------------------------------belongCode--------------------------------"+belongCode);  
	

    String rowNum = "16";
    String sys_Date = "";
		String retCode = "";    
    String custName = WtcUtil.repNull(request.getParameter("userName"));
    String gCustId = WtcUtil.repNull(request.getParameter("gCustId"));
    
    opCode ="1102";
		opName ="统一产品新装账户开户";
%>
<wtc:utype name="sQryCustCons" id="retVal" scope="end">
     <wtc:uparam value="<%=gCustId%>" type="LONG"/>
</wtc:utype>
<%
	retCode = String.valueOf(retVal.getValue(0));
	String retMsg = String.valueOf(retVal.getValue(1));
	
	System.out.println("------------retMsg--------------"+retMsg);
%>
<HTML><HEAD><TITLE>帐户开户</TITLE>
</HEAD>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/validate_class.js"></script>
<SCRIPT type=text/javascript>
onload=function()
{
	if("<%=retCode%>" != "0" || "<%=retVal.getSize(2)%>" == "0"){
		$("#oldConNo").css("display","none");
	}
	//将用户密码置初始值111111
	document.all.newPwd.value = '111111';
	document.all.cfmPwd.value = '111111';	
	
	if(typeof(frm1102.accountId)!="undefined") 
	{	if(frm1102.accountId.value != "")            ////恢复到提交前的获得帐户ID按钮显示状态
		{	
			frm1102.accountIdQuery.disabled = true; 
		}
	}		
	//getId();
}
//---------1------RPC处理函数------------------
function doProcess(packet)
{	
    //RPC处理函数findValueByName
	var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode"); 
    var retMessage = packet.data.findValueByName("retMessage");	
    self.status="";
	if((retCode).trim()=="")
	{
       rdShowMessageDialog("调用"+retType+"服务时失败！",0);
       return false;
	}
  	if(retType == "AccountId")
	{
        var retnewId = packet.data.findValueByName("retnewId");

    	if(retCode=="000000")
    	{
    	    document.frm1102.accountId.value = retnewId;
    	}
    	else
    	{
    	    retMessage = retMessage + "[errorCode1:" + retCode + "]";
    			rdShowMessageDialog(retMessage,0);
					return false;
    	}	
	}
    //-----------------------------------------
    if(retType == "checkPwd")
    {
    	
        //进行密码校验
        var retResult = packet.data.findValueByName("retResult");
		frm1102.checkPwd_Flag.value = retResult; 
	    if(frm1102.checkPwd_Flag.value == "false")
	    {
	    	rdShowMessageDialog("客户密码校验失败，请重新输入！",0);
	    	frm1102.custPwd.value = "";
	    	frm1102.custPwd.focus();
	    	frm1102.checkPwd_Flag.value = "false";	    	
	    	return false;	        	
	    }		
		else
		{
 		   rdShowMessageDialog("客户密码校验成功！",2);
 		   frm1102.newPwd.value=frm1102.custPwd.value;
   		   frm1102.cfmPwd.value=frm1102.custPwd.value;
		   document.all.accountIdQuery.disabled=false;	
		   frm1102.custPwd.disabled=true;  
		}

     } 	
	//------------------------------------
	if(retType == "getInfo_withID")
	{
	    clear_CustInfo();
	    if(retCode == "000000")
	    {
	       var retInfo = packet.data.findValueByName("retInfo");
	       if(retInfo != "")
           {
                for(i=0;i<7;i++)
               {   	   
        	        var chPos = retInfo.indexOf("|");
                    valueStr = retInfo.substring(0,chPos);
                    retInfo = retInfo.substring(chPos+1);
                    var obj = "in" + i;
                    document.all(obj).value = valueStr
                }
	        }
	    }	        
	    else
	    {
	        retMessage = retMessage + "[errorCode2:" + retCode + "]";
    		rdShowMessageDialog(retMessage,0);
			return false;
	    }
	}
	if(retType=="chkX")
	{
        var retObj = packet.data.findValueByName("retObj");

		if(retCode == "000000")
        {
         // document.all.print.disabled=false;
		}
        else
        {
             retMessage = "错误" + retCode + "："+retMessage;			 
             rdShowMessageDialog(retMessage,0);
			 document.all.print.disabled=true;
			 document.all(retObj).focus();
			 return false;
        }
	}
}

//--------------------------------------------
//清空上级客户信息
function clear_CustInfo()
{
        for(i=0;i<6;i++)
        {          
                var obj = "in" + i;
                document.all(obj).value = "";
        }
}
//-----------------------------------------------------
function choiceSelWay()
{	//选择客户信息的查询方式
	document.all.accountIdQuery2.disabled=false;
	document.frm1102.custPwd.disabled=false;
	if(frm1102.custId.value != "")
	{	//按客户ID进行查询
		getInfo_withId();	
		return true;
	}
	 
	if(frm1102.idIccid.value != "")
	{	
		getInfo_IccId();
		return true;
	}
	if(frm1102.custName.value != "")
	{	
		getInfo_withName();
		return true;
	}
	
	rdShowMessageDialog("客户信息可以以ID、证件号码或名称进行查询，请输入其中任意项作为查询条件！",0);
	 
}
//-----------------------------------------------------
function getInfo_withId()
{
    //根据客户ID得到相关信息
    
    if(document.frm1102.custId.value == "")
    {
        rdShowMessageDialog("请输入客户ID！",0);
        return false;
    }
    if(for0_9(frm1102.custId) == false)
    {	
    	frm1102.custId.value = "";
    	return false;	
    }    
    
    var getIdPacket = new AJAXPacket("f1100_rpc.jsp","正在获得客户信息，请稍候......");
	getIdPacket.data.add("retType","getInfo_withID");
	getIdPacket.data.add("fieldNum","7");
	getIdPacket.data.add("sqlStr","select to_char(a.CUST_ID),a.CUST_PASSWD,a.ID_ICCID,b.ID_NAME,a.CUST_NAME," +
	            " a.CUST_ADDRESS,a.REGION_CODE||a.DISTRICT_CODE||a.TOWN_CODE" + 
	            " from DCUSTDOC a,SIDTYPE b where a.CUST_ID=" +
                document.frm1102.custId.value + " and b.ID_TYPE = a.ID_TYPE and rownum<500 ");
	core.ajax.sendPacket(getIdPacket);
	getIdPacket = null;  
	
} 

//-----------------------------------------------------
/*
    参数1(pageTitle)：查询页面标题
    参数2(fieldName)：列中文名称，以'|'分隔的串
    参数3(sqlStr)：sql语句
    参数4(selType)：类型1 rediobutton 2 checkbox
    参数5(retQuence)：返回域信息，返回域个数＋ 返回域标识，以'|'分隔，如"3|0|2|3"表示返回3个域0，2，3
    参数6(retToField))：返回值存放域的名称,以'|'分隔
*/
function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{   //公共查询

    var path = "/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    retInfo = window.showModalDialog(path);
     if(typeof(retInfo)=="undefined")    
    {   return false;   }
    retToField = retToField+"|";
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
//-------------------------------------------------
function getInfo_withName()
{ 
  	////根据客户名称得到相关信息
    
  	
  	if(document.frm1102.custName.value == "")
    {
        rdShowMessageDialog("请输入客户名称！",0);
        return false;
    }
    
    var pageTitle = "客户信息查询";
    var fieldName = "客户ID|客户名称|开户时间|证件类型|证件号码|客户地址|归属代码|客户密码|";
    var sqlStr = "select to_char(a.CUST_ID),a.CUST_NAME,to_char(a.CREATE_TIME,'YYYY-MM-DD HH24:MI:SS'),b.ID_NAME,a.ID_ICCID," +
	             " a.CUST_ADDRESS,a.REGION_CODE||a.DISTRICT_CODE||a.TOWN_CODE,a.CUST_PASSWD" + 
	             " from DCUSTDOC a,SIDTYPE b where " +
	             " a.CUST_NAME like '" + document.frm1102.custName.value + "%' and b.ID_TYPE = a.ID_TYPE  and rownum<500 order by a.cust_name asc,a.create_time desc ";
    var selType = "S";              //'S'单选；'M'多选
    var retQuence = "7|0|1|3|4|5|6|7|";
    var retToField = "in0|in4|in3|in2|in5|in6|in1|";
    custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);     	       	   
}
//-----------------------------------------------------
function custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    /*
    参数1(pageTitle)：查询页面标题
    参数2(fieldName)：列中文名称，以'|'分隔的串
    参数3(sqlStr)：sql语句
    参数4(selType)：类型1 rediobutton 2 checkbox
    参数5(retQuence)：返回域信息，返回域个数＋ 返回域标识，以'|'分隔，如"3|0|2|3"表示返回3个域0，2，3
    参数6(retToField))：返回值存放域的名称,以'|'分隔
    */
    //var path = "../../npage/public/fPubSimpSel.jsp";   //密码显示
    var path = "pubGetCustInfo.jsp";   //密码为*
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
   
    retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:35;");
    if(typeof(retInfo) == "undefined")     
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
		if(obj=="in4")
		  document.all.accountName.value=valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");        
    }
	rpc_chkX("idType","idIccid","A");
}
//-------------------------------------------------
function getInfo_IccId()
{ 
  	//根据客户证件号码得到相关信息
  	if((document.frm1102.idIccid.value).trim().length == 0)
    {
        rdShowMessageDialog("请输入客户证件号码！",0);
        return false;
    }
	else if((document.frm1102.idIccid.value).trim().length < 5)
	{
        rdShowMessageDialog("证件号码长度有误（最少五位）！",0);
        return false;
	}
    var pageTitle = "客户信息查询";
    var fieldName = "客户ID|客户名称|开户时间|证件类型|证件号码|客户地址|归属代码|客户密码|";
    var sqlStr = "select to_char(a.CUST_ID),a.CUST_NAME,to_char(a.CREATE_TIME,'YYYY-MM-DD HH24:MI:SS'),b.ID_NAME,a.ID_ICCID," +
	             " a.CUST_ADDRESS,a.REGION_CODE||a.DISTRICT_CODE||a.TOWN_CODE,a.CUST_PASSWD" + 
	             " from DCUSTDOC a,SIDTYPE b where b.ID_TYPE = a.ID_TYPE " +
	             " and a.ID_ICCID = '" + (document.frm1102.idIccid.value).trim() + "' and rownum<500 order by a.cust_name asc,a.create_time desc "; 
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "7|0|1|3|4|5|6|7|";
    var retToField = "in0|in4|in3|in2|in5|in6|in1|";
    custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);       	       	   
}

//----------------------------------------------------------
function printCommit()
{   
	if((frm1102.payCode.value).indexOf("托收") > 0)
	{
		if((frm1102.accountNo.value == "")||(frm1102.bankCode.value == "")||(frm1102.postCode.value == ""))
		{
			rdShowMessageDialog("托收相关的帐号、银行信息不能为空！",0);
			return false;
		}		
	}
	//
	if(checksubmit(frm1102))
	{
	    if((document.all.newPwd.value).trim().length>0)
			{
		  if(document.all.newPwd.value.length!=6)
		  {
		    rdShowMessageDialog("帐户密码长度有误！",0);
		    document.all.custPwd.focus();
		    return false;
		  }
          if(checkPwd(document.frm1102.newPwd,document.frm1102.cfmPwd)==false)
		  return false;
		}else{
			rdShowMessageDialog("请输入帐户密码及确认密码！");
			return false;
		}
    	//1、信用卡、托收：帐户id，帐户名称，帐户类型，帐户密码，开始日期，帐号，银行代码，局方银行代码；
//2、 帐户id，帐户名称，帐户类型，帐户密码，开始日期，

		getId();
		if(document.all.accountId.value == ""){
			return false;	
		}
		var packet = new AJAXPacket("newContractNoCfm.jsp","请稍后...");
		packet.data.add("accountId",document.all.accountId.value);
		packet.data.add("gCustId","<%=gCustId%>");
		packet.data.add("newPwd",document.all.newPwd.value);
		packet.data.add("accountName",document.all.accountName.value);
		packet.data.add("belongCode",document.all.belongCode.value);
		packet.data.add("beginDate",document.all.beginDate.value);
		packet.data.add("payCode",document.all.payCode.value);
		packet.data.add("bankCode",document.all.bankCode.value);
		packet.data.add("postCode",document.all.postCode.value);
		packet.data.add("accountNo",document.all.accountNo.value);
		packet.data.add("accountType",document.all.accountType.value); 
		packet.data.add("unitCode",document.all.unitCode.value);
		packet.data.add("endDate",document.all.endDate.value);
		packet.data.add("opCode","<%=opCode%>");
		core.ajax.sendPacket(packet,doNewContractNo);
		packet =null;
		
		/*
		if(document.all.payCode.value ==2 ||document.all.payCode.value == 4) //信用卡，托收
	    	window.opener.document.all.accountStr.value=document.all.accountId.value
	    	+"~"+ document.all.accountName.value+"~"+document.all.accountType.value
	    	+"~"+document.all.newPwd.value+"~"+document.all.beginDate.value+"~"
	    	+document.all.accountNo.value+"~"+document.all.bankCode.value+"~"+document.all.postCode.value+"~";
    else
    	window.opener.document.all.accountStr.value=document.all.accountId.value+"~"+ document.all.accountName.value+"~"+document.all.accountType.value+"~"+document.all.newPwd.value+"~"+document.all.beginDate.value+"~";
    */
    }    
}

function doNewContractNo(packet){
	var errorCode = packet.data.findValueByName("errorCode");
	var errorMsg = packet.data.findValueByName("errorMsg");
	if(errorCode.trim() == "0")
	{
		rdShowMessageDialog("账户开户成功！",2);
		window.opener.$("input[name='contractNo']").val(document.all.accountId.value);
		window.opener.$("input[name='contractName']").val(document.all.accountName.value);
		window.opener.$("input[name='contractType']").val($("select[name='accountType'] :selected").text().trim());  
		
  	window.close();
	}
	else{
		rdShowMessageDialog("账户开户失败！",0);
		return false;	
	}
} 

//---------------------------------------------------
function getId()
{
    //得到帐户ID
  var getAccountId_Packet = new AJAXPacket("f1100_getId.jsp","正在获得帐户ID，请稍候......");
	getAccountId_Packet.data.add("region_code","<%=regionCode%>");
	getAccountId_Packet.data.add("retType","AccountId");
	getAccountId_Packet.data.add("idType","1");
	getAccountId_Packet.data.add("oldId","0");
	core.ajax.sendPacket(getAccountId_Packet);
	getAccountId_Packet = null;
}
//----------------------------------
function checkPwd(obj1,obj2)
{
	//密码一致性校验
	var pwd1 = obj1.value;
	var pwd2 = obj2.value;
	if(pwd1 != pwd2)
	{
		var message = "'" + obj1.v_name + "'和'" + obj2.v_name + "'不一致，请重新输入！";
		rdShowMessageDialog(message,0);
		obj1.value = "";
		obj2.value = "";
		obj1.focus();
		return false;
	}
	return true;
}
//-------------------------------------
function payWayChange()
{
    var payWay = document.frm1102.payCode.options[document.all.frm1102.payCode.selectedIndex].text;
    var chPos = payWay.indexOf("托收");
    var chPos2 = payWay.indexOf("信用卡");
    var obj = "tbBank" + 0;
    if(chPos > 0 || chPos2>0)
    {
        document.all(obj).style.display = "";
    }
    else
    {
        document.all(obj).style.display = "none";
        frm1102.bankCode.value = "";
        frm1102.postCode.value = "";
    }
}
function parentBankChange(){
	document.frm1102.bankCode.value="";
	document.frm1102.bankName.value="";
}

function getBankCode()
{ 
  	//调用公共js得到银行代码
    var pageTitle = "银行代码查询";
    var fieldName = "银行代码|银行名称";
    var sqlStr = "select BANK_CODE,BANK_NAME from sBankCode " +
                "where REGION_CODE = '" + document.frm1102.unitCode.value.substring(0,2) + "'" +
                " and DISTRICT_CODE ='" + document.frm1102.unitCode.value.substring(2,4) + "'"+
                " and PARENT_BANK ='" + document.frm1102.parentBank.value + "'";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "0|1";
    var retToField = "bankCode|bankName";
    PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);        	       	   
}
function getPostCode()
{ 
  	//调用公共js得到银行代码
    var pageTitle = "局方银行代码查询";
    var fieldName = "银行代码|银行名称";
    var sqlStr = "select POST_BANK_CODE,BANK_NAME from sPostCode " +
                "where REGION_CODE = '" + document.frm1102.unitCode.value.substring(0,2) + "'";
    if(document.frm1102.postName.value != "")
    {
        sqlStr = sqlStr + " and BANK_NAME like '%" + document.frm1102.postName.value + "%'";
    }
    sqlStr = sqlStr + " and rowNum <" + <%=rowNum%> ;  
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "0|1";
    var retToField = "postCode|postName";
    PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);   	       	   
}
function jspReset()
{
        var obj = null;
        var t = null;
    	var i;   	
        for (i=0;i<document.frm1102.length;i++)
        {    
    		obj = document.frm1102.elements[i];		 		 		 
    		//packUp(obj); 
    	    obj.disabled = false;
         }        
        //document.frm1102.commit.disabled = "none"; 
}
//---------------------------------------------------

function getOldConNo(){
	var h=250;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="height:"+h+",width:"+w+",left:"+l+"px, top:"+t+"px,toolbar:no, menubar:no, scrollbars:yes, resizable:no,location:no,status:no,help:no";
	window.opener.open("getContractNo.jsp?userName="+"<%=custName%>"+"&gCustId="+"<%=gCustId%>","",prop);
	self.close();	
}
</SCRIPT>
<!--**************************************************************************************-->
<body>
<div id="operation"> 
<FORM method=post name="frm1102" action="">
<%@ include file="/npage/include/header_pop.jsp" %>
<div id="operation_table">	
 	<div class="input">	
              <TABLE cellSpacing=0>
                 <TR> 
                  <Td class="blue">帐户ID</Td>
                  <TD> 
                    <input name=accountId id=accountId v_must=1 v_type="0_9" v_name="帐户ID" maxlength="22" readonly class="InputGrey">
                    <br>
                  </TD>
                  <Td class="blue"><font class="orange">*</font> 帐户名称</Td>
                  <TD> 
                    <input name=accountName class="required" value="<%=custName%>" v_must=1 v_maxlength=60 v_type="string" v_name="帐户名称" maxlength="60" size=35 index="5">
                  </TD>
                </TR>
				 <TR>      
			
				   <jsp:include page="/npage/common/pwd_2.jsp">
			 
					  <jsp:param name="width1" value="16%"  />
					  <jsp:param name="width2" value="34%"  />
					  <jsp:param name="pname" value="newPwd"  />
					  <jsp:param name="pcname" value="cfmPwd"  />
			 
				   </jsp:include>
			    </TR>
                <TR> 
                  <Td class=blue>帐户类型</Td>
                  <TD> 
                    <select align="left" name=accountType width=50  index="8">
											<wtc:qoption  name="sPubSelect" outnum="2">
												<wtc:sql>select trim(ACCOUNT_TYPE), TYPE_NAME from sAccountType order by ACCOUNT_TYPE</wtc:sql>
											</wtc:qoption>

                    </select>
                  </TD>
                  <Td class=blue>付款方式</Th>
                  <TD> 
                    <select align="left" name=payCode onchange="payWayChange()" width=50 index="9">
												<wtc:qoption  name="sPubSelect"  outnum="2">
													<wtc:sql>select trim(PAY_CODE),trim(PAY_CODE)||'-->'||trim(PAY_NAME) from sPayCode where REGION_CODE= '?' order by PAY_CODE</wtc:sql>
													<wtc:param value="<%=regionCode.substring(0,2)%>"/> 
												</wtc:qoption>
                    </select>
                  </TD>
                </TR>
              </TABLE>  
                   
            
              <TABLE cellSpacing=0 id=tbBank0 style="display:none">
                <TBODY> 
                <TR> 
                  <td class=blue> <font class="orange">*</font> 帐号 </Td>
                  <TD > 
                    <input name=accountNo class="required" v_name="帐号" maxlength="30" index="10">
                  </TD>
                  
                  <Td class=blue>总行代码</Td>
                  <TD> 
                    <select align="left" name=parentBank onchange="parentBankChange()" width=50 index="9">
											<wtc:qoption   name="sPubSelect" outnum="2">
											<wtc:sql>select parent_bank,parent_bank||'->'||bank_name from sparentbank where region_code='?'</wtc:sql>
												<wtc:param value="<%=regionCode.substring(0,2)%>"/> 
											</wtc:qoption>  
                    </select>											  
                  </TD>
                </TR>
                <TR> 
                  <Td class=blue>银行代码</Td>
                  <TD> 
                    <input name=bankCode size=7  maxlength="5" readonly >
                    <input name=bankName size=13  onkeyup="if(event.keyCode==13)getBankCode();" readonly index="11">
                    <input name=bankCodeQuery type=button class="b_text" id="bankCodeQuery" style="cursor:hand" onClick="getBankCode()" value=查询 index="12">
                  </TD>
                  <Td class=blue>局方银行代码</Td>
                  <TD> 
                    <input name=postCode size=5 maxlength="5" readonly>
                    <input name=postName size=13 onkeyup="if(event.keyCode==13)getPostCode();" index="13">
                    <input name=postCodeQuery type=button class="b_text" id="postCodeQuery" style="cursor:hand" onClick="getPostCode()" value=查询 index="14">
                  </TD>
                </TR>
              </TABLE>  

              <TABLE cellSpacing=0>
                <TR> 
                  <Td class=blue>开始日期</Td>
                  <TD> 
                     <input class="yyyMMdd" name=beginDate v_type="date" v_name="开始日期" v_must=1 value="<%=new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new Date())%>" maxlength="20" readonly>
                    <input class="yyyMMdd" name=endDate date v_name="结束日期" v_must=1 maxlength="20" value="20501231" readonly style="display:none">
                  </TD>
                </TR>
              </TABLE>  
                                          
              <TABLE cellSpacing=0>
                <tr style="display:none"> 
                  <td class=blue>系统备注</td>
                  <td> 
                    <input name=sysNote size=60 readonly maxlength="60">
                  </td>
                </tr>
                <TR style="display:none"> 
                  <Td class=blue>用户备注</Td>
                  <TD> 
                    <input name=opNote size=60 maxlength="60"  index="15" v_must=0 v_maxlength=60 v_type="string" v_name="用户备注">
                  </TD>
                </TR>
                <tr>
                	<td id=footer colspan=4>
                		      <div id="operation_button">                 
       
              <input class="b_foot_long" name=print  onmouseup="printCommit()" onkeyup="if(event.keyCode==13)printCommit()" type=button value=确认&返回 index="16" >
			        <input class="b_foot" name=reset1   type=button onClick="frm1102.reset();jspReset();" value=清除 index="17">
			        <input class="b_foot" name=back   onclick="window.close()" type=button value=关闭 index="18">
			  			<input class="b_foot" name="oldConNo" id="oldConNo"  onclick="getOldConNo()" type=button value="已有账户">
        </div>
                	</td>
                </tr>
              </TABLE>   
              </div>
            </div>
    
<br>
<br>

  <!------------------------> 
  <input type="hidden" id=in1 name="hidPwd" v_name="原始密码">
  <input type="hidden" name="hidCustPwd">  <!--客户加密后的密码-->
  <input type="hidden" name="workno" value=<%=workNo%>>
  <input type="hidden" name="regionCode" value=<%=regionCode%>> 
  <input type="hidden" id=in6 name="belongCode" value=<%=belongCode%>>
  <input type="hidden" name="unitCode" value=<%=Department%>>
  <input type="hidden" name="ip_Addr" value=<%=ip_Addr%>>
  <input type="hidden" name="inParaStr" >
  <input type="hidden" name="checkPwd_Flag" value="false">		<!--密码校验标志-->
  <input type="hidden" name="workName" value=<%=workName%> >
 <jsp:include page="/npage/common/pwd_comm.jsp"/>
<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</div>
</body>
</html> 
