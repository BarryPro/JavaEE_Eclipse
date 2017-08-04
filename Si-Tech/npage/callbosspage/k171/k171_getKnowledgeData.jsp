<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient,java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  /*
   * ����: ����֪ʶ��
�� * �汾: 1.0.0
�� * ����: 2010/9/20
�� * ����: tangsong
�� * ��Ȩ: sitech
*/
%>
<title>����֪ʶ��</title>

<script type="text/javascript">
//����������ѯ֪ʶ��
function knowledgeSearch() {
	if ($("#searchCaption").val() == "") {
		rdShowMessageDialog('����д��������',1);
		return;
	}
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k171/k171_searchKnowledge.jsp","���ڲ�ѯ����...");
	mypacket.data.add("searchCaption",$("#searchCaption").val());
  core.ajax.sendPacket(mypacket,doprocess,true);
	mypacket=null;
}

function doprocess(packet) {
	var knowledgeId = packet.data.findValueByName("knowledgeId");
	var knowledgeCaption = packet.data.findValueByName("knowledgeCaption");
	var htmlText = "";
	if (knowledgeId != "") {
		var knowledgeIdArr = knowledgeId.split(",");
		var knowledgeCaptionArr = knowledgeCaption.split(",");
		var checkboxCount = 0;
		for (var i=0;i<knowledgeIdArr.length;i++) {
			checkboxCount++;
			if (checkboxCount%3 == 1) {
				htmlText += "<tr>";
			}
			htmlText += "<td><input type='checkbox' name='knowledge' value='"+knowledgeIdArr[i]+"' caption='"+knowledgeCaptionArr[i]+"' />";
			htmlText += knowledgeCaptionArr[i] + "</td>";
			if (checkboxCount%3 == 0) {
				htmlText += "</tr>";
			}
		}
		if (checkboxCount/3 < 1) {
			htmlText += "</tr>";
		} else {
			//Ϊ���һ�в����Ͽ���
			if (checkboxCount%3 == 1) {
				htmlText += "<td>&nbsp;</td><td>&nbsp;</td></tr>";
			}
			if (checkboxCount%3 == 2) {
				htmlText += "<td>&nbsp;</td></tr>";
			}
		}
		htmlText = "<table style='width:96%'>" + htmlText + "</table>";
	} else {
		htmlText = "�Բ���δ��ѯ������������֪ʶ�㣡";
	}
	window.knowledgeDiv.innerHTML = htmlText;
}

//��ѡ���֪ʶ��չʾ����ҳ����
function confirm() {
	<%
		String pknowledgeId = request.getParameter("p_knowledgeId");
	%>
	var pknowledgeId = "<%=pknowledgeId%>";
	var knowledgeObj = document.getElementsByName("knowledge");
	var htmlText = "";
	for (var i=0;i<knowledgeObj.length;i++) {
		if (knowledgeObj[i].checked) {
			if (pknowledgeId.indexOf(","+knowledgeObj[i].value+",") == -1) {
				htmlText += "<input type='checkbox' name='knowledge' checked='checked'"+" value='"+knowledgeObj[i].value+"' exist='N' />";
				htmlText += knowledgeObj[i].caption + "<br />";
			}
		}
	}
	window.dialogArguments.innerHTML += htmlText;
	window.close();
}

function cleanSearchInput() {
	document.getElementById("searchCaption").value = "";
}

function cleanChecked() {
	var knowledgeObj = document.getElementsByName("knowledge");
	for (var i=0;i<knowledgeObj.length;i++) {
		if (knowledgeObj[i].checked) {
			knowledgeObj[i].checked = false;
		}
	}
}
</script>
<style type="text/css">
a {
	text-decoration:underline;
	color:blue;
}
td {
	text-indent:0;
	border:0;
}
#knowledgeDiv {
	height:400px;
	overflow-y:scroll;
	border:1px solid #99BBE8;
	padding:2px;
}
</style>
</head>

<body>
	<div id="frameDiv" style="width:40%;height:100%;margin-top:10px;float:left;">
		<iframe name="myFrame" id="myFrame" src="k171_knowledgeTree.jsp" style="width:100%;height:461px;" frameborder="0"></iframe>
	</div>
	
	<div id="Operation_Table" style="width:56%;float:right">
		<div class="title" style="color:#366FA9;">
			֪ʶ�����ƣ�
			<input type="text" id="searchCaption" />
			&nbsp;&nbsp;
   		<input type="button" class="b_foot" value="����" onClick="knowledgeSearch()" />
   		&nbsp;&nbsp;
   		<input type="button" class="b_foot" value="���" onClick="cleanSearchInput()" />
		</div>
		
		<div id="knowledgeDiv"></div>
		
		<div class="title" style="text-align:center;color:#366FA9;border:1px solid #99BBE8;border-top:0;">
   		<input type="button" class="b_foot" value="ȷ��" onClick="confirm()" />
   		&nbsp;&nbsp;
   		<input type="button" class="b_foot" value="�����ѡ" onClick="cleanChecked()" />
		</div>
	</div>
</body>
</html>