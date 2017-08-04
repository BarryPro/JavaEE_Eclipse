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
 <div class="title"><div id="title_zi">成员信息</div></div>
 <input type="hidden" id="p_POOrderNumber" value="">
 <input type="hidden" id="p_POSpecNumber" value="">
 <input type="hidden" id="p_ProductOrderNumber" value=""> 
 <table>
  <tr>
   <td>订单来源   	
   </td>
   <td>
   	   <input id="p_ParameterNumber" type="string" size="20" maxlength="20" readOnly>   		   	  
   </td>
   <td>成员号码  	
   </td>
   <td>
   	   <input id="p_ParameterName" type="string" size="20" maxlength="20" readOnly>
   		   	  
   </td>
 	</tr>
  <tr>
   <td>成员类型   	
   </td>
   <td >
   	   <input id="p_ParameterValue" type="string" size="20" maxlength="20" readOnly>   		   	  
   </td>
   <td>成员群组号  	
   </td>
   <td >
   	   <input id="p_Membergroup" type="string" size="20"  readOnly>   		   	  
   </td>
 	</tr>   
 	<tr>
   <td>生效时间  	
   </td>
   <td colspan="3">
   	   <input id="p_effdate" type="string" size="20" maxlength="20" readOnly>   		   	  
   </td>
   
 	</tr>      
 </table>
<br>  
<DIV id="div0_show"   class="groupItem">
   <DIV class="title">
	    <DIV id="zi"><img id="div0_switch" class="closeEl" src="../../../nresources/default/images/jia.gif" style='cursor:hand' width="15" height="15"  ></DIV>
   	  <DIV id="zi0">成员属性列表</DIV>
   </DIV>
   <DIV class="itemContent" id="mydiv0">
	 	  <DIV id="wait0"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30">
	 	  </DIV>
   </DIV>
</DIV>
<table>
  <tr>
    <td align="center" id="footer" colspan="4">
    	<input class="b_foot" id=confirm type=button value="确认" onClick="window.close()">
      <input class="b_foot" id=closebtn type=button value="关闭" onClick="window.close()">
    </td>
  </tr>
</table>
</div>
</div>
<script>
var ProductOrderCharacter;

	var _jspPage =
	{"div0_switch":["mydiv0","f2034_MemberCharacters_list.jsp","f"]
	};
	function hiddenSpider()
	{
		document.getElementById("mydiv0").style.display='none';
	}

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
  		   		$("#"+tmp2[0]).load(tmp2[1],{sProductOrderNumber:$("#p_ProductOrderNumber").val()
  		   			                         ,sMemberNo:$("#p_ParameterName").val()});
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


//页面装载
$(document).ready(function () {	 
	  ProductOrderCharacter=window.dialogArguments;    	  	  	  
	  $("#p_ParameterNumber").val(ProductOrderCharacter[0]);
	  $("#p_ParameterName").val(ProductOrderCharacter[1]);
	  $("#p_ParameterValue").val(ProductOrderCharacter[2]);
	  $("#p_Membergroup").val(ProductOrderCharacter[3]);
	  $("#p_effdate").val(ProductOrderCharacter[4]);
	  $("#p_ProductOrderNumber").val(ProductOrderCharacter[5]);
	  //隐藏进度条
	  hiddenSpider();
	  $('img.closeEl').bind('click', toggleContent);	 	    
	});
</script>
</BODY>
</HTML>
