<%
  /*
   * ����: ���������б�ҳ��
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%
	String opCode = "K230";
	String opName = "���������б�";
%>

<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>


<%
/*---------------���Ĭ��object_id��ʼ-------------------*/
String object_id = WtcUtil.repNull(request.getParameter("object_id"));
String sqlGetObjectId = "";
/*midify by guozw 20091114 ������ѯ�����滻  ��regionCode����ΪĬ��ֵ00 ��ֹsessionδȡ�� 20100303*/
String orgCode = (String)session.getAttribute("orgCode");
String regionCode ="00";

if(orgCode != null && !"".equals(orgCode)){
		regionCode = orgCode.substring(0,2);
}


if(object_id == null || object_id.equals("")){
	sqlGetObjectId = "select to_char(min(object_id)) from dqcobject";

%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="8">
<wtc:param value="<%=sqlGetObjectId%>"/>
</wtc:service>
<wtc:array id="object_ids" scope="end"/>
<%

	object_id = object_ids[0][0];
} //end_of_if
/*---------------object_id��ֵ-------------------*/
%>

<%
/*---------------��ÿ��������б�ʼ-------------------*/
String sqlStr = "select name, source_id, to_char(weight), auto_get, formula, contect_id " +
                "from dqccheckcontect where object_id = :object_id and bak1='Y' order by contect_id";
String myParams = "object_id="+object_id ;
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="8">
<wtc:param value="<%=sqlStr%>"/>
<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="queryList" scope="end"/>
<%
/*---------------��ÿ��������б����-------------------*/

String hasContentNum = "0";
int tmpNum = queryList.length;
if(tmpNum>0){
	hasContentNum = "1";
}
//out.print(hasContentNum);
%>

<html>
<head>
<title>��������</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">

<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>


<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>


<script>
/*zhengjiang 20091004 add*/
var tempNum = '<%=tmpNum%>';
/**
  *
  *����ӿ������ݴ���
  *
  */
function add_qc_content(){
var object_id = document.getElementById("object_id").value;
	/*
	window.open('K230_add_qc_content.jsp?object_id=' + object_id,
	            '',
	            'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width='+screen.availWidth+',height='+screen.availHeight+',left=0,top=0');
	*/
	/*zhengjiang 20091004 start*/
	if('0'==tempNum){
			var time     = new Date();
			var winParam = 'dialogWidth=800px;dialogHeight=330px';
			window.showModalDialog('K230_add_qc_content.jsp?time=' + time + '&object_id=' + object_id, window, winParam);
			tempNum += 1;
	}else{
		parent.top.similarMSNPop("ֻ�����һ���������ݣ�");
		return false;
	}
	/*zhengjiang 20091004 end*/	
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
		parent.top.similarMSNPop("��ѡ��Ҫ�޸ĵĿ������ݣ�");
		return false;
		}
	
	/*
	window.open('K230_update_qc_content.jsp?content_id=' + check_content+'&object_id='+'<%=object_id%>',
	            '',
	            'toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width='+screen.availWidth+',height='+screen.availHeight+',left=0,top=0');
	*/
	var time     = new Date();
	var winParam = 'dialogWidth=800px;dialogHeight=330px';
	window.showModalDialog('K230_update_qc_content.jsp?time=' + time + '&content_id=' + check_content+'&object_id='+'<%=object_id%>', window, winParam);	
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
		parent.top.similarMSNPop("��ѡ��Ҫɾ���Ŀ������ݣ�");
		return false;
	}
	//var itemNum = window.parent.frames.mainFrame.document.getElementById("itemNum").value;
	var itemNum=window.parent.frames.mainFrame.tree.getSubItems('0').length;
	if(!(itemNum==undefined)&&itemNum>0){
			window.parent.top.similarMSNPop("�ÿ����������п��������ɾ����");
			return false;
		}
	if(rdShowConfirmDialog("ȷ��ɾ����ǰ��������ô��") == 1){
		delQcContent();
		//zhengjiang 20091004 add
		tempNum = tempNum-1;
	}
}


