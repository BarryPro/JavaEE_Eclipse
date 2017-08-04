<%
  /*
   * 功能: 质检权限管理->维护质检员和组->右下工具条
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
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
					<input type="button" class="b_text"  onclick="showCheckItemWin()" value="范围选择"/>
					<input type="button" class="b_text" onclick="clearAll('loginNo')" value="全部清除"/>
					<input type="button" class="b_text"  onclick="checkAll('loginNo')" value="全部选中"/>
					<input type="button" class="b_text" onclick="memberMsgWin()" value="查询成员信息"/>
				<TD align="left">
					<input type="button" class="b_text" onclick="saveChange()" value="保存"/>
				</TD>
			</TR>
		</TABLE>
	</div>
</html>
<SCRIPT type=text/javascript> 
//操作栏显示
function showTable(){
var odiv = document.getElementById('div1');
odiv.style.display ="block";
}
//操作栏隐藏
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
	
