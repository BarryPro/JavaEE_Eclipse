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
  String opName="�й��ƶ���Ϣ����Ʒ";
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
 <div class="title"><div id="title_zi">�й��ƶ���Ϣ����Ʒ</div></div>
 <table>
  <tr>
  	<td>
   	�й��ƶ���Ϣ����Ʒ
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
    	<input class="b_foot" id=confirm type=button value="ȷ��" onClick="">

    </td>
  </tr>
</table>

</div>
</div>
<script>
var CMCCPrd;
//ȷ�ϸ��²���
function CMCCPrdConfirm(){
   if($("#p_CMCCPrd").val()=="")
  {
  			rdShowMessageDialog("�й��ƶ���Ϣ����Ʒ����Ϊ��!");	
    		return;
  }	
  CMCCPrd[0] = $("#p_CMCCPrd").val();
  CMCCPrd[1] = $("#p_CustomerProvinceNumber").val();
  CMCCPrd[2] = $("#p_ExtInfoAcceptID").val();
  CMCCPrd[3] = $("#p_CMCCPrdAcceptID").val();           
  window.returnValue="Y";
  window.close();
}
//ҳ��װ��
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
    //ע��ȷ��
    $('#confirm').click(function(){
	      CMCCPrdConfirm();
	  });
	}
);
</script>
</BODY>
</HTML>