/*�Է���ֵ���д���*/
function doProcessDelQcContent(packet){
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	if(retType=="delQcObject"){
		if(retCode=="000000"){
			parent.top.similarMSNPop("�ɹ�ɾ���������ݣ�");
			var radios = document.getElementsByName("check_content");
			for(var i = 0; i < radios.length; i++){
				if(radios[i].checked){
					var trobj = radios[i].parentElement.parentElement;
					trobj.parentElement.removeChild(trobj);
				}
			}
		}else{
			parent.top.similarMSNPop("ɾ����������ʧ�ܣ�");
			return false;
		}
	}
}

/**
  *
  *ɾ��ѡ����������
  *
  */
function delQcContent(){
	//alert("Begin call delQcContent()....");
	var radios = document.getElementsByName("check_content");
	var check_content = "";
	for(var i = 0; i < radios.length; i++){
		if(radios[i].checked){
			check_content = radios[i].value;
		}
	}
	//alert(check_content);

	var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K230/K230_do_delete_qc_content.jsp","���Ժ�...");
	chkPacket.data.add("retType","delQcObject");
	chkPacket.data.add("content_id", check_content);
	chkPacket.data.add("object_id", '<%=object_id%>');
	core.ajax.sendPacket(chkPacket, doProcessDelQcContent, true);
	chkPacket =null;
	//alert("End call delQcContent()....");
}

/**
  *
  *ѡ�е�ǰ�������ݣ�ˢ�¿�����֡
  *
  */
function getCheckItem(content_id){
	//alert("content_id----->" + content_id);
	var object_id = document.getElementById("object_id").value;
	//alert("object_id----->" + object_id);
	window.parent.frames['mainFrame'].location.href = "./K230_qc_item_tree.jsp?content_id=" + content_id +"&object_id=" + object_id;
}

</script>

</head>

<body>
<form  name="formbar">
<input type="hidden" name="object_id" id="object_id" value="<%=object_id%>"/>

<input type="hidden" name="hasContentNum" id="hasContentNum" value="<%=hasContentNum%>"/>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
  <td width="60%">&nbsp;</td>
  <td width="40%" align="right">
	<input type="button" name="btn_add" value="���" class="b_text" onclick="add_qc_content()"/>
	<input type="button" name="btn_update" value="�޸�" class="b_text" onclick="update_qc_content()"/>
	<input type="button" name="btn_delete" value="ɾ��" class="b_text" onclick="delete_qc_content()"/>
</td>
</tr>
</table>

<input type="hidden" name="object_id" id="object_id" value="<%=object_id%>"/>
<table width="100%" border="0" align="center"  cellpadding="0" cellspacing="0">
  <tr>
	<td valign="top">
    <div id="Operation_Table">
      <table id="contentTable" width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="16%" class="blue">ѡ��</td>
        <td width="16%" class="blue">����</td>
        <td width="16%" class="blue">����������Դ</td>
        <td width="16%" class="blue">Ȩ��</td>
        <td width="16%" class="blue">�Ƿ��Զ���ȡ</td>
        <td width="16%" class="blue">��ʽ</td>
      </tr>

      <%
      if(queryList != null && queryList.length >= 0){
      	for(int i = 0; i< queryList.length; i++){%>
      <tr>
        <td class="blue"><input type="radio" name="check_content" onclick="getCheckItem(this.value);" value="<%=queryList[i][5]%>"/></td>
        <td class="blue"><%=queryList[i][0]%>&nbsp;</td>
        <td class="blue">
        	<%if(queryList[i][1].equals("0")){
        	  	out.println("ͨ����¼");	
        	  }else if(queryList[i][1].equals("1")){
        	  	out.println("������¼");
        	  }else if(queryList[i][1].equals("2")){
        	  	out.println("�ʼ���");
        	  }else if(queryList[i][1].equals("3")){
        	  	out.println("ͳ������");
        	  }
        	%>&nbsp;
        </td>
        <td class="blue"><%=(queryList[i][2].startsWith(".")?("0"+queryList[i][2]):queryList[i][2])%>&nbsp; </td>
        <td class="blue"><%if(queryList[i][3].equals("Y")){out.println("��");}else{out.println("��");}%>&nbsp;</td>
        <td class="blue"><%=queryList[i][4]%>&nbsp;</td>
      </tr>
      <%
      }
      	}%>
      </table>
    </div>
    <br/>
    </td>
  </tr>
</table>

</FORM>
</BODY>
</HTML>