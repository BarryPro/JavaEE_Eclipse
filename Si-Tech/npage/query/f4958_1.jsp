<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%

  /*
   * ����:�û�����������Ϣ��ѯ
   * �汾: 1.0
   * ����: 2009/8/25
   * ����: dujl
   * ��Ȩ: si-tech
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
    
	String opCode = "4958";
	String opName = "�û�����������Ϣ��ѯ";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--	

onload=function()
{		
	dreset();
}

function dreset()
{
	var iframes = document.getElementsByTagName("iframe");
	for(var i=0;i<iframes.length;i++)
	{
		iframes[i].style.display = "none";	
	}
}

function selQry()
{
	if(document.frm.phoneNo.value.trim()=="")
	{
		rdShowMessageDialog("�������ֻ����룡");
		return;
	}
	if(document.frm.modeCode.value.trim()=="")
	{
		rdShowMessageDialog("������Ӫ������");
		return;
	}
	if(document.frm.selTime.value.trim()=="")
	{
		rdShowMessageDialog("�������ѯʱ�䣡");
		return;
	}
	
	var phone_no = document.frm.phone_no.value;
	var modeCode = document.frm.modeCode.value;
	var selTime = document.frm.selTime.value;
	
	document.getElementById("qryOprInfoFrame").style.display="block"; 
	document.qryOprInfoFrame.location = "f4958qry.jsp?phoneNo="+phone_no+"&modeCode="+modeCode+"&selTime="+selTime;
	
}

function phoQry()
{
	if(document.frm.phoneNo.value.trim()=="")
	{
		rdShowMessageDialog("�������ֻ����룡");
		return;
	}
	var myPacketQry = new AJAXPacket("f4958getqry.jsp","�����ύ�����Ժ�......");
	myPacketQry.data.add("phoneNo",document.frm.phoneNo.value);
	
	core.ajax.sendPacket(myPacketQry);
	myPacketQry=null;
	document.all.phone_no.value = document.all.phoneNo.value;
}

function doProcess(packet)
{
	var backString = packet.data.findValueByName("backString");
	var cfmFlag = packet.data.findValueByName("flag");
	
	if(cfmFlag==8)
	{
		var errCode = packet.data.findValueByName("errCode");
		var errMsg = packet.data.findValueByName("errMsg");
		rdShowMessageDialog("δ��ѯ�������");
		
		resetJsp();
		return;
	}
	
	if(cfmFlag==1)
	{
		var code = packet.data.findValueByName("code");
		var text =  packet.data.findValueByName("text");
		fillSelectAdd(document.all.modeCode,code,text);
	
	}
	
	document.all.phone_no.value = document.all.phoneNo.value;
}

function fillSelectAdd(obj,code,text)
{
	obj.length=0;
	var option0 = new Option("--��ѡ��--","");
	obj.add(option0);
	for(var i=0; i<code.length; i++)
	{
		var option1 = new Option(code[i]+"-->"+text[i],code[i]);
        obj.add(option1);
	}
}

function resetJsp()
{
	document.frm.phoneNo.value="";
	document.frm.modeCode.value="";
	document.frm.selTime.value="";
}

</script> 
 
<title>�û�����������Ϣ��ѯ</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form action="" method="post" name="frm"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="phone_no" value="">
	<input type="hidden" name="getop_code" value="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�û�����������Ϣ��ѯ</div>
	</div>
<table cellspacing="0">
    <tr>
    	<td class="blue" width="15%">�ֻ�����</td>
		<td colspan="3">
			<input name="phoneNo" type="text" class="button" size="20" id="phoneNo"  v_must=1 v_name="�ֻ�����">
			<input type="button" class="b_text" name="phoneQry" value="��ѯ" onClick="phoQry()">
		</td>
  	</tr>
    <tr>
    	<td class="blue">Ӫ����</td>
		<td>
			<select name="modeCode" id="modeCode">
			    <option value="" selected >--��ѡ��--</option>
      		</select>
		</td>
		<td class="blue" width="15%">��ѯʱ��</td>
    	<td width="35%">
    		<input name="selTime" type="text" class="button" maxlength="6" size="20" id="selTime"  v_must=1 v_name="��ѯʱ��"><font color="red">(YYYYMM)</font>
    	</td>
  	</tr>
	<tr>
		<td align="center" id="footer" colspan="4">
			<input type="button" name="select" class="b_foot" value="��ѯ" onclick="selQry()">
			&nbsp;
			<input type="button" name="qryP" class="b_foot" value="�ر�" onclick="parent.removeTab('<%=opCode%>')">
			&nbsp;
			<input type="button" name="reset" class="b_foot" value="���" onclick="resetJsp()">
		</td>
	</tr>
</table>
<div id="oprDiv" style="display:block">
	<table cellspacing="0">
		<tr>
			<td style="height:0;">
				<iframe frameBorder="0" id="qryOprInfoFrame" align="center" name="qryOprInfoFrame" scrolling="yes" style="height:300px;overflow-y:auto; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryOprInfoFrame').style.height=qryOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
			</td>
		</tr>
	</table>
	<table>
		<tr>
			<td style="height:0;">
				<iframe frameBorder="0" id="qryOprAuditInfoFrame" align="center" name="qryOprAuditInfoFrame" scrolling="yes" style="height:300px; overflow-x:auto;overflow-y:auto; visibility:inherit; width:100%; z-index:1; display:none;"  onload="document.getElementById('qryOprInfoFrame').style.height=qryOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
			</td>
		</tr>
	</table>
</div>
	 <%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>
