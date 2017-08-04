<%
  /*
   * 功能: 098权限角色管理->维护权限功能->新增/修改/删除 按钮界面
　 * 版本: 1.0.0
　 * 日期: 2008/1/16
　 * 作者: fangyuan
　 * 版权: sitech
   * update:
　 */
%>
<%@ page language="java" pageEncoding="gb2312"%>
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