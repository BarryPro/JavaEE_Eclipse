<%
  /*
   * ����: 098Ȩ�޽�ɫ����->ά��Ȩ�޹���->����/�޸�/ɾ�� ��ť����
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
	<BODY>

		<TABLE width="100%" height="30" cellSpacing="0" valign="top">
			<TR>
				<TD valign="top" align="center" >
					<input type="button" onclick="showNewNodeWin()" value="����" class="b_text"/>
					<input type="button" onclick="showModifyNodeWin()" value="�޸�" class="b_text"/>
					<input type="button" onclick="deleNode()" value="ɾ��" class="b_text"/>
				</TD>
			</TR>
		</TABLE>

	</BODY>
</html>
<SCRIPT type=text/javascript> 
//����������
function showNewNodeWin(){
		window.parent.frameleft.window.showNewNodeWin();
}
function showModifyNodeWin(){
	parent.frameleft.window.showModifyNodeWin();
}
function deleNode(){
	parent.frameleft.window.deleNode();
}
</SCRIPT>