<%
  /*
   * ����: 098Ȩ�޽�ɫ����->��ɫ�б�->���� ��ť����
�� * �汾: 1.0.0
�� * ����: 2008/1/16
�� * ����: fangyuan
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%@ page language="java" pageEncoding="gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<HTML>
	<HEAD>
	</HEAD>
	<BODY>
<div id="div1" style="display: none" >
		<TABLE width="100%"  height="25" cellSpacing="0" vAlign=top>
			<TR>
				 
				<TD align="left">
					<input type="button" class="b_text" onclick="saveChangea()" value="����"/>
 
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
function generatejs(){
		parent.frameright.window.generatejs();
	}
	
function checkAll(){
		parent.frameright.window.checkAll('loginNo');
	}
	
function saveChangea(){
	
		parent.frameright.window.saveChangea();
		 
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
	
