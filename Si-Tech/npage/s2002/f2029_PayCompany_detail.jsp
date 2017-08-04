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
  String opName="支付省";
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
 <div class="title"><div id="title_zi">支付省</div></div>
 <input type="hidden" id="p_POSpecNumber" value="">
 <input type="hidden" id="p_POOrderNumber" value="">
 <input type="hidden" id="p_ProductOrderNumber" value="">
 <input type="hidden" id="p_ProductSpecNumber" value="">
 <input type="hidden" id="p_ParAcceptID" value="">
 <input type="hidden" id="p_AcceptID" value="">
 <input type="hidden" id="p_OprType" value="">
 <input type="hidden" id="action_flag" value="">
 <table>
  <tr>
   <td>支付省编码   	
   </td>
   <td>
   	   <input id="p_PayCompanyID" type="string" size="20" maxlength="20" readonly>
   	   <input id="getPayCompanyID" type="button" class="b_text" onclick="getPayCompanyID()" value="查询">
   </td>
   <td>支付省名称   	
   </td>
   <td>
   	   <input id="p_PayCompanyName" type="string" size="20" maxlength="20" readonly>   		   	  
   </td>      
 	</tr>
 </table>
<br>
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
var payCompany;

$(document).ready(function () {		
	$('#nextoper').click(function(){
     nextoper();
  });

  }
);

function ConfirmCheck(){
  payCompany[0]  = $("#p_PayCompanyID").val();      //0
  payCompany[1]  = $("#p_PayCompanyName").val();    //1
  payCompany[2]  = $("#p_POOrderNumber").val();     //2
  payCompany[3]  = $("#p_POSpecNumber").val();      //3
  payCompany[4]  = $("#p_ProductOrderNumber").val();//4 
  payCompany[6]  = $("#p_ProductSpecNumber").val(); //6
  payCompany[7]  = $("#p_ParAcceptID").val();       //7
  payCompany[8]  = $("#p_AcceptID").val();          //8
  window.returnValue = "Y";
  window.close();
}

//页面装载
$(document).ready(function () {
	  payCompany=window.dialogArguments;	   	  	  	  
	  $("#p_PayCompanyID").val(payCompany[0]);
	  $("#p_PayCompanyName").val(payCompany[1]);	  	  
	  $("#p_POOrderNumber").val(payCompany[2]);
	  $("#p_POSpecNumber").val(payCompany[3]);	
	  $("#p_ProductOrderNumber").val(payCompany[4]);
	  $("#p_ProductSpecNumber").val(payCompany[6]);
	  $("#p_ParAcceptID").val(payCompany[7]);
	  $("#p_AcceptID").val(payCompany[8]);
	  $("#p_OprType").val(payCompany[9]);
	  $("#action_flag").val(payCompany[10]);
	  if($("#p_OprType").val()=="1")
	  {
	  	document.all.p_PayCompanyID.readOnly=true;
	  	$("#getPayCompanyID").hide();
	  	document.all.p_PayCompanyName.readOnly=true;
	  	
	  	
	   }
	  //注册确认
    $('#confirm').click(function(){
       ConfirmCheck();
    });		     
	}
);

function getPayCompanyID(){	  
	  var pageTitle = "";
    var fieldName = "支付省编码|支付省名称|流水|";
    var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "3|0|1|2|";

    var retToField = "p_PayCompanyID|p_PayCompanyName|p_AcceptID|";

    var path = "<%=request.getContextPath()%>/npage/s2002/f2029_getPayCompany_list.jsp?";
    path = path + "&fieldName="+fieldName;
    path = path + "&selType="+selType;
    path = path + "&retQuence="+retQuence;
    path = path + "&retToField="+retToField;
    path = path + "&sPOSpecNumber=" +$("#p_POSpecNumber").val();    

    retInfo = window.open(path,
                          "newwindow",
                          "height=400, width=700,top=300,left=350,scrollbars=yes, resizable=no,location=no, status=yes");
    return true;
}

function getPayCompanyIDRtn(retInfo)
{
    var retToField = "p_PayCompanyID|p_PayCompanyName|p_AcceptID|";
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
