<%
  /*
   * ����: FTP����
�� * �汾: 1.0.0
�� * ����: 2009/03/14
�� * ����: fangyuan
�� * ��Ȩ: sitech
   * update: liujied �ͷ�����
   * 1.�淶��ʽ����
   * 2.���opCode��opName
   * 3.�޸��˴��ݵ�ftp_upd.jsp��ftp_add.jsp��winParam����
   * 4.ɾ�����������Ϣ��"��������"�޸�Ϊ"��������"
�� */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
  /*midify by guozw 20091114 ������ѯ�����滻*/
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

/*---------------���FTP�����б�ʼ-------------------*/
String sqlStr = "select t.ftp_ip,t.ftp_port,nvl(t.ftp_user,' '),t.ftp_dir,to_char(t.create_time,'yyyy-mm-dd HH:MM:SS'),nvl(t.FTP_PASSWD,' ') "+" from dcallftpservercfg t order by t.create_time desc";

String opCode="K103";
String opName="¼������������";
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="8">
<wtc:param value="<%=sqlStr%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end"/>
<%
/*---------------���FTP�����б����-------------------*/
%>

<html>
<head>
<title>FTP����</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">

<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>

<script>

//ȫ�ֱ�������ҳ��ֵ
var g_values="";

/**
  *
  *����ӿ������ݴ���
  *
  */
function add_qc_content(){
	
	var time     = new Date();
	//var winParam = 'dialogWidth=800px;dialogHeight=330px';
        var winParam = 'dialogWidth=600px;dialogHeight=400px';
	window.showModalDialog('ftp_add.jsp?time=' + time , window, winParam);	
}

/**
  *
  *���޸��������ݴ���
  *
  */
function update_qc_content(){
	var radios = document.getElementsByName("check_content");
	var check_content = "";
	for(var i = 0; i < radios.length; i++){
		if(radios[i].checked){
			check_content = radios[i].value;
		}
	}
	if(undefined==check_content||''==check_content){
		rdShowMessageDialog('��ѡ��Ҫ�޸ĵ�����',1);
		return false;
	}
	var time     = new Date();
	//var winParam = 'dialogWidth=800px;dialogHeight=330px';
        var winParam = 'dialogWidth=600px;dialogHeight=400px';                   
	window.showModalDialog('ftp_upd.jsp?time=' + time + '&params='+g_values, window, winParam);	
}

/**
  *
  *ɾ����������
  *
  */
function delete_qc_content(){
	var radios = document.getElementsByName("check_content");
	var check_content = "";
	for(var i = 0; i < radios.length; i++){
		if(radios[i].checked){
			check_content = radios[i].value;
		}
	}
	if(undefined==check_content||''==check_content){
		rdShowMessageDialog('��ѡ��Ҫɾ��������',1);
		return false;
	}
	if(rdShowConfirmDialog("ȷ��ɾ����ǰ����ô��") == 1){
		delQcContent();
	}
}


/*�Է���ֵ���д���*/
function doProcessDelQcContent(packet){
	var retCode = packet.data.findValueByName("retCode");
	if(retCode=="000000"){
		//rdShowMessageDialog('�ɹ�ɾ��������Ϣ',2);
		var radios = document.getElementsByName("check_content");
		for(var i = 0; i < radios.length; i++){
			if(radios[i].checked){
				var trobj = radios[i].parentElement.parentElement;
				trobj.parentElement.removeChild(trobj);
			}
		}
	}else{
		rdShowMessageDialog('ɾ��������Ϣʧ��!',0);
		return false;
	}
}

/**
  *
  *ɾ��ѡ����������
  *
  */
function delQcContent(){
	var radios = document.getElementsByName("check_content");
	var check_content = "";
	for(var i = 0; i < radios.length; i++){
		if(radios[i].checked){
			check_content = radios[i].value;
		}
	}
	//alert(g_values);
	var arr = g_values.split(',');
	var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K098/ftpconfig/ftp_doDel.jsp","���Ժ�...");
     var ip = arr[0];
     var port = arr[1];
     var panfu = arr[3];
     chkPacket.data.add("ip",ip);
     chkPacket.data.add("port",port);
     chkPacket.data.add("panfu",panfu);
	core.ajax.sendPacket(chkPacket, doProcessDelQcContent, false);
	chkPacket =null;
	//alert("End call delQcContent()....");
}

/**
  *
  *ѡ�е�ǰ���ݣ�ˢ��ҳ�洫ֵ����
  *
  */
function getCheckItem(v){
	//alert("v----->" + v);
	g_values = v;
}

</script>
</head>

<body>

<form  name="formbar">
 <%@ include file="/npage/include/header.jsp"%>
<!--<table width="100%" border="0" align="center"  cellpadding="0" cellspacing="0">
  <tr>
	<td valign="top"> -->
    <div id="Operation_Table">
    	<div class="title"><div id="title_zi">FTP����</div></div>
      <table id="contentTable" width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <th align="center" width="8%" class="blue">ѡ��</th>
        <th align="center" width="16%" class="blue">FTP��������ַ(IP)</th>
        <th align="center" width="16%" class="blue">FTP�������˿�</th>
        <th align="center" width="16%" class="blue">�û���</th>
        <th align="center" width="16%" class="blue">ӳ���̷�</th>      
      </tr>
      <%
      if(queryList != null && queryList.length > 0){
      	for(int i = 0; i< queryList.length; i++){%>
      <tr>
        <td align="center" class="blue"><input type="radio" name="check_content" onclick="getCheckItem(this.value);" value="<%=queryList[i][0]%>,<%=queryList[i][1]%>,<%=queryList[i][2]%>,<%=queryList[i][3]%>,<%=queryList[i][5]%>"/></td>
        <td align="center" class="blue"><%=queryList[i][0]%>&nbsp;</td>
        <td align="center" class="blue"><%=queryList[i][1]%>&nbsp;</td>
        <td align="center" class="blue"><%=queryList[i][2]%>&nbsp;</td>
        <td align="center" class="blue"><%=queryList[i][3]%>&nbsp;</td>
      
      </tr>
      <%
      	}
      }else{
      %>
       <!--tr><td align="center" class="blue" colspan="5"><font color="orange">��ǰ��¼Ϊ�գ�</font></td></tr-->	
      <% }%>
      </table> 
      
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
  <td id="footer"  align="right">
	<input type="button" name="btn_add" value="���" class="b_foot" onclick="add_qc_content()"/>
	<input type="button" name="btn_update" value="�޸�" class="b_foot" onclick="update_qc_content()"/>
	<input type="button" name="btn_delete" value="ɾ��" class="b_foot" onclick="delete_qc_content()"/>
</td>
</tr>
</table>
</div>

</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>
