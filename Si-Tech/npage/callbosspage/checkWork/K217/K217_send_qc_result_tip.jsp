<%
  /*
   * ����: �ƻ����ʼ�
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
   * update: tangsong 20100411 ���з��ͷ�ʽ����dqcresultaffirm������ʼ�ȷ������
�� */
%>

<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String userId     = request.getParameter("userId"); //������
	String receiverPersons      = request.getParameter("receiverPersons");	//������
	String title     = request.getParameter("title"); //��ǩ����
%>
<html>
<head>
<title>�ʼ�������</title>

<script language=javascript>

function closeWin(){
		window.close();
}

function getRadioValue(){
		var radio = document.forms['sitechform'].elements['typeRange'];
		if (!radio.length && radio.type.toLowerCase() == 'radio') {
					 return (radio.checked)?radio.value:''; 
		}
		
		if (radio[0].tagName.toLowerCase() != 'input' || 
		radio[0].type.toLowerCase() != 'radio')
				{ return ''; }
		
		var len = radio.length;
		for(i=0; i<len; i++){
				if (radio[i].checked){
						return radio[i].value;
				}
		}
		return '';
}

//�ڵ�ѡ���¼�
function isRadioSelect(flag){
	var radiovalue=getRadioValue();
		
		if(radiovalue==0){
				noticeTip(flag);
		}else if(radiovalue==1){
				notesTip(flag);
		}else if(radiovalue==2){
				msgTip(flag);
		}else if(radiovalue==3){
				emailTip(flag);
		}

}

//֪ͨ����
function noticeTip(flag){
		opener.doQcCfm(flag);
		closeWin();
}
//��ǩ����
function notesTip(flag){
	if(flag == 'Y'){
			var width = 650,height = 600;
			var req = '<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()%>';
			sysWindowOpen(req + "/notices/npage/notices/note/Note_add.jsp?userId=<%=userId%>&receiverPersons=<%=receiverPersons%>&title=<%=title%>",'width='+width+'px,height='+height+'px,top='+((screen.availHeight-width)/2)+',left= '+((screen.availWidth-height)/2)+',');
			//added by tangsong 20100411 ��dqcresultaffirm������ʼ�ȷ������
			opener.addAffirmData();
			closeWin();
	}else{
			//added by tangsong 20100411 ��dqcresultaffirm������ʼ�ȷ������
			opener.addAffirmData();
			closeWin();
	}
}
var popupWin;
function sysWindowOpen(url , opts){
	opts += ",toolbar=no ,directories=no, menubar=no , scrollbars=yes , resizable=yes , location=no, status=no";
	if (popupWin == null){	popupWin=window.open( url,'', opts);}
	else if (popupWin.closed ){	popupWin = window.open( url,'', opts);}
	else { popupWin.close(); popupWin=window.open( url,'', opts);}
}

//��������
function msgTip(flag){
	//added by tangsong 20100411 ��dqcresultaffirm������ʼ�ȷ������
	opener.addAffirmData();
}
//�����ʼ�����
function emailTip(flag){
		opener.doMailCfm(flag);
		//added by tangsong 20100411 ��dqcresultaffirm������ʼ�ȷ������
		opener.addAffirmData();
		closeWin();
}
</script>
</head>

<body >
<form id=sitechform name=sitechform>
	<div id="Operation_Table" style="width:100%">
		<div class="title"><div id="title_zi">��ѡ�����ѷ�ʽ��</div></div>
		<table>
	   <tr>
      <td >
      <input type="radio" onclick=""  id="typeRange" name="typeRange" value="0" disabled>֪ͨ</input>
      <input type="radio" checked="true" name="typeRange" id="typeRange"  value="1">��ǩ</input>
      <input type="radio"  onclick=""  id="typeRange" name="typeRange" disabled value="2">����</input>
      <input type="radio"  onclick=""  name="typeRange" id="typeRange"  value="3" disabled>�����ʼ�</input>
      </p>
	</center>
</td>
</tr>
<tr>
<td  align="right">
 <input name="add" type="button" class="b_text" id="add" value="��������" onclick="isRadioSelect('Y');">
 <input name="close" type="button" class="b_text" id="close" value="������" onclick="isRadioSelect('N');">
</td>
 </tr>
 </table>
 </div>
</form>
</body>
</html>