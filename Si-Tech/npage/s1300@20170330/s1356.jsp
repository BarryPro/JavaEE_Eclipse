<%
/********************
 version v2.0
 ������: si-tech
 ģ�飺����.���ʻ��ջ���
 update zhaohaitao at 2008.12.29
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>	
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.util.*"%>

 
<%
	String opCode = request.getParameter("opCode");
  	String opName = request.getParameter("opName");
  	String flag1 = "";
  	String flag2 = "";
  	if(opCode.equals("1356")){
  		flag1="checked";
  	}else{
  		flag2="checked";
  	}
   
	String belongName = (String)session.getAttribute("orgCode");
	String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
%>

<HEAD><TITLE>������BOSS-����.���ʻ��ջ���</TITLE>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<script language="JavaScript">

function form_load()
{
	getBeforePrompt("<%=opCode%>");
	form.sure.disabled=true;
	document.form.billdate.focus();
	var op_code = "<%=opCode%>";
	if(op_code=="1356"){
		document.form.busyType.value = "1";
	}else{
		document.form.busyType.value = "2";
	}	
}

function docheck()
{
		//getAfterPrompt(document.form.op_code.value);
		if(form.billdate.value=="")
		{	
			rdShowMessageDialog("�������ڲ���Ϊ�գ�<br>������YYYYMMDD��ʽ�����ڣ�");
			document.form.billdate.select();
			return false;
		}

       if (!forDate(form.billdate.value))
       {
		  rdShowMessageDialog("��������ʱ���ʽ����! <br>ӦΪ��YYYYMMDD ");
		  form.billdate.focus();
		  return false;
        }
		
		if(form.water_number.value=="")
		{
			rdShowMessageDialog("�ɷ���ˮ����Ϊ�գ�");
			document.form.water_number.select();
			return false;	
		}
 		document.form.action="s1356_2.jsp";
 		
		form.submit();
 
}
function sel1()
{
	document.form.busyType.value = "1";
	document.form.op_code.value="1356";
	document.all.billdate.focus();
	getBeforePrompt("1356");
}
function sel2()
{
	document.form.busyType.value = "2";
	document.form.op_code.value="1360";
	document.all.billdate.focus();
	getBeforePrompt("1360");
}
function getBeforePrompt(op_code)
{
	var packet = new AJAXPacket("/npage/include/getBeforePrompt.jsp","���Ժ�...");
	packet.data.add("opCode" ,op_code);
  core.ajax.sendPacketHtml(packet,doGetBeforePrompt,true);//�첽
	packet =null;
}

function doGetBeforePrompt(data)
{
	$('#wait').hide();
	$('#beforePrompt').html(data);
}
function getAfterPrompt(op_code)
{
	var packet = new AJAXPacket("/npage/include/getAfterPrompt.jsp","���Ժ�...");
	packet.data.add("opCode" ,op_code);
  core.ajax.sendPacket(packet,doGetAfterPrompt,false);//ͬ��
	packet =null;
}

function doGetAfterPrompt(packet)
{
var retCode = packet.data.findValueByName("retCode"); 
var retMsg = packet.data.findValueByName("retMsg"); 
if(retCode=="000000"){
	promtFrame(retMsg);
}
}
</script>

</HEAD>
<BODY onLoad="form_load();">
<FORM action="s1356_2.jsp" method=post name="form">
	<%@ include file="/npage/include/header.jsp" %>  
	
	<div class="title">
		<div id="title_zi">�ͻ���Ϣ</div>
	</div>
<INPUT TYPE="hidden" name="busyType" value="1">
<INPUT TYPE="hidden" name="opCode" value="<%=opCode%>">
<INPUT TYPE="hidden" name="opName" value="<%=opName%>">
<INPUT TYPE="hidden" name="op_code" value="<%=opCode%>">
<table cellspacing="0">
	<tr> 
	  	<td class="blue">��������</td>
	<td> 
		<input name="busy"  type="radio" value="1" <%=flag1%> onclick="sel1()">���ʻ��ջ��� 
		<input type="radio" name="busy"  value="2" <%=flag2%> onclick="sel2()">���ʻ��ջ���
	</td>
		<td class="blue">����</td>
		<td><%=belongName%></td>
	</tr>
	<tr> 
		<td class="blue">��������</td>
		<td> 
			<input type="text" name="billdate" value="<%=dateStr%>" onkeydown="if(event.keyCode==13) document.form.water_number.focus();">
		</td>
		<td class="blue">�ɷ���ˮ</td>
		<td> 
			<input type="text" name="water_number" onKeyPress="return isKeyNumberdot(0)" onkeydown="if(event.keyCode==13) docheck();">
			<input name=sure22 type=button class="b_text" value=��ѯ onClick="docheck();">
		</td>
	</tr>
	<tr> 
		<td class="blue">�����ʻ�</td>
		<td> 
			<input type="text" readonly name="textfield4" class="InputGrey">
		</td>
		<td class="blue">��������</td>
		<td> 
			<input type="text" readonly name="textfield5" class="InputGrey">
		</td>
	</tr>
	<tr> 
	  <td class="blue">�û�����</td>
	  <td> 
		  <input type="text" readonly name="textfield7" class="InputGrey">
	  </td>
	  <td class="blue">���˽��</td>
	  <td> 
	      <input type="text" readonly name="textfield8" class="InputGrey">
	  </td>
	</tr>
	<tr> 
	  <td class="blue">�û�����</td>
	  <td> 
	      <input type="text" readonly name="textfield6" class="InputGrey">
	  </td>
	  <td class="blue">�ɷ�ʱ��</td>
	  <td> 
	      <input type="text" readonly name="paytime" class="InputGrey">
	  </td>
	</tr>
</table>
</div>

<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">�ɷ���Ϣ</div>
</div>
<table cellspacing="0">
	<tr> 
		<th> 
			<div align="center">�������</div>
		</th>
		<th> 
			<div align="center">�ɷѽ��</div>
		</th>
		<th> 
			<div align="center">Ԥ���</div>
		</th>
		<th> 
			<div align="center">����</div>
		</th>
		<th> 
			<div align="center">���ɽ�</div>
		</th>
	</tr>
	<tr> 
		<td class="blue">�˷ѽ��</td>
		<td colspan="4"> 
			<input class="InputGrey" readonly name=remark2>
		</td>
	</tr>
	<tr style="display:none"> 
		<td class="blue">�û���ע</td>
		<td colspan="4"> 
			<input name=remark size="30">
		</td>
	</tr>
	<tr> 
		<td id="footer" colspan="5"> 
			<input class="b_foot" name=sure type="button" value="ȷ��" onclick="docheck()">
			<input class="b_foot" name=reset type="button" value="�ر�" onclick="removeCurrentTab()">
		</td>
	</tr>
</table>
	<div id="relationArea" style="display:none"></div>
				<div id="wait" style="display:none">
				<img  src="/nresources/default/images/blue-loading.gif" />
			</div>
			<div id="beforePrompt"></div>
		</DIV>               
  <%@ include file="/npage/include/footer_simple.jsp" %>
</FORM>
 </BODY>
 </HTML>
