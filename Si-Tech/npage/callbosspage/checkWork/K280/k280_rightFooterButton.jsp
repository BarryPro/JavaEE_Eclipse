<%
  /*
   * 功能: 质检权限管理->维护被检工号和组->右下工具条
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
					<!--
					<input type="button" class="b_text" onclick="beforeLoad();" value="导入被检工号"/>
					<input type="button" class="b_text" onclick="beforeLoadSerialNo()" value="导入被检流水"/>
					-->
					<!--input type='file' id='impFileid' name='impFileid' class="b_text" > <input type='button' name='upload' value='提交' class="b_text" onClick='importSubmit();'/><font color='red'>&nbsp;文件文件大小<5M</font-->
						
				<TD align="left">
					<input type="button" id="saveBtn" class="b_text" onclick="saveChange()" value="保存"/>
				</TD>
			</TR>
		</TABLE>
	</div>
</html>
<SCRIPT type=text/javascript> 

//进入导入工号选择路径页面	
function beforeLoad(){
		var selectedItemId = parent.frameleft.window.tree.getSelectedItemId();
		if(selectedItemId == "undefined" || "" == selectedItemId){
				similarMSNPop("请先选择要导入工号的被检组！");
				return false ;
		}
		var itemName = parent.frameleft.window.tree.getItemText(selectedItemId);
		if(rdShowConfirmDialog("重复工号只导入一次,确定导入工号到被检组【"+itemName+"】中么？") == 1){
			
			var time = new Date();
			var path='<%=request.getContextPath()%>/npage/callbosspage/checkWork/K280/K280_loadPage.jsp?now=' + time;
			path = path + '&selectedItemId=' + selectedItemId;
				
			var Height = window.screen.availHeight - 500; 
			var width  = window.screen.availWidth  - 500;
			var top    = (window.screen.availHeight-30 - Height)/2; //获得窗口的垂直位置;
			var left   = (window.screen.availWidth-10 - width)/2; //获得窗口的水平位置;
			var param  = 'height=' + Height + ',width=' + width + ',top=' + top + ',left=' + left + 
			             ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=no';
			
			window.open(path, '导入工号', param);	
			//window.open("K280_loadPage.jsp?selectedItemId="+selectedItemId,'导入工号',250,550);
		}
}
//进入导入流水选择路径页面
function beforeLoadSerialNo(){
		var selectedItemId = parent.frameleft.window.tree.getSelectedItemId();
		if(selectedItemId == "undefined" || "" == selectedItemId){
				similarMSNPop("请先选择要导入流水的被检组！");
				return false ;
		}
		var itemName = parent.frameleft.window.tree.getItemText(selectedItemId);
		if(rdShowConfirmDialog("重复流水号只导入一次,导入的流水必须属于同一月份,确定导入流水到被检组【"+itemName+"】中么？") == 1){
			
			var time = new Date();
			var path='<%=request.getContextPath()%>/npage/callbosspage/checkWork/K280/K280_loadSerialPage.jsp?now=' + time;
			path = path + '&selectedItemId=' + selectedItemId;
				
			var Height = window.screen.availHeight - 500; 
			var width  = window.screen.availWidth  - 500;
			var top    = (window.screen.availHeight-30 - Height)/2; //获得窗口的垂直位置;
			var left   = (window.screen.availWidth-10 - width)/2; //获得窗口的水平位置;
			var param  = 'height=' + Height + ',width=' + width + ',top=' + top + ',left=' + left + 
			             ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=no';			
			window.open(path, '导入流水号', param);
		}
}
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
	
/**
  *保存被质检组成员信息
  */
function saveChange(){
	parent.frameright.window.saveChange();
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
showTable();
</SCRIPT>
	
