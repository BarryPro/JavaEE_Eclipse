<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * ����: ��½���ù�������
�� * �汾: 1.0.0
�� * ����: 2009/04/11
�� * ����: fangyuan
�� * ��Ȩ: sitech
	 * update: yinzx 0715 �ͷ�����  1.�޸�opName���޸�opCode='K099'
	 *															2.�淶��ʽ�ĵ��� 3.�޸����У�鷽��
	 * 					 
	 * modify by yinzx 20091006 
��*/
%>
<%
	String opCode = "K099";
	String opName = "��½���ù�������";
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
  /*midify by guozw 20091114 ������ѯ�����滻*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

	String login_no ="";
	String tmpPasswd ="";
	//���ݿ��м�¼�������ı��
	boolean isExistFlag = false;
 
	 
	if(request.getParameter("login_no")!=null){
		login_no = (String)request.getParameter("login_no");
	}
	String subccno = (String)request.getParameter("subccno");
	String sql="select a.password from DLOGINCFG a where a.login_no=:login_no and a.subccno=:subccno";
	myParams = "login_no="+login_no + ",subccno="+subccno;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
		<wtc:param value="<%=sql%>"/>
		<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />

<%
	if(result.length>0){
		isExistFlag = true;		
		tmpPasswd = result[0][0];
	} 
%>	

<html>
<head>
<title><%=opName%></title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">
<script>
	
var flag = <%=isExistFlag%>;

window.onload=function(){
	var serv = document.getElementById("subccno");
	var subccno = <%=subccno%>;
	
	toggle_button(flag);	
	if(subccno != undefined && subccno != null){
		serv.selected=false;
		serv.options[subccno-1].selected=true;
	}
}

//add by hucw,20100904
function toggle_button(flag){	
	if(!flag){
			$("#table_2 input:first").show();
			$("#table_2 input:gt(0)").hide();
	}else{
			$("#table_2 input:first").hide();
			$("#table_2 input:gt(0)").show();
	}
}
	
//�޸Ļص�
function handleUpd(packet){
	var retCode = packet.data.findValueByName("retCode");	
	if(retCode=="000000"){
		rdShowMessageDialog("���óɹ�!",2);
		flag=true;
		toggle_button(flag);
	}else{
		rdShowMessageDialog("����ʧ��!",0);
		return false;
	}
}
//�޸�
function doUpd(){		
	if(doCheck()==false) return;
	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/config/logincfg_update.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("login_no", document.getElementById("login_no").value);
	packet.data.add("subccno", document.getElementById("subccno").value);
	packet.data.add("passwd", document.getElementById("passwd").value);
	core.ajax.sendPacket(packet,handleUpd,true);
	packet =null;
}

//����ص�
function handleInsert(packet){
	var retCode = packet.data.findValueByName("retCode");	
	if(retCode=="000000"){
		rdShowMessageDialog("���óɹ�!",2);
		flag=true;
		toggle_button(flag);
	}else{
		rdShowMessageDialog("����ʧ��!",0);
		return false;
	}
}
//����
function doInsert(){	
	if(doCheck()==false) return;
	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/config/logincfg_insert.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("login_no", document.getElementById("login_no").value);
	packet.data.add("passwd", document.getElementById("passwd").value);
	//add by hucw,20100618,dlogincfg����ʱ��������ֶ�
	packet.data.add("subccno",document.getElementById("subccno").value);
	core.ajax.sendPacket(packet,handleInsert,true);
	packet =null;
}

//ɾ��
function doDel(){	
	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/config/logincfg_del.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("login_no", document.getElementById("login_no").value);
	packet.data.add("passwd", document.getElementById("passwd").value);
	packet.data.add("subccno", document.getElementById("subccno").value);
	core.ajax.sendPacket(packet,handleDel,true);
	packet =null;
}


//ɾ���ص�
function handleDel(packet){
	var retCode = packet.data.findValueByName("retCode");	
	if(retCode=="000000"){
		rdShowMessageDialog("ɾ���ɹ�!",2);
		flag=false;
		toggle_button(flag);
		$("#table_1 input:not(:eq(1))").val("")
	}else{
		rdShowMessageDialog("ɾ��ʧ��!",0);
		return false;
	}
}

function doClose(){
	
	window.close();	
}

//�ύǰУ��
function doCheck(){
	var el = document.getElementById('passwd');
	if(el.value==''){
		el.focus();
		return false;	
	}
}


 //��֤
function doChecklogin()
{	
   var login_no = document.getElementById('login_no').value;
   var subccno = document.getElementById('subccno').value;
	 document.sitechform.action="logincfg.jsp?login_no="+login_no+"&subccno="+subccno;
   document.sitechform.method='post';
   document.sitechform.submit(); 
}


 //��֤
function doback()
{	
	  window.location.replace("logincfg.jsp");
}


</script>
</head>
<body>
<form id="sitechform" name="sitechform" action="logincfg.jsp">
<%@ include file="/npage/include/header.jsp" %>
    <div class="title"><div id="title_zi">�ͷ�ƽ̨��������</div></div>
 
    <table cellpadding="0" id="table_1">
       <tr>
         <td class="blue">��½����</td>
         <td> 
         
         <input id="login_no" value="<%=login_no%>"><font class="orange">&nbsp;*</font> 
         </td>   
         <td class="blue">�ͷ�����</td> 
         <td>
         	<select id="subccno" name="subccno">
         		<option value="1" selected="true">����</option>
         		<option value="2" >����</option>
         	</select>	
         	<font class="orange">&nbsp;*</font>
         	<input class = "b_text"   type="button" value="��֤" onClick="doChecklogin()" >
         </td>    	
         <td class="blue">����</td>
         <td><input id="passwd" value=""  type='password' maxlength="6" v_must="1" v_type="string" onBlur="checkElement(this)"><font class="orange">*</font></td>        
         
         <td>
         <!-- add by hucw,20100618 -->
       </tr>
    </table>
 

    <table id="table_2" width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr> 
      <td id="footer"  align=center  > 
        <span><input class="b_foot" id="add" name="add" type="button" value="����" onclick="doInsert()"   ></span>
        <span><input class="b_foot" id="modify" name="modify" type="button" value="�޸�" onclick="doUpd()" ></span>
        <span><input class="b_foot" id="del" name="del" type="button" value="ɾ��" onclick="doDel()" ></span>
        <span><input class="b_foot" id="back" name="back" type="button" value="����" onclick="doback()" ></span>
    </td>
   </tr>  
    </table>
    
</form>
</body>
</html>

<script>
if('<%=isExistFlag%>'=='true'){
	document.getElementById("passwd").value ='<%=tmpPasswd%>';
}
</script>


