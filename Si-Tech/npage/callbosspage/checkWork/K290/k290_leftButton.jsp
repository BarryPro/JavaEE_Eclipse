<%
  /*
   * 功能: 质检权限管理->维护质检员和组->质检组树的操作按钮条
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者:
　 * 版权: sitech
   * update:
　 */
%>
<%@ page language="java" pageEncoding="gbk"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<HTML>
	<BODY>

		<TABLE width="100%" height="30" cellSpacing="0" valign="top">
			<TR>
				<TD valign="top" align="center" >
					<input type="button" onclick="showNewNodeWin()" value="新增" class="b_text"/>
					<input type="button" onclick="showModifyNodeWin()" value="修改" class="b_text"/>
					<input type="button" onclick="deleNode()" value="删除" class="b_text"/>
				</TD>
			</TR>
		</TABLE>

	</BODY>
</html>
<SCRIPT type=text/javascript> 
//打开新增窗口
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