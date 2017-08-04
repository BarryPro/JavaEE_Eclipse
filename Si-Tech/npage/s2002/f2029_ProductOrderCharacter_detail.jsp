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
  String opCode="";
  String opName="中国移动信息化产品";
  String sqlStr="";
%>
<HTML>
<HEAD>
<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
<link href="s2002.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY>
<div id="Main">
<DIV id="Operation_Table">
 <div class="title"><div id="title_zi">产品属性值</div></div>
 <input type="hidden" id="p_POOrderNumber" value="">
 <input type="hidden" id="p_POSpecNumber" value="">
 <input type="hidden" id="p_ProductOrderNumber" value="">
 <input type="hidden" id="p_ProductSpecNumber" value="">
 <input type="hidden" id="p_ParAcceptID" value="">
 <input type="hidden" id="p_AcceptID" value="">
 <input type="hidden" id="p_OprType" value="">
 <input type="hidden" id="action_flag" value="">
 <table>
  <tr>
   <td>产品属性代码   	
   </td>
   <td>
   	   <input id="p_ParameterNumber" type="string" size="20" maxlength="20" readOnly>
   	   <input id="getProductOrderCharacter" type="button" class="b_text" onclick="getProductOrderCharacter()" value="查询">   		   	  
   </td>
   <td>属性值  	
   </td>
   <td>
   	   <input id="p_ParameterValue" type="string" size="20" maxlength="20" readOnly>
   		   	  
   </td>
 	</tr>
  <tr>
   <td>属性名   	
   </td>
   <td colspan="3">
   	   <input id="p_ParameterName" type="string" size="20" maxlength="20" readOnly>   		   	  
   </td>
 	</tr>     
 </table>
<table>
  <tr>
    <td align="center" id="footer" colspan="4">
    	<input class="b_foot" id=confirm type=button value="确认" onClick="">
      <input class="b_foot" id=closebtn type=button value="关闭" onClick="window.close()">
    </td>
  </tr>
</table>
</div>
</div>
<script>
var ProductOrderCharacter;
function ParameterUpdate(){  	
  ProductOrderCharacter[0] = $("#p_ParameterNumber").val();
  ProductOrderCharacter[1] = $("#p_ParameterName").val();
  ProductOrderCharacter[2] = $("#p_ParameterValue").val();
  ProductOrderCharacter[3] = $("#p_POOrderNumber").val();
  ProductOrderCharacter[4] = $("#p_POSpecNumber").val();
  ProductOrderCharacter[5] = $("#p_ProductOrderNumber").val();
  ProductOrderCharacter[7] = $("#p_ProductSpecNumber").val();
  ProductOrderCharacter[8] = $("#p_ParAcceptID").val();
  ProductOrderCharacter[9] = $("#p_AcceptID").val();          
  window.returnValue = "Y";
  window.close();
}

//页面装载
$(document).ready(function () {	 
	  ProductOrderCharacter=window.dialogArguments;
	     	  
	  $("#p_ParameterNumber").val(ProductOrderCharacter[0]);
	  $("#p_ParameterName").val(ProductOrderCharacter[1]);
	  $("#p_ParameterValue").val(ProductOrderCharacter[2]);
	  $("#p_POOrderNumber").val(ProductOrderCharacter[3]);
	  $("#p_POSpecNumber").val(ProductOrderCharacter[4]);
	  
	  $("#p_ProductOrderNumber").val(ProductOrderCharacter[5]);
	 
	  $("#p_ProductSpecNumber").val(ProductOrderCharacter[7]);
	  $("#p_ParAcceptID").val(ProductOrderCharacter[8]);
	  $("#p_AcceptID").val(ProductOrderCharacter[9]);	
	  $("#p_OprType").val(ProductOrderCharacter[10]);	 
	  $("#action_flag").val(ProductOrderCharacter[11]);	
	  if( $("#p_OprType").val()=="1")
	  {
	  	document.all.p_ParameterNumber.readOnly=true;
	  	$("#getProductOrderCharacter").hide();
	  	document.all.p_ParameterName.readOnly=true;
	  	document.all.p_ParameterValue.readOnly=true;
	  	
	  	
	  } 
	  if($("#p_OprType").val()=="2"&&$("#action_flag").val()=="1")
	  {
	  	document.all.p_ParameterNumber.readOnly=true;
	  	$("#getProductOrderCharacter").hide();
	  	document.all.p_ParameterName.readOnly=true;
	  	document.all.p_ParameterValue.readOnly=true;
	  }
	  //注册确认
    $('#confirm').click(function(){
	      ParameterUpdate();
	  });	  	    	 	 	 	    
	});
	
function getProductOrderCharacter(){	  
	  var pageTitle = "";
    var fieldName = "产品属性代码|属性值|属性名|流水|";
    var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "4|0|3|1|2|";

    var retToField = "p_ParameterNumber|p_ParameterValue|p_ParameterName|p_AcceptID|";

    var path = "<%=request.getContextPath()%>/npage/s2002/f2029_getProductCharacter_list.jsp?";
    path = path + "&fieldName="+fieldName;
    path = path + "&selType="+selType;
    path = path + "&retQuence="+retQuence;
    path = path + "&retToField="+retToField;
    path = path + "&sProductSpecNumber=" +$("#p_ProductSpecNumber").val();  
    path = path + "&sPOSpecNumber=" +$("#p_POSpecNumber").val();    

    
    retInfo = window.open(path,
                          "newwindow",
                          "height=400, width=900,top=300,left=350,scrollbars=yes, resizable=no,location=no, status=yes");
    return true;
}

function getProductOrderCharacterRtn(retInfo)
{
    var retToField = "p_ParameterNumber|p_ParameterValue|p_ParameterName|p_AcceptID|";
   
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
}	
</script>
</BODY>
</HTML>
