<%
  /*
   * 功能: 问题反馈
　 * 版本: v1.0
　 * 日期: 2008年10月25日
　 * 作者: piaoyi
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd>
<HTML xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib uri="weblogic-tags.tld" prefix="wl" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0);
  String workName = (String)session.getAttribute("workName");
  String ipAddr = (String)session.getAttribute("ipAddr");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
  String opCode="2034";
  String opName="开通工单管理";  
  String sqlStr="";
%>
<HTML>
<HEAD>
<link href="s2002.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE="javascript" >
    function doCfm(){
    	if (!checkElement(document.getElementById("p_CustomerNumber"))) {
    		return;
    	}
    	
    	var parameterNumberObj = document.getElementById("parameterNumber");
    	var parameterNameObj = document.getElementById("parameterName");
    	var parameterValueObj = document.getElementById("parameterValue");
    	var characterGroupObj = document.getElementById("characterGroup");

    	var parameterNumberItObj = document.getElementsByName("p_ParameterNumber");
    	var parameterNameItObj = document.getElementsByName("p_ParameterName");
    	var parameterValueItObj = document.getElementsByName("p_ParameterValue");
    	var characterGroupItObj = document.getElementsByName("p_CharacterGroup");
    	var parameterNumberArr = new Array();
    	var parameterNameArr = new Array();
    	var parameterValueArr = new Array();
    	var characterGroupArr = new Array();
    	
    	for (var i = 0; i < parameterNumberItObj.length; i ++) {
    		if (!checkElement(parameterValueItObj[i])) {
    			return;
    		} else if (!checkElement(characterGroupItObj[i])) {
    			return;
    		}
    		
    		parameterNumberArr[i] = parameterNumberItObj[i].value;
		  	parameterNameArr[i] = parameterNameItObj[i].value;
		  	parameterValueArr[i] = parameterValueItObj[i].value;
		  	characterGroupArr[i] = characterGroupItObj[i].value;
    	}
    	parameterNumberObj.value = parameterNumberArr;
    	parameterNameObj.value = parameterNameArr;
    	parameterValueObj.value = parameterValueArr;
    	characterGroupObj.value = characterGroupArr;
    	
    	//alert(parameterNumberObj.value + "\n" + parameterNameObj.value + "\n" + parameterValueObj.value + "\n" + characterGroupObj.value);
    	
    	document.form1.action="f2034_cfm.jsp";
    	document.form1.submit();
    }

</SCRIPT>
</HEAD>
<BODY>
	<FORM name="form1" method="post" action="">
<%@ include file="/npage/include/header.jsp" %>
 
<div class="title"><div id="title_zi">产品订单基本信息</div></div>
<table cellSpacing=0>
  <tr>
    <td class="blue"  width="15%" >
			Ec集团客户编码
    </td>
    <td colspan="3">
      <input name="p_CustomerNumber" id="p_CustomerNumber" v_type="0_9"  v_must="1" size="30" maxlength="30">      
    </td>
  </tr>
  <tr>
    <td class="blue"  width="15%" >
    产品订单号
    </td>
    <td  width="35%" >
       <input name="p_ProductOrderNumber" id="p_ProductOrderNumber" v_type="string" size="20" maxlength="19">       
       <input name="getProductOrderNumberQuery" type="button" class="b_text" onclick="getProductOrderNumber()" id="getProductOrderNumberQueryBtn" value="查询">
    </td>
    <td class="blue"  width="15%" >
    产品规格编号
    </td>
    <td  width="35%" >
       <input name="p_ProductSpecNumber" id="p_ProductSpecNumber" v_type="string" size="20" maxlength="7">
       <font class="orange">*</font>           
    </td>    
  </tr> 
  <tr>
    <td class="blue">
    产品关键号码
    </td>
    <td>
      <input name="p_AccessNumber" id="p_AccessNumber" v_type="string" size="20" maxlength="40">           
    </td>
    <td  class="blue">
    产品附件号码
    </td>
    <td>
      <input name="p_PriAccessNumber" id="p_PriAccessNumber" v_type="string" size="20" maxlength="20">           
    </td>
   </tr>
   <tr>
    <td class="blue">
    联系人
    </td>
    <td>
      <input name="p_Linkman" id="p_Linkman" v_type="string" size="20" maxlength="10">
    </td>
    <td class="blue">
    联系电话
    </td>
    <td>
    	<input name="p_ContactPhone" id="p_ContactPhone" v_type="string" size="20" maxlength="10">
      <font class="orange">*</font>      
    </td>
  </tr>
  <tr>
    <td class="blue">
    是否需要二次确认
    </td>
    <td>
      <select name="p_TerminalConfirm" id=p_TerminalConfirm>
       <option value="">----不限制----</option>
       <%sqlStr ="select detail_code, detail_name from sbbossListCode where list_code = 'TerminalConfirm' order by detail_order ";%>
			 <wtc:qoption name="sPubSelect" outnum="2">
			 <wtc:sql><%=sqlStr%></wtc:sql>
			 </wtc:qoption>
      </select>
    </td>
    <td class="blue">
    操作类型
    </td>
    <td>
      <select name="p_OperationSubTypeID" id=p_OperationSubTypeID>
      	<option value="">----不限制----</option>
       <%sqlStr ="select detail_code, detail_name from sbbossListCode where list_code = 'OperationSTID' order by to_number(detail_order)";%>
			 <wtc:qoption name="sPubSelect" outnum="2">
			 <wtc:sql><%=sqlStr%></wtc:sql>
			 </wtc:qoption>
      </select>    	           
    </td>
  </tr>
  <tr>
   <td class="blue">
    服务开通等级ID
    </td>
    <td colspan="1">      
      <input name="p_ServiceLevelID" id="p_ServiceLevelID" v_type="string" size="20" maxlength="20">          
    </td> 
    <td class="blue">
    产品状态
    </td>
    <td   colspan="1">  
    	<select name="p_TASK_FLAG" id=p_TASK_FLAG>
      	<option value="0">未竣工</option>
        <option value="1">已竣工</option>
      </select>               
    </td> 
  </tr> 
     <tr> 
    <td class="blue"  width="15%">
    产品描述
    </td>
    <td   colspan="3">      
      <input name="p_Description" id="p_Description" v_type="string" size="70" maxlength="250">          
    </td>       
    
  </tr>          
</table>
<br>  
 <DIV id="div0_show"   class="groupItem">
   <DIV class="title">
	    <DIV id="zi"><img id="div0_switch" class="closeEl" src="../../../nresources/default/images/jia.gif" style='cursor:hand' width="15" height="15"  ></DIV>
   	  <DIV id="zi0">产品属性列表</DIV>
   </DIV>
   <DIV class="itemContent" id="mydiv0">
	 	  <DIV id="wait0"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30">
	 	  </DIV>
   </DIV>
</DIV>

<DIV id="div1_show"   class="groupItem">
   <DIV class="title">
	    <DIV id="zi"><img id="div1_switch" class="closeEl" src="../../../nresources/default/images/jia.gif" style='cursor:hand' width="15" height="15"  ></DIV>
   	  <DIV id="zi0">成员列表</DIV>
   </DIV>
   <DIV class="itemContent" id="mydiv1">
	 	  <DIV id="wait1"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30">
	 	  </DIV>
   </DIV>
</DIV>

<DIV id="hiddendate_new">
</DIV>
<DIV id="hiddendate_delete">
</DIV>

<input type="hidden" name="hiddendate_productorderchar_num"        id="hiddendate_productorderchar_num">
<input type="hidden" name="parameterNumber" id="parameterNumber" value="">
<input type="hidden" name="parameterName" id="parameterName" value="">
<input type="hidden" name="parameterValue" id="parameterValue" value="">
<input type="hidden" name="characterGroup" id="characterGroup" value="">

<table>
  <tr>
    <td align="center" id="footer" colspan="2">
      <input class="b_foot" name=next id=nextoper type=button value="确认" onclick="doCfm()" >
      <input class="b_foot" name=reset type=button value="清除" onClick="clearbutton()">
      <input class="b_foot" name=reset type=button value="关闭" onClick="parent.removeTab('<%=opCode%>')">
    </td>
  </tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>

<script type="text/javascript">
	var _jspPage =
	{"div0_switch":["mydiv0","f2034_ProductOrderCharacters_list.jsp","f"]
	 ,"div1_switch":["mydiv1","f2034_Member_list.jsp","f"]
	};
	function hiddenSpider()
	{
		document.getElementById("mydiv0").style.display='none';
		document.getElementById("mydiv1").style.display='none';
	}

  $(document).ready(function () {
		//隐藏进度条
		hiddenSpider();
		$('img.closeEl').bind('click', toggleContent);
    }
  );

  var toggleContent = function(e)
  {
  	var targetContent = $( 'DIV.itemContent',this.parentNode.parentNode.parentNode);
  	if (targetContent.css('display') == 'none') {  	  
  		   targetContent.slideDown(300);
  		   $(this).attr({ src: "../../../nresources/default/images/jian.gif"});
  		   //调用服务
  		   try{
  		   	var tmp = $(this).attr('id');
  		   	var tmp2 = eval("_jspPage."+tmp);
  		   	if(tmp2[2]=="f"&&tmp2[1]!=''&&tmp2[1]!=undefined)
  		   	{  		   		
  		   		$("#"+tmp2[0]).load(tmp2[1],{sProductOrderNumber:$("#p_ProductOrderNumber").val()});
  		   		//tmp2[2]="t";
  		   	}
  		   }catch(e)
  		   {  		   	
  		   }

  	} else {
  		targetContent.slideUp(300);
  		$(this).attr({ src: "../../../nresources/default/images/jia.gif"});
  	}
  	return false;
  };

function clearbutton()
{
	document.all.p_ProductOrderNumber.readOnly=false;
    document.all.p_ProductSpecNumber.readOnly=false;
    document.all.p_AccessNumber.readOnly=false;
    document.all.p_PriAccessNumber.readOnly=false;
    document.all.p_Linkman.readOnly=false;
    document.all.p_ContactPhone.readOnly=false;
    document.all.p_TerminalConfirm.disabled=false;
    document.all.p_OperationSubTypeID.disabled=false;
    document.all.p_ServiceLevelID.readOnly=false;
    document.all.p_Description.readOnly=false;
	$("#p_ProductOrderNumber").val("");
	$("#p_ProductSpecNumber").val("");
	$("#p_AccessNumber").val("");
	$("#p_PriAccessNumber").val("");
	$("#p_Linkman").val("");
	$("#p_ContactPhone").val("");
	$("#p_TerminalConfirm").val("");
	$("#p_OperationSubTypeID").val("");
	$("#p_ServiceLevelID").val("");
	$("#p_TASK_FLAG").val("0");
	$("#p_Description").val("");
	document.all("getProductOrderNumberQueryBtn").disabled=false;
	//var targetContent = $( 'DIV.itemContent',this.parentNode.parentNode.parentNode);
	//targetContent.slideUp(300);
	$("div.itemContent").slideUp(30);
	$("img.closeEl").attr({ src: "../../../nresources/default/images/jia.gif"});
}

//调用公共界面，进行订购信息选择
function getProductOrderNumber()
{
    var pageTitle = "订购信息";
    var fieldName = "产品订单号|产品规格编号|产品关键号码|产品附件号码|联系人|产品状态|"                 
                  + "联系电话|产品描述|服务开通等级ID|是否需要二次确认|操作类型|Ec集团客户编码|";
    var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "12|0|1|2|3|4|5|6|7|8|9|10|11|";

    var retToField = "p_ProductOrderNumber|p_ProductSpecNumber|p_AccessNumber|p_PriAccessNumber|p_Linkman|p_TASK_FLAG|"
                   + "p_ContactPhone|p_Description|p_ServiceLevelID|p_TerminalConfirm|p_OperationSubTypeID|p_CustomerNumber|";

    var path = "<%=request.getContextPath()%>/npage/s2002/f2034_getProductOrderNumber.jsp";
    path = path + "?sqlStr=" + sqlStr;
    path = path + "&fieldName="+fieldName;
    path = path + "&selType="+selType;
    path = path + "&retQuence="+retQuence;
    path = path + "&retToField="+retToField;
    path = path + "&sOrderType=" +$("#p_OrderType").val();
    path = path + "&sProductOrderNumber="+$("#p_ProductOrderNumber").val();
    path = path + "&sProductSpecNumber=" +$("#p_ProductSpecNumber").val();
    path = path + "&sAccessNumber="+$("#p_AccessNumber").val();
    path = path + "&sPriAccessNumber="+$("#p_PriAccessNumber").val();
    path = path + "&sLinkman="+$("#p_Linkman").val();
    path = path + "&sContactPhone="+$("#p_ContactPhone").val();
    path = path + "&sDescription="+$("#p_Description").val();
    path = path + "&sServiceLevelID="+$("#p_ServiceLevelID").val();
    path = path + "&sTerminalConfirm="+$("#p_TerminalConfirm").val();
    path = path + "&sOperationSubTypeID="+$("#p_OperationSubTypeID").val();   
    path = path + "&p_CustomerNumber="+$("#p_CustomerNumber").val();   
    path = path + "&sTASK_FLAG="+$("#p_TASK_FLAG").val();
    retInfo = window.open(path,
                          "newwindow",
                          "height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
    return true;
}

function getProductOrderNumberRtn(retInfo)
{
    var retToField = "p_ProductOrderNumber|p_ProductSpecNumber|p_AccessNumber|p_PriAccessNumber|p_Linkman|p_TASK_FLAG|"
                   + "p_ContactPhone|p_Description|p_ServiceLevelID|p_TerminalConfirm|p_OperationSubTypeID|p_CustomerNumber|";
    if (retInfo == undefined)
    {
        return false;
    }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while (chPos_field > -1)
    {
        obj = retToField.substring(0, chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0, chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
    }
    document.all("getProductOrderNumberQueryBtn").disabled=true;
    document.all.p_ProductOrderNumber.readOnly=true;
    document.all.p_ProductSpecNumber.readOnly=true;
    document.all.p_AccessNumber.readOnly=true;
    document.all.p_PriAccessNumber.readOnly=true;
    document.all.p_Linkman.readOnly=true;
    document.all.p_ContactPhone.readOnly=true;
    document.all.p_TerminalConfirm.disabled=true;
    document.all.p_OperationSubTypeID.disabled=true;
    document.all.p_ServiceLevelID.readOnly=true;
    document.all.p_Description.readOnly=true;
    document.all.p_CustomerNumber.readOnly=true;
}


</script>
