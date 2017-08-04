<%@ page language="java" pageEncoding="gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<HTML>
	<HEAD>
	</HEAD>
	<BODY>
<div id="div1" >
		<TABLE width="100%"  height="25" cellSpacing="0" vAlign=top>
			<TR>
				<TD align="center">
					<input type="button" class="b_text"  onclick="showCheckItemWin()" value="查询增加"/>
					<input type="button" class="b_text" onclick="clearAll('loginNo')" value="全部清除"/>
				<TD align="left">
					<input type="button" class="b_text" onclick="saveChange()" value="关闭"/>
					<!--input type="button" class="b_text"  onclick="cancel()" value="退出"/-->
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
		parent.frameleft.window.location.reload();
}
function showCheckItemWin(){
	parent.frameright.window.showCheckItemWin();
	}	
function cancel(){
	parent.frameright.window.cancel();
}	
function memberMsgWin(){
	parent.frameright.window.memberMsgWin();
	}
</SCRIPT>
	
