<%
/********************
 version v2.0
 ������: si-tech
 update sunaj at 2009.9.8
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%
  request.setCharacterEncoding("GBK");
%>
<html>
<head>
<title>TD�޸�IMEI�󶨹�ϵ</title>
<%
	
    String opCode = "7634";
    String opName = "TD�޸�IMEI�󶨹�ϵ";
	String loginNo = (String)session.getAttribute("workNo");
	String orgCode = (String)session.getAttribute("orgCode");
  	String regionCode = (String)session.getAttribute("regCode");    
%>		
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>

function controlButt(subButton)
{
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
}

//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
	if(document.frm.srv_no.value.substring(0, 3)!='157'&&document.frm.srv_no.value.substring(0, 3)!='184' && document.frm.srv_no.value.substring(0, 3)!='451' && document.frm.srv_no.value.substring(0, 3)!='045' && document.frm.srv_no.value.substring(0, 3)!='046' && document.frm.srv_no.value.substring(0, 3)!='147')
	{
		rdShowMessageDialog("ֻ��451��045��046�Ŷκ�147��157��184���ֺŶε��û����ܰ����ҵ��");
  		return false;
  	}
	if(isNaN(document.frm.srv_no.value.trim()))
	{
		 rdShowMessageDialog("�ֻ���������������!");
		 return false;
	}
	if(document.frm.srv_no.value.trim().length>=0 && document.frm.srv_no.value.trim().length !=11)
	{
	   rdShowMessageDialog("�ֻ�����λ������ȷ������������!");
	   document.frm.srv_no.value="";
	   document.frm.srv_no.focus();
	   return false;
	}
	// add by wanglm 20101119 �ж�147 ���εĵ绰���Ƿ�Ϊ TD�̻� start
	if(document.frm.srv_no.value.substring(0,3) =='147'){
	   	var packet = new AJAXPacket("/npage/bill/check147SuperTD.jsp","������֤�����Ժ󡣡���");
	    packet.data.add("phoneNo",document.frm.srv_no.value);
	    core.ajax.sendPacket(packet,doPro);
	    packet =null;
	}
	// add by gaopeng 20120917 �ж�157 ���εĵ绰���Ƿ�Ϊ TD�̻� start
	if(document.frm.srv_no.value.substring(0,3) =='157'){
	   	var packet = new AJAXPacket("/npage/bill/check157SuperTD.jsp","������֤�����Ժ󡣡���");
	    packet.data.add("phoneNo",document.frm.srv_no.value);
	    core.ajax.sendPacket(packet,doPro);
	    packet =null;
	}
	// add by gaopeng 2014/12/12 17:26:41 �ж�184 ���εĵ绰���Ƿ�Ϊ TD�̻� start
	if(document.frm.srv_no.value.substring(0,3) =='184'){
	   	var packet = new AJAXPacket("/npage/bill/check184SuperTD.jsp","������֤�����Ժ󡣡���");
	    packet.data.add("phoneNo",document.frm.srv_no.value);
	    core.ajax.sendPacket(packet,doPro);
	    packet =null;
	}
	else{
	    document.frm.action="f7634_2.jsp"
	    frm.submit();
	    document.frm.confirm.disabled=true;
	    return true;	
	}
  	//controlButt(subButton); //��ʱ���ư�ť�Ŀ�����
}
  function doPro(packet){
		var result = packet.data.findValueByName("result");
		if(result == "false"){
			rdShowMessageDialog("�ֻ����벻��TD�̻�����!");
			document.frm.srv_no.value="";
	        document.frm.srv_no.focus();
			return false;
		}
		document.frm.action="f7634_2.jsp"
	    frm.submit();
	    document.frm.confirm.disabled=true;
	    return true;
	}
	// add by wanglm 20101119 �ж�147 ���εĵ绰���Ƿ�Ϊ TD�̻� end
</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>    	
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table cellspacing="0">    
	<tr>  	
		<td class="blue">�ֻ�����</td>
		<td>
			<input type="text" name="srv_no" id="srv_no"  maxlength="11" v_type="mobphone" v_must=1 index="0">
			<font color="orange">*</font>
		</td>
	</tr>  
	<tr> 
		<td colspan="4" id="footer"> 
		<div align="center"> 
			<input class="b_foot" type="button" name="confirm" value="ȷ��" onClick="doCfm(this);">   
			<input class="b_foot" type="button" name="back" value="���" onClick="frm.reset();">
			<input class="b_foot" type="button" name="qryP" value="�ر�" onClick="removeCurrentTab();">
		</div>
		</td>
	</tr>
	</table>
  
<input type="hidden" name="opCode" value="<%=opCode%>" >
<input type="hidden" name="opName" value="<%=opName%>" >
 <%@ include file="/npage/include/footer_simple.jsp" %>        
   </form>
   
</body>
</html>