<%
/********************
 version v2.0
������: si-tech
*
*add :huangqi IMS��Ŀ������ sFixCodeNew �����ý���
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%
		String opCode = "zg50";
		String opName = "sFixCodeNew�Ŷ�����";
		String orgCode     = (String)session.getAttribute("orgCode");
		String regionCode  = orgCode.substring(0,2);
		String workno      = (String)session.getAttribute("workNo");
		String workname    = (String)session.getAttribute("workName");
		String nopass      = (String)session.getAttribute("password");
		String[] inParas2 = new String[2];
		inParas2[0]="select to_char(d.region_name)  from dloginmsg a ,dchngroupinfo b ,schnregionlist c ,sregioncode d where a.group_id = b.group_id and b.parent_group_id = c.group_id and c.group_id = d.group_id and a.login_no = :login_no";
		inParas2[1]="login_no="+workno;
		String reginName="";
%>
	<wtc:service name="TlsPubSelCrm" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=inParas2[0]%>"/>
	<wtc:param value="<%=inParas2[1]%>"/>	
	</wtc:service>
	<wtc:array id="ret_val" scope="end" />
		
<%
	if(ret_val!=null&&ret_val.length>0)
	{
		reginName = ret_val[0][0];
	}
%>

<HTML>
<HEAD>
<script language="JavaScript">
 function inits()
 {
	 //alert("orgCode is "+"<%=orgCode%>"+" and regionCode is "+"<%=regionCode%>");
	 document.getElementById("configType").value="0";
 }
 
 //����configType��ѡ����չʾ��ͬtable
function checkConfigType(configType){
	if("2"==configType){
		document.getElementById("dantiao").style.display="none";
		document.getElementById("piliang").style.display="block";
	}
	else if("1"==configType){
		document.getElementById("dantiao").style.display="block";
		document.getElementById("piliang").style.display="none";
	}	
	document.all.haoduan.value="";
	document.all.hdStart.value="";
	document.all.hdEnd.value="";
		document.all.note.value="";
	
}
 function docheck()
 {
 var configType=document.getElementById("configType");
// 	alert(configType.value);
 	if(configType.value==0)
	{
		rdShowMessageDialog("��ѡ���������ͣ�");
		return false;
	}
	
	if(configType.value=="1"){
			var s_login_no =  document.all.s_login_no.value;
			var haoduan = document.all.haoduan.value;
			if(haoduan=="")
			{
				rdShowMessageDialog("������ŶΣ�");
				document.all.haoduan.focus();
				return false;
			}else
			{
				document.frm.action="zg50_2.jsp";
			 	document.frm.submit();
			}
	}else if(configType.value=="2"){
			var s_login_no =  document.all.s_login_no.value;
			var hdStart = document.all.hdStart.value;
			var hdEnd = document.all.hdEnd.value;
			var hdStartStr=hdStart.substring(0,6);
			var hdEndStr=hdEnd.substring(0,6);
			var endno=new Number(hdEnd);
			var startno=new Number(hdStart);
			if(hdStart=="")
			{
				rdShowMessageDialog("��������ʼ�ŶΣ�");
				document.all.hdStart.focus();
				return false;
			}else if(hdEnd=="")
			{
				rdShowMessageDialog("����������ŶΣ�");
				document.all.hdEnd.focus();
				return false;
			}else if(hdEndStr!=hdStartStr)
			{
				rdShowMessageDialog("��ʼ�Ŷ�ǰ��λ����������Ŷ�ǰ��λһ�£�");
				document.all.hdSrart.focus();
				return false;
			}else if(startno>endno)
			{
				rdShowMessageDialog("�����Ŷε���ֵ���������ʼ�ŶΣ�");
				document.all.hdEnd.focus();
				return false;
			}else
			{
				document.frm.action="zg50_2.jsp";
			 	document.frm.submit();
			}
	}

 
 }
 
  function doclear() {
 		frm.reset();
 }

 </script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY onload="inits()">
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	<div class="title">
			<div id="title_zi">������Ŷ�</div>
		</div>
	<table cellspacing="0">
	

		<tr>
			<td class="blue" >��������</td>
      <td colspan=5> 
        <select id="configType" name="configType" onchange="checkConfigType(this.value)">
					<option value="0" selected>--��ѡ��</option>
					<option value="1" >�Ŷε�������</option>
					<option value="2" >�Ŷ���������</option>
				</select> 
      </td>
    </tr>
<TBody id="dantiao">
	<tr >
		<td class="blue">�Ŷ�</td>
      <td> 
        <input type="text" name="haoduan" size="20" maxlength="9" onKeyPress="return isKeyNumberdot(1)" >
      </td>
      	<td class="blue"></td>
      		<td></td>
	</tr>
</TBody>
<TBody id="piliang" style="display:none;">
<tr >
		<td class="blue">��ʼ�Ŷ�</td>
      <td> 
        <input type="text" name="hdStart" size="20" maxlength="9" onKeyPress="return isKeyNumberdot(1)" >
      </td>
    <td class="blue">�����Ŷ�</td>
       <td> 
        <input type="text" name="hdEnd" size="20" maxlength="9" onKeyPress="return isKeyNumberdot(1)" >
      </td>
	</tr>
</TBody>
<tr >
		<td class="blue">������</td>
      <td colspan=5> 
        <input type="text" name="note" size="50" maxlength="128"  >
      </td>
	</tr>
<tr >
      <td class="blue" width="15%">���ù���</td>
      <td> 
        <input class="button"type="text" name="s_login_no" size="20" maxlength="12"  value="<%=workno%>" readonly >
      </td>
      <td class="blue">���õ���</td>
      <td colspan=3> 
      	  <input class="button" type="text" name="pzdsname" size="20" maxlength="12"  value="<%=reginName%>" readonly >
      </td>
      
    </tr>
  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="ȷ��" onclick="docheck()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="����" onclick="doclear()" >
          &nbsp;
		      <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
      </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>