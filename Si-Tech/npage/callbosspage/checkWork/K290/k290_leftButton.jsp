<%
  /*
   * ����: �ʼ�Ȩ�޹���->ά���ʼ�Ա����->�ʼ������Ĳ�����ť��
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����:
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%@ page language="java" pageEncoding="gbk"%>
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
function insertNewNode(parNode,nodeName,note,objectType){
	parent.frameleft.window.insertNewNode(parNode,nodeName,note,objectType);
	}
function modifyNode(login_group_id,login_group_name,note,objectType){
	parent.frameleft.window.modifyNode(login_group_id,login_group_name,note,objectType);
	}	
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