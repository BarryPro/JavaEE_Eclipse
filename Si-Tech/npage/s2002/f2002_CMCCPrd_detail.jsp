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
	<input type="hidden" id=p_Action value="" >
 <div class="title"><div id="title_zi">中国移动信息化产品</div></div>
 <table>
  <tr>
  	<td>
   	中国移动信息化产品
   </td>
   <td>
 	  <input id="p_CMCCPrd" type="string" size="20" maxlength="20">
 	  <input id="p_CustomerProvinceNumber" type="hidden" value="">
 	  <input id="p_ExtInfoAcceptID" type="hidden" value="">
    <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="01"  id="seq"/>
 	  <input id="p_CMCCPrdAcceptID" type="hidden" value="<%=seq%>"> 	   	  
   </td>
 	</tr>
 </table>
 <br>

<table>
  <tr>
    <td align="center" id="footer" colspan="4">
    	<input class="b_foot" id=confirm type=button value="确认" onClick="">

    </td>
  </tr>
</table>

</div>
</div>
<script>
var CMCCPrd;
//确认更新操作
function CMCCPrdConfirm(){
   if($("#p_CMCCPrd").val()=="")
  {
  			rdShowMessageDialog("中国移动信息化产品不能为空!");	
    		return;
  }	
  CMCCPrd[0] = $("#p_CMCCPrd").val();
  CMCCPrd[1] = $("#p_CustomerProvinceNumber").val();
  CMCCPrd[2] = $("#p_ExtInfoAcceptID").val();
  CMCCPrd[3] = $("#p_CMCCPrdAcceptID").val();           
  window.returnValue="Y";
  window.close();
}
//页面装载
$(document).ready(function () {
	  CMCCPrd=window.dialogArguments;  
	  	  
	  $("#p_CMCCPrd").val(CMCCPrd[0].trim());
	  $("#p_CustomerProvinceNumber").val(CMCCPrd[1].trim());
	  $("#p_ExtInfoAcceptID").val(CMCCPrd[2].trim());	
	  
	  $("#p_Action").val(CMCCPrd[5].trim()); 
	  if( $("#p_Action").val()=="1")
	  {
	  	document.all.p_CMCCPrd.readOnly=false;
	  }
	  if($("#p_Action").val()=="2")
	  {
	  	document.all.p_CMCCPrd.readOnly=false;
	   }
	   if($("#p_Action").val()=="3")
	  {
	  	document.all.p_CMCCPrd.readOnly=false;
	   }
	  if(CMCCPrd[3]!="0")
	  {
	     $("#p_CMCCPrdAcceptID").val(CMCCPrd[3].trim());	
	  }
    //注册确认
    $('#confirm').click(function(){
	      CMCCPrdConfirm();
	  });
	}
);
</script>
</BODY>
</HTML>
