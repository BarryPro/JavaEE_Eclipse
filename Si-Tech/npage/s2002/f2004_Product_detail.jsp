<%
   /*
   * ����: ���ⷴ��
�� * �汾: v1.0
�� * ����: 2008��10��25��
�� * ����: piaoyi
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
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
  String opName="��Ʒ��������Ϣ";
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

	
 <div class="title"><div id="title_zi">��Ʒ��������Ϣ</div></div>
 <input type="hidden" id="p_POSpecNumber" value="">
 
 <table>
  <tr>
   <td>��Ʒ�����   	
   </td>
   <td>
   	   <input id="p_ProductSpecNumber" type="string" size="20" maxlength="20">   		   	  
   </td>
   <td>��Ʒ�������   	
   </td>
   <td>
   	   <input id="p_ProductSpecName" type="string" size="20" maxlength="20">
   		   	  
   </td>
 	</tr>
  <tr>
  	<!--      wuxy alter 
   <td>��Ʒ����   	
   </td>
   <td>
   	   <input id="p_ProductType" type="string" size="20" maxlength="20">   		   	  
   </td>
   -->
   <td>��Ʒ���״̬   	
   </td>
   <td>
   	   <input id="p_Status" type="string" size="20" maxlength="20">
   		   	  
   </td>
   <!--        wuxy alter 
 	</tr>
  <tr>
   -->
   <td>��Ʒ����   	
   </td>
   <td colspan="3">
   	   <input id="p_Description" type="string" size="20" maxlength="20">   		   	  
   </td>
 	</tr> 	 	 	 	
 </table>
<br>  
 <DIV id="div0_show"   class="groupItem">
   <DIV class="title">
	    <DIV id="zi"><img id="div0_switch" class="closeEl" src="../../../nresources/default/images/jia.gif" style='cursor:hand' width="15" height="15"></DIV>
   	  <DIV id="zi0">��Ʒ���ʷ��б�</DIV>
   </DIV>
   <DIV class="itemContent" id="mydiv0">
	 	  <DIV id="wait0"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30">
	 	  </DIV>
   </DIV>
</DIV>


 <DIV id="div1_show"   class="groupItem">
   <DIV class="title">
	    <DIV id="zi"><img id="div1_switch" class="closeEl" src="../../../nresources/default/images/jia.gif" style='cursor:hand' width="15" height="15"></DIV>
   	  <DIV id="zi0">��Ʒ�����б�</DIV>
   </DIV>
   <DIV class="itemContent" id="mydiv1">
	 	  <DIV id="wait1"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30">
	 	  </DIV>
   </DIV>
</DIV>

 <DIV id="div2_show"   class="groupItem">
   <DIV class="title">
	    <DIV id="zi"><img id="div2_switch" class="closeEl" src="../../../nresources/default/images/jia.gif" style='cursor:hand' width="15" height="15"></DIV>
   	  <DIV id="zi0">������Ʒ�б�</DIV>
   </DIV>
   <DIV class="itemContent" id="mydiv2">
	 	  <DIV id="wait2"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30">
	 	  </DIV>
   </DIV>
</DIV>


<table>
  <tr>
    <td align="center" id="footer" colspan="4">
    	<input class="b_foot" id=confirm type=button value="ȷ��" onClick="window.close()">
      <input class="b_foot" id=closebtn type=button value="�ر�" onClick="window.close()">
    </td>
  </tr>
</table>
</div>
</div>
<script>
var CMCCPrd;

var _jspPage =
{"div0_switch":["mydiv0","f2004_ProductRatePlans_list.jsp","f"]
,"div1_switch":["mydiv1","f2004_ProductSpecCharacters_list.jsp","f"]
,"div2_switch":["mydiv2","f2004_ProductSpecRelation_list.jsp","f"]
};
function hiddenSpider()
{
	document.getElementById("mydiv0").style.display='none';
	document.getElementById("mydiv1").style.display='none';
	document.getElementById("mydiv2").style.display='none';
}

$(document).ready(function () {
	//���ؽ�����
	hiddenSpider();
	$('img.closeEl').bind('click', toggleContent);
	$('#nextoper').click(function(){
     nextoper();
  });

  }
);

var toggleContent = function(e)
{
	var targetContent = $( 'DIV.itemContent',this.parentNode.parentNode.parentNode);
	if (targetContent.css('display') == 'none') {  	  
		   targetContent.slideDown(300);
		   $(this).attr({ src: "../../../nresources/default/images/jian.gif"});
		   //���÷���
		   try{
		   	var tmp = $(this).attr('id');
		   	var tmp2 = eval("_jspPage."+tmp);
		   	if(tmp2[2]=="f"&&tmp2[1]!=''&&tmp2[1]!=undefined)
		   	{  		   		
		   		$("#"+tmp2[0]).load(tmp2[1],{sPOSpecNumber:$("#p_POSpecNumber").val()
		   			                          ,sProductSpecNumber:$("#p_ProductSpecNumber").val()
		   			                          });
		   		tmp2[2]="t";
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

//ҳ��װ��
$(document).ready(function () { 
	  var ProductSpec=window.dialogArguments;	  
	  $("#p_ProductSpecNumber").val(ProductSpec[0]);  
	  $("#p_ProductSpecName").val(ProductSpec[1]);	  
	  $("#p_ProductType").val(ProductSpec[2]);	  
	  $("#p_Status").val(ProductSpec[3]);
	  $("#p_Description").val(ProductSpec[4]);
	  $("#p_POSpecNumber").val(ProductSpec[5]);
	}
);
</script>
</BODY>
</HTML>
