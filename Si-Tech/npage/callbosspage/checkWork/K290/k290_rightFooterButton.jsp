<%
  /*
   * ����: �ʼ�Ȩ�޹���->ά���ʼ�Ա����->���¹�����
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: mixh
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%@ page language="java" pageEncoding="gbk"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<HTML>
	<HEAD>
	</HEAD>
	<BODY>
<div id="div1" style="display: none" >
		<TABLE width="100%"  height="25" cellSpacing="0" vAlign=top>
			<TR>
				<TD>
					<input type="button" class="b_text"  onclick="showCheckItemWin()" value="��Χѡ��"/>
					<input type="button" class="b_text" onclick="clearAll('loginNo')" value="ȫ�����"/>
					<input type="button" class="b_text"  onclick="checkAll('loginNo')" value="ȫ��ѡ��"/>
					<input type="button" class="b_text" onclick="memberMsgWin()" value="��ѯ��Ա��Ϣ"/>
				<TD align="left">
					<input type="button" class="b_text" onclick="saveChange()" value="����"/>
				</TD>
			</TR>
		</TABLE>
	</div>
</html>
<SCRIPT type=text/javascript> 
//��������ʾ
function showTable(){
var odiv = document.getElementById('div1');
odiv.style.display ="block";
}
//����������
function hiddenTable(){
var odiv = document.getElementById('div1');
odiv.style.display ="none";

}
function clearAll(){
	parent.frameright.window.clearAll('loginNo');
}
function checkAll(){
		parent.frameright.window.checkAll('loginNo');
	}
function saveChange(){
	
		parent.frameright.window.saveChange();

}
function showCheckItemWin(){
	window.parent.frameright.window.showCheckItemWin();
	}
function memberMsgWin(){
	parent.frameright.window.memberMsgWin();
}
function cancel(){
	parent.frameright.window.cancel();
}	
showTable();
</SCRIPT>
	
