<%
  /*
   * 功能: 计划外质检-》选择考评内容
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%
	 String opCode = "K217";
	 String opName = "选择考评内容";
   String staffno = request.getParameter("staffno");

%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title></title>

<script>
function closeThisWin(){
		var object_id  = document.getElementById("object_id").value;
		var content_id = document.getElementById("content_id").value;
		var staffno = document.getElementById("staffno").value;
		
		if(object_id == ""){
				rdShowMessageDialog('请选择质检对象！', 0);
				return false;
		}
		
		if(content_id == ""){
				rdShowMessageDialog('请选择考评内容！', 0);
				return false;
		}	
		var param  = 'dialogWidth=' + screen.availWidth +';dialogHeight=' + screen.availHeight;
		var serialnum = '<%=request.getParameter("serialnum")%>';
		var opCode = '<%=opCode%>';
		var path = '/npage/callbosspage/checkWork/K217/K217_exec_out_plan_qc_main.jsp?serialnum=' + serialnum + '&object_id=' +object_id + '&content_id=' + content_id +'&isOutPlanflag=1&staffno=<%=staffno%>';
		var tabId = opCode+serialnum;
		
		if(!parent.parent.document.getElementById(tabId)){
				path = path+'&tabId='+tabId;
				parent.parent.addTab(true,tabId,'计划外质检',path);
				parent.parent.removeTab(serialnum+1);
		}else{
				rdShowConfirmDialog("此流水质检窗口已打开！",1);
		}
}

function cancel(){
		var object_id      = document.getElementById("object_id");
		var content_id     = document.getElementById("content_id");
		var object_name    = document.getElementById("qc_object");
		var content_name   = document.getElementById("qc_content");	
		object_id.value    = "";
		content_id.value   = "";
		object_name.value  = "";
		content_name.value = "";
}
</script>
</head>

<body>
	<div id="Operation_Table">
<table>
	<tr>
		<td>被检测对象类别</td>
		<td>
			<input type="text" name="qc_object" id="qc_object"  value=""/>
			<input type="hidden" name="object_id" id="object_id" value=""/>
		</td>
		<td>考评内容</td>
		<td>
			<input type="text" name="qc_content" id="qc_object" size="50" value=""/>
			<input type="hidden" name="content_id" id="content_id" value=""/>
		</td>
		<input type="hidden" name="staffno" id="staffno" value="<%=staffno%>"/>
		<td><input type="button" name="btn_submit" value="确定" class="b_foot" onclick="closeThisWin();"/></td>
		<td><input type="button" name="btn_cancel" value="刷新" class="b_foot" onclick="window.parent.frames['mainFrame'].history.go(0);"/></td>
	</tr>
</talbe>
</div>
</body>
</html>
